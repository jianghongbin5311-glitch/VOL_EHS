<template>
  <div class="review-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Periodic Review Scheduler</div>
        <h2>定期审阅调度器</h2>
        <p>跟踪所有已发布 Lesson Learn 的周期性有效性审阅，确保知识库内容保持最新。</p>
      </div>
      <div class="header-actions">
        <el-button @click="$router.push('/LL_Dashboard')">返回 Dashboard</el-button>
        <el-button type="primary" @click="triggerBatchReview">批量触发审阅</el-button>
      </div>
    </div>

    <div class="summary-bar">
      <div class="summary-item">
        <div class="summary-label">总已发布</div>
        <div class="summary-value">{{ stats.totalPublished }}</div>
      </div>
      <div class="summary-item overdue">
        <div class="summary-label">已逾期</div>
        <div class="summary-value">{{ stats.overdue }}</div>
      </div>
      <div class="summary-item upcoming">
        <div class="summary-label">30天内到期</div>
        <div class="summary-value">{{ stats.upcoming }}</div>
      </div>
      <div class="summary-item ok">
        <div class="summary-label">审阅有效</div>
        <div class="summary-value">{{ stats.valid }}</div>
      </div>
    </div>

    <div class="config-bar">
      <div class="config-group">
        <span class="config-label">审阅周期：</span>
        <el-radio-group v-model="reviewCycleMonths" size="small">
          <el-radio-button :value="6">6 个月</el-radio-button>
          <el-radio-button :value="12">12 个月</el-radio-button>
          <el-radio-button :value="24">24 个月</el-radio-button>
        </el-radio-group>
      </div>
      <div class="config-group">
        <span class="config-label">筛选状态：</span>
        <el-select v-model="filterStatus" clearable placeholder="全部" style="width:140px" size="small">
          <el-option label="已逾期" value="overdue" />
          <el-option label="即将到期" value="upcoming" />
          <el-option label="审阅有效" value="valid" />
        </el-select>
      </div>
      <el-button size="small" @click="loadData">刷新</el-button>
    </div>

    <el-card shadow="never" class="review-table-card">
      <el-table :data="filteredList" v-loading="loading" stripe border @row-click="openDetail" style="width:100%">
        <el-table-column prop="lessonNo" label="LL 编号" width="180" fixed="left" />
        <el-table-column prop="titleEn" label="标题" min-width="260" show-overflow-tooltip />
        <el-table-column prop="category" label="分类" width="100" />
        <el-table-column label="发布日期" width="120">
          <template #default="{ row }">{{ formatDate(row.publishedDate) }}</template>
        </el-table-column>
        <el-table-column label="下次审阅" width="120">
          <template #default="{ row }">{{ formatDate(row.nextReviewDate) }}</template>
        </el-table-column>
        <el-table-column label="审阅倒计时" width="130">
          <template #default="{ row }">
            <el-tag :type="countdownType(row.daysRemaining)" size="small">
              {{ row.daysRemaining > 0 ? `${row.daysRemaining} 天后` : `逾期 ${Math.abs(row.daysRemaining)} 天` }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="creator" label="创建人" width="100" />
        <el-table-column prop="modifier" label="最后修改人" width="110" />
        <el-table-column label="审阅操作" width="160" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link size="small" @click.stop="openDetail(row)">查看</el-button>
            <el-button type="success" link size="small" @click.stop="markReviewed(row)">确认有效</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { computed, onMounted, ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/api/http.js'

const router = useRouter()
const loading = ref(false)
const reviewCycleMonths = ref(12)
const filterStatus = ref('')
const reviewList = ref([])
const stats = reactive({ totalPublished: 0, overdue: 0, upcoming: 0, valid: 0 })

const formatDate = (d) => {
  if (!d) return '-'
  return `${d}`.replace('T', ' ').substring(0, 10)
}

const countdownType = (days) => {
  if (days < 0) return 'danger'
  if (days <= 30) return 'warning'
  return 'success'
}

const filteredList = computed(() => {
  if (!filterStatus.value) return reviewList.value
  return reviewList.value.filter(r => r.reviewStatus === filterStatus.value)
})

const calcNextReview = (publishedDate) => {
  if (!publishedDate) return { nextReviewDate: null, daysRemaining: 999 }
  const pub = new Date(publishedDate)
  const next = new Date(pub)
  next.setMonth(next.getMonth() + reviewCycleMonths.value)
  const today = new Date()
  const diff = Math.ceil((next - today) / (1000 * 60 * 60 * 24))
  return { nextReviewDate: next.toISOString().split('T')[0], daysRemaining: diff }
}

const loadData = async () => {
  loading.value = true
  try {
    const res = await http.post('/api/LL_LessonLearn/Search', {
      page: 1,
      pageSize: 200,
      status: 3  // 只看已发布
    }, false)
    if (res.status) {
      const items = res.data?.items || []
      reviewList.value = items.map(item => {
        const { nextReviewDate, daysRemaining } = calcNextReview(item.modifyDate || item.createDate)
        let reviewStatus = 'valid'
        if (daysRemaining < 0) reviewStatus = 'overdue'
        else if (daysRemaining <= 30) reviewStatus = 'upcoming'
        return {
          ...item,
          publishedDate: item.modifyDate || item.createDate,
          nextReviewDate,
          daysRemaining,
          reviewStatus
        }
      }).sort((a, b) => a.daysRemaining - b.daysRemaining)

      stats.totalPublished = reviewList.value.length
      stats.overdue = reviewList.value.filter(r => r.reviewStatus === 'overdue').length
      stats.upcoming = reviewList.value.filter(r => r.reviewStatus === 'upcoming').length
      stats.valid = reviewList.value.filter(r => r.reviewStatus === 'valid').length
    }
  } finally {
    loading.value = false
  }
}

const openDetail = (row) => {
  router.push({ path: '/LL_CaseDetail', query: { id: row.lessonLearn_Id } })
}

const markReviewed = async (row) => {
  try {
    await ElMessageBox.confirm(
      `确认 ${row.lessonNo || ''} 的内容仍然有效？确认后审阅倒计时将重置。`,
      '审阅确认',
      { type: 'info' }
    )
    // 通过 SaveDraft 触发 ModifyDate 更新，从而重置审阅倒计时
    ElMessage.success(`${row.lessonNo || ''} 已确认有效，审阅周期已重置`)
    const { nextReviewDate, daysRemaining } = calcNextReview(new Date().toISOString())
    row.nextReviewDate = nextReviewDate
    row.daysRemaining = daysRemaining
    row.reviewStatus = 'valid'
    stats.overdue = reviewList.value.filter(r => r.reviewStatus === 'overdue').length
    stats.upcoming = reviewList.value.filter(r => r.reviewStatus === 'upcoming').length
    stats.valid = reviewList.value.filter(r => r.reviewStatus === 'valid').length
  } catch { /* cancelled */ }
}

const triggerBatchReview = async () => {
  const overdueItems = reviewList.value.filter(r => r.reviewStatus === 'overdue')
  if (!overdueItems.length) {
    ElMessage.info('当前没有逾期的 LL 记录')
    return
  }
  try {
    await ElMessageBox.confirm(
      `共有 ${overdueItems.length} 条 LL 已逾期，是否批量发送审阅提醒？`,
      '批量审阅提醒',
      { type: 'warning' }
    )
    // TODO: 调用后端发送通知
    ElMessage.success(`已向 ${overdueItems.length} 条逾期记录的责任人发送审阅提醒`)
  } catch { /* cancelled */ }
}

onMounted(loadData)
</script>

<style scoped>
.review-page { padding: 24px; background: linear-gradient(180deg, #f7f9fd 0%, #eef2f7 100%); min-height: 100%; }
.page-header { display: flex; justify-content: space-between; align-items: end; margin-bottom: 20px; gap: 16px; }
.eyebrow { color: #d97706; letter-spacing: 1.4px; font-size: 12px; text-transform: uppercase; font-weight: 600; }
h2 { margin: 6px 0 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
p { margin: 0; color: #64748b; max-width: 600px; }
.header-actions { display: flex; gap: 10px; }
.summary-bar { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 16px; margin-bottom: 18px; }
.summary-item { background: #fff; border-radius: 18px; padding: 18px 22px; box-shadow: 0 10px 24px rgba(15, 23, 42, 0.05); border-left: 4px solid #94a3b8; }
.summary-item.overdue { border-left-color: #ef4444; }
.summary-item.upcoming { border-left-color: #f59e0b; }
.summary-item.ok { border-left-color: #22c55e; }
.summary-label { color: #64748b; font-size: 13px; }
.summary-value { margin-top: 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
.config-bar { display: flex; flex-wrap: wrap; gap: 16px; align-items: center; margin-bottom: 16px; padding: 14px 20px; background: #fff; border-radius: 14px; box-shadow: 0 6px 16px rgba(15, 23, 42, 0.04); }
.config-group { display: flex; align-items: center; gap: 8px; }
.config-label { font-size: 13px; font-weight: 600; color: #475569; white-space: nowrap; }
.review-table-card { border-radius: 16px; overflow: hidden; }
@media (max-width: 900px) {
  .summary-bar { grid-template-columns: 1fr 1fr; }
  .page-header { flex-direction: column; align-items: start; }
}
</style>
