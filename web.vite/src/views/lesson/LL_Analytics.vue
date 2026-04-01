<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Insight Board</div>
        <h2>统计与检索分析</h2>
        <p>围绕状态、标签、产品线和复用热度形成汇总视图，为后续统计页奠定结构。</p>
      </div>
    </div>

    <div class="summary-grid">
      <div class="summary-card"><div class="label">记录总数</div><div class="value">{{ summary.all }}</div></div>
      <div class="summary-card"><div class="label">总浏览</div><div class="value">{{ summary.totalViews }}</div></div>
      <div class="summary-card"><div class="label">总收藏</div><div class="value">{{ summary.totalFavorites }}</div></div>
      <div class="summary-card"><div class="label">总点赞</div><div class="value">{{ summary.totalLikes }}</div></div>
    </div>

    <div class="two-col">
      <el-card shadow="never">
        <template #header>状态分布</template>
        <div class="status-grid">
          <div class="status-card"><span>编辑中</span><strong>{{ summary.draft }}</strong></div>
          <div class="status-card"><span>待审核</span><strong>{{ summary.review }}</strong></div>
          <div class="status-card"><span>已驳回</span><strong>{{ summary.rejected }}</strong></div>
          <div class="status-card"><span>已发布</span><strong>{{ summary.published }}</strong></div>
        </div>
      </el-card>
      <el-card shadow="never">
        <template #header>产品线热度</template>
        <el-table :data="productLines" stripe>
          <el-table-column prop="name" label="产品线" />
          <el-table-column prop="count" label="数量" width="100" />
        </el-table>
      </el-card>
    </div>

    <el-card shadow="never" class="mt16">
      <template #header>标签检索准备区</template>
      <el-table :data="tags" stripe>
        <el-table-column prop="name" label="标签" />
        <el-table-column prop="count" label="命中数" width="120" />
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue'
import { loadLessonWorkspace } from './lessonLearnPortal'

const loading = ref(false)
const summary = reactive({
  all: 0,
  draft: 0,
  review: 0,
  rejected: 0,
  published: 0,
  totalViews: 0,
  totalFavorites: 0,
  totalLikes: 0
})
const tags = ref([])
const productLines = ref([])

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 40, detailSize: 12 })
    Object.assign(summary, workspace.summary)
    tags.value = workspace.topTags
    productLines.value = workspace.topProductLines
  } finally {
    loading.value = false
  }
}

onMounted(loadData)
</script>

<style scoped>
.portal-page { padding: 24px; background: #f5f7fb; min-height: 100%; }
.page-header { display: flex; justify-content: space-between; align-items: end; margin-bottom: 20px; gap: 16px; }
.eyebrow { color: #0f766e; letter-spacing: 1.4px; font-size: 12px; text-transform: uppercase; }
h2 { margin: 6px 0 8px; font-size: 30px; }
p { margin: 0; color: #64748b; }
.summary-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 16px; margin-bottom: 20px; }
.summary-card { background: #fff; border-radius: 18px; padding: 18px 20px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06); }
.label { color: #64748b; font-size: 13px; }
.value { margin-top: 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
.status-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.status-card { background: #f8fafc; border-radius: 14px; padding: 18px; display: flex; justify-content: space-between; align-items: center; }
.status-card span { color: #64748b; }
.status-card strong { font-size: 24px; color: #0f172a; }
.mt16 { margin-top: 16px; }
@media (max-width: 900px) { .summary-grid, .two-col { grid-template-columns: 1fr; } }
</style>
