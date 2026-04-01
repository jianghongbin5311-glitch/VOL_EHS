<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Document Hub</div>
        <h2>文件与变更中心</h2>
        <p>统一查看相关附件、变更前后文件和下载情况，支撑标准文件更新闭环。</p>
      </div>
      <el-button type="primary" @click="goTo('/LL_LessonLearn')">维护详细文件</el-button>
    </div>

    <div class="summary-grid">
      <div class="summary-card"><div class="label">文件记录</div><div class="value">{{ rows.length }}</div></div>
      <div class="summary-card"><div class="label">总下载次数</div><div class="value">{{ totalDownloads }}</div></div>
      <div class="summary-card"><div class="label">设计/工艺/供应商</div><div class="value">{{ categories }}</div></div>
      <div class="summary-card"><div class="label">最近更新时间</div><div class="value small">{{ latestUpload }}</div></div>
    </div>

    <el-card shadow="never">
      <template #header>文件汇总</template>
      <el-table :data="rows" v-loading="loading" stripe>
        <el-table-column prop="lessonNo" label="LL编号" width="150" />
        <el-table-column prop="title" label="标题" min-width="220" />
        <el-table-column prop="source" label="来源" width="120" />
        <el-table-column prop="category" label="类型" width="140" />
        <el-table-column prop="name" label="文件名" min-width="220" />
        <el-table-column prop="size" label="大小" width="110" />
        <el-table-column prop="downloadCount" label="下载次数" width="100" />
        <el-table-column prop="uploadTime" label="上传时间" width="170">
          <template #default="{ row }">{{ formatDateTime(row.uploadTime) }}</template>
        </el-table-column>
      </el-table>
      <div v-if="!loading && rows.length === 0" class="empty-state">暂无文件记录，可先执行演示数据 SQL 或在详情页上传附件。</div>
    </el-card>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { formatDateTime, loadLessonWorkspace } from './lessonLearnPortal'

const router = useRouter()
const loading = ref(false)
const rows = ref([])

const totalDownloads = computed(() => rows.value.reduce((sum, item) => sum + (Number(item.downloadCount) || 0), 0))
const categories = computed(() => [...new Set(rows.value.map((item) => item.category).filter(Boolean))].length)
const latestUpload = computed(() => {
  const values = rows.value.map((item) => item.uploadTime).filter(Boolean).sort().reverse()
  return values[0] ? formatDateTime(values[0]) : '-'
})

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 30, detailSize: 12 })
    rows.value = workspace.documentRows
  } finally {
    loading.value = false
  }
}

const goTo = (path) => router.push(path)
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
.value.small { font-size: 18px; }
.empty-state { padding: 18px 0 4px; color: #94a3b8; }
@media (max-width: 900px) { .summary-grid { grid-template-columns: 1fr 1fr; } .page-header { flex-direction: column; align-items: start; } }
</style>
