<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Insight Board</div>
        <h2>统计与检索分析</h2>
        <p>围绕状态、标签、产品线和复用热度形成汇总视图，帮助团队洞察知识资产分布。</p>
      </div>
      <div class="header-actions">
        <el-button @click="$router.push('/LL_Dashboard')">返回 Dashboard</el-button>
        <el-button type="primary" @click="loadData">刷新数据</el-button>
      </div>
    </div>

    <div class="summary-grid">
      <div class="summary-card"><div class="label">记录总数</div><div class="value">{{ summary.all }}</div></div>
      <div class="summary-card"><div class="label">总浏览</div><div class="value">{{ summary.totalViews }}</div></div>
      <div class="summary-card"><div class="label">总收藏</div><div class="value">{{ summary.totalFavorites }}</div></div>
      <div class="summary-card"><div class="label">总点赞</div><div class="value">{{ summary.totalLikes }}</div></div>
    </div>

    <div class="two-col">
      <div class="panel">
        <div class="panel-header"><div class="panel-title">状态分布</div></div>
        <div class="status-grid">
          <div class="status-card" :class="{ active: statusFilter === 0 }" @click="toggleFilter(0)">
            <span>编辑中</span><strong>{{ summary.draft }}</strong>
          </div>
          <div class="status-card" :class="{ active: statusFilter === 1 }" @click="toggleFilter(1)">
            <span>待审核</span><strong>{{ summary.review }}</strong>
          </div>
          <div class="status-card" :class="{ active: statusFilter === 2 }" @click="toggleFilter(2)">
            <span>已驳回</span><strong>{{ summary.rejected }}</strong>
          </div>
          <div class="status-card" :class="{ active: statusFilter === 3 }" @click="toggleFilter(3)">
            <span>已发布</span><strong>{{ summary.published }}</strong>
          </div>
        </div>

        <div class="bar-chart">
          <div class="bar-row" v-for="bar in statusBars" :key="bar.label">
            <div class="bar-label">{{ bar.label }}</div>
            <div class="bar-track"><div class="bar-fill" :style="{ width: bar.pct + '%', background: bar.color }"></div></div>
            <div class="bar-count">{{ bar.count }}</div>
          </div>
        </div>
      </div>

      <div class="panel">
        <div class="panel-header"><div class="panel-title">产品线热度 TOP</div></div>
        <div class="ranking-list">
          <div class="ranking-row" v-for="(item, i) in productLines" :key="item.name">
            <div class="rank-num" :class="{ top: i < 3 }">{{ i + 1 }}</div>
            <div class="rank-name">{{ item.name }}</div>
            <div class="rank-bar">
              <div class="rank-fill" :style="{ width: plBarWidth(item.count) + '%' }"></div>
            </div>
            <div class="rank-count">{{ item.count }}</div>
          </div>
          <div v-if="productLines.length === 0" class="empty-state">暂无产品线数据</div>
        </div>
      </div>
    </div>

    <div class="two-col mt-gap">
      <div class="panel">
        <div class="panel-header"><div class="panel-title">标签云</div></div>
        <div class="tag-cloud" v-if="tags.length">
          <el-tag v-for="tag in tags" :key="tag.name" :class="tagSize(tag.count)" effect="plain" class="cloud-tag">
            {{ tag.name }} <span class="tag-count">({{ tag.count }})</span>
          </el-tag>
        </div>
        <div v-else class="empty-state">暂无标签数据</div>
      </div>

      <div class="panel">
        <div class="panel-header"><div class="panel-title">复用热度排行</div></div>
        <el-table :data="topViewed" stripe size="small" style="border-radius:12px;overflow:hidden">
          <el-table-column label="#" width="40" type="index" />
          <el-table-column prop="lessonNo" label="编号" width="160" />
          <el-table-column label="标题" min-width="200" show-overflow-tooltip>
            <template #default="{ row }">{{ row.titleEn || row.titleCn || '-' }}</template>
          </el-table-column>
          <el-table-column prop="viewCount" label="浏览" width="70" />
          <el-table-column prop="favoriteCount" label="收藏" width="70" />
          <el-table-column prop="likeCount" label="点赞" width="70" />
        </el-table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { loadLessonWorkspace } from './lessonLearnPortal'

const loading = ref(false)
const statusFilter = ref(null)
const summary = reactive({
  all: 0, draft: 0, review: 0, rejected: 0, published: 0,
  totalViews: 0, totalFavorites: 0, totalLikes: 0
})
const tags = ref([])
const productLines = ref([])
const allItems = ref([])

const topViewed = computed(() => {
  return [...allItems.value]
    .sort((a, b) => ((b.viewCount || 0) + (b.favoriteCount || 0) * 3) - ((a.viewCount || 0) + (a.favoriteCount || 0) * 3))
    .slice(0, 8)
})

const statusBars = computed(() => {
  const max = Math.max(summary.draft, summary.review, summary.rejected, summary.published, 1)
  return [
    { label: '编辑中', count: summary.draft, pct: (summary.draft / max) * 100, color: '#3b82f6' },
    { label: '审批中', count: summary.review, pct: (summary.review / max) * 100, color: '#f59e0b' },
    { label: '已发布', count: summary.published, pct: (summary.published / max) * 100, color: '#22c55e' },
    { label: '已驳回', count: summary.rejected, pct: (summary.rejected / max) * 100, color: '#ef4444' }
  ]
})

const plBarWidth = (count) => {
  const max = productLines.value[0]?.count || 1
  return Math.max((count / max) * 100, 4)
}

const tagSize = (count) => {
  if (count >= 5) return 'tag-lg'
  if (count >= 3) return 'tag-md'
  return 'tag-sm'
}

const toggleFilter = (status) => {
  statusFilter.value = statusFilter.value === status ? null : status
}

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 60, detailSize: 0 })
    Object.assign(summary, workspace.summary)
    tags.value = workspace.topTags
    productLines.value = workspace.topProductLines
    allItems.value = workspace.items || []
  } finally {
    loading.value = false
  }
}

onMounted(loadData)
</script>

<style scoped>
.portal-page { padding: 24px; background: linear-gradient(180deg, #f7f9fd 0%, #eef2f7 100%); min-height: 100%; }
.page-header { display: flex; justify-content: space-between; align-items: end; margin-bottom: 20px; gap: 16px; }
.eyebrow { color: #0f766e; letter-spacing: 1.4px; font-size: 12px; text-transform: uppercase; font-weight: 600; }
h2 { margin: 6px 0 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
p { margin: 0; color: #64748b; max-width: 600px; }
.header-actions { display: flex; gap: 10px; }
.summary-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 16px; margin-bottom: 20px; }
.summary-card { background: #fff; border-radius: 18px; padding: 18px 22px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06); }
.label { color: #64748b; font-size: 13px; }
.value { margin-top: 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
.mt-gap { margin-top: 18px; }
.panel { background: #fff; border-radius: 20px; padding: 22px 24px; box-shadow: 0 12px 28px rgba(15, 23, 42, 0.05); }
.panel-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px; }
.panel-title { font-size: 17px; font-weight: 700; color: #0f172a; }

/* Status Grid */
.status-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 18px; }
.status-card { background: #f8fafc; border-radius: 14px; padding: 16px; display: flex; justify-content: space-between; align-items: center; cursor: pointer; border: 2px solid transparent; transition: border-color 0.15s; }
.status-card:hover { border-color: #e2e8f0; }
.status-card.active { border-color: #6366f1; background: #f5f3ff; }
.status-card span { color: #64748b; font-size: 13px; }
.status-card strong { font-size: 22px; color: #0f172a; }

/* Bar Chart */
.bar-chart { display: grid; gap: 10px; }
.bar-row { display: grid; grid-template-columns: 56px 1fr 40px; gap: 10px; align-items: center; }
.bar-label { font-size: 12px; font-weight: 600; color: #475569; text-align: right; }
.bar-track { height: 22px; border-radius: 11px; background: #f1f5f9; overflow: hidden; }
.bar-fill { height: 100%; border-radius: 11px; transition: width 0.6s ease; min-width: 4px; }
.bar-count { font-size: 15px; font-weight: 700; color: #0f172a; }

/* Ranking List */
.ranking-list { display: grid; gap: 10px; }
.ranking-row { display: grid; grid-template-columns: 30px minmax(0, 1fr) minmax(80px, 1fr) 40px; gap: 10px; align-items: center; }
.rank-num { width: 24px; height: 24px; border-radius: 8px; background: #f1f5f9; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: 700; color: #94a3b8; }
.rank-num.top { background: #6366f1; color: #fff; }
.rank-name { font-size: 13px; font-weight: 600; color: #334155; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.rank-bar { height: 16px; border-radius: 8px; background: #f1f5f9; overflow: hidden; }
.rank-fill { height: 100%; border-radius: 8px; background: linear-gradient(90deg, #6366f1, #a78bfa); transition: width 0.5s; }
.rank-count { font-size: 14px; font-weight: 700; color: #0f172a; text-align: right; }

/* Tag Cloud */
.tag-cloud { display: flex; flex-wrap: wrap; gap: 8px; }
.cloud-tag { cursor: default; }
.tag-count { opacity: 0.6; }
.tag-lg { font-size: 16px !important; font-weight: 700 !important; }
.tag-md { font-size: 14px !important; }
.tag-sm { font-size: 12px !important; }

.empty-state { padding: 18px 0; color: #94a3b8; font-size: 13px; }

@media (max-width: 900px) { .summary-grid, .two-col { grid-template-columns: 1fr; } }
</style>
