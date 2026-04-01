<template>
  <div class="ll-home">
    <el-scrollbar style="height: 100%">
      <section class="hero">
        <div class="hero-copy">
          <div class="eyebrow">Lesson Learn Workspace</div>
          <h1>经验教训中心</h1>
          <p>面向 Lesson Learn 的独立知识沉淀平台，聚焦问题、根因、措施和复用。</p>
          <div class="hero-actions">
            <el-button type="primary" size="large" @click="goToPage('/LL_LessonLearn')">进入 Search Case</el-button>
            <el-button size="large" @click="goToPage('/LL_CaseDetail')">新建 Case Detail</el-button>
          </div>
        </div>
        <div class="hero-side">
          <div class="hero-stat">
            <div class="stat-label">总记录数</div>
            <div class="stat-value">{{ totals.all }}</div>
          </div>
          <div class="hero-meta">
            <div>主库: vol_pro_ll_main</div>
            <div>业务库: vol_pro_ll_service</div>
            <div>当前日期: {{ currentDate }}</div>
          </div>
        </div>
      </section>

      <section class="cards">
        <div class="metric-card blue">
          <div class="metric-name">草稿</div>
          <div class="metric-value">{{ totals.draft }}</div>
          <div class="metric-desc">编辑中的 Lesson Learn</div>
        </div>
        <div class="metric-card amber">
          <div class="metric-name">审批中</div>
          <div class="metric-value">{{ totals.review }}</div>
          <div class="metric-desc">等待审批处理</div>
        </div>
        <div class="metric-card green">
          <div class="metric-name">已发布</div>
          <div class="metric-value">{{ totals.published }}</div>
          <div class="metric-desc">可供复用的知识资产</div>
        </div>
        <div class="metric-card slate">
          <div class="metric-name">最新列表页</div>
          <div class="metric-value">LL</div>
          <div class="metric-desc">菜单入口已切换为 Lesson Learn</div>
        </div>
      </section>

      <section class="content-grid">
        <div class="panel">
          <div class="panel-header">
            <div class="panel-title">最近 Lesson Learn</div>
            <el-button link type="primary" @click="goToPage('/LL_LessonLearn')">查看全部</el-button>
          </div>
          <div v-if="loading" class="empty-state">加载中...</div>
          <div v-else-if="recentLessons.length === 0" class="empty-state">暂无数据，请先执行 Lesson Learn 初始化 SQL。</div>
          <div v-else class="lesson-list">
            <div class="lesson-row" v-for="item in recentLessons" :key="item.lessonLearn_Id || item.lessonNo" @click="goToPage('/LL_LessonLearn')">
              <div class="lesson-main">
                <div class="lesson-title">{{ item.titleEn || item.titleCn || item.lessonNo || '-' }}</div>
                <div class="lesson-sub">{{ item.lessonNo || '-' }} · {{ item.category || '未分类' }}</div>
              </div>
              <div class="lesson-side">
                <el-tag :type="statusType(item.status)">{{ statusText(item.status) }}</el-tag>
              </div>
            </div>
          </div>
        </div>

        <div class="panel accent">
          <div class="panel-header">
            <div class="panel-title">当前阶段建议</div>
          </div>
          <div class="guide-list">
            <div class="guide-item">
              <div class="guide-name">1. 先验证菜单链路</div>
              <div class="guide-desc">通过左侧 Lesson Learn 菜单进入，而不是只靠地址栏直达。</div>
            </div>
            <div class="guide-item">
              <div class="guide-name">2. 再验证业务数据</div>
              <div class="guide-desc">确认 `vol_pro_ll_service.dbo.LL_LessonLearn` 已有初始化数据或迁移数据。</div>
            </div>
            <div class="guide-item">
              <div class="guide-name">3. 清理旧样板菜单</div>
              <div class="guide-desc">禁用 EHS、MES、Demo 等样板菜单，避免独立实例继续混杂。</div>
            </div>
          </div>
        </div>
      </section>

      <section class="quick-links">
        <div class="section-title">平台导航</div>
        <div class="link-grid">
          <div class="link-card" v-for="item in quickLinks" :key="item.path" @click="goToPage(item.path)">
            <div class="link-icon">{{ item.icon }}</div>
            <div class="link-name">{{ item.name }}</div>
            <div class="link-desc">{{ item.desc }}</div>
          </div>
        </div>
      </section>
    </el-scrollbar>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import http from '@/api/http.js'

const router = useRouter()
const loading = ref(false)
const recentLessons = ref([])
const totals = reactive({
  all: 0,
  draft: 0,
  review: 0,
  published: 0
})
const quickLinks = [
  { name: 'Dashboard', path: '/LL_Dashboard', icon: '01', desc: '首页工作台与知识分布' },
  { name: 'Search Case', path: '/LL_LessonLearn', icon: '02', desc: '快速检索、筛选和打开案例' },
  { name: 'Case Detail', path: '/LL_CaseDetail', icon: '03', desc: '一页式录入标题、根因、附件和评审' },
  { name: 'Review Center', path: '/LL_ReviewCenter', icon: '04', desc: '多轮评审链和审批结果' },
  { name: 'Task Center', path: '/LL_TaskCenter', icon: '05', desc: '文件更新任务和闭环进度' },
  { name: 'Document Center', path: '/LL_DocumentCenter', icon: '06', desc: '标准文件、附件和下载统计' },
  { name: 'Analytics', path: '/LL_Analytics', icon: '07', desc: '标签、产品线和状态统计' },
  { name: 'Base Data', path: '/LL_MasterDataPlant', icon: '08', desc: '工厂、车间、线体与标签主数据维护' }
]

const currentDate = computed(() => {
  const now = new Date()
  return now.toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  })
})

const searchPayload = (status) => ({
  page: 1,
  pageSize: status === undefined ? 6 : 1,
  keyword: '',
  tag: '',
  category: '',
  status,
  productLine: ''
})

const statusText = (status) => {
  if (status === 1) return '审批中'
  if (status === 2) return '已驳回'
  if (status === 3) return '已发布'
  return '编辑中'
}

const statusType = (status) => {
  if (status === 1) return 'warning'
  if (status === 2) return 'danger'
  if (status === 3) return 'success'
  return 'info'
}

const loadLessons = async () => {
  loading.value = true
  try {
    const [allRes, draftRes, reviewRes, publishedRes] = await Promise.all([
      http.post('/api/LL_LessonLearn/Search', searchPayload(undefined), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(0), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(1), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(3), false)
    ])

    if (allRes?.status) {
      recentLessons.value = allRes.data?.items || []
      totals.all = allRes.data?.total || 0
    }
    totals.draft = draftRes?.status ? draftRes.data?.total || 0 : 0
    totals.review = reviewRes?.status ? reviewRes.data?.total || 0 : 0
    totals.published = publishedRes?.status ? publishedRes.data?.total || 0 : 0
  } finally {
    loading.value = false
  }
}

const goToPage = (path) => {
  router.push(path)
}

onMounted(() => {
  loadLessons()
})
</script>

<style scoped>
.ll-home {
  position: absolute;
  width: 100%;
  height: 100%;
  background:
    radial-gradient(circle at top left, rgba(17, 94, 89, 0.16), transparent 28%),
    linear-gradient(180deg, #f6fbfa 0%, #eef3f8 100%);
}

.hero {
  margin: 0;
  padding: 30px 34px;
  display: grid;
  grid-template-columns: minmax(0, 1.4fr) minmax(320px, 0.8fr);
  gap: 24px;
  background: linear-gradient(135deg, #0f4c5c 0%, #125e63 42%, #1f7a8c 100%);
  color: #fff;
}

.eyebrow {
  font-size: 13px;
  letter-spacing: 1.8px;
  text-transform: uppercase;
  opacity: 0.75;
}

.hero h1 {
  margin: 10px 0 12px;
  font-size: 34px;
  line-height: 1.15;
}

.hero p {
  max-width: 620px;
  margin: 0;
  font-size: 15px;
  line-height: 1.7;
  opacity: 0.9;
}

.hero-actions {
  margin-top: 22px;
  display: flex;
  gap: 12px;
}

.hero-side {
  padding: 24px;
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.12);
  backdrop-filter: blur(6px);
}

.hero-stat {
  margin-bottom: 18px;
}

.stat-label {
  font-size: 14px;
  opacity: 0.75;
}

.stat-value {
  margin-top: 8px;
  font-size: 58px;
  font-weight: 700;
  line-height: 1;
}

.hero-meta {
  display: grid;
  gap: 8px;
  font-size: 13px;
  opacity: 0.88;
}

.cards {
  padding: 24px 34px 0;
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
}

.metric-card {
  padding: 22px 24px;
  border-radius: 22px;
  background: #fff;
  border: 1px solid rgba(15, 76, 92, 0.08);
  box-shadow: 0 14px 32px rgba(25, 44, 71, 0.08);
}

.metric-card.blue {
  border-top: 4px solid #3b82f6;
}

.metric-card.amber {
  border-top: 4px solid #f59e0b;
}

.metric-card.green {
  border-top: 4px solid #22c55e;
}

.metric-card.slate {
  border-top: 4px solid #475569;
}

.metric-name {
  color: #64748b;
  font-size: 14px;
}

.metric-value {
  margin: 14px 0 8px;
  font-size: 38px;
  font-weight: 700;
  color: #0f172a;
}

.metric-desc {
  color: #94a3b8;
  font-size: 13px;
}

.content-grid {
  padding: 24px 34px 34px;
  display: grid;
  grid-template-columns: minmax(0, 1.3fr) minmax(320px, 0.7fr);
  gap: 18px;
}

.panel {
  background: rgba(255, 255, 255, 0.92);
  border-radius: 24px;
  padding: 22px 24px;
  box-shadow: 0 18px 40px rgba(25, 44, 71, 0.08);
}

.panel.accent {
  background: linear-gradient(180deg, rgba(15, 76, 92, 0.05) 0%, rgba(255, 255, 255, 0.96) 100%);
}

.panel-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 14px;
}

.panel-title {
  font-size: 18px;
  font-weight: 700;
  color: #0f172a;
}

.lesson-list,
.guide-list {
  display: grid;
  gap: 12px;
}

.lesson-row,
.guide-item {
  border-radius: 16px;
  padding: 16px 18px;
  background: #f8fafc;
  border: 1px solid rgba(148, 163, 184, 0.18);
}

.lesson-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
}

.lesson-row:hover {
  border-color: rgba(15, 118, 110, 0.34);
  background: #f0fdfa;
}

.lesson-title,
.guide-name {
  font-size: 15px;
  font-weight: 600;
  color: #0f172a;
}

.lesson-sub,
.guide-desc,
.empty-state {
  margin-top: 6px;
  font-size: 13px;
  color: #64748b;
}

.empty-state {
  padding: 22px 0;
}

.quick-links {
  padding: 0 34px 34px;
}

.section-title {
  margin-bottom: 14px;
  font-size: 18px;
  font-weight: 700;
  color: #0f172a;
}

.link-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 16px;
}

.link-card {
  padding: 18px 20px;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.92);
  box-shadow: 0 18px 40px rgba(25, 44, 71, 0.08);
  cursor: pointer;
}

.link-card:hover {
  transform: translateY(-2px);
  transition: 0.2s ease;
}

.link-icon {
  width: 42px;
  height: 42px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #0f766e 0%, #1d4ed8 100%);
  color: #fff;
  font-weight: 700;
  letter-spacing: 1px;
}

.link-name {
  margin-top: 14px;
  font-size: 16px;
  font-weight: 600;
  color: #0f172a;
}

.link-desc {
  margin-top: 6px;
  font-size: 13px;
  color: #64748b;
}

@media (max-width: 1200px) {
  .cards,
  .content-grid,
  .hero {
    grid-template-columns: 1fr;
  }

  .link-grid {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 768px) {
  .hero,
  .cards,
  .content-grid {
    padding-left: 16px;
    padding-right: 16px;
  }

  .cards {
    grid-template-columns: 1fr;
  }

  .link-grid {
    grid-template-columns: 1fr;
  }

  .hero h1 {
    font-size: 28px;
  }

  .hero-actions {
    flex-direction: column;
  }
}
</style>
