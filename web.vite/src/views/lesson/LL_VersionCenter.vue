<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Audit Trail</div>
        <h2>版本与操作记录</h2>
        <p>集中查看保存、提交、驳回、发布、解锁等历史操作，支撑审计追踪。</p>
      </div>
      <el-button type="primary" @click="goTo('/LL_LessonLearn')">进入版本详情</el-button>
    </div>

    <div class="summary-grid">
      <div class="summary-card"><div class="label">版本记录</div><div class="value">{{ rows.length }}</div></div>
      <div class="summary-card"><div class="label">已发布快照</div><div class="value">{{ publishedCount }}</div></div>
      <div class="summary-card"><div class="label">提交审批</div><div class="value">{{ submitCount }}</div></div>
      <div class="summary-card"><div class="label">最近操作</div><div class="value small">{{ latestTime }}</div></div>
    </div>

    <el-card shadow="never">
      <template #header>操作流水</template>
      <el-table :data="rows" v-loading="loading" stripe>
        <el-table-column prop="lessonNo" label="LL编号" width="150" />
        <el-table-column prop="title" label="标题" min-width="220" />
        <el-table-column prop="versionNo" label="版本" width="90" />
        <el-table-column prop="action" label="动作" width="120" />
        <el-table-column prop="operator" label="操作人" width="130" />
        <el-table-column prop="statusText" label="状态" width="100" />
        <el-table-column prop="time" label="时间" width="170" />
        <el-table-column prop="comment" label="备注" min-width="220" />
      </el-table>
      <div v-if="!loading && rows.length === 0" class="empty-state">暂无版本记录，可先执行演示数据脚本。</div>
    </el-card>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { loadLessonWorkspace } from './lessonLearnPortal'

const router = useRouter()
const loading = ref(false)
const rows = ref([])

const publishedCount = computed(() => rows.value.filter((item) => /发布/i.test(item.action || '')).length)
const submitCount = computed(() => rows.value.filter((item) => /提交/i.test(item.action || '')).length)
const latestTime = computed(() => rows.value[0]?.time || '-')

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 30, detailSize: 12 })
    rows.value = workspace.versionRows
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
