<template>
  <div class="kb-chat-container">
    <!-- 顶部标题栏 -->
    <div class="kb-header">
      <div class="kb-header-left">
        <h2>🤖 EHS 知识问答助手</h2>
        <p>基于企业知识库的智能问答 · 支持多轮对话</p>
      </div>
      <div class="kb-header-right">
        <div class="connection-status" :class="connectionClass">
          <span class="status-dot"></span>
          <span>{{ connectionText }}</span>
        </div>
        <el-button size="small" @click="testConnection" :loading="testing">
          <el-icon><Connection /></el-icon> 测试连接
        </el-button>
        <el-button size="small" type="primary" @click="newSession">
          <el-icon><RefreshRight /></el-icon> 新会话
        </el-button>
      </div>
    </div>

    <!-- 聊天消息区 -->
    <div class="kb-messages" ref="messagesRef">
      <div v-for="(msg, idx) in messages" :key="idx"
           :class="['msg-item', 'msg-' + msg.role]">
        <div class="msg-avatar">
          {{ msg.role === 'user' ? '👤' : msg.role === 'error' ? '⚠️' : '🤖' }}
        </div>
        <div class="msg-content">
          <div class="msg-bubble" v-html="msg.role === 'assistant' ? renderMarkdown(msg.text) : msg.text"></div>
          <div class="msg-meta" v-if="msg.elapsed">
            ⏱ {{ msg.elapsed }}ms
          </div>
          <!-- 来源引用 -->
          <div class="msg-sources" v-if="msg.sources && msg.sources.length">
            <div class="sources-title">📚 参考来源</div>
            <div class="source-item" v-for="(src, si) in msg.sources" :key="si">
              <div class="source-header">
                <span class="source-name">{{ src.title || '未命名来源' }}</span>
                <el-tag v-if="src.score" size="small" type="success" effect="plain">
                  匹配度 {{ (src.score * 100).toFixed(0) }}%
                </el-tag>
                <el-tag v-if="src.sourceType" size="small" effect="plain">
                  {{ src.sourceType }}
                </el-tag>
              </div>
              <div class="source-content" v-if="src.content">{{ truncate(src.content, 150) }}</div>
              <a v-if="src.url" :href="src.url" target="_blank" class="source-link">🔗 查看原文</a>
            </div>
          </div>
        </div>
      </div>

      <!-- 加载动画 -->
      <div v-if="loading" class="msg-item msg-assistant">
        <div class="msg-avatar">🤖</div>
        <div class="msg-content">
          <div class="msg-bubble typing-indicator">
            <span></span><span></span><span></span>
          </div>
        </div>
      </div>
    </div>

    <!-- 快捷问题标签 -->
    <div class="quick-questions" v-if="messages.length <= 1">
      <span class="quick-label">💡 试试问：</span>
      <el-tag v-for="(q, i) in quickQuestions" :key="i"
              class="quick-tag" effect="plain" @click="askQuestion(q)">
        {{ q }}
      </el-tag>
    </div>

    <!-- 输入区 -->
    <div class="kb-input-area">
      <el-input
        v-model="inputText"
        type="textarea"
        :rows="2"
        placeholder="输入您的EHS相关问题... (Enter发送, Shift+Enter换行)"
        resize="none"
        @keydown="handleKeydown"
        :disabled="loading"
      />
      <el-button type="primary" @click="sendMessage" :loading="loading"
                 :disabled="!inputText.trim()">
        <el-icon><Promotion /></el-icon> 发送
      </el-button>
    </div>
  </div>
</template>

<script>
import { ref, reactive, onMounted, nextTick, computed } from 'vue'
import { Connection, RefreshRight, Promotion } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { queryKnowledgeBase, testKnowledgeBaseConnection } from '@/api/knowledgeBaseChat'
import { marked } from 'marked'

export default {
  name: 'EHS_KnowledgeChat',
  components: { Connection, RefreshRight, Promotion },
  setup() {
    const messagesRef = ref(null)
    const inputText = ref('')
    const loading = ref(false)
    const testing = ref(false)
    const sessionId = ref(null)
    const connectionState = ref('unknown') // unknown, connected, failed

    const messages = ref([
      {
        role: 'assistant',
        text: '您好！我是 EHS 知识问答助手 🤖\n\n我可以帮您查询以下方面的知识：\n- 🔒 安全管理制度与规程\n- ⚗️ 化学品管理与SDS\n- 🏭 职业健康与防护\n- 🌿 环保法规与合规\n- 🚨 应急预案与处置流程\n- 📋 EHS标准与体系\n\n请输入您的问题，我会从企业知识库中为您查找答案。'
      }
    ])

    const quickQuestions = [
      '有限空间作业安全要求',
      '危废暂存间管理规范',
      'LOTO上锁挂牌程序',
      '化学品泄漏应急处置',
      '高处作业安全规定',
      '消防器材检查标准'
    ]

    const connectionClass = computed(() => ({
      'status-connected': connectionState.value === 'connected',
      'status-failed': connectionState.value === 'failed',
      'status-unknown': connectionState.value === 'unknown'
    }))

    const connectionText = computed(() => {
      const map = { connected: '已连接', failed: '连接失败', unknown: '未检测' }
      return map[connectionState.value]
    })

    const renderMarkdown = (text) => {
      try {
        return marked(text || '')
      } catch { return text }
    }

    const truncate = (str, len) => {
      if (!str) return ''
      return str.length > len ? str.substring(0, len) + '...' : str
    }

    const scrollToBottom = () => {
      nextTick(() => {
        if (messagesRef.value) {
          messagesRef.value.scrollTop = messagesRef.value.scrollHeight
        }
      })
    }

    const sendMessage = async () => {
      const question = inputText.value.trim()
      if (!question || loading.value) return

      messages.value.push({ role: 'user', text: question })
      inputText.value = ''
      loading.value = true
      scrollToBottom()

      try {
        const payload = { question }
        if (sessionId.value) {
          payload.sessionId = sessionId.value
        }

        const res = await queryKnowledgeBase(payload)

        if (res.status && res.answer) {
          // 更新sessionId
          if (res.sessionId) {
            sessionId.value = res.sessionId
          }

          messages.value.push({
            role: 'assistant',
            text: res.answer,
            sources: res.sources || [],
            elapsed: res.elapsedMilliseconds
          })
          connectionState.value = 'connected'
        } else if (res.answer) {
          // answer 存在但 status=false，仍然展示
          if (res.sessionId) sessionId.value = res.sessionId
          messages.value.push({
            role: 'assistant',
            text: res.answer,
            sources: res.sources || [],
            elapsed: res.elapsedMilliseconds
          })
        } else {
          messages.value.push({
            role: 'error',
            text: res.message || '未获取到答案，请重试'
          })
        }
      } catch (err) {
        messages.value.push({
          role: 'error',
          text: '请求失败: ' + (err.message || err)
        })
        connectionState.value = 'failed'
      } finally {
        loading.value = false
        scrollToBottom()
      }
    }

    const askQuestion = (q) => {
      inputText.value = q
      sendMessage()
    }

    const handleKeydown = (e) => {
      if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault()
        sendMessage()
      }
    }

    const newSession = () => {
      sessionId.value = null
      messages.value = [messages.value[0]] // 保留欢迎消息
      ElMessage.success('已开始新会话')
    }

    const testConnection = async () => {
      testing.value = true
      try {
        const res = await testKnowledgeBaseConnection()
        if (res.status) {
          connectionState.value = 'connected'
          ElMessage.success(`连接成功 (${res.elapsedMs}ms)`)
        } else {
          connectionState.value = 'failed'
          ElMessage.error(res.message || '连接失败')
        }
      } catch (err) {
        connectionState.value = 'failed'
        ElMessage.error('连接测试失败: ' + (err.message || err))
      } finally {
        testing.value = false
      }
    }

    onMounted(() => {
      testConnection()
    })

    return {
      messagesRef, inputText, loading, testing, messages,
      quickQuestions, connectionClass, connectionText,
      renderMarkdown, truncate, sendMessage, askQuestion,
      handleKeydown, newSession, testConnection
    }
  }
}
</script>

<style scoped>
.kb-chat-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  background: #f0f2f5;
}

/* Header */
.kb-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background: linear-gradient(135deg, #1a237e 0%, #0d47a1 100%);
  color: #fff;
  flex-shrink: 0;
}
.kb-header-left h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 700;
}
.kb-header-left p {
  margin: 4px 0 0;
  font-size: 12px;
  opacity: 0.8;
}
.kb-header-right {
  display: flex;
  align-items: center;
  gap: 10px;
}
.connection-status {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  padding: 4px 12px;
  border-radius: 12px;
  background: rgba(255,255,255,0.15);
}
.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #909399;
}
.status-connected .status-dot { background: #67c23a; }
.status-failed .status-dot { background: #f56c6c; }
.status-unknown .status-dot { background: #e6a23c; }

/* Messages */
.kb-messages {
  flex: 1;
  overflow-y: auto;
  padding: 20px 24px;
}
.msg-item {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
  max-width: 85%;
}
.msg-user {
  margin-left: auto;
  flex-direction: row-reverse;
}
.msg-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  flex-shrink: 0;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}
.msg-bubble {
  padding: 12px 16px;
  border-radius: 12px;
  font-size: 14px;
  line-height: 1.6;
  word-break: break-word;
}
.msg-user .msg-bubble {
  background: linear-gradient(135deg, #409eff, #337ecc);
  color: #fff;
  border-bottom-right-radius: 4px;
  white-space: pre-wrap;
}
.msg-assistant .msg-bubble {
  background: #fff;
  color: #303133;
  border-bottom-left-radius: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
.msg-error .msg-bubble {
  background: #fef0f0;
  color: #f56c6c;
  border-left: 3px solid #f56c6c;
}
.msg-meta {
  font-size: 11px;
  color: #909399;
  margin-top: 4px;
  padding-left: 4px;
}

/* Markdown in messages */
.msg-bubble :deep(p) { margin: 0 0 8px; }
.msg-bubble :deep(p:last-child) { margin-bottom: 0; }
.msg-bubble :deep(ul), .msg-bubble :deep(ol) { padding-left: 20px; margin: 4px 0; }
.msg-bubble :deep(li) { margin: 2px 0; }
.msg-bubble :deep(code) {
  background: #f4f4f5;
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 13px;
}
.msg-bubble :deep(pre) {
  background: #1e1e1e;
  color: #d4d4d4;
  padding: 12px;
  border-radius: 6px;
  overflow-x: auto;
  margin: 8px 0;
}
.msg-bubble :deep(pre code) {
  background: none;
  padding: 0;
  color: inherit;
}
.msg-bubble :deep(strong) { font-weight: 600; }
.msg-bubble :deep(h3), .msg-bubble :deep(h4) {
  margin: 12px 0 6px;
  font-weight: 600;
}

/* Sources */
.msg-sources {
  margin-top: 10px;
  padding: 10px;
  background: #f8f9fa;
  border-radius: 8px;
  border: 1px solid #ebeef5;
}
.sources-title {
  font-weight: 600;
  font-size: 13px;
  margin-bottom: 8px;
  color: #606266;
}
.source-item {
  padding: 8px;
  margin-bottom: 6px;
  border-left: 3px solid #409eff;
  background: #fff;
  border-radius: 4px;
}
.source-item:last-child { margin-bottom: 0; }
.source-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}
.source-name {
  font-weight: 600;
  font-size: 13px;
  color: #303133;
}
.source-content {
  font-size: 12px;
  color: #909399;
  line-height: 1.5;
}
.source-link {
  font-size: 12px;
  color: #409eff;
  text-decoration: none;
  margin-top: 4px;
  display: inline-block;
}

/* Typing indicator */
.typing-indicator {
  display: flex;
  gap: 4px;
  padding: 16px 20px !important;
}
.typing-indicator span {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #c0c4cc;
  animation: typing 1.4s infinite ease-in-out;
}
.typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
.typing-indicator span:nth-child(3) { animation-delay: 0.4s; }
@keyframes typing {
  0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
  40% { transform: scale(1); opacity: 1; }
}

/* Quick questions */
.quick-questions {
  padding: 8px 24px;
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
  flex-shrink: 0;
}
.quick-label {
  font-size: 13px;
  color: #909399;
}
.quick-tag {
  cursor: pointer;
  transition: all 0.2s;
}
.quick-tag:hover {
  background: #409eff;
  color: #fff;
  border-color: #409eff;
}

/* Input */
.kb-input-area {
  display: flex;
  gap: 12px;
  padding: 16px 24px;
  background: #fff;
  border-top: 1px solid #ebeef5;
  flex-shrink: 0;
}
.kb-input-area .el-button {
  height: auto;
  align-self: flex-end;
}
</style>
