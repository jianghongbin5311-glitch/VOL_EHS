<template>
  <div class="ll-page">
    <div class="ll-toolbar">
      <div class="toolbar-left">
        <el-input v-model="searchForm.keyword" placeholder="搜索 LL 编号/标题/标签" clearable style="width: 260px" />
        <el-input v-model="searchForm.tag" placeholder="标签" clearable style="width: 160px" />
        <el-select v-model="searchForm.category" placeholder="分类" clearable style="width: 140px">
          <el-option v-for="item in categoryOptions" :key="item" :label="item" :value="item" />
        </el-select>
        <el-select v-model="searchForm.lessonLevel" placeholder="LL属性" clearable style="width: 150px">
          <el-option v-for="item in lessonLevelOptions" :key="item" :label="item" :value="item" />
        </el-select>
        <el-select v-model="searchForm.status" placeholder="状态" clearable style="width: 140px">
          <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <el-select v-model="searchForm.productLine" placeholder="产品线" clearable filterable style="width: 170px">
          <el-option v-for="item in productLineOptions" :key="item" :label="item" :value="item" />
        </el-select>
        <el-button type="primary" @click="loadList">查询</el-button>
        <el-button @click="resetSearch">重置</el-button>
      </div>
      <div class="toolbar-right">
        <el-button type="success" @click="openCreate">新建 Lesson Learn</el-button>
      </div>
    </div>

    <div class="ll-table">
      <el-table :data="tableData" stripe border v-loading="listLoading" @row-click="openEdit">
        <el-table-column prop="LessonNo" label="LL编号" width="160" />
        <el-table-column label="标题" min-width="260">
          <template #default="{ row }">
            <div class="title-cell">
              <div>{{ row.TitleEn || '-' }}</div>
              <div class="title-cn">{{ row.TitleCn || '' }}</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="Category" label="分类" width="110" />
        <el-table-column prop="LessonLevel" label="LL属性" width="130" />
        <el-table-column prop="ApplicableProductLinesText" label="适用产品线" min-width="180" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="statusTagType(row.Status)">{{ statusText(row.Status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="Progress" label="进度" width="90">
          <template #default="{ row }">{{ row.Progress || 0 }}%</template>
        </el-table-column>
        <el-table-column prop="ViewCount" label="浏览" width="70" />
        <el-table-column prop="FavoriteCount" label="收藏" width="70" />
        <el-table-column prop="LikeCount" label="点赞" width="70" />
        <el-table-column prop="VersionNo" label="版本" width="70" />
        <el-table-column prop="ModifyDate" label="最后修改" width="170">
          <template #default="{ row }">{{ formatDateTime(row.ModifyDate || row.CreateDate) }}</template>
        </el-table-column>
        <el-table-column label="操作" width="110" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click.stop="openEdit(row)">打开</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination-wrap">
        <el-pagination
          v-model:current-page="page.current"
          v-model:page-size="page.size"
          :total="page.total"
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          @current-change="loadList"
          @size-change="loadList"
        />
      </div>
    </div>

    <el-drawer v-model="drawerVisible" :size="'88%'" destroy-on-close>
      <template #header>
        <div class="drawer-header">
          <div>
            <div class="drawer-title">{{ form.TitleEn || '新建 Lesson Learn' }}</div>
            <div class="drawer-subtitle">{{ form.TitleCn || '结构化沉淀经验教训、评审、任务与附件' }}</div>
          </div>
          <div class="drawer-actions">
            <span class="autosave-text">{{ autoSaveText }}</span>
            <input ref="pptInputRef" type="file" accept=".pptx" style="display: none" @change="parsePpt" />
            <el-button @click="triggerPptImport">导入PPT</el-button>
            <el-button type="primary" :loading="saveLoading" @click="saveDraft(false)">保存</el-button>
            <el-button type="warning" :disabled="!form.LessonLearn_Id" @click="submitLesson">提交审批</el-button>
            <el-button :disabled="!form.LessonLearn_Id" @click="rejectLesson">驳回</el-button>
            <el-button type="success" :disabled="!form.LessonLearn_Id" @click="publishLesson">发布</el-button>
            <el-button :disabled="!form.LessonLearn_Id" @click="unlockLesson">解锁</el-button>
          </div>
        </div>
      </template>

      <div class="summary-cards">
        <div class="summary-card"><div class="label">状态</div><div class="value">{{ statusText(form.Status) }}</div></div>
        <div class="summary-card"><div class="label">完成进度</div><div class="value">{{ form.Progress || 0 }}%</div></div>
        <div class="summary-card"><div class="label">分析周期</div><div class="value">{{ form.AnalysisCycleDays || 0 }} 天</div></div>
        <div class="summary-card clickable" @click="updateMetric('favorite')"><div class="label">收藏次数</div><div class="value">{{ form.FavoriteCount || 0 }}</div></div>
        <div class="summary-card clickable" @click="updateMetric('like')"><div class="label">点赞次数</div><div class="value">{{ form.LikeCount || 0 }}</div></div>
        <div class="summary-card"><div class="label">浏览次数</div><div class="value">{{ form.ViewCount || 0 }}</div></div>
      </div>

      <el-tabs>
        <el-tab-pane label="基础信息">
          <div class="section-grid">
            <el-card>
              <template #header>标题与编号</template>
              <div class="form-grid">
                <div class="inline-field">
                  <el-input v-model="form.LessonNo" placeholder="LL-CEPS-D-001" />
                  <el-button @click="generateLessonNo">自动编号</el-button>
                </div>
                <el-select v-model="form.Category" placeholder="LL分类">
                  <el-option v-for="item in categoryOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-input v-model="form.TitleEn" placeholder="英文标题（必填）" />
                <el-input v-model="form.TitleCn" placeholder="中文标题（选填）" />
                <el-input v-model="form.ProductPlatform" placeholder="产品所属平台" />
                <el-input v-model="form.LlGroup" placeholder="LL组别，如 CEPS: CIS/MPP/AM/Software" />
              </div>
            </el-card>

            <el-card>
              <template #header>业务字段</template>
              <div class="form-grid">
                <el-input v-model="form.IssueSource" placeholder="Issue System" />
                <el-input v-model="form.IssueNo" placeholder="Issue No." />
                <el-input v-model="form.IssueType" placeholder="Type" />
                <el-input v-model="form.CPI" placeholder="CPI" />
                <el-input v-model="form.Customer" placeholder="Customer" />
                <el-input v-model="form.Program" placeholder="Program" />
                <el-input v-model="form.PartNo" placeholder="Part No." />
                <el-input v-model="form.Plant" placeholder="Plant" />
                <el-input v-model="form.ProductionLine" placeholder="Line" />
                <el-input v-model="form.CellName" placeholder="Cell" />
                <el-input v-model="form.ApprovalOwner" placeholder="审批责任人，如 PL APQP" />
              </div>
            </el-card>
          </div>

          <el-card class="mt16">
            <template #header>适用产品线与标签</template>
            <div class="section-grid">
              <div>
                <div class="field-title">适用产品线</div>
                <el-checkbox-group v-model="form.ApplicableProductLines" class="option-grid">
                  <el-checkbox v-for="item in productLineOptions" :key="item" :label="item">{{ item }}</el-checkbox>
                </el-checkbox-group>
              </div>
              <div>
                <div class="field-title">标签</div>
                <el-select v-model="form.Tags" multiple filterable allow-create default-first-option style="width: 100%">
                  <el-option v-for="item in suggestedTags" :key="item" :label="item" :value="item" />
                </el-select>
              </div>
            </div>
          </el-card>
        </el-tab-pane>

        <el-tab-pane label="四段内容">
          <div class="content-columns">
            <el-card>
              <template #header>
                问题描述
                <el-button type="primary" link @click="addTextBlock('IssueDescription')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.IssueDescription" :key="'issue-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('IssueDescription', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'IssueDescription', index)" />
                </div>
                <div class="attachment-list">
                  <div v-for="(img, imgIndex) in item.Images" :key="img.Path + imgIndex" class="attachment-row">
                    <div>{{ img.Name }}</div>
                    <div class="attachment-actions">
                      <el-input v-model="img.CaptionEn" placeholder="图片英文说明" size="small" />
                      <el-input v-model="img.CaptionZh" placeholder="图片中文说明" size="small" />
                      <el-button link @click="downloadAttachment(img)">下载</el-button>
                      <el-button type="danger" link @click="item.Images.splice(imgIndex, 1)">删除</el-button>
                    </div>
                  </div>
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                根本原因
                <el-button type="primary" link @click="addTextBlock('RootCause')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.RootCause" :key="'root-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('RootCause', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'RootCause', index)" />
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                纠正措施
                <el-button type="primary" link @click="addTextBlock('CorrectiveActions')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.CorrectiveActions" :key="'action-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('CorrectiveActions', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'CorrectiveActions', index)" />
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                全球经验教训
                <el-button type="primary" link @click="addTextBlock('GlobalLessons')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.GlobalLessons" :key="'global-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('GlobalLessons', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'GlobalLessons', index)" />
                </div>
              </div>
            </el-card>
          </div>
        </el-tab-pane>

        <el-tab-pane label="文档与附件">
          <el-card>
            <template #header>标准文件清单与变更前后文件</template>
            <div class="section-grid">
              <el-select v-model="form.DocumentTypes" multiple placeholder="选择文件类型" style="width: 100%">
                <el-option v-for="item in documentTypeOptions" :key="item" :label="item" :value="item" />
              </el-select>
              <el-button type="primary" @click="addDocumentChange">新增变更条目</el-button>
            </div>
            <div v-for="(item, index) in form.DocumentChanges" :key="'doc-' + index" class="doc-card">
              <div class="block-toolbar">
                <span>变更条目 {{ index + 1 }}</span>
                <el-button type="danger" link @click="form.DocumentChanges.splice(index, 1)">删除</el-button>
              </div>
              <div class="form-grid">
                <el-input v-model="item.ChangeType" placeholder="文件类型" />
                <el-input v-model="item.BeforeFileName" placeholder="更改前文件名" />
                <el-input v-model="item.AfterFileName" placeholder="更改后文件名" />
              </div>
              <div class="section-grid mt8">
                <div>
                  <div class="field-title">更改前文件</div>
                  <input type="file" multiple @change="uploadDocumentFiles($event, item, 'BeforeFiles')" />
                </div>
                <div>
                  <div class="field-title">更改后文件</div>
                  <input type="file" multiple @change="uploadDocumentFiles($event, item, 'AfterFiles')" />
                </div>
              </div>
            </div>
          </el-card>

          <el-card class="mt16">
            <template #header>通用附件</template>
            <div class="section-grid">
              <input type="file" multiple @change="uploadGeneralFiles" />
              <el-button @click="downloadAll">下载全部</el-button>
            </div>
            <div class="attachment-list">
              <div v-for="(item, index) in form.Attachments" :key="'file-' + index" class="attachment-row">
                <div>
                  <div>{{ item.Name }}</div>
                  <div class="muted">{{ formatSize(item.Size) }} / 下载 {{ item.DownloadCount || 0 }} 次 / {{ item.UploadTime }}</div>
                </div>
                <div class="attachment-actions">
                  <el-button link @click="downloadAttachment(item)">下载</el-button>
                  <el-button type="danger" link @click="form.Attachments.splice(index, 1)">删除</el-button>
                </div>
              </div>
            </div>
          </el-card>
        </el-tab-pane>

        <el-tab-pane label="评审与任务">
          <div class="section-grid">
            <el-card>
              <template #header>
                多轮评审
                <el-button type="primary" link @click="form.ReviewRecords.push(newReview())">新增评审</el-button>
              </template>
              <div v-for="(item, index) in form.ReviewRecords" :key="'review-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>评审 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="form.ReviewRecords.splice(index, 1)">删除</el-button>
                </div>
                <div class="form-grid">
                  <el-input v-model="item.Round" placeholder="轮次" />
                  <el-input v-model="item.ReviewDate" placeholder="日期" />
                  <el-input v-model="item.Reviewer" placeholder="评审人" />
                  <el-input v-model="item.ReviewerTitle" placeholder="职位" />
                  <el-input v-model="item.Result" placeholder="结果" />
                  <el-input v-model="item.Comments" placeholder="意见" />
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                参与人员
                <el-button type="primary" link @click="form.Participants.push(newParticipant())">新增人员</el-button>
              </template>
              <div v-for="(item, index) in form.Participants" :key="'person-' + index" class="mini-row">
                <el-input v-model="item.Name" placeholder="姓名" />
                <el-input v-model="item.Title" placeholder="职位" />
                <el-button type="danger" link @click="form.Participants.splice(index, 1)">删除</el-button>
              </div>
            </el-card>
          </div>

          <el-card class="mt16">
            <template #header>
              任务分配
              <el-button type="primary" link @click="form.Tasks.push(newTask())">新增任务</el-button>
            </template>
            <div v-for="(item, index) in form.Tasks" :key="'task-' + index" class="block-card">
              <div class="block-toolbar">
                <span>任务 {{ index + 1 }}</span>
                <el-button type="danger" link @click="form.Tasks.splice(index, 1)">删除</el-button>
              </div>
              <div class="form-grid">
                <el-input v-model="item.Title" placeholder="任务名称" />
                <el-input v-model="item.Owner" placeholder="责任人" />
                <el-input v-model="item.DueDate" placeholder="完成时间" />
                <el-input-number v-model="item.Progress" :min="0" :max="100" />
                <el-select v-model="item.Status" placeholder="任务状态">
                  <el-option label="待开始" value="待开始" />
                  <el-option label="进行中" value="进行中" />
                  <el-option label="待审批" value="待审批" />
                  <el-option label="已完成" value="已完成" />
                </el-select>
                <el-input v-model="item.Notes" placeholder="说明" />
              </div>
            </div>
          </el-card>
        </el-tab-pane>

        <el-tab-pane label="历史版本">
          <el-timeline>
            <el-timeline-item
              v-for="(item, index) in form.HistoryRecords"
              :key="'history-' + index"
              :timestamp="item.Time"
              placement="top"
            >
              <div class="history-item">
                <div>V{{ item.VersionNo }} / {{ item.Action }} / {{ item.StatusText }}</div>
                <div class="muted">{{ item.Operator }} {{ item.Comment || '' }}</div>
              </div>
            </el-timeline-item>
          </el-timeline>
        </el-tab-pane>
      </el-tabs>
    </el-drawer>
  </div>
</template>

<script setup>
import { nextTick, onMounted, reactive, ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import http from '@/api/http.js'

const statusOptions = [
  { label: '编辑中', value: 0 },
  { label: '待审核', value: 1 },
  { label: '已驳回', value: 2 },
  { label: '已发布', value: 3 }
]
const lessonLevelOptions = ['Mandatory', 'Optional', 'Standardized', 'Other']
const categoryOptions = ['Design', 'Process', 'Supplier']
const productLineOptions = ref(['All EPS', 'REPS', 'SPEPS', 'DPEPS', 'Manual Gear', 'RWA', 'CEPS', 'BEPS', 'I-Shaft', 'Column', 'MPP', 'Motor'])
const documentTypeOptions = ['设计文件', '工艺文件', '供应商文件']
const suggestedTags = ['比利时路面', '左右换向', 'rattle noise', '左右转向不一致', '钢环与齿条碰撞', '热处理不良', '模具磨损']

const listLoading = ref(false)
const saveLoading = ref(false)
const drawerVisible = ref(false)
const tableData = ref([])
const pptInputRef = ref(null)
const autoSaveText = ref('自动保存未开始')
const suppressWatch = ref(false)
let autoSaveTimer = null
const router = useRouter()

const searchForm = reactive({ keyword: '', tag: '', category: '', lessonLevel: '', status: null, productLine: '' })
const page = reactive({ current: 1, size: 10, total: 0 })

const defaultTextBlock = () => ({ Sort: 1, En: '', Zh: '', Images: [] })
const newReview = () => ({ Round: '', ReviewDate: '', Reviewer: '', ReviewerTitle: '', Result: '', Comments: '' })
const newParticipant = () => ({ Name: '', Title: '' })
const newTask = () => ({ Title: '', Owner: '', DueDate: '', Progress: 0, Status: '待开始', Notes: '' })
const newDocumentChange = () => ({ ChangeType: '', BeforeFileName: '', AfterFileName: '', BeforeFiles: [], AfterFiles: [] })
const emptyForm = () => ({
  LessonLearn_Id: 0,
  LessonNo: '',
  TitleEn: '',
  TitleCn: '',
  Category: '',
  ProductPlatform: '',
  LlGroup: '',
  IssueSource: '',
  IssueNo: '',
  IssueType: '',
  CPI: '',
  Customer: '',
  Program: '',
  PartNo: '',
  Plant: '',
  ProductionLine: '',
  CellName: '',
  ApprovalOwner: 'PL APQP',
  Status: 0,
  Progress: 0,
  AnalysisCycleDays: 0,
  ViewCount: 0,
  FavoriteCount: 0,
  LikeCount: 0,
  VersionNo: 0,
  IsLocked: false,
  CreateDate: '',
  ModifyDate: '',
  HistoryRecords: [],
  BasicInfo: { LlCategoryCode: '', LlGroupNote: '', VersionRemark: '' },
  ApplicableProductLines: [],
  Tags: [],
  IssueDescription: [defaultTextBlock()],
  RootCause: [defaultTextBlock()],
  CorrectiveActions: [defaultTextBlock()],
  GlobalLessons: [defaultTextBlock()],
  SupplementalNotes: [],
  DocumentTypes: [],
  DocumentChanges: [],
  Attachments: [],
  ReviewRecords: [],
  Participants: [],
  Tasks: []
})

const form = ref(emptyForm())

const keyAliasMap = {
  cpi: 'CPI',
  createId: 'CreateID',
  modifyId: 'ModifyID'
}

const toPascalCaseKeys = (value) => {
  if (Array.isArray(value)) {
    return value.map((item) => toPascalCaseKeys(item))
  }
  if (!value || Object.prototype.toString.call(value) !== '[object Object]') {
    return value
  }
  return Object.keys(value).reduce((result, key) => {
    const normalizedKey = keyAliasMap[key] || (key ? `${key.charAt(0).toUpperCase()}${key.slice(1)}` : key)
    result[normalizedKey] = toPascalCaseKeys(value[key])
    return result
  }, {})
}

const statusText = (status) => {
  const item = statusOptions.find((x) => x.value === status)
  return item ? item.label : '编辑中'
}
const statusTagType = (status) => {
  if (status === 1) return 'warning'
  if (status === 2) return 'danger'
  if (status === 3) return 'success'
  return 'info'
}
const formatDateTime = (val) => (val ? `${val}`.replace('T', ' ').substring(0, 19) : '-')
const formatSize = (size) => {
  if (!size) return '0B'
  if (size < 1024) return `${size}B`
  if (size < 1024 * 1024) return `${(size / 1024).toFixed(1)}KB`
  return `${(size / 1024 / 1024).toFixed(1)}MB`
}

const loadMasterBundle = async () => {
  const res = await http.get('/api/LL_MasterData/Bundle', {}, false)
  const rows = res?.data?.productLines || res?.data?.ProductLines || []
  const values = rows.map((item) => item.dataName || item.DataName).filter(Boolean)
  if (values.length) {
    productLineOptions.value = values
  }
}

const loadList = async () => {
  listLoading.value = true
  try {
    const res = await http.post('/api/LL_LessonLearn/Search', {
      page: page.current,
      pageSize: page.size,
      keyword: searchForm.keyword,
      tag: searchForm.tag,
      category: searchForm.category,
      lessonLevel: searchForm.lessonLevel,
      status: searchForm.status,
      productLine: searchForm.productLine
    }, false)
    if (res.status) {
      const data = toPascalCaseKeys(res.data || {})
      tableData.value = data.Items || []
      page.total = data.Total || 0
    }
  } finally {
    listLoading.value = false
  }
}

const resetSearch = () => {
  searchForm.keyword = ''
  searchForm.tag = ''
  searchForm.category = ''
  searchForm.lessonLevel = ''
  searchForm.status = null
  searchForm.productLine = ''
  page.current = 1
  loadList()
}

const mergeForm = (data) => {
  suppressWatch.value = true
  form.value = Object.assign(emptyForm(), data || {})
  form.value.ApplicableProductLines ||= []
  form.value.Tags ||= []
  form.value.IssueDescription = form.value.IssueDescription?.length ? form.value.IssueDescription : [defaultTextBlock()]
  form.value.RootCause = form.value.RootCause?.length ? form.value.RootCause : [defaultTextBlock()]
  form.value.CorrectiveActions = form.value.CorrectiveActions?.length ? form.value.CorrectiveActions : [defaultTextBlock()]
  form.value.GlobalLessons = form.value.GlobalLessons?.length ? form.value.GlobalLessons : [defaultTextBlock()]
  form.value.SupplementalNotes ||= []
  form.value.DocumentTypes ||= []
  form.value.DocumentChanges ||= []
  form.value.Attachments ||= []
  form.value.ReviewRecords ||= []
  form.value.Participants ||= []
  form.value.Tasks ||= []
  form.value.HistoryRecords ||= []
  nextTick(() => {
    suppressWatch.value = false
  })
}

const openCreate = () => {
  router.push('/LL_CaseDetail')
}

const openEdit = async (row) => {
  const id = row?.LessonLearn_Id || row
  router.push({ path: '/LL_CaseDetail', query: { id } })
}

const addTextBlock = (field) => {
  form.value[field].push({ ...defaultTextBlock(), Sort: form.value[field].length + 1 })
}

const removeTextBlock = (field, index) => {
  form.value[field].splice(index, 1)
  if (!form.value[field].length) {
    form.value[field].push(defaultTextBlock())
  }
}

const uploadFiles = async (files) => {
  const forms = new FormData()
  Array.from(files).forEach((file) => forms.append('fileInput', file, file.name))
  const result = await http.post('/api/LL_LessonLearn/Upload', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
  if (!result.status) {
    throw new Error(result.message || '上传失败')
  }
  return Array.from(files).map((file) => ({
    Category: '',
    Name: file.name,
    Path: `${result.data || ''}${file.name}`,
    Size: file.size,
    DownloadCount: 0,
    UploadTime: new Date().toLocaleString(),
    CaptionEn: '',
    CaptionZh: ''
  }))
}

const uploadSectionFiles = async (event, field, index) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const rows = await uploadFiles(files)
    form.value[field][index].Images.push(...rows)
    ElMessage.success('图片上传成功')
  } catch (error) {
    ElMessage.error(error.message || '图片上传失败')
  } finally {
    event.target.value = ''
  }
}

const uploadDocumentFiles = async (event, item, field) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const rows = await uploadFiles(files)
    item[field].push(...rows)
    ElMessage.success('文件上传成功')
  } catch (error) {
    ElMessage.error(error.message || '文件上传失败')
  } finally {
    event.target.value = ''
  }
}

const uploadGeneralFiles = async (event) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const rows = await uploadFiles(files)
    form.value.Attachments.push(...rows)
    ElMessage.success('附件上传成功')
  } catch (error) {
    ElMessage.error(error.message || '附件上传失败')
  } finally {
    event.target.value = ''
  }
}

const normalizePayload = () => JSON.parse(JSON.stringify(form.value))

const saveDraft = async (silent = false) => {
  if (saveLoading.value) return
  saveLoading.value = !silent
  try {
    const res = await http.post('/api/LL_LessonLearn/SaveDraft', normalizePayload(), false)
    if (!res.status) {
      if (!silent) ElMessage.error(res.message || '保存失败')
      return
    }
    mergeForm(toPascalCaseKeys(res.data))
    autoSaveText.value = `最近保存：${new Date().toLocaleTimeString()}`
    if (!silent) {
      ElMessage.success(res.message || '保存成功')
      loadList()
    }
  } finally {
    saveLoading.value = false
  }
}

const postAction = async (path, message) => {
  if (!form.value.LessonLearn_Id) {
    ElMessage.warning('请先保存记录')
    return
  }
  const res = await http.post(path, { comment: '' }, false)
  if (!res.status) {
    ElMessage.error(res.message || '操作失败')
    return
  }
  mergeForm(toPascalCaseKeys(res.data))
  ElMessage.success(message)
  loadList()
}

const submitLesson = () => postAction(`/api/LL_LessonLearn/Submit/${form.value.LessonLearn_Id}`, '已提交审批')
const rejectLesson = () => postAction(`/api/LL_LessonLearn/Reject/${form.value.LessonLearn_Id}`, '已驳回')
const publishLesson = () => postAction(`/api/LL_LessonLearn/Publish/${form.value.LessonLearn_Id}`, '已发布并锁定')
const unlockLesson = () => postAction(`/api/LL_LessonLearn/Unlock/${form.value.LessonLearn_Id}`, '已解锁')

const generateLessonNo = async () => {
  const productLine = form.value.ApplicableProductLines?.[0] || ''
  const category = form.value.Category || ''
  const res = await http.post('/api/LL_LessonLearn/GenerateLessonNo', {
    lessonLearn_Id: form.value.LessonLearn_Id || 0,
    productLine,
    category
  }, false)
  if (!res.status) {
    ElMessage.warning(res.message || '编号生成失败')
    return
  }
  const data = toPascalCaseKeys(res.data || {})
  form.value.LessonNo = data.LessonNo || form.value.LessonNo
  ElMessage.success(res.message || '编号已生成')
}

const updateMetric = async (metric) => {
  if (!form.value.LessonLearn_Id) {
    ElMessage.warning('请先保存记录')
    return
  }
  const res = await http.post(`/api/LL_LessonLearn/Metric/${form.value.LessonLearn_Id}/${metric}`, {}, false)
  if (res.status) {
    mergeForm(toPascalCaseKeys(res.data))
  }
}

const addDocumentChange = () => form.value.DocumentChanges.push(newDocumentChange())

const buildFileUrl = (path) => {
  if (!path) return ''
  if (/^https?:/i.test(path)) return path
  const base = http.ipAddress.endsWith('/') ? http.ipAddress : `${http.ipAddress}/`
  return `${base}${path.replace(/^\/+/, '')}`
}

const downloadAttachment = async (item) => {
  if (!item?.Path) return
  if (form.value.LessonLearn_Id) {
    await http.post(`/api/LL_LessonLearn/RecordDownload/${form.value.LessonLearn_Id}`, { path: item.Path }, false)
    item.DownloadCount = (item.DownloadCount || 0) + 1
  }
  window.open(buildFileUrl(item.Path), '_blank')
}

const downloadAll = () => {
  form.value.Attachments.forEach((item) => downloadAttachment(item))
}

const triggerPptImport = () => {
  pptInputRef.value?.click()
}

const parsePpt = async (event) => {
  const file = event.target.files?.[0]
  if (!file) return
  const forms = new FormData()
  forms.append('file', file)
  const res = await http.post('/api/LL_LessonLearn/ParsePpt', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
  if (!res.status) {
    ElMessage.error(res.message || 'PPT解析失败')
    event.target.value = ''
    return
  }
  const data = toPascalCaseKeys(res.data || {})
  form.value.TitleEn = data.TitleEn || form.value.TitleEn
  form.value.LessonNo = data.LessonNo || form.value.LessonNo
  form.value.Category = data.Category || form.value.Category
  form.value.IssueSource = data.IssueSource || form.value.IssueSource
  form.value.IssueNo = data.IssueNo || form.value.IssueNo
  form.value.IssueType = data.IssueType || form.value.IssueType
  form.value.CPI = data.CPI || form.value.CPI
  form.value.Customer = data.Customer || form.value.Customer
  form.value.Program = data.Program || form.value.Program
  form.value.PartNo = data.PartNo || form.value.PartNo
  form.value.Plant = data.Plant || form.value.Plant
  if (data.ProductLine) {
    form.value.ApplicableProductLines = Array.from(new Set([...(form.value.ApplicableProductLines || []), data.ProductLine]))
  }
  if (data.IssueDescription?.length) form.value.IssueDescription = data.IssueDescription
  if (data.RootCause?.length) form.value.RootCause = data.RootCause
  if (data.CorrectiveActions?.length) form.value.CorrectiveActions = data.CorrectiveActions
  if (data.GlobalLessons?.length) form.value.GlobalLessons = data.GlobalLessons
  if (data.SupplementalNotes?.length) form.value.SupplementalNotes = data.SupplementalNotes
  ElMessage.success('PPT 内容已带入表单')
  event.target.value = ''
}

const scheduleAutoSave = () => {
  if (suppressWatch.value || !drawerVisible.value) return
  clearTimeout(autoSaveTimer)
  autoSaveTimer = setTimeout(() => {
    if (form.value.TitleEn || form.value.TitleCn || form.value.LessonNo) {
      saveDraft(true)
    }
  }, 30000)
}

watch(form, () => {
  scheduleAutoSave()
}, { deep: true })

watch(drawerVisible, (visible) => {
  if (!visible) {
    clearTimeout(autoSaveTimer)
  }
})

onMounted(async () => {
  await loadMasterBundle()
  await loadList()
})
</script>

<style scoped>
.ll-page {
  padding: 16px;
}
.ll-toolbar {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 16px;
}
.toolbar-left {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}
.ll-table {
  background: #fff;
  padding: 16px;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(15, 23, 42, 0.06);
}
.pagination-wrap {
  margin-top: 16px;
  display: flex;
  justify-content: flex-end;
}
.title-cell {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
.title-cn,
.muted {
  color: #6b7280;
  font-size: 12px;
}
.drawer-header {
  width: 100%;
  display: flex;
  justify-content: space-between;
  gap: 16px;
}
.drawer-title {
  font-size: 20px;
  font-weight: 700;
}
.drawer-subtitle,
.autosave-text {
  color: #6b7280;
  font-size: 12px;
}
.drawer-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
}
.summary-cards {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 12px;
  margin-bottom: 16px;
}
.summary-card {
  padding: 12px 14px;
  border-radius: 10px;
  background: linear-gradient(180deg, #f8fafc 0%, #eef2ff 100%);
}
.summary-card.clickable {
  cursor: pointer;
}
.summary-card .label {
  font-size: 12px;
  color: #6b7280;
}
.summary-card .value {
  margin-top: 6px;
  font-size: 22px;
  font-weight: 700;
}
.section-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}
.form-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 12px;
}
.field-title {
  margin-bottom: 8px;
  font-size: 13px;
  font-weight: 600;
}
.inline-field {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 8px;
}
.option-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 8px;
}
.content-columns {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}
.block-card,
.doc-card {
  padding: 12px;
  margin-bottom: 12px;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
}
.block-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  font-weight: 600;
}
.upload-line,
.attachment-list {
  margin-top: 8px;
}
.attachment-row,
.mini-row {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 12px;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #eef2f7;
}
.attachment-actions {
  display: flex;
  gap: 8px;
  align-items: center;
}
.history-item {
  line-height: 1.7;
}
.mt8 {
  margin-top: 8px;
}
.mt16 {
  margin-top: 16px;
}
@media (max-width: 1200px) {
  .summary-cards,
  .section-grid,
  .content-columns,
  .form-grid {
    grid-template-columns: 1fr;
  }
  .option-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}
</style>
