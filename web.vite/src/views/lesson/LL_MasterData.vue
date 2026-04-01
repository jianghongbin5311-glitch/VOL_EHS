<template>
  <div class="master-page">
    <div class="hero">
      <div>
        <div class="eyebrow">MASTER DATA</div>
        <h1>{{ config.title }}</h1>
        <p>{{ config.description }}</p>
      </div>
      <el-button type="primary" @click="openDialog()">新增</el-button>
    </div>

    <div class="toolbar card">
      <el-input v-model="searchForm.keyword" placeholder="搜索编码/名称/备注" clearable style="width: 280px" @keyup.enter="loadRows" />
      <el-select v-model="searchForm.isEnabled" clearable placeholder="状态" style="width: 140px">
        <el-option label="启用" :value="true" />
        <el-option label="停用" :value="false" />
      </el-select>
      <el-button type="primary" @click="loadRows">查询</el-button>
      <el-button @click="resetSearch">重置</el-button>
    </div>

    <div class="card table-wrap">
      <el-table :data="rows" stripe border v-loading="loading">
        <el-table-column prop="DataCode" :label="config.codeLabel" width="180" />
        <el-table-column prop="DataName" :label="config.nameLabel" min-width="200" />
        <el-table-column v-if="config.parentType" prop="ParentName" :label="config.parentLabel" width="180" />
        <el-table-column prop="Sort" label="排序" width="90" />
        <el-table-column label="状态" width="90">
          <template #default="{ row }">
            <el-tag :type="row.IsEnabled ? 'success' : 'info'">{{ row.IsEnabled ? '启用' : '停用' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="默认" width="90">
          <template #default="{ row }">
            <el-tag :type="row.IsDefault ? 'warning' : 'info'">{{ row.IsDefault ? '默认' : '否' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="Remark" label="说明" min-width="220" show-overflow-tooltip />
        <el-table-column prop="ModifyDate" label="更新时间" width="170" />
        <el-table-column label="操作" width="150" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" @click="openDialog(row)">编辑</el-button>
            <el-button link type="danger" @click="removeRow(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <el-dialog v-model="dialogVisible" :title="config.title" width="720px">
      <div class="form-grid">
        <el-input v-model="editForm.DataCode" :placeholder="config.codeLabel" />
        <el-input v-model="editForm.DataName" :placeholder="config.nameLabel" />
        <el-select v-if="config.parentType" v-model="editForm.ParentCode" clearable :placeholder="config.parentLabel" @change="syncParentName">
          <el-option v-for="item in parentOptions" :key="item.DataCode" :label="item.DataName" :value="item.DataCode" />
        </el-select>
        <el-input-number v-model="editForm.Sort" :min="0" :max="9999" controls-position="right" />
        <el-switch v-model="editForm.IsEnabled" active-text="启用" inactive-text="停用" />
        <el-switch v-model="editForm.IsDefault" active-text="默认项" inactive-text="普通项" />
        <el-input v-model="editForm.Ext1" placeholder="扩展字段1" />
        <el-input v-model="editForm.Ext2" placeholder="扩展字段2" />
        <el-input v-model="editForm.Remark" type="textarea" :rows="4" placeholder="补充说明" class="span-2" />
      </div>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="saving" @click="saveRow">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, reactive, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/api/http.js'
import { getMasterDataConfig } from './lessonMasterData'
import { toPascalCaseKeys } from './lessonLearnShared'

const route = useRoute()
const loading = ref(false)
const saving = ref(false)
const dialogVisible = ref(false)
const rows = ref([])
const bundle = ref({ plants: [], workshops: [], lines: [], productLines: [], tagSuggestions: [], documentTypes: [] })
const searchForm = reactive({ keyword: '', isEnabled: null })
const editForm = reactive(emptyEditForm())

function emptyEditForm() {
  return {
    MasterData_Id: 0,
    DataCode: '',
    DataName: '',
    ParentCode: '',
    ParentName: '',
    Sort: 0,
    IsEnabled: true,
    IsDefault: false,
    Ext1: '',
    Ext2: '',
    Remark: ''
  }
}

const config = computed(() => getMasterDataConfig(route.path))
const parentOptions = computed(() => {
  if (config.value.parentType === 'Plant') return bundle.value.Plants || bundle.value.plants || []
  if (config.value.parentType === 'Workshop') return bundle.value.Workshops || bundle.value.workshops || []
  return []
})

const loadBundle = async () => {
  const res = await http.get('/api/LL_MasterData/Bundle', {}, false)
  if (res.status) {
    bundle.value = toPascalCaseKeys(res.data || bundle.value)
  }
}

const loadRows = async () => {
  loading.value = true
  try {
    const res = await http.post('/api/LL_MasterData/Search', {
      dataType: config.value.dataType,
      keyword: searchForm.keyword,
      isEnabled: searchForm.isEnabled
    }, false)
    if (!res.status) {
      ElMessage.error(res.message || '加载主数据失败')
      return
    }
    const data = toPascalCaseKeys(res.data || {})
    rows.value = data.Items || []
  } finally {
    loading.value = false
  }
}

const resetSearch = () => {
  searchForm.keyword = ''
  searchForm.isEnabled = null
  loadRows()
}

const openDialog = (row) => {
  Object.assign(editForm, emptyEditForm(), row || {})
  dialogVisible.value = true
}

const syncParentName = () => {
  const current = parentOptions.value.find(item => item.DataCode === editForm.ParentCode)
  editForm.ParentName = current?.DataName || ''
}

const saveRow = async () => {
  if (!editForm.DataCode || !editForm.DataName) {
    ElMessage.warning('编码和名称不能为空')
    return
  }
  saving.value = true
  try {
    const res = await http.post('/api/LL_MasterData/Save', {
      ...editForm,
      DataType: config.value.dataType
    }, false)
    if (!res.status) {
      ElMessage.error(res.message || '保存失败')
      return
    }
    ElMessage.success(res.message || '保存成功')
    dialogVisible.value = false
    await loadBundle()
    await loadRows()
  } finally {
    saving.value = false
  }
}

const removeRow = async (row) => {
  try {
    await ElMessageBox.confirm(`确认删除【${row.DataName}】吗？`, '提示', { type: 'warning' })
    const res = await http.post(`/api/LL_MasterData/Delete/${row.MasterData_Id}`, {}, false)
    if (!res.status) {
      ElMessage.error(res.message || '删除失败')
      return
    }
    ElMessage.success(res.message || '删除成功')
    await loadBundle()
    await loadRows()
  } catch {
  }
}

watch(() => route.path, async () => {
  Object.assign(editForm, emptyEditForm())
  dialogVisible.value = false
  await loadRows()
})

onMounted(async () => {
  await loadBundle()
  await loadRows()
})
</script>

<style scoped>
.master-page{display:grid;gap:18px;padding:24px;background:linear-gradient(180deg,#f7f9fd 0%,#eef2f7 100%);min-height:100%}
.hero,.card{background:rgba(255,255,255,.95);border:1px solid rgba(15,23,42,.06);border-radius:22px;box-shadow:0 16px 38px rgba(15,23,42,.06)}
.hero{display:flex;justify-content:space-between;align-items:flex-start;gap:24px;padding:24px 28px}
.eyebrow{font-size:12px;font-weight:700;letter-spacing:.12em;color:#165dff}
h1{margin:8px 0 10px;font-size:34px;color:#16315c}
p{margin:0;color:#526177;max-width:720px;line-height:1.7}
.toolbar{display:flex;gap:12px;align-items:center;padding:18px 22px;flex-wrap:wrap}
.table-wrap{padding:18px}
.form-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:14px}
.span-2{grid-column:1 / -1}
@media (max-width:960px){.master-page{padding:12px}.hero{padding:18px;flex-direction:column}.form-grid{grid-template-columns:1fr}h1{font-size:28px}}
</style>
