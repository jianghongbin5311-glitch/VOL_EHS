<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Task Loop</div>
        <h2>任务闭环中心</h2>
        <p>跟踪文件更新、责任人、完成时间和 0/50/100 的闭环进度。</p>
      </div>
      <el-button type="primary" @click="goTo('/LL_LessonLearn')">回到 Lesson Learn</el-button>
    </div>

    <div class="summary-grid">
      <div class="summary-card"><div class="label">任务总数</div><div class="value">{{ rows.length }}</div></div>
      <div class="summary-card"><div class="label">已发布 0%</div><div class="value">{{ zeroCount }}</div></div>
      <div class="summary-card"><div class="label">上传完成 50%</div><div class="value">{{ middleCount }}</div></div>
      <div class="summary-card"><div class="label">审批完成 100%</div><div class="value">{{ fullCount }}</div></div>
    </div>

    <el-card shadow="never">
      <template #header>任务清单</template>
      <el-table :data="rows" v-loading="loading" stripe>
        <el-table-column prop="lessonNo" label="LL编号" width="160" />
        <el-table-column prop="title" label="任务" min-width="220" />
        <el-table-column prop="owner" label="责任人" width="140" />
        <el-table-column prop="dueDate" label="计划完成" width="130" />
        <el-table-column label="进度" width="180">
          <template #default="{ row }">
            <el-progress :percentage="row.progress || 0" :stroke-width="10" />
          </template>
        </el-table-column>
        <el-table-column label="状态" width="120">
          <template #default="{ row }">
            <el-tag :type="taskTagType(row.progress)">{{ row.taskStatus || progressLabel(row.progress) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="notes" label="说明" min-width="260" />
      </el-table>
      <div v-if="!loading && rows.length === 0" class="empty-state">暂无任务记录，可先在详情页任务区补充或执行演示数据脚本。</div>
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

const zeroCount = computed(() => rows.value.filter((item) => (item.progress || 0) === 0).length)
const middleCount = computed(() => rows.value.filter((item) => (item.progress || 0) > 0 && (item.progress || 0) < 100).length)
const fullCount = computed(() => rows.value.filter((item) => (item.progress || 0) >= 100).length)

const progressLabel = (progress) => {
  if ((progress || 0) >= 100) return '审批完成'
  if ((progress || 0) >= 50) return '上传完成'
  return '已发布'
}

const taskTagType = (progress) => {
  if ((progress || 0) >= 100) return 'success'
  if ((progress || 0) >= 50) return 'warning'
  return 'info'
}

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 30, detailSize: 12 })
    rows.value = workspace.taskRows
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
.empty-state { padding: 18px 0 4px; color: #94a3b8; }
@media (max-width: 900px) { .summary-grid { grid-template-columns: 1fr 1fr; } .page-header { flex-direction: column; align-items: start; } }
</style>
