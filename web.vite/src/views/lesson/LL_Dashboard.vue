<template>
  <div class="dashboard-page">
    <el-scrollbar style="height: 100%">
      <!-- 页面标题 -->
      <div class="page-header">
        <div>
          <div class="eyebrow">Lesson Learn Dashboard</div>
          <h2>知识资产统计看板</h2>
          <p>多维度洞察 Lesson Learn 知识库的分布、趋势和复用情况，点击图表可跳转到相关列表。</p>
        </div>
        <div class="header-actions">
          <el-button @click="$router.push('/LL_LessonLearn')">进入 Search Case</el-button>
          <el-button type="primary" @click="$router.push('/LL_CaseDetail')">新建 Case</el-button>
          <el-button @click="loadAllData" :loading="loading">刷新数据</el-button>
        </div>
      </div>

      <!-- KPI 摘要卡片 -->
      <div class="kpi-row">
        <div class="kpi-card" @click="jumpToList(null)">
          <div class="kpi-icon total">📊</div>
          <div class="kpi-body"><div class="kpi-label">LL 总数</div><div class="kpi-value">{{ kpi.total }}</div></div>
        </div>
        <div class="kpi-card" @click="jumpToList(0)">
          <div class="kpi-icon draft">📝</div>
          <div class="kpi-body"><div class="kpi-label">编辑中</div><div class="kpi-value">{{ kpi.draft }}</div></div>
        </div>
        <div class="kpi-card" @click="jumpToList(1)">
          <div class="kpi-icon review">⏳</div>
          <div class="kpi-body"><div class="kpi-label">审批中</div><div class="kpi-value">{{ kpi.review }}</div></div>
        </div>
        <div class="kpi-card" @click="jumpToList(3)">
          <div class="kpi-icon published">✅</div>
          <div class="kpi-body"><div class="kpi-label">已发布</div><div class="kpi-value">{{ kpi.published }}</div></div>
        </div>
        <div class="kpi-card" @click="jumpToList(2)">
          <div class="kpi-icon rejected">❌</div>
          <div class="kpi-body"><div class="kpi-label">已驳回</div><div class="kpi-value">{{ kpi.rejected }}</div></div>
        </div>
        <div class="kpi-card" @click="$router.push('/LL_ProblemCenter')">
          <div class="kpi-icon problem">🚨</div>
          <div class="kpi-body"><div class="kpi-label">Open 问题</div><div class="kpi-value">{{ kpi.openProblems }}</div></div>
        </div>
      </div>

      <!-- 图表行-1: 产品线堆叠柱状图 + Issue Source 饼图 -->
      <div class="chart-row">
        <div class="chart-panel wide">
          <div class="panel-header">
            <div class="panel-title">📦 按产品线统计（堆叠柱状图）</div>
            <el-tag size="small" type="info">点击柱体跳转</el-tag>
          </div>
          <div ref="plBarRef" class="chart-area" style="height: 360px"></div>
        </div>
        <div class="chart-panel narrow">
          <div class="panel-header">
            <div class="panel-title">🔗 Issue Source 分布</div>
          </div>
          <div ref="issueSourceRef" class="chart-area" style="height: 360px"></div>
        </div>
      </div>

      <!-- 图表行-2: 月度趋势 + LL 属性分布 -->
      <div class="chart-row">
        <div class="chart-panel wide">
          <div class="panel-header">
            <div class="panel-title">📈 月度新增/关闭趋势</div>
          </div>
          <div ref="trendRef" class="chart-area" style="height: 320px"></div>
        </div>
        <div class="chart-panel narrow">
          <div class="panel-header">
            <div class="panel-title">📋 LL 属性分布</div>
          </div>
          <div ref="levelRef" class="chart-area" style="height: 320px"></div>
        </div>
      </div>

      <!-- 图表行-3: 分类 + Active/Inactive -->
      <div class="chart-row">
        <div class="chart-panel">
          <div class="panel-header">
            <div class="panel-title">📊 按分类统计</div>
          </div>
          <div ref="categoryRef" class="chart-area" style="height: 300px"></div>
        </div>
        <div class="chart-panel">
          <div class="panel-header">
            <div class="panel-title">🔄 Active / Inactive 状态</div>
          </div>
          <div ref="activeRef" class="chart-area" style="height: 300px"></div>
        </div>
      </div>

      <!-- 底部快捷入口 -->
      <div class="quick-row">
        <div class="quick-card" v-for="item in quickLinks" :key="item.path" @click="$router.push(item.path)">
          <div class="quick-icon">{{ item.icon }}</div>
          <div class="quick-name">{{ item.name }}</div>
          <div class="quick-desc">{{ item.desc }}</div>
        </div>
      </div>
    </el-scrollbar>
  </div>
</template>

<script setup>
import { nextTick, onMounted, onUnmounted, ref, reactive, markRaw } from 'vue'
import { useRouter } from 'vue-router'
import * as echarts from 'echarts'
import http from '@/api/http.js'

const router = useRouter()
const loading = ref(false)

const plBarRef = ref(null)
const issueSourceRef = ref(null)
const trendRef = ref(null)
const levelRef = ref(null)
const categoryRef = ref(null)
const activeRef = ref(null)
let charts = []

const kpi = reactive({ total: 0, draft: 0, review: 0, published: 0, rejected: 0, openProblems: 0 })

const quickLinks = [
  { name: 'Search Case', path: '/LL_LessonLearn', icon: '🔍', desc: '检索和筛选案例' },
  { name: 'Task Center', path: '/LL_TaskCenter', icon: '📋', desc: '任务闭环追踪' },
  { name: 'Problem Center', path: '/LL_ProblemCenter', icon: '🚨', desc: '问题管理和转化 LL' },
  { name: 'Review Center', path: '/LL_ReviewCenter', icon: '✅', desc: '多轮评审记录' },
  { name: 'Analytics', path: '/LL_Analytics', icon: '📈', desc: '标签和热度分析' },
  { name: 'Periodic Review', path: '/LL_PeriodicReview', icon: '🔄', desc: '定期审阅调度' }
]

const statusColors = { draft: '#3b82f6', review: '#f59e0b', published: '#22c55e', rejected: '#ef4444' }
const statusNames = { draft: '编辑中', review: '审批中', published: '已发布', rejected: '已驳回' }

const jumpToList = (status) => {
  const query = status !== null && status !== undefined ? { status } : {}
  router.push({ path: '/LL_LessonLearn', query })
}

// ========== 数据加载 ==========
const loadAllData = async () => {
  loading.value = true
  try {
    const res = await http.post('/api/LL_LessonLearn/Search', { page: 1, pageSize: 500 }, false)
    const items = res?.status ? (res.data?.items || []) : []

    // KPI
    kpi.total = res?.data?.total || items.length
    kpi.draft = items.filter(x => x.status === 0 || x.status == null).length
    kpi.review = items.filter(x => x.status === 1).length
    kpi.published = items.filter(x => x.status === 3).length
    kpi.rejected = items.filter(x => x.status === 2).length

    // 尝试加载问题中心数据
    try {
      const pRes = await http.post('/api/LL_ProblemCenter/Search', { page: 1, pageSize: 1, status: 'Open' }, false)
      kpi.openProblems = pRes?.status ? (pRes.data?.total || pRes.data?.Total || 0) : 0
    } catch { kpi.openProblems = 0 }

    await nextTick()
    renderCharts(items)
  } finally {
    loading.value = false
  }
}

// ========== 图表渲染 ==========
const initChart = (domRef) => {
  if (!domRef) return null
  const inst = echarts.init(domRef)
  charts.push(inst)
  return inst
}

const renderCharts = (items) => {
  // 销毁旧实例
  charts.forEach(c => c?.dispose?.())
  charts = []

  renderProductLineBar(items)
  renderIssueSourcePie(items)
  renderMonthlyTrend(items)
  renderLevelPie(items)
  renderCategoryBar(items)
  renderActivePie(items)
}

// 产品线堆叠柱状图
const renderProductLineBar = (items) => {
  const chart = initChart(plBarRef.value)
  if (!chart) return

  const plMap = {}
  items.forEach(item => {
    const pls = (item.applicableProductLinesText || '').split(',').map(s => s.trim()).filter(Boolean)
    const st = item.status
    const statusKey = st === 1 ? 'review' : st === 2 ? 'rejected' : st === 3 ? 'published' : 'draft'
    pls.forEach(pl => {
      if (!plMap[pl]) plMap[pl] = { draft: 0, review: 0, published: 0, rejected: 0 }
      plMap[pl][statusKey]++
    })
  })

  const plNames = Object.keys(plMap).sort((a, b) => {
    const sumA = Object.values(plMap[a]).reduce((s, v) => s + v, 0)
    const sumB = Object.values(plMap[b]).reduce((s, v) => s + v, 0)
    return sumB - sumA
  })

  chart.setOption({
    tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
    legend: { data: Object.values(statusNames), top: 4, textStyle: { color: '#64748b' } },
    grid: { left: 90, right: 20, top: 40, bottom: 30 },
    xAxis: { type: 'value', axisLabel: { color: '#94a3b8' }, splitLine: { lineStyle: { color: '#f1f5f9' } } },
    yAxis: { type: 'category', data: plNames.reverse(), axisLabel: { color: '#334155', fontSize: 12 } },
    series: Object.keys(statusNames).map(key => ({
      name: statusNames[key],
      type: 'bar',
      stack: 'total',
      barWidth: 18,
      itemStyle: { color: statusColors[key], borderRadius: key === 'rejected' ? [4, 4, 4, 4] : 0 },
      data: plNames.map(pl => plMap[pl]?.[key] || 0),
      emphasis: { focus: 'series' }
    }))
  })

  chart.on('click', (params) => {
    if (params.name) {
      router.push({ path: '/LL_LessonLearn', query: { productLine: params.name } })
    }
  })
}

// Issue Source 饼图
const renderIssueSourcePie = (items) => {
  const chart = initChart(issueSourceRef.value)
  if (!chart) return

  const srcMap = {}
  items.forEach(item => {
    const src = item.issueSource || '未填写'
    srcMap[src] = (srcMap[src] || 0) + 1
  })

  const pieData = Object.entries(srcMap).map(([name, value]) => ({ name, value })).sort((a, b) => b.value - a.value)
  const colors = ['#6366f1', '#f59e0b', '#22c55e', '#ef4444', '#14b8a6', '#f97316', '#8b5cf6', '#06b6d4']

  chart.setOption({
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    legend: { orient: 'vertical', right: 10, top: 'center', textStyle: { color: '#64748b', fontSize: 12 } },
    color: colors,
    series: [{
      type: 'pie', radius: ['40%', '70%'], center: ['40%', '50%'],
      label: { show: false },
      emphasis: { label: { show: true, fontSize: 14, fontWeight: 'bold' } },
      data: pieData
    }]
  })
}

// 月度趋势折线图
const renderMonthlyTrend = (items) => {
  const chart = initChart(trendRef.value)
  if (!chart) return

  const monthMap = {}
  items.forEach(item => {
    const dateStr = item.createDate || item.modifyDate || ''
    if (!dateStr) return
    const month = dateStr.substring(0, 7) // YYYY-MM
    if (!monthMap[month]) monthMap[month] = { created: 0, published: 0 }
    monthMap[month].created++
    if (item.status === 3) monthMap[month].published++
  })

  const months = Object.keys(monthMap).sort()
  // 确保至少有6个月的数据
  if (months.length === 0) {
    const now = new Date()
    for (let i = 5; i >= 0; i--) {
      const d = new Date(now)
      d.setMonth(d.getMonth() - i)
      const m = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`
      if (!monthMap[m]) { monthMap[m] = { created: 0, published: 0 }; months.push(m) }
    }
  }

  chart.setOption({
    tooltip: { trigger: 'axis' },
    legend: { data: ['新增 LL', '已发布'], top: 4, textStyle: { color: '#64748b' } },
    grid: { left: 50, right: 20, top: 40, bottom: 30 },
    xAxis: { type: 'category', data: months, axisLabel: { color: '#94a3b8' }, boundaryGap: false },
    yAxis: { type: 'value', axisLabel: { color: '#94a3b8' }, splitLine: { lineStyle: { color: '#f1f5f9' } } },
    series: [
      {
        name: '新增 LL', type: 'line', smooth: true,
        data: months.map(m => monthMap[m]?.created || 0),
        lineStyle: { color: '#6366f1', width: 3 },
        itemStyle: { color: '#6366f1' },
        areaStyle: { color: { type: 'linear', x: 0, y: 0, x2: 0, y2: 1, colorStops: [{ offset: 0, color: 'rgba(99,102,241,0.25)' }, { offset: 1, color: 'rgba(99,102,241,0.02)' }] } }
      },
      {
        name: '已发布', type: 'line', smooth: true,
        data: months.map(m => monthMap[m]?.published || 0),
        lineStyle: { color: '#22c55e', width: 3 },
        itemStyle: { color: '#22c55e' },
        areaStyle: { color: { type: 'linear', x: 0, y: 0, x2: 0, y2: 1, colorStops: [{ offset: 0, color: 'rgba(34,197,94,0.2)' }, { offset: 1, color: 'rgba(34,197,94,0.02)' }] } }
      }
    ]
  })
}

// LL 属性分布（Mandatory/Optional/Standardized/Other）
const renderLevelPie = (items) => {
  const chart = initChart(levelRef.value)
  if (!chart) return

  const levelMap = {}
  items.forEach(item => {
    const lvl = item.lessonLevel || '未分类'
    levelMap[lvl] = (levelMap[lvl] || 0) + 1
  })

  const pieData = Object.entries(levelMap).map(([name, value]) => ({ name, value })).sort((a, b) => b.value - a.value)
  const colors = ['#6366f1', '#14b8a6', '#f59e0b', '#94a3b8']

  chart.setOption({
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    color: colors,
    series: [{
      type: 'pie', radius: ['35%', '65%'], center: ['50%', '55%'],
      label: { formatter: '{b}\n{d}%', color: '#475569', fontSize: 12 },
      data: pieData
    }]
  })
}

// 按分类柱状图
const renderCategoryBar = (items) => {
  const chart = initChart(categoryRef.value)
  if (!chart) return

  const catMap = {}
  items.forEach(item => {
    const cat = item.category || '未分类'
    catMap[cat] = (catMap[cat] || 0) + 1
  })

  const cats = Object.keys(catMap).sort((a, b) => catMap[b] - catMap[a])
  const colors = ['#6366f1', '#f59e0b', '#22c55e', '#ef4444', '#14b8a6', '#f97316']

  chart.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: 50, right: 20, top: 20, bottom: 30 },
    xAxis: { type: 'category', data: cats, axisLabel: { color: '#475569', fontSize: 12 } },
    yAxis: { type: 'value', axisLabel: { color: '#94a3b8' }, splitLine: { lineStyle: { color: '#f1f5f9' } } },
    series: [{
      type: 'bar', barWidth: 32, data: cats.map((c, i) => ({ value: catMap[c], itemStyle: { color: colors[i % colors.length], borderRadius: [6, 6, 0, 0] } })),
      emphasis: { itemStyle: { shadowBlur: 10, shadowColor: 'rgba(0,0,0,0.1)' } }
    }]
  })

  chart.on('click', (params) => {
    if (params.name) {
      router.push({ path: '/LL_LessonLearn', query: { category: params.name } })
    }
  })
}

// Active/Inactive 饼图
const renderActivePie = (items) => {
  const chart = initChart(activeRef.value)
  if (!chart) return

  const activeCount = items.filter(x => x.isActive !== false).length
  const inactiveCount = items.filter(x => x.isActive === false).length

  chart.setOption({
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    color: ['#22c55e', '#94a3b8'],
    series: [{
      type: 'pie', radius: ['40%', '68%'], center: ['50%', '55%'],
      label: { formatter: '{b}\n{c} 条', color: '#475569', fontSize: 13 },
      data: [
        { name: 'Active', value: activeCount },
        { name: 'Inactive', value: inactiveCount }
      ]
    }]
  })
}

// ========== 生命周期 ==========
const handleResize = () => { charts.forEach(c => c?.resize?.()) }

onMounted(async () => {
  await loadAllData()
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  charts.forEach(c => c?.dispose?.())
  charts = []
})
</script>

<style scoped>
.dashboard-page {
  position: absolute; width: 100%; height: 100%;
  background: radial-gradient(circle at top left, rgba(99, 102, 241, 0.1), transparent 28%),
    linear-gradient(180deg, #f6f8fc 0%, #eef2f7 100%);
}

/* 页面标题 */
.page-header {
  padding: 28px 34px 0; display: flex; justify-content: space-between; align-items: end; gap: 16px;
}
.eyebrow { font-size: 13px; letter-spacing: 1.8px; text-transform: uppercase; color: #6366f1; font-weight: 600; }
h2 { margin: 8px 0 10px; font-size: 30px; font-weight: 700; color: #0f172a; }
p { margin: 0; color: #64748b; max-width: 600px; font-size: 14px; }
.header-actions { display: flex; gap: 10px; flex-shrink: 0; }

/* KPI 卡片行 */
.kpi-row {
  padding: 20px 34px 0; display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr)); gap: 14px;
}
.kpi-card {
  display: flex; align-items: center; gap: 14px;
  padding: 18px 20px; border-radius: 20px;
  background: rgba(255,255,255,0.94);
  border: 1px solid rgba(15,23,42,0.04);
  box-shadow: 0 10px 24px rgba(25,44,71,0.06);
  cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;
}
.kpi-card:hover { transform: translateY(-2px); box-shadow: 0 14px 32px rgba(25,44,71,0.1); }
.kpi-icon { font-size: 30px; width: 52px; height: 52px; border-radius: 16px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.kpi-icon.total { background: linear-gradient(135deg, #ede9fe, #ddd6fe); }
.kpi-icon.draft { background: linear-gradient(135deg, #dbeafe, #bfdbfe); }
.kpi-icon.review { background: linear-gradient(135deg, #fef3c7, #fde68a); }
.kpi-icon.published { background: linear-gradient(135deg, #dcfce7, #bbf7d0); }
.kpi-icon.rejected { background: linear-gradient(135deg, #fee2e2, #fecaca); }
.kpi-icon.problem { background: linear-gradient(135deg, #ffe4e6, #fecdd3); }
.kpi-label { font-size: 13px; color: #64748b; }
.kpi-value { font-size: 28px; font-weight: 700; color: #0f172a; margin-top: 2px; }

/* 图表面板 */
.chart-row {
  padding: 18px 34px 0; display: grid;
  grid-template-columns: minmax(0, 1.6fr) minmax(0, 1fr); gap: 18px;
}
.chart-panel {
  background: rgba(255,255,255,0.94); border-radius: 22px;
  padding: 20px 22px;
  border: 1px solid rgba(15,23,42,0.04);
  box-shadow: 0 10px 24px rgba(25,44,71,0.05);
}
.chart-panel.wide { /* 用 grid 控制 */ }
.chart-panel.narrow { /* 用 grid 控制 */ }
.panel-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.panel-title { font-size: 16px; font-weight: 700; color: #0f172a; }
.chart-area { width: 100%; }

/* 底部快捷入口 */
.quick-row {
  padding: 24px 34px 32px; display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr)); gap: 14px;
}
.quick-card {
  padding: 18px 16px; border-radius: 18px;
  background: rgba(255,255,255,0.94);
  box-shadow: 0 10px 20px rgba(25,44,71,0.05);
  cursor: pointer; transition: transform 0.15s;
  text-align: center;
}
.quick-card:hover { transform: translateY(-2px); }
.quick-icon { font-size: 28px; }
.quick-name { margin-top: 10px; font-size: 14px; font-weight: 600; color: #0f172a; }
.quick-desc { margin-top: 4px; font-size: 11px; color: #94a3b8; }

/* 响应式 */
@media (max-width: 1400px) {
  .kpi-row { grid-template-columns: repeat(3, minmax(0, 1fr)); }
  .quick-row { grid-template-columns: repeat(3, minmax(0, 1fr)); }
}
@media (max-width: 1000px) {
  .chart-row { grid-template-columns: 1fr; }
  .kpi-row { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .page-header { flex-direction: column; align-items: start; }
  .quick-row { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}
@media (max-width: 600px) {
  .kpi-row, .quick-row { grid-template-columns: 1fr; }
  .dashboard-page .page-header, .dashboard-page .kpi-row, .dashboard-page .chart-row, .dashboard-page .quick-row { padding-left: 16px; padding-right: 16px; }
}
</style>
