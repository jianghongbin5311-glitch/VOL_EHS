<template>
  <div class="ehs-news-report">
    <!-- 顶部搜索区 -->
    <div class="search-bar">
      <el-radio-group v-model="activeType" @change="handleTypeChange" size="default">
        <el-radio-button label="全部" />
        <el-radio-button label="日报" />
        <el-radio-button label="周报" />
        <el-radio-button label="月报" />
      </el-radio-group>
      <el-date-picker
        v-model="dateRange"
        type="daterange"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        style="margin-left: 16px"
        value-format="YYYY-MM-DD"
      />
      <el-input
        v-model="searchText"
        placeholder="搜索标题/摘要/来源..."
        style="width: 240px; margin-left: 16px"
        clearable
        @keyup.enter="handleSearch"
      >
        <template #prefix>
          <el-icon><Search /></el-icon>
        </template>
      </el-input>
      <el-select v-model="searchCategory" placeholder="类别筛选" clearable style="width: 120px; margin-left: 12px">
        <el-option label="事故" value="事故" />
        <el-option label="处罚" value="处罚" />
        <el-option label="法规" value="法规" />
        <el-option label="检查" value="检查" />
        <el-option label="预警" value="预警" />
        <el-option label="培训" value="培训" />
      </el-select>
      <el-button type="primary" @click="handleSearch" style="margin-left: 12px">
        <el-icon><Search /></el-icon> 查询
      </el-button>
      <el-button @click="handleReset">重置</el-button>
      <el-button type="success" @click="generateReport" :loading="generating" style="margin-left: auto">
        <el-icon><Refresh /></el-icon> 手动生成报告
      </el-button>
    </div>

    <!-- 内容区 -->
    <div class="content-area">
      <!-- 列表 -->
      <div class="table-panel">
        <el-table
          :data="tableData"
          stripe
          border
          highlight-current-row
          @row-click="handleRowClick"
          :row-class-name="getRowClassName"
          v-loading="loading"
          style="width: 100%"
        >
          <el-table-column prop="ReportDate" label="日期" width="110" sortable>
            <template #default="{ row }">
              {{ formatDate(row.ReportDate) }}
            </template>
          </el-table-column>
          <el-table-column prop="Title" label="标题" min-width="200" show-overflow-tooltip />
          <el-table-column prop="Category" label="类别" width="80" align="center">
            <template #default="{ row }">
              <el-tag :type="getCategoryType(row.Category)" size="small">{{ row.Category }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="Source" label="来源" width="140" show-overflow-tooltip />
          <el-table-column prop="Summary" label="摘要" min-width="200" show-overflow-tooltip />
          <el-table-column prop="GenerateStatus" label="状态" width="80" align="center">
            <template #default="{ row }">
              <el-tag :type="row.GenerateStatus === 2 ? 'success' : row.GenerateStatus === 3 ? 'danger' : 'info'" size="small">
                {{ row.GenerateStatus === 2 ? '成功' : row.GenerateStatus === 3 ? '失败' : '待生成' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="80" align="center" fixed="right">
            <template #default="{ row }">
              <el-button type="primary" link size="small" @click.stop="handleView(row)">查看</el-button>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页 -->
        <div class="pagination-bar">
          <el-pagination
            v-model:current-page="page.current"
            v-model:page-size="page.size"
            :total="page.total"
            :page-sizes="[20, 50, 100]"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="handleSearch"
            @current-change="handleSearch"
          />
        </div>
      </div>

      <!-- 详情面板 -->
      <el-drawer v-model="detailVisible" :title="detailData.Title" size="50%" direction="rtl">
        <div class="detail-header">
          <el-descriptions :column="2" border size="small">
            <el-descriptions-item label="日期">{{ formatDate(detailData.ReportDate) }}</el-descriptions-item>
            <el-descriptions-item label="类别">
              <el-tag :type="getCategoryType(detailData.Category)" size="small">{{ detailData.Category }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="来源">{{ detailData.Source }}</el-descriptions-item>
            <el-descriptions-item label="来源链接">
              <a v-if="detailData.SourceUrl" :href="detailData.SourceUrl" target="_blank" class="source-link">
                {{ detailData.SourceUrl }}
              </a>
              <span v-else>-</span>
            </el-descriptions-item>
            <el-descriptions-item label="影响" :span="2">{{ detailData.Impact || '-' }}</el-descriptions-item>
            <el-descriptions-item label="建议动作" :span="2">{{ detailData.Action || '-' }}</el-descriptions-item>
          </el-descriptions>
        </div>
        <el-divider />
        <div class="detail-content markdown-body" v-html="renderedContent"></div>
      </el-drawer>
    </div>
  </div>
</template>

<script>
import { ref, reactive, onMounted, computed } from 'vue'
import { Search, Refresh } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/api/http.js'
import { marked } from 'marked'

export default {
  name: 'EHS_NewsReport',
  components: { Search, Refresh },
  setup() {
    const activeType = ref('全部')
    const generating = ref(false)
    const dateRange = ref(null)
    const searchText = ref('')
    const searchCategory = ref('')
    const loading = ref(false)
    const tableData = ref([])
    const detailVisible = ref(false)
    const detailData = ref({})
    const page = reactive({ current: 1, size: 20, total: 0 })

    const renderedContent = computed(() => {
      if (!detailData.value.Content) return ''
      try {
        return marked(detailData.value.Content)
      } catch {
        return detailData.value.Content
      }
    })

    const formatDate = (val) => {
      if (!val) return ''
      return val.substring(0, 10)
    }

    const getCategoryType = (cat) => {
      const map = {
        '事故': 'danger', '处罚': 'warning', '法规': '',
        '检查': 'success', '预警': 'danger', '培训': 'info'
      }
      return map[cat] || 'info'
    }

    const getRowClassName = ({ row }) => {
      return row.Report_Id === detailData.value.Report_Id ? 'current-row-highlight' : ''
    }

    const handleSearch = () => {
      loading.value = true
      const wheres = []

      // 报告类型筛选
      if (activeType.value && activeType.value !== '全部') {
        wheres.push({ name: 'ReportType', value: activeType.value, displayType: 'text' })
      }
      // 日期范围
      if (dateRange.value && dateRange.value.length === 2) {
        wheres.push({ name: 'ReportDate', value: dateRange.value[0], displayType: 'datetime', type: 'gte' })
        wheres.push({ name: 'ReportDate', value: dateRange.value[1] + ' 23:59:59', displayType: 'datetime', type: 'lte' })
      }
      // 关键词
      if (searchText.value) {
        wheres.push({ name: 'Title', value: searchText.value, displayType: 'like' })
      }
      // 类别
      if (searchCategory.value) {
        wheres.push({ name: 'Category', value: searchCategory.value, displayType: 'text' })
      }

      const params = {
        page: page.current,
        rows: page.size,
        sort: 'ReportDate',
        order: 'desc',
        wheres: JSON.stringify(wheres)
      }

      http.post('/api/EHS_NewsReport/GetPageData', params, true).then(res => {
        // VOL框架 GetPageData 返回 status=0 表示成功(0在JS中是falsy)
        if (res.rows) {
          tableData.value = res.rows || []
          page.total = res.total || 0
        }
        loading.value = false
      }).catch(() => {
        loading.value = false
      })
    }

    const handleReset = () => {
      activeType.value = '全部'
      dateRange.value = null
      searchText.value = ''
      searchCategory.value = ''
      page.current = 1
      handleSearch()
    }

    const generateReport = async () => {
      try {
        const { value } = await ElMessageBox.confirm(
          '选择要生成的报告类型', '生成EHS法规新闻报告',
          {
            distinguishCancelAndClose: true,
            confirmButtonText: '日报',
            cancelButtonText: '取消',
          }
        )
      } catch {
        // cancelled
      }
      generating.value = true
      const reportType = activeType.value === '全部' ? '日报' : activeType.value
      try {
        const res = await http.post(`/api/EHS_NewsReport/GenerateReport?type=${reportType}`, {}, false)
        if (res && res.success) {
          ElMessage.success(res.message || '报告生成成功')
          handleSearch()
        } else {
          ElMessage.warning(res?.message || '生成失败')
        }
      } catch (e) {
        ElMessage.error('生成请求失败: ' + (e.message || e))
      } finally {
        generating.value = false
      }
    }

    const handleTypeChange = () => {
      page.current = 1
      handleSearch()
    }

    const handleRowClick = (row) => {
      handleView(row)
    }

    const handleView = (row) => {
      detailData.value = row
      detailVisible.value = true
    }

    onMounted(() => {
      handleSearch()
    })

    return {
      activeType, dateRange, searchText, searchCategory,
      loading, generating, tableData, page,
      detailVisible, detailData, renderedContent,
      formatDate, getCategoryType, getRowClassName,
      handleSearch, handleReset, handleTypeChange,
      handleRowClick, handleView, generateReport
    }
  }
}
</script>

<style scoped>
.ehs-news-report {
  padding: 16px;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.search-bar {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
  padding: 16px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}
.content-area {
  flex: 1;
  overflow: auto;
}
.table-panel {
  background: #fff;
  border-radius: 8px;
  padding: 16px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}
.pagination-bar {
  display: flex;
  justify-content: flex-end;
  margin-top: 16px;
}
.detail-header {
  margin-bottom: 16px;
}
.source-link {
  color: #409eff;
  text-decoration: none;
  word-break: break-all;
}
.source-link:hover {
  text-decoration: underline;
}
.detail-content {
  line-height: 1.8;
  font-size: 14px;
}
.detail-content :deep(h2) {
  font-size: 18px;
  color: #303133;
  border-bottom: 1px solid #ebeef5;
  padding-bottom: 8px;
  margin: 16px 0 12px;
}
.detail-content :deep(h3) {
  font-size: 15px;
  color: #606266;
  margin: 12px 0 8px;
}
.detail-content :deep(a) {
  color: #409eff;
}
.detail-content :deep(table) {
  border-collapse: collapse;
  width: 100%;
  margin: 12px 0;
}
.detail-content :deep(th),
.detail-content :deep(td) {
  border: 1px solid #ebeef5;
  padding: 8px 12px;
  text-align: left;
}
.detail-content :deep(th) {
  background: #f5f7fa;
}
:deep(.current-row-highlight) {
  background-color: #ecf5ff !important;
}
</style>
