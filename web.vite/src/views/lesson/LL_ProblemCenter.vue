<template>
  <div class="problem-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Problem Center</div>
        <h2>问题中心</h2>
        <p>统一管理、追踪和闭环所有产品线的问题记录，问题完结后可一键转化为 Lesson Learn 经验报告。</p>
      </div>
      <div class="header-actions">
        <el-button @click="goTo('/LL_LessonLearn')">返回 Lesson Learn</el-button>
        <el-button type="primary" @click="openCreate">新增问题</el-button>
      </div>
    </div>

    <div class="summary-grid">
      <div class="summary-card">
        <div class="label">问题总数</div>
        <div class="value">{{ summaryStats.total }}</div>
      </div>
      <div class="summary-card open">
        <div class="label">Open</div>
        <div class="value">{{ summaryStats.open }}</div>
      </div>
      <div class="summary-card pending">
        <div class="label">Pending</div>
        <div class="value">{{ summaryStats.pending }}</div>
      </div>
      <div class="summary-card closed">
        <div class="label">Closed</div>
        <div class="value">{{ summaryStats.closed }}</div>
      </div>
    </div>

    <div class="filter-bar">
      <el-input v-model="searchForm.keyword" placeholder="搜索编号/描述" clearable style="width:220px" />
      <el-select v-model="searchForm.type" placeholder="类型 D/P/S/NC" clearable style="width:140px">
        <el-option label="D (Design)" value="D" />
        <el-option label="P (Process)" value="P" />
        <el-option label="S (Supplier)" value="S" />
        <el-option label="NC (Nonconformance)" value="NC" />
        <el-option label="Other" value="Other" />
      </el-select>
      <el-select v-model="searchForm.priority" placeholder="优先级" clearable style="width:120px">
        <el-option label="H (High)" value="H" />
        <el-option label="M (Medium)" value="M" />
        <el-option label="L (Low)" value="L" />
      </el-select>
      <el-select v-model="searchForm.status" placeholder="状态" clearable style="width:140px">
        <el-option label="Open" value="Open" />
        <el-option label="Closed" value="Closed" />
        <el-option label="Pending" value="Pending" />
      </el-select>
      <el-select v-model="searchForm.component" placeholder="Component" clearable filterable style="width:160px">
        <el-option v-for="item in componentOptions" :key="item" :label="item" :value="item" />
      </el-select>
      <el-button type="primary" @click="loadList">查询</el-button>
      <el-button @click="resetSearch">重置</el-button>
      <el-button @click="exportProblems">导出</el-button>
    </div>

    <el-card shadow="never" class="table-card">
      <el-table :data="tableData" v-loading="loading" stripe border @row-click="openEdit" style="width:100%">
        <el-table-column prop="IssueNo" label="Issue/Risk No." width="160" fixed="left" />
        <el-table-column prop="RecordDate" label="录入时间" width="110" />
        <el-table-column prop="CloseDate" label="闭环完成时间" width="110" />
        <el-table-column prop="IssueDescription" label="Issue description" min-width="240" show-overflow-tooltip />
        <el-table-column prop="Component" label="Component" width="130" />
        <el-table-column prop="Type" label="D/P/S" width="80">
          <template #default="{ row }">
            <el-tag :type="typeTagMap[row.Type] || 'info'" size="small">{{ row.Type }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="Priority" label="Priority" width="90">
          <template #default="{ row }">
            <el-tag :type="priorityTagMap[row.Priority] || 'info'" size="small">{{ row.Priority }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="AffectPlant" label="Affect Plant" width="120" />
        <el-table-column prop="ActionPlan" label="Action plan" min-width="220" show-overflow-tooltip />
        <el-table-column prop="ActionOwner" label="Action Owner" width="120" />
        <el-table-column prop="IssueOwner" label="Issue Owner" width="120" />
        <el-table-column prop="TargetCloseDate" label="目标关闭日" width="110" />
        <el-table-column prop="ActualCloseDate" label="实际关闭日" width="110" />
        <el-table-column prop="Status" label="Status" width="100">
          <template #default="{ row }">
            <el-tag :type="statusTagMap[row.Status] || 'info'" size="small">{{ row.Status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="Comments" label="Comments" min-width="180" show-overflow-tooltip />
        <el-table-column label="操作" width="160" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link size="small" @click.stop="openEdit(row)">编辑</el-button>
            <el-button type="success" link size="small" v-if="row.Status === 'Closed'" @click.stop="convertToLL(row)">转 LL</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination-wrap">
        <el-pagination
          v-model:current-page="page.current"
          v-model:page-size="page.size"
          :total="page.total"
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next"
          @current-change="loadList"
          @size-change="loadList"
        />
      </div>
    </el-card>

    <!-- 编辑 / 新建 Drawer -->
    <el-drawer v-model="drawerVisible" size="72%" destroy-on-close>
      <template #header>
        <div class="drawer-header">
          <span class="drawer-title">{{ form.Problem_Id ? '编辑问题' : '新增问题' }} - {{ form.IssueNo || '(未编号)' }}</span>
          <div class="drawer-actions">
            <el-button type="primary" :loading="saveLoading" @click="saveForm">保存</el-button>
            <el-button v-if="form.Problem_Id && form.Status !== 'Closed'" type="warning" @click="closeIssue">关闭问题</el-button>
            <el-button v-if="form.Problem_Id && form.Status === 'Closed'" type="success" @click="convertToLL(form)">一键转 LL</el-button>
          </div>
        </div>
      </template>

      <div class="form-section">
        <div class="section-title">基本信息</div>
        <div class="form-grid">
          <div class="field">
            <div class="field-label">Issue/Risk No.</div>
            <el-input v-model="form.IssueNo" placeholder="如 CEPS-D-0001" />
          </div>
          <div class="field">
            <div class="field-label">录入时间</div>
            <el-date-picker v-model="form.RecordDate" type="date" value-format="YYYY-MM-DD" placeholder="选择日期" style="width:100%" />
          </div>
          <div class="field">
            <div class="field-label">闭环完成时间</div>
            <el-date-picker v-model="form.CloseDate" type="date" value-format="YYYY-MM-DD" placeholder="选择日期" style="width:100%" />
          </div>
          <div class="field">
            <div class="field-label">Issue Description</div>
            <el-input v-model="form.IssueDescription" type="textarea" :rows="3" placeholder="问题描述" />
          </div>
          <div class="field">
            <div class="field-label">Component</div>
            <el-select v-model="form.Component" filterable allow-create default-first-option placeholder="零件/组件" style="width:100%">
              <el-option v-for="item in componentOptions" :key="item" :label="item" :value="item" />
            </el-select>
          </div>
          <div class="field">
            <div class="field-label">D/P/S/NC</div>
            <el-select v-model="form.Type" placeholder="选择类型" style="width:100%">
              <el-option label="D (Design)" value="D" />
              <el-option label="P (Process)" value="P" />
              <el-option label="S (Supplier)" value="S" />
              <el-option label="NC (Nonconformance)" value="NC" />
              <el-option label="Other" value="Other" />
            </el-select>
          </div>
          <div class="field">
            <div class="field-label">Priority</div>
            <el-select v-model="form.Priority" placeholder="优先级" style="width:100%">
              <el-option label="H (High)" value="H" />
              <el-option label="M (Medium)" value="M" />
              <el-option label="L (Low)" value="L" />
            </el-select>
          </div>
          <div class="field">
            <div class="field-label">Affect Plant</div>
            <el-input v-model="form.AffectPlant" placeholder="如 S3,S7,S8" />
          </div>
        </div>
      </div>

      <div class="form-section">
        <div class="section-title">行动计划与责任</div>
        <div class="form-grid">
          <div class="field wide">
            <div class="field-label">Action Plan</div>
            <el-input v-model="form.ActionPlan" type="textarea" :rows="3" placeholder="行动计划" />
          </div>
          <div class="field">
            <div class="field-label">Action Owner</div>
            <el-input v-model="form.ActionOwner" placeholder="行动责任人" />
          </div>
          <div class="field">
            <div class="field-label">Issue Owner</div>
            <el-input v-model="form.IssueOwner" placeholder="问题责任人" />
          </div>
          <div class="field">
            <div class="field-label">Target Close Date</div>
            <el-date-picker v-model="form.TargetCloseDate" type="date" value-format="YYYY-MM-DD" placeholder="目标关闭日" style="width:100%" />
          </div>
          <div class="field">
            <div class="field-label">Actual Close Date</div>
            <el-date-picker v-model="form.ActualCloseDate" type="date" value-format="YYYY-MM-DD" placeholder="实际关闭日" style="width:100%" />
          </div>
          <div class="field">
            <div class="field-label">Status</div>
            <el-select v-model="form.Status" placeholder="状态" style="width:100%">
              <el-option label="Open" value="Open" />
              <el-option label="Pending" value="Pending" />
              <el-option label="Closed" value="Closed" />
            </el-select>
          </div>
        </div>
      </div>

      <div class="form-section">
        <div class="section-title">附件与备注</div>
        <div class="form-grid">
          <div class="field wide">
            <div class="field-label">Notification（通知操作）</div>
            <el-input v-model="form.Notification" type="textarea" :rows="2" placeholder="通知相关人员..." />
          </div>
          <div class="field wide">
            <div class="field-label">Comments</div>
            <el-input v-model="form.Comments" type="textarea" :rows="3" placeholder="备注说明" />
          </div>
          <div class="field wide">
            <div class="field-label">附件 (支持多文件上传)</div>
            <input type="file" multiple @change="uploadAttachments" />
            <div v-for="(item, index) in form.Attachments" :key="`att-${index}`" class="att-row">
              <span>{{ item.Name }}</span>
              <el-button link type="danger" size="small" @click="form.Attachments.splice(index, 1)">删除</el-button>
            </div>
          </div>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/api/http.js'

const router = useRouter()
const loading = ref(false)
const saveLoading = ref(false)
const drawerVisible = ref(false)
const tableData = ref([])
const componentOptions = ref(['Worm Gear', 'Rack', 'Pinion', 'Motor', 'Sensor', 'Torque Sensor', 'Bearing', 'Housing', 'Shaft', 'Connector', 'Other'])

const searchForm = reactive({ keyword: '', type: '', priority: '', status: '', component: '' })
const page = reactive({ current: 1, size: 20, total: 0 })

const typeTagMap = { D: 'primary', P: 'warning', S: '', NC: 'danger', Other: 'info' }
const priorityTagMap = { H: 'danger', M: 'warning', L: 'success' }
const statusTagMap = { Open: 'danger', Pending: 'warning', Closed: 'success' }

const emptyForm = () => ({
  Problem_Id: 0,
  IssueNo: '',
  RecordDate: '',
  CloseDate: '',
  IssueDescription: '',
  Component: '',
  Type: '',
  Priority: 'M',
  AffectPlant: '',
  ActionPlan: '',
  ActionOwner: '',
  IssueOwner: '',
  TargetCloseDate: '',
  ActualCloseDate: '',
  Status: 'Open',
  Notification: '',
  Comments: '',
  Attachments: []
})

const form = ref(emptyForm())

const summaryStats = computed(() => {
  const all = tableData.value
  return {
    total: page.total || all.length,
    open: all.filter(r => r.Status === 'Open').length,
    pending: all.filter(r => r.Status === 'Pending').length,
    closed: all.filter(r => r.Status === 'Closed').length
  }
})

const loadList = async () => {
  loading.value = true
  try {
    const res = await http.post('/api/LL_ProblemCenter/Search', {
      page: page.current,
      pageSize: page.size,
      keyword: searchForm.keyword,
      type: searchForm.type,
      priority: searchForm.priority,
      status: searchForm.status,
      component: searchForm.component
    }, false)
    if (res.status) {
      tableData.value = res.data?.items || res.data?.Items || []
      page.total = res.data?.total || res.data?.Total || 0
    } else {
      // 在后端 API 尚未就绪时使用演示数据
      tableData.value = demoData()
      page.total = tableData.value.length
    }
  } catch {
    tableData.value = demoData()
    page.total = tableData.value.length
  } finally {
    loading.value = false
  }
}

const resetSearch = () => {
  searchForm.keyword = ''
  searchForm.type = ''
  searchForm.priority = ''
  searchForm.status = ''
  searchForm.component = ''
  page.current = 1
  loadList()
}

const openCreate = () => {
  form.value = emptyForm()
  drawerVisible.value = true
}

const openEdit = (row) => {
  form.value = { ...emptyForm(), ...row }
  if (!form.value.Attachments) form.value.Attachments = []
  drawerVisible.value = true
}

const saveForm = async () => {
  saveLoading.value = true
  try {
    const res = await http.post('/api/LL_ProblemCenter/Save', JSON.parse(JSON.stringify(form.value)), false)
    if (res.status) {
      ElMessage.success(res.message || '保存成功')
      drawerVisible.value = false
      loadList()
    } else {
      ElMessage.error(res.message || '保存失败')
    }
  } catch {
    ElMessage.error('保存失败，接口可能尚未就绪')
  } finally {
    saveLoading.value = false
  }
}

const closeIssue = async () => {
  try {
    await ElMessageBox.confirm('确认关闭此问题？关闭后可一键转化为 Lesson Learn 记录。', '关闭确认', { type: 'warning' })
    form.value.Status = 'Closed'
    form.value.ActualCloseDate = new Date().toISOString().split('T')[0]
    await saveForm()
  } catch { /* cancelled */ }
}

const convertToLL = async (row) => {
  try {
    await ElMessageBox.confirm(`确认将问题 ${row.IssueNo || ''} 转化为 Lesson Learn 记录？`, '转化确认', { type: 'info' })
    const res = await http.post('/api/LL_ProblemCenter/ConvertToLL', { problem_Id: row.Problem_Id || 0 }, false)
    if (res.status) {
      const newId = res.data?.lessonLearn_Id || res.data?.LessonLearn_Id
      ElMessage.success('已成功生成 Lesson Learn 记录')
      if (newId) router.push({ path: '/LL_CaseDetail', query: { id: newId } })
    } else {
      ElMessage.warning(res.message || '转化功能需要后端 API 支持')
    }
  } catch { /* cancelled */ }
}

const uploadAttachments = async (event) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const forms = new FormData()
    Array.from(files).forEach(file => forms.append('fileInput', file, file.name))
    const result = await http.post('/api/LL_LessonLearn/Upload', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
    if (!result.status) throw new Error(result.message)
    Array.from(files).forEach(file => {
      form.value.Attachments.push({ Name: file.name, Path: `${result.data || ''}${file.name}`, Size: file.size })
    })
    ElMessage.success('附件上传成功')
  } catch (e) {
    ElMessage.error(e.message || '附件上传失败')
  } finally {
    event.target.value = ''
  }
}

const exportProblems = () => {
  const url = `${http.ipAddress}/api/LL_ProblemCenter/ExportExcel?keyword=${searchForm.keyword || ''}&type=${searchForm.type || ''}&status=${searchForm.status || ''}`
  window.open(url, '_blank')
}

const goTo = (path) => router.push(path)

const demoData = () => [
  { Problem_Id: 1, IssueNo: 'CEPS-D-0001', RecordDate: '2026-04-01', CloseDate: '', IssueDescription: 'Noise-32mm worm bearing-Insufficient axial load capacity', Component: 'Worm Gear', Type: 'D', Priority: 'H', AffectPlant: 'S3,S7,S8', ActionPlan: 'Define design improvement plan', ActionOwner: 'Meicheng Fu', IssueOwner: 'Dillon Li', TargetCloseDate: '2026-04-08', ActualCloseDate: '', Status: 'Open', Comments: '' },
  { Problem_Id: 2, IssueNo: 'REPS-P-002', RecordDate: '2026-03-15', CloseDate: '', IssueDescription: 'Revalidate torque sequence after fixture maintenance', Component: 'Rack', Type: 'P', Priority: 'M', AffectPlant: 'S3', ActionPlan: 'Define test plan', ActionOwner: 'David Xu', IssueOwner: 'Jun Xu', TargetCloseDate: '2026-04-04', ActualCloseDate: '2026-04-03', Status: 'Closed', Comments: '推荐 APQP 作 Follow up' },
  { Problem_Id: 3, IssueNo: 'LL-CEPS-D-001', RecordDate: '2026-04-10', CloseDate: '', IssueDescription: 'Issue CEPS design alert to global teams', Component: 'Sensor', Type: 'S', Priority: 'H', AffectPlant: 'S7', ActionPlan: '', ActionOwner: 'Eric Liu', IssueOwner: 'Lucy Zhang', TargetCloseDate: '2026-04-15', ActualCloseDate: '', Status: 'Pending', Comments: '' }
]

onMounted(loadList)
</script>

<style scoped>
.problem-page { padding: 24px; background: linear-gradient(180deg, #f7f9fd 0%, #eef2f7 100%); min-height: 100%; }
.page-header { display: flex; justify-content: space-between; align-items: end; margin-bottom: 20px; gap: 16px; }
.eyebrow { color: #6366f1; letter-spacing: 1.4px; font-size: 12px; text-transform: uppercase; font-weight: 600; }
h2 { margin: 6px 0 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
p { margin: 0; color: #64748b; max-width: 600px; }
.header-actions { display: flex; gap: 10px; }
.summary-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 16px; margin-bottom: 20px; }
.summary-card { background: #fff; border-radius: 18px; padding: 20px 22px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06); border-left: 4px solid transparent; }
.summary-card .label { color: #64748b; font-size: 13px; }
.summary-card .value { margin-top: 8px; font-size: 32px; font-weight: 700; color: #0f172a; }
.summary-card.open { border-left-color: #ef4444; }
.summary-card.pending { border-left-color: #f59e0b; }
.summary-card.closed { border-left-color: #22c55e; }
.filter-bar { display: flex; flex-wrap: wrap; gap: 10px; align-items: center; margin-bottom: 16px; padding: 16px 20px; background: #fff; border-radius: 16px; box-shadow: 0 6px 16px rgba(15, 23, 42, 0.04); }
.table-card { border-radius: 16px; overflow: hidden; }
.pagination-wrap { padding: 16px 0 4px; display: flex; justify-content: flex-end; }
.drawer-header { display: flex; justify-content: space-between; align-items: center; width: 100%; }
.drawer-title { font-size: 18px; font-weight: 700; color: #0f172a; }
.drawer-actions { display: flex; gap: 10px; }
.form-section { margin-bottom: 24px; padding: 20px; background: #f8fafc; border-radius: 16px; border: 1px solid #e7edf5; }
.section-title { font-size: 16px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 10px; border-bottom: 1px solid #e2e8f0; }
.form-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
.field { display: flex; flex-direction: column; gap: 6px; }
.field.wide { grid-column: span 2; }
.field-label { font-size: 13px; font-weight: 600; color: #475569; }
.att-row { display: flex; justify-content: space-between; align-items: center; padding: 6px 0; border-bottom: 1px solid #f1f5f9; font-size: 13px; }
@media (max-width: 900px) {
  .summary-grid { grid-template-columns: 1fr 1fr; }
  .form-grid { grid-template-columns: 1fr; }
  .field.wide { grid-column: span 1; }
  .page-header { flex-direction: column; align-items: start; }
}
</style>
