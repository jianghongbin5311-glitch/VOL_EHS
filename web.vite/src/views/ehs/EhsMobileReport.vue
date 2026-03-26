<template>
  <div class="ehs-mobile">
    <!-- 顶部标题栏 -->
    <div class="ehs-header">
      <div class="header-title">
        <span class="header-icon">🛡️</span>
        <span>EHS 现场快报</span>
      </div>
      <div class="header-user" v-if="userName">{{ userName }}</div>
    </div>

    <!-- 报告类型选择 -->
    <div class="type-selector">
      <div
        v-for="t in reportTypes"
        :key="t.key"
        :class="['type-card', { active: currentType === t.key }]"
        @click="currentType = t.key"
      >
        <span class="type-icon">{{ t.icon }}</span>
        <span class="type-label">{{ t.label }}</span>
      </div>
    </div>

    <!-- 表单区域 -->
    <div class="form-section">
      <!-- === 隐患上报 === -->
      <template v-if="currentType === 'hazard'">
        <div class="form-group">
          <label class="form-label required">隐患等级</label>
          <select v-model="form.HazardLevel" class="form-select">
            <option value="">请选择</option>
            <option v-for="lv in hazardLevels" :key="lv" :value="lv">{{ lv }}</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">隐患类别</label>
          <select v-model="form.HazardType" class="form-select">
            <option value="">请选择</option>
            <option v-for="tp in hazardTypes" :key="tp" :value="tp">{{ tp }}</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label required">隐患描述</label>
          <input v-model="form.Title" class="form-input" placeholder="简要描述发现的隐患" />
        </div>
        <div class="form-group">
          <label class="form-label">详细说明</label>
          <textarea v-model="form.Description" class="form-textarea" rows="3" placeholder="补充详细信息..."></textarea>
        </div>
        <div class="form-group">
          <label class="form-label">发现位置</label>
          <input v-model="form.Location" class="form-input" placeholder="例：A车间3号产线" />
        </div>
      </template>

      <!-- === 事故上报 === -->
      <template v-if="currentType === 'accident'">
        <div class="form-group">
          <label class="form-label">事故等级</label>
          <select v-model="form.AccidentLevel" class="form-select">
            <option value="">请选择</option>
            <option v-for="lv in accidentLevels" :key="lv" :value="lv">{{ lv }}</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label required">事故类型</label>
          <select v-model="form.AccidentType" class="form-select">
            <option value="">请选择</option>
            <option v-for="tp in accidentTypes" :key="tp" :value="tp">{{ tp }}</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label required">事故标题</label>
          <input v-model="form.Title" class="form-input" placeholder="简要描述事故情况" />
        </div>
        <div class="form-group">
          <label class="form-label">事故经过</label>
          <textarea v-model="form.Description" class="form-textarea" rows="3" placeholder="描述事故经过..."></textarea>
        </div>
        <div class="form-group">
          <label class="form-label">发生地点</label>
          <input v-model="form.OccurLocation" class="form-input" placeholder="事故发生地点" />
        </div>
        <div class="form-row">
          <div class="form-group half">
            <label class="form-label">受伤人数</label>
            <input v-model.number="form.Injuries" type="number" class="form-input" placeholder="0" />
          </div>
          <div class="form-group half">
            <label class="form-label">死亡人数</label>
            <input v-model.number="form.Fatalities" type="number" class="form-input" placeholder="0" />
          </div>
        </div>
      </template>

      <!-- === 巡查记录 === -->
      <template v-if="currentType === 'inspection'">
        <div class="form-group">
          <label class="form-label required">检查类型</label>
          <select v-model="form.InspectionType" class="form-select">
            <option value="">请选择</option>
            <option v-for="tp in inspectionTypes" :key="tp" :value="tp">{{ tp }}</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label required">检查标题</label>
          <input v-model="form.Title" class="form-input" placeholder="例：2号厂房日常巡查" />
        </div>
        <div class="form-group">
          <label class="form-label">检查区域</label>
          <input v-model="form.Area" class="form-input" placeholder="例：B2车间" />
        </div>
        <div class="form-group">
          <label class="form-label">备注</label>
          <textarea v-model="form.Remark" class="form-textarea" rows="3" placeholder="巡查发现和备注..."></textarea>
        </div>
        <div class="form-row">
          <div class="form-group half">
            <label class="form-label">检查项数</label>
            <input v-model.number="form.TotalItems" type="number" class="form-input" placeholder="0" />
          </div>
          <div class="form-group half">
            <label class="form-label">发现隐患数</label>
            <input v-model.number="form.HazardCount" type="number" class="form-input" placeholder="0" />
          </div>
        </div>
      </template>

      <!-- === 图片/视频上传 === -->
      <div class="upload-section">
        <label class="form-label">📷 现场照片/视频</label>
        <div class="upload-tips">支持拍照、录视频或从相册选择，最多 9 个文件</div>

        <div class="media-grid">
          <!-- 已选文件预览 -->
          <div v-for="(file, idx) in mediaFiles" :key="idx" class="media-item">
            <img v-if="file.isImage" :src="file.preview" class="media-thumb" />
            <div v-else class="media-video-thumb">
              <span class="video-icon">▶</span>
              <span class="video-name">{{ file.name }}</span>
            </div>
            <div class="media-remove" @click="removeMedia(idx)">✕</div>
          </div>

          <!-- 拍照按钮 -->
          <div class="media-add" v-if="mediaFiles.length < 9" @click="triggerCapture('photo')">
            <div class="add-icon">📸</div>
            <div class="add-text">拍照</div>
            <input
              ref="photoInput"
              type="file"
              accept="image/*"
              capture="environment"
              style="display:none"
              @change="onFileSelected($event)"
            />
          </div>

          <!-- 录视频按钮 -->
          <div class="media-add" v-if="mediaFiles.length < 9" @click="triggerCapture('video')">
            <div class="add-icon">🎥</div>
            <div class="add-text">录视频</div>
            <input
              ref="videoInput"
              type="file"
              accept="video/*"
              capture="environment"
              style="display:none"
              @change="onFileSelected($event)"
            />
          </div>

          <!-- 从相册选择 -->
          <div class="media-add" v-if="mediaFiles.length < 9" @click="triggerCapture('album')">
            <div class="add-icon">🖼️</div>
            <div class="add-text">相册</div>
            <input
              ref="albumInput"
              type="file"
              accept="image/*,video/*"
              multiple
              style="display:none"
              @change="onFileSelected($event)"
            />
          </div>
        </div>
      </div>

      <!-- 提交按钮 -->
      <div class="submit-section">
        <button class="submit-btn" :disabled="submitting" @click="submitReport">
          <span v-if="submitting" class="submit-loading"></span>
          {{ submitting ? '提交中...' : '📤 提交报告' }}
        </button>
      </div>
    </div>

    <!-- 成功提示 -->
    <div v-if="showSuccess" class="success-overlay" @click="showSuccess = false">
      <div class="success-card">
        <div class="success-icon">✅</div>
        <div class="success-title">提交成功！</div>
        <div class="success-msg">{{ successMsg }}</div>
        <button class="success-btn" @click="resetForm">继续上报</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import http from '@/api/http'
import store from '@/store/index'

// ===== 报告类型 =====
const reportTypes = [
  { key: 'hazard', label: '隐患上报', icon: '⚠️' },
  { key: 'accident', label: '事故上报', icon: '🚨' },
  { key: 'inspection', label: '巡查记录', icon: '🔍' },
]
const currentType = ref('hazard')

// ===== 下拉数据 =====
const hazardLevels = ['低风险', '一般风险', '较大风险', '重大隐患', '特别重大隐患']
const hazardTypes = ['机械安全', '电气安全', '消防安全', '化学品', '高处作业', '密闭空间', '人因工程', '环境保护', '其他']
const accidentLevels = ['未遂事件', '一般', '较大', '重大', '特别重大']
const accidentTypes = ['工伤', '设备', '火灾', '化学品', '触电', '高处坠落', '机械伤害', '环境', '其他']
const inspectionTypes = ['日常巡查', '专项检查', '季度检查', '节前检查', '夜间巡查', '领导带队检查', '其他']

// ===== 表单数据 =====
const form = reactive({
  Title: '',
  Description: '',
  // 隐患
  HazardLevel: '',
  HazardType: '',
  Location: '',
  // 事故
  AccidentLevel: '',
  AccidentType: '',
  OccurLocation: '',
  Injuries: null,
  Fatalities: null,
  // 巡查
  InspectionType: '',
  Area: '',
  Remark: '',
  TotalItems: null,
  HazardCount: null,
})

// ===== 媒体文件 =====
const mediaFiles = ref([])
const photoInput = ref(null)
const videoInput = ref(null)
const albumInput = ref(null)

const userName = computed(() => {
  const userInfo = store.getters.getUserInfo()
  return userInfo?.userName || ''
})

function triggerCapture(type) {
  if (type === 'photo') photoInput.value?.click()
  else if (type === 'video') videoInput.value?.click()
  else albumInput.value?.click()
}

function onFileSelected(event) {
  const files = event.target.files
  if (!files) return
  for (let i = 0; i < files.length; i++) {
    if (mediaFiles.value.length >= 9) break
    const file = files[i]
    const isImage = file.type.startsWith('image/')
    const preview = isImage ? URL.createObjectURL(file) : ''
    mediaFiles.value.push({ file, name: file.name, isImage, preview })
  }
  event.target.value = null
}

function removeMedia(index) {
  const item = mediaFiles.value[index]
  if (item.preview) URL.revokeObjectURL(item.preview)
  mediaFiles.value.splice(index, 1)
}

// ===== 提交逻辑 =====
const submitting = ref(false)
const showSuccess = ref(false)
const successMsg = ref('')

async function submitReport() {
  // 前端校验
  if (!form.Title) {
    alert('请填写标题/描述')
    return
  }

  submitting.value = true
  try {
    // 1. 先上传文件（如有）
    let uploadedPaths = []
    if (mediaFiles.value.length > 0) {
      const formData = new FormData()
      for (const m of mediaFiles.value) {
        formData.append('fileInput', m.file, m.file.name)
      }

      const uploadUrl = getUploadUrl()
      const uploadRes = await http.post(uploadUrl, formData, '', {
        headers: { 'Content-Type': 'multipart/form-data' },
      })
      if (uploadRes.status) {
        // 后端返回路径前缀
        uploadedPaths = mediaFiles.value.map((m) => (uploadRes.data || '') + m.file.name)
      }
    }

    // 2. 构建提交数据
    const postData = buildPostData(uploadedPaths)

    // 3. 提交表单
    const saveUrl = getSaveUrl()
    const res = await http.post(saveUrl, postData, '正在提交...')

    if (res.status) {
      successMsg.value = getSuccessMsg()
      showSuccess.value = true
    } else {
      alert('提交失败: ' + (res.message || '未知错误'))
    }
  } catch (err) {
    alert('提交异常: ' + err.message)
  } finally {
    submitting.value = false
  }
}

function getUploadUrl() {
  const map = {
    hazard: '/api/EHS_HazardReport/Upload',
    accident: '/api/EHS_Accident/Upload',
    inspection: '/api/EHS_HazardInspection/Upload',
  }
  return map[currentType.value]
}

function getSaveUrl() {
  const map = {
    hazard: '/api/EHS_HazardReport/Add',
    accident: '/api/EHS_Accident/Add',
    inspection: '/api/EHS_HazardInspection/Add',
  }
  return map[currentType.value]
}

function buildPostData(uploadedPaths) {
  const now = new Date().toISOString()
  const attachments = uploadedPaths.join(',')

  if (currentType.value === 'hazard') {
    return {
      mainData: {
        HazardLevel: form.HazardLevel,
        HazardType: form.HazardType,
        Title: form.Title,
        Description: form.Description || (attachments ? `[附件] ${attachments}` : ''),
        Location: form.Location,
        DiscoveryDate: now,
        Status: 0,
      },
      detailData: null,
      delKeys: null,
    }
  } else if (currentType.value === 'accident') {
    return {
      mainData: {
        AccidentLevel: form.AccidentLevel,
        AccidentType: form.AccidentType,
        Title: form.Title,
        Description: form.Description || (attachments ? `[附件] ${attachments}` : ''),
        OccurLocation: form.OccurLocation,
        OccurDate: now,
        Injuries: form.Injuries || 0,
        Fatalities: form.Fatalities || 0,
        Status: 0,
      },
      detailData: null,
      delKeys: null,
    }
  } else {
    return {
      mainData: {
        InspectionType: form.InspectionType,
        Title: form.Title,
        Area: form.Area,
        Remark: form.Remark || (attachments ? `[附件] ${attachments}` : ''),
        ActualDate: now,
        TotalItems: form.TotalItems || 0,
        HazardCount: form.HazardCount || 0,
        Status: 0,
      },
      detailData: null,
      delKeys: null,
    }
  }
}

function getSuccessMsg() {
  const names = { hazard: '隐患', accident: '事故', inspection: '巡查记录' }
  return `${names[currentType.value]}报告已成功提交！\n含 ${mediaFiles.value.length} 个附件`
}

function resetForm() {
  Object.keys(form).forEach((k) => {
    form[k] = typeof form[k] === 'number' ? null : ''
  })
  mediaFiles.value.forEach((m) => m.preview && URL.revokeObjectURL(m.preview))
  mediaFiles.value = []
  showSuccess.value = false
}
</script>

<style scoped>
/* ===== 全局 ===== */
.ehs-mobile {
  max-width: 480px;
  margin: 0 auto;
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e9f0 100%);
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  padding-bottom: 40px;
}

/* ===== 顶部 ===== */
.ehs-header {
  background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%);
  color: #fff;
  padding: 16px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.15);
}
.header-title {
  font-size: 18px;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 8px;
}
.header-icon {
  font-size: 22px;
}
.header-user {
  font-size: 13px;
  opacity: 0.85;
  background: rgba(255, 255, 255, 0.15);
  padding: 4px 12px;
  border-radius: 20px;
}

/* ===== 类型选择器 ===== */
.type-selector {
  display: flex;
  gap: 10px;
  padding: 16px 16px 8px;
}
.type-card {
  flex: 1;
  background: #fff;
  border: 2px solid #e8ecf1;
  border-radius: 12px;
  padding: 12px 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.25s;
}
.type-card.active {
  border-color: #2980b9;
  background: linear-gradient(135deg, #ebf5fb 0%, #d4e6f1 100%);
  box-shadow: 0 2px 8px rgba(41, 128, 185, 0.2);
}
.type-icon {
  display: block;
  font-size: 28px;
  margin-bottom: 4px;
}
.type-label {
  font-size: 13px;
  font-weight: 600;
  color: #2c3e50;
}

/* ===== 表单 ===== */
.form-section {
  padding: 8px 16px;
}
.form-group {
  margin-bottom: 14px;
}
.form-label {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: #34495e;
  margin-bottom: 6px;
}
.form-label.required::after {
  content: ' *';
  color: #e74c3c;
}
.form-input,
.form-select,
.form-textarea {
  width: 100%;
  padding: 10px 12px;
  border: 1.5px solid #d5dbe3;
  border-radius: 10px;
  font-size: 15px;
  background: #fff;
  color: #2c3e50;
  transition: border-color 0.2s;
  box-sizing: border-box;
  -webkit-appearance: none;
}
.form-input:focus,
.form-select:focus,
.form-textarea:focus {
  outline: none;
  border-color: #2980b9;
  box-shadow: 0 0 0 3px rgba(41, 128, 185, 0.1);
}
.form-textarea {
  resize: vertical;
  min-height: 80px;
}
.form-row {
  display: flex;
  gap: 12px;
}
.form-group.half {
  flex: 1;
}

/* ===== 上传区域 ===== */
.upload-section {
  margin: 20px 0 10px;
  background: #fff;
  border-radius: 14px;
  padding: 16px;
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.06);
}
.upload-tips {
  font-size: 12px;
  color: #95a5a6;
  margin: 4px 0 12px;
}
.media-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}
.media-item {
  position: relative;
  aspect-ratio: 1;
  border-radius: 10px;
  overflow: hidden;
  border: 1px solid #e8ecf1;
}
.media-thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.media-video-thumb {
  width: 100%;
  height: 100%;
  background: #2c3e50;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #fff;
}
.video-icon {
  font-size: 28px;
  margin-bottom: 4px;
}
.video-name {
  font-size: 10px;
  padding: 0 4px;
  text-align: center;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 90%;
}
.media-remove {
  position: absolute;
  top: 4px;
  right: 4px;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: rgba(231, 76, 60, 0.85);
  color: #fff;
  font-size: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
.media-add {
  aspect-ratio: 1;
  border: 2px dashed #bdc3c7;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
  background: #fafbfc;
}
.media-add:active {
  background: #ecf0f1;
  border-color: #2980b9;
}
.add-icon {
  font-size: 24px;
  margin-bottom: 2px;
}
.add-text {
  font-size: 11px;
  color: #7f8c8d;
  font-weight: 500;
}

/* ===== 提交 ===== */
.submit-section {
  margin-top: 20px;
  padding-bottom: 20px;
}
.submit-btn {
  width: 100%;
  padding: 14px;
  border: none;
  border-radius: 12px;
  font-size: 17px;
  font-weight: 700;
  color: #fff;
  background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 4px 12px rgba(39, 174, 96, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.submit-btn:active {
  transform: scale(0.98);
}
.submit-btn:disabled {
  background: #95a5a6;
  box-shadow: none;
}
.submit-loading {
  width: 18px;
  height: 18px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* ===== 成功弹层 ===== */
.success-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
  padding: 20px;
}
.success-card {
  background: #fff;
  border-radius: 20px;
  padding: 32px 24px;
  text-align: center;
  max-width: 320px;
  width: 100%;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
}
.success-icon {
  font-size: 52px;
  margin-bottom: 12px;
}
.success-title {
  font-size: 22px;
  font-weight: 700;
  color: #27ae60;
  margin-bottom: 8px;
}
.success-msg {
  font-size: 14px;
  color: #7f8c8d;
  white-space: pre-line;
  margin-bottom: 20px;
}
.success-btn {
  width: 100%;
  padding: 12px;
  border: none;
  border-radius: 10px;
  font-size: 16px;
  font-weight: 600;
  color: #fff;
  background: linear-gradient(135deg, #2980b9 0%, #3498db 100%);
  cursor: pointer;
}
</style>
