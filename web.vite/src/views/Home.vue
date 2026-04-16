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
            <div>草稿: {{ totals.draft }} · 审批: {{ totals.review }} · 已发布: {{ totals.published }}</div>
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
        <div class="metric-card red">
          <div class="metric-name">已驳回</div>
          <div class="metric-value">{{ totals.rejected }}</div>
          <div class="metric-desc">被驳回需重新整理</div>
        </div>
      </section>

      <section class="dashboard-grid">
        <!-- 状态分布柱状图 -->
        <div class="panel chart-panel">
          <div class="panel-header">
            <div class="panel-title">状态分布</div>
          </div>
          <div class="bar-chart">
            <div class="bar-row" v-for="bar in statusBars" :key="bar.label">
              <div class="bar-label">{{ bar.label }}</div>
              <div class="bar-track">
                <div class="bar-fill" :style="{ width: bar.pct + '%', background: bar.color }"></div>
              </div>
              <div class="bar-count">{{ bar.count }}</div>
            </div>
          </div>
        </div>

        <!-- 产品线饼状分布 -->
        <div class="panel chart-panel">
          <div class="panel-header">
            <div class="panel-title">产品线分布</div>
          </div>
          <div class="donut-container">
            <div class="donut-ring">
              <svg viewBox="0 0 36 36" class="donut-svg">
                <circle cx="18" cy="18" r="15.9" fill="none" stroke="#e2e8f0" stroke-width="3.8" />
                <circle v-for="(seg, i) in donutSegments" :key="i" cx="18" cy="18" r="15.9" fill="none" :stroke="seg.color" stroke-width="3.8"
                  :stroke-dasharray="seg.dashArray" :stroke-dashoffset="seg.offset" stroke-linecap="round" />
              </svg>
              <div class="donut-center">{{ productLines.length }}<small>产品线</small></div>
            </div>
            <div class="donut-legend">
              <div class="legend-item" v-for="(item, i) in productLines.slice(0, 6)" :key="item.name">
                <span class="legend-dot" :style="{ background: pieColors[i % pieColors.length] }"></span>
                <span class="legend-name">{{ item.name }}</span>
                <span class="legend-count">{{ item.count }}</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section class="personal-grid">
        <!-- 我的收藏 -->
        <div class="panel">
          <div class="panel-header">
            <div class="panel-title">⭐ 我的收藏</div>
            <el-button link type="primary" @click="goToPage('/LL_LessonLearn')">查看全部</el-button>
          </div>
          <div v-if="myFavorites.length === 0" class="empty-state">暂无收藏记录。可在 Case Detail 页面点击"我的收藏"按钮收藏。</div>
          <div v-else class="lesson-list">
            <div class="lesson-row" v-for="item in myFavorites" :key="item.lessonLearn_Id" @click="openDetail(item)">
              <div class="lesson-main">
                <div class="lesson-title">{{ item.titleEn || item.titleCn || item.lessonNo || '-' }}</div>
                <div class="lesson-sub">{{ item.lessonNo || '-' }} · {{ item.category || '未分类' }}</div>
              </div>
              <el-tag :type="statusType(item.status)" size="small">{{ statusText(item.status) }}</el-tag>
            </div>
          </div>
        </div>

        <!-- 我的任务 -->
        <div class="panel">
          <div class="panel-header">
            <div class="panel-title">📋 我的任务</div>
            <el-button link type="primary" @click="goToPage('/LL_TaskCenter')">查看全部</el-button>
          </div>
          <div v-if="myTasks.length === 0" class="empty-state">暂无分配给您的任务。</div>
          <div v-else class="task-list">
            <div class="task-row" v-for="task in myTasks" :key="task.lessonNo + task.title">
              <div class="task-main">
                <div class="task-title">{{ task.title }}</div>
                <div class="task-sub">{{ task.lessonNo || '-' }} · {{ task.owner || '待分配' }}</div>
              </div>
              <div class="task-side">
                <el-progress :percentage="task.progress || 0" :stroke-width="8" :show-text="false" style="width:80px" />
                <el-tag :type="taskTagType(task.progress)" size="small">{{ taskProgressLabel(task.progress) }}</el-tag>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section class="content-grid">
        <div class="panel">
          <div class="panel-header">
            <div class="panel-title">最近 Lesson Learn</div>
            <el-button link type="primary" @click="goToPage('/LL_LessonLearn')">查看全部</el-button>
          </div>
          <div v-if="loading" class="empty-state">加载中...</div>
          <div v-else-if="recentLessons.length === 0" class="empty-state">暂无数据，请先创建 Lesson Learn 记录。</div>
          <div v-else class="lesson-list">
            <div class="lesson-row" v-for="item in recentLessons" :key="item.lessonLearn_Id || item.lessonNo" @click="openDetail(item)">
              <div class="lesson-main">
                <div class="lesson-title">{{ item.titleEn || item.titleCn || item.lessonNo || '-' }}</div>
                <div class="lesson-sub">{{ item.lessonNo || '-' }} · {{ item.category || '未分类' }} · 👁 {{ item.viewCount || 0 }} ❤ {{ item.likeCount || 0 }}</div>
              </div>
              <div class="lesson-side">
                <el-tag :type="statusType(item.status)" size="small">{{ statusText(item.status) }}</el-tag>
              </div>
            </div>
          </div>
        </div>

        <div class="panel accent">
          <div class="panel-header">
            <div class="panel-title">热门标签</div>
          </div>
          <div class="tag-cloud">
            <el-tag v-for="tag in topTags" :key="tag.name" effect="plain" class="cloud-tag" @click="goToPage('/LL_LessonLearn')">{{ tag.name }} ({{ tag.count }})</el-tag>
          </div>
          <div v-if="topTags.length === 0" class="empty-state">暂无标签统计数据</div>
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
import { useStore } from 'vuex'
import http from '@/api/http.js'

const router = useRouter()
const store = useStore()
const loading = ref(false)
const recentLessons = ref([])
const myFavorites = ref([])
const myTasks = ref([])
const topTags = ref([])
const productLines = ref([])
const pieColors = ['#6366f1', '#f59e0b', '#22c55e', '#ef4444', '#14b8a6', '#f97316', '#8b5cf6', '#06b6d4']
const totals = reactive({
  all: 0,
  draft: 0,
  review: 0,
  rejected: 0,
  published: 0
})

const quickLinks = [
  { name: 'Dashboard', path: '/LL_Dashboard', icon: '📊', desc: '首页工作台与知识分布' },
  { name: 'Search Case', path: '/LL_LessonLearn', icon: '🔍', desc: '快速检索、筛选和打开案例' },
  { name: 'Case Detail', path: '/LL_CaseDetail', icon: '📝', desc: '一页式录入标题、根因、附件和评审' },
  { name: 'Review Center', path: '/LL_ReviewCenter', icon: '✅', desc: '多轮评审链和审批结果' },
  { name: 'Task Center', path: '/LL_TaskCenter', icon: '📋', desc: '文件更新任务和闭环进度' },
  { name: 'Document Center', path: '/LL_DocumentCenter', icon: '📁', desc: '标准文件、附件和下载统计' },
  { name: 'Problem Center', path: '/LL_ProblemCenter', icon: '🚨', desc: '问题流转、闭环追踪与一键转 LL' },
  { name: 'Exploded View', path: '/LL_ExplodedView', icon: '🔧', desc: '产品爆炸图知识库与零件 LL 关联' },
  { name: 'Periodic Review', path: '/LL_PeriodicReview', icon: '🔄', desc: '已发布 LL 的定期审阅与有效性确认' },
  { name: 'Analytics', path: '/LL_Analytics', icon: '📈', desc: '标签、产品线和状态统计' },
  { name: 'Base Data', path: '/LL_MasterDataPlant', icon: '⚙️', desc: '工厂、车间、线体与标签主数据维护' }
]

const currentDate = computed(() => {
  const now = new Date()
  return now.toLocaleDateString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit' })
})

const statusBars = computed(() => {
  const max = Math.max(totals.draft, totals.review, totals.rejected, totals.published, 1)
  return [
    { label: '编辑中', count: totals.draft, pct: (totals.draft / max) * 100, color: '#3b82f6' },
    { label: '审批中', count: totals.review, pct: (totals.review / max) * 100, color: '#f59e0b' },
    { label: '已发布', count: totals.published, pct: (totals.published / max) * 100, color: '#22c55e' },
    { label: '已驳回', count: totals.rejected, pct: (totals.rejected / max) * 100, color: '#ef4444' }
  ]
})

const donutSegments = computed(() => {
  const total = productLines.value.reduce((s, p) => s + p.count, 0) || 1
  const segments = []
  let offset = 25
  productLines.value.slice(0, 6).forEach((item, i) => {
    const pct = (item.count / total) * 100
    segments.push({
      color: pieColors[i % pieColors.length],
      dashArray: `${pct} ${100 - pct}`,
      offset: offset
    })
    offset -= pct
  })
  return segments
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

const taskTagType = (progress) => {
  if ((progress || 0) >= 100) return 'success'
  if ((progress || 0) >= 50) return 'warning'
  return 'info'
}

const taskProgressLabel = (progress) => {
  if ((progress || 0) >= 100) return '完成'
  if ((progress || 0) >= 50) return '进行中'
  return '待开始'
}

const searchPayload = (status) => ({
  page: 1,
  pageSize: status === undefined ? 8 : 1,
  keyword: '',
  tag: '',
  category: '',
  status,
  productLine: ''
})

const loadLessons = async () => {
  loading.value = true
  try {
    const [allRes, draftRes, reviewRes, publishedRes, rejectedRes] = await Promise.all([
      http.post('/api/LL_LessonLearn/Search', searchPayload(undefined), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(0), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(1), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(3), false),
      http.post('/api/LL_LessonLearn/Search', searchPayload(2), false)
    ])

    if (allRes?.status) {
      recentLessons.value = allRes.data?.items || []
      totals.all = allRes.data?.total || 0
    }
    totals.draft = draftRes?.status ? draftRes.data?.total || 0 : 0
    totals.review = reviewRes?.status ? reviewRes.data?.total || 0 : 0
    totals.published = publishedRes?.status ? publishedRes.data?.total || 0 : 0
    totals.rejected = rejectedRes?.status ? rejectedRes.data?.total || 0 : 0

    // 构建产品线和标签统计
    const items = recentLessons.value
    const plMap = new Map()
    const tagMap = new Map()
    items.forEach(item => {
      const pls = (item.applicableProductLinesText || '').split(',').map(s => s.trim()).filter(Boolean)
      pls.forEach(pl => plMap.set(pl, (plMap.get(pl) || 0) + 1))
      const tgs = (item.tagsText || '').split(',').map(s => s.trim()).filter(Boolean)
      tgs.forEach(t => tagMap.set(t, (tagMap.get(t) || 0) + 1))
    })
    productLines.value = [...plMap.entries()].map(([name, count]) => ({ name, count })).sort((a, b) => b.count - a.count)
    topTags.value = [...tagMap.entries()].map(([name, count]) => ({ name, count })).sort((a, b) => b.count - a.count).slice(0, 12)

    // 模拟"我的收藏"——取前3条有收藏的
    myFavorites.value = items.filter(x => (x.favoriteCount || 0) > 0).slice(0, 5)

    // 加载任务
    loadTasks()
  } finally {
    loading.value = false
  }
}

const loadTasks = async () => {
  try {
    const userInfo = store.getters.getUserInfo?.() || {}
    const userName = userInfo?.userName || ''
    // 尝试加载任务列表
    const res = await http.post('/api/LL_LessonLearn/Search', { page: 1, pageSize: 30 }, false)
    if (!res?.status) return
    const items = res.data?.items || []
    // 模拟从详情抽取任务（简化为取前2条有任务的 LL）
    const tasks = []
    for (const item of items.slice(0, 6)) {
      try {
        const detail = await http.get(`/api/LL_LessonLearn/Detail/${item.lessonLearn_Id}?increaseView=false`, {}, false)
        if (detail?.status && detail.data?.tasks?.length) {
          detail.data.tasks.forEach(t => {
            if ((t.progress || 0) < 100) {
              tasks.push({
                lessonLearn_Id: item.lessonLearn_Id,
                lessonNo: item.lessonNo || detail.data.lessonNo,
                title: t.title,
                owner: t.owner,
                progress: t.progress,
                dueDate: t.dueDate
              })
            }
          })
        }
      } catch { /* skip */ }
      if (tasks.length >= 5) break
    }
    myTasks.value = tasks
  } catch { /* silent */ }
}

const openDetail = (item) => {
  const id = item?.lessonLearn_Id || item?.LessonLearn_Id
  if (id) {
    router.push({ path: '/LL_CaseDetail', query: { id } })
  }
}

const goToPage = (path) => { router.push(path) }

onMounted(() => { loadLessons() })
</script>

<style scoped>
.ll-home {
  position: absolute;
  width: 100%;
  height: 100%;
  background:
    radial-gradient(circle at top left, rgba(99, 102, 241, 0.12), transparent 28%),
    linear-gradient(180deg, #f6f8fc 0%, #eef2f7 100%);
}

.hero {
  margin: 0;
  padding: 30px 34px;
  display: grid;
  grid-template-columns: minmax(0, 1.4fr) minmax(320px, 0.8fr);
  gap: 24px;
  background: linear-gradient(135deg, #1e1b4b 0%, #312e81 42%, #4f46e5 100%);
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
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(6px);
}

.hero-stat { margin-bottom: 18px; }
.stat-label { font-size: 14px; opacity: 0.75; }
.stat-value { margin-top: 8px; font-size: 58px; font-weight: 700; line-height: 1; }

.hero-meta {
  display: grid;
  gap: 8px;
  font-size: 13px;
  opacity: 0.88;
}

/* Metric Cards */
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
  border: 1px solid rgba(99, 102, 241, 0.06);
  box-shadow: 0 14px 32px rgba(25, 44, 71, 0.06);
  transition: transform 0.2s, box-shadow 0.2s;
}
.metric-card:hover { transform: translateY(-2px); box-shadow: 0 18px 40px rgba(25, 44, 71, 0.1); }
.metric-card.blue { border-top: 4px solid #3b82f6; }
.metric-card.amber { border-top: 4px solid #f59e0b; }
.metric-card.green { border-top: 4px solid #22c55e; }
.metric-card.red { border-top: 4px solid #ef4444; }
.metric-name { color: #64748b; font-size: 14px; }
.metric-value { margin: 14px 0 8px; font-size: 38px; font-weight: 700; color: #0f172a; }
.metric-desc { color: #94a3b8; font-size: 13px; }

/* Dashboard Charts Grid */
.dashboard-grid {
  padding: 24px 34px 0;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 18px;
}

.chart-panel { min-height: 220px; }

/* Bar Chart */
.bar-chart { display: grid; gap: 14px; padding-top: 8px; }
.bar-row { display: grid; grid-template-columns: 80px 1fr 50px; gap: 12px; align-items: center; }
.bar-label { font-size: 13px; font-weight: 600; color: #475569; text-align: right; }
.bar-track { height: 28px; border-radius: 14px; background: #f1f5f9; overflow: hidden; }
.bar-fill { height: 100%; border-radius: 14px; transition: width 0.6s ease; min-width: 4px; }
.bar-count { font-size: 18px; font-weight: 700; color: #0f172a; }

/* Donut Chart */
.donut-container { display: flex; gap: 24px; align-items: center; padding-top: 8px; }
.donut-ring { position: relative; width: 140px; height: 140px; flex-shrink: 0; }
.donut-svg { width: 100%; height: 100%; transform: rotate(-90deg); }
.donut-center { position: absolute; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center; font-size: 28px; font-weight: 700; color: #0f172a; }
.donut-center small { font-size: 11px; font-weight: 400; color: #94a3b8; margin-top: 2px; }
.donut-legend { display: grid; gap: 8px; }
.legend-item { display: flex; align-items: center; gap: 8px; font-size: 13px; }
.legend-dot { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
.legend-name { color: #475569; min-width: 80px; }
.legend-count { font-weight: 700; color: #0f172a; }

/* Personal Grid */
.personal-grid {
  padding: 24px 34px 0;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 18px;
}

/* Common Panel */
.panel {
  background: rgba(255, 255, 255, 0.92);
  border-radius: 24px;
  padding: 22px 24px;
  box-shadow: 0 14px 32px rgba(25, 44, 71, 0.06);
}

.panel.accent {
  background: linear-gradient(180deg, rgba(99, 102, 241, 0.04) 0%, rgba(255, 255, 255, 0.96) 100%);
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

/* Lesson List */
.lesson-list, .task-list { display: grid; gap: 10px; }

.lesson-row, .task-row {
  border-radius: 14px;
  padding: 14px 16px;
  background: #f8fafc;
  border: 1px solid rgba(148, 163, 184, 0.14);
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
}

.lesson-row:hover, .task-row:hover {
  border-color: rgba(99, 102, 241, 0.3);
  background: #f0f0ff;
}

.lesson-title, .task-title { font-size: 14px; font-weight: 600; color: #0f172a; }
.lesson-sub, .task-sub { margin-top: 4px; font-size: 12px; color: #64748b; }
.task-side { display: flex; align-items: center; gap: 10px; }

/* Tag Cloud */
.tag-cloud { display: flex; flex-wrap: wrap; gap: 8px; }
.cloud-tag { cursor: pointer; }

.empty-state { padding: 18px 0; color: #94a3b8; font-size: 13px; }

/* Content Grid */
.content-grid {
  padding: 24px 34px 0;
  display: grid;
  grid-template-columns: minmax(0, 1.3fr) minmax(300px, 0.7fr);
  gap: 18px;
}

/* Quick Links */
.quick-links { padding: 24px 34px 34px; }
.section-title { margin-bottom: 14px; font-size: 18px; font-weight: 700; color: #0f172a; }

.link-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 16px;
}

.link-card {
  padding: 18px 20px;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.92);
  box-shadow: 0 14px 32px rgba(25, 44, 71, 0.06);
  cursor: pointer;
  transition: transform 0.2s;
}
.link-card:hover { transform: translateY(-2px); }
.link-icon { font-size: 28px; line-height: 1; }
.link-name { margin-top: 12px; font-size: 15px; font-weight: 600; color: #0f172a; }
.link-desc { margin-top: 6px; font-size: 12px; color: #64748b; }

@media (max-width: 1200px) {
  .cards, .dashboard-grid, .personal-grid, .content-grid, .hero { grid-template-columns: 1fr; }
  .link-grid { grid-template-columns: 1fr 1fr; }
}

@media (max-width: 768px) {
  .hero, .cards, .dashboard-grid, .personal-grid, .content-grid { padding-left: 16px; padding-right: 16px; }
  .cards { grid-template-columns: 1fr 1fr; }
  .link-grid { grid-template-columns: 1fr; }
  .hero h1 { font-size: 28px; }
  .hero-actions { flex-direction: column; }
}
</style>
