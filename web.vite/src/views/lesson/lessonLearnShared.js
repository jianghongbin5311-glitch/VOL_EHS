export const workflowStatusOptions = [
  { label: '编辑中', value: 0 },
  { label: '待审核', value: 1 },
  { label: '已驳回', value: 2 },
  { label: '已发布', value: 3 }
]

export const lessonLevelOptions = ['Mandatory', 'Optional', 'Standardized', 'Other']
export const categoryOptions = ['Design', 'Process', 'Supplier']
export const productLineOptions = ['All EPS', 'REPS', 'SPEPS', 'DPEPS', 'Manual Gear', 'RWA', 'CEPS', 'BEPS', 'I-Shaft', 'Column', 'MPP', 'Motor']
export const documentTypeOptions = ['设计文件', '工艺文件', '供应商文件']
export const suggestedTags = ['零件', '失效模式', '关键工艺', 'EP', '淬火裂纹', 'rack', 'traceability', 'cold cure', 'DFMEA', 'supplier']
export const quickSectionAnchors = [
  { key: 'basic', label: '基础信息' },
  { key: 'lines', label: 'LL适用产品线' },
  { key: 'tags', label: '标签信息' },
  { key: 'issue', label: '问题描述' },
  { key: 'root', label: '根本原因' },
  { key: 'action', label: '纠正措施' },
  { key: 'global', label: '全球经验教训' },
  { key: 'document', label: '标准文件清单' },
  { key: 'supplement', label: '补充文本信息' },
  { key: 'attachment', label: '相关文档' },
  { key: 'review', label: '架构评审记录' },
  { key: 'participant', label: '参与人员' },
  { key: 'task', label: '任务跟踪' },
  { key: 'history', label: '历史版本' }
]

export const defaultTextBlock = () => ({ Sort: 1, En: '', Zh: '', Images: [] })
export const newReview = () => ({ Round: '', ReviewDate: '', Reviewer: '', ReviewerTitle: '', Result: '', Comments: '' })
export const newParticipant = () => ({ Name: '', Title: '' })
export const newTask = () => ({ Title: '', Owner: '', DueDate: '', Progress: 0, Status: '待开始', Notes: '' })
export const newDocumentChange = () => ({ ChangeType: '', BeforeFileName: '', AfterFileName: '', BeforeFiles: [], AfterFiles: [] })
export const newPfmeaScore = () => ({ Severity: 10, Occurrence: 1, Detection: 1 })

export const emptyForm = () => ({
  LessonLearn_Id: 0,
  LessonNo: '',
  TitleEn: '',
  TitleCn: '',
  Category: '',
  LessonLevel: 'Standardized',
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
  Workshop: '',
  ProductionLine: '',
  CellName: '',
  ApprovalOwner: 'PL APQP',
  PfmeaEnabled: true,
  PfmeaDescription: '',
  PfmeaBefore: newPfmeaScore(),
  PfmeaAfter: newPfmeaScore(),
  IsLocked: false,
  Status: 0,
  Progress: 0,
  AnalysisCycleDays: 0,
  ViewCount: 0,
  FavoriteCount: 0,
  LikeCount: 0,
  VersionNo: 0,
  BasicInfo: {
    LlCategoryCode: '',
    LlGroupNote: '',
    VersionRemark: ''
  },
  ApplicableProductLines: [],
  Tags: [],
  IssueDescription: [defaultTextBlock()],
  RootCause: [defaultTextBlock()],
  CorrectiveActions: [defaultTextBlock()],
  GlobalLessons: [defaultTextBlock()],
  SupplementalNotes: [defaultTextBlock()],
  DocumentTypes: [],
  DocumentChanges: [],
  Attachments: [],
  ReviewRecords: [],
  Participants: [],
  Tasks: [],
  HistoryRecords: []
})

export const statusText = (status) => {
  if (status === 1) return '待审核'
  if (status === 2) return '已驳回'
  if (status === 3) return '已发布'
  return '编辑中'
}

export const statusTagType = (status) => {
  if (status === 1) return 'warning'
  if (status === 2) return 'danger'
  if (status === 3) return 'success'
  return 'info'
}

export const formatDateTime = (value) => {
  if (!value) return '-'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value
  return `${date.getFullYear()}-${`${date.getMonth() + 1}`.padStart(2, '0')}-${`${date.getDate()}`.padStart(2, '0')} ${`${date.getHours()}`.padStart(2, '0')}:${`${date.getMinutes()}`.padStart(2, '0')}:${`${date.getSeconds()}`.padStart(2, '0')}`
}

export const formatSize = (size) => {
  if (!size) return '0 KB'
  if (size >= 1024 * 1024) return `${(size / 1024 / 1024).toFixed(2)} MB`
  if (size >= 1024) return `${(size / 1024).toFixed(1)} KB`
  return `${size} B`
}

export const calcRpn = (score) => {
  const severity = Number(score?.Severity || 0)
  const occurrence = Number(score?.Occurrence || 0)
  const detection = Number(score?.Detection || 0)
  return severity * occurrence * detection
}

export const toPascalCaseKeys = (payload) => {
  if (Array.isArray(payload)) return payload.map((item) => toPascalCaseKeys(item))
  if (!payload || typeof payload !== 'object') return payload
  return Object.keys(payload).reduce((acc, key) => {
    const specialMap = {
      lessonLearn_Id: 'LessonLearn_Id',
      cpi: 'CPI',
      pfmeaEnabled: 'PfmeaEnabled',
      pfmeaDescription: 'PfmeaDescription',
      pfmeaBefore: 'PfmeaBefore',
      pfmeaAfter: 'PfmeaAfter'
    }
    const nextKey = specialMap[key] || `${key.charAt(0).toUpperCase()}${key.slice(1)}`
    acc[nextKey] = toPascalCaseKeys(payload[key])
    return acc
  }, {})
}
