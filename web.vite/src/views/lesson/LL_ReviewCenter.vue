<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Review Chain</div>
        <h2>多轮评审中心</h2>
        <p>集中查看各条 Lesson Learn 的评审轮次、评审人、意见和当前结论。</p>
      </div>
      <el-button type="primary" @click="goTo('/LL_LessonLearn')">进入 LL 详情维护</el-button>
    </div>

    <div class="summary-grid">
      <div class="summary-card"><div class="label">评审记录</div><div class="value">{{ rows.length }}</div></div>
      <div class="summary-card"><div class="label">待审核</div><div class="value">{{ pendingCount }}</div></div>
      <div class="summary-card"><div class="label">通过/发布</div><div class="value">{{ approvedCount }}</div></div>
      <div class="summary-card"><div class="label">驳回</div><div class="value">{{ rejectedCount }}</div></div>
    </div>

    <el-card shadow="never">
      <template #header>评审明细</template>
      <el-table :data="rows" v-loading="loading" stripe>
        <el-table-column prop="lessonNo" label="LL编号" width="160" />
        <el-table-column prop="title" label="标题" min-width="220" />
        <el-table-column prop="round" label="轮次" width="120" />
        <el-table-column prop="reviewer" label="评审人" width="140" />
        <el-table-column prop="reviewerTitle" label="职位" width="160" />
        <el-table-column prop="reviewDate" label="时间" width="120" />
        <el-table-column label="结果" width="120">
          <template #default="{ row }">
            <el-tag :type="resultTagType(row.result)">{{ row.result || statusText(row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="comments" label="意见" min-width="260" />
      </el-table>
      <div v-if="!loading && rows.length === 0" class="empty-state">暂无评审记录，可通过测试数据脚本生成演示数据。</div>
    </el-card>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { loadLessonWorkspace, statusText } from './lessonLearnPortal'

const router = useRouter()
const loading = ref(false)
const rows = ref([])

const pendingCount = computed(() => rows.value.filter((item) => item.status === 1 || /pending|待审核/i.test(item.result || '')).length)
const approvedCount = computed(() => rows.value.filter((item) => /pass|approve|发布|通过/i.test(item.result || '')).length)
const rejectedCount = computed(() => rows.value.filter((item) => /reject|驳回/i.test(item.result || '')).length)

const resultTagType = (result) => {
  if (/reject|驳回/i.test(result || '')) return 'danger'
  if (/pass|approve|发布|通过/i.test(result || '')) return 'success'
  return 'warning'
}

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 30, detailSize: 12 })
    rows.value = workspace.reviewRows
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
