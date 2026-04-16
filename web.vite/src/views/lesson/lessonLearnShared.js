export const workflowStatusOptions = [
  { label: '编辑中', value: 0 },
  { label: '待审核', value: 1 },
  { label: '已驳回', value: 2 },
  { label: '已发布', value: 3 }
]

export const lessonLevelOptions = ['Mandatory', 'Optional', 'Standardized', 'Other']
export const categoryOptions = ['Design', 'Process', 'Supplier', 'Nonconformance']
export const issueSourceOptions = ['deviation', 'eFRQC', '5phase', 'eQMS', 'Other']
export const productPlatformOptions = ['CEPS', 'REPS', 'SPEPS', 'DPEPS', 'MG', 'RWA', 'CIS', 'HWA', 'BEPS', 'I-Shaft', 'Column', 'MPP', 'Motor']
export const productLineOptions = ['All EPS', 'REPS', 'SPEPS', 'DPEPS', 'Manual Gear', 'RWA', 'CEPS', 'BEPS', 'I-Shaft', 'Column', 'MPP', 'Motor']

// 产品线二级层级数据：一级为产品线大类，children 为具体细分型号
export const productLineTree = [
  { label: 'CEPS', children: ['M70', 'M80', 'M90', 'HO-CEPS', 'CEPS-Other'] },
  { label: 'REPS', children: ['REPS-Gen1', 'REPS-Gen2', 'REPS-Other'] },
  { label: 'SPEPS', children: ['SPEPS-Standard', 'SPEPS-Other'] },
  { label: 'DPEPS', children: ['DPEPS-Standard', 'DPEPS-Other'] },
  { label: 'BEPS', children: ['BEPS-Standard', 'BEPS-Other'] },
  { label: 'Manual Gear', children: ['MG-Standard', 'MG-Other'] },
  { label: 'RWA', children: ['RWA-Standard', 'RWA-Other'] },
  { label: 'I-Shaft', children: ['I-Shaft-Standard', 'I-Shaft-Other'] },
  { label: 'Column', children: ['Column-Standard', 'Column-Other'] },
  { label: 'MPP', children: ['MPP-Standard', 'MPP-Other'] },
  { label: 'Motor', children: ['Motor-Standard', 'Motor-Other'] },
  { label: 'All EPS', children: [] }
]
export const partVersionOptions = ['v1', 'v2', 'v3']
export const documentTypeOptions = [
  'Product Roadmap',
  'Architecture Technical Roadmap',
  'Product Manual',
  'Architecture BOD Book',
  'Template Drawing/Spec',
  'Template DFMEA',
  'Template PFMEA',
  'Template DSS',
  'Template Stack Up',
  'Core Design Guidelines Book',
  'Platform BOP',
  'Customer Program APQP Checklist',
  'Customer Program DR Checklist',
  'Customer Program Production Release – ISR',
  'Customer Program Production Release – PSW',
  'Customer Program Production Release – PPAP',
  'Platform Validation Report',
  'Platform Lesson Learn',
  'Platform TCM',
  'Supplier Quality Manual',
  'Incoming Inspection Standard',
  'Process Control Plan',
  'Work Instruction',
  'Design Verification Plan & Report',
  'Other'
]

// 发现阶段选项 (Slide 3⑥)
export const discoveryStageOptions = ['Test Center', 'Prototype Center', 'Production', 'Field', 'NA']

export const suggestedTags = ['零件', '失效模式', '关键工艺', 'EP', '淬火裂纹', 'rack', 'traceability', 'cold cure', 'DFMEA', 'supplier']

// 结构化标签分组 (Slide 4②, Slide 45)
export const tagGroupDefinitions = [
  { key: 'problem', label: '问题', icon: '🔴', examples: ['比利时路面', '左右换向', 'rattle noise', '左右转向不一致', '钢环与齿条碰撞'] },
  { key: 'part', label: '零件', icon: '🔩', examples: ['rack', 'pinion', 'housing', 'motor', 'worm gear', 'valve', 'torsion bar'] },
  { key: 'rootCause', label: '根因', icon: '🔍', examples: ['设计不良', '工艺不良', '供应商不良', '热处理不良', '模具磨损', '材料缺陷'] },
  { key: 'action', label: '措施', icon: '🛠️', examples: ['DFMEA更新', 'PFMEA更新', 'CP更新', 'WI更新', 'traceability', 'cold cure'] },
  { key: 'project', label: '项目', icon: '📁', examples: ['EP', 'DV', 'PV', 'SOP', 'APQP', 'PPAP'] }
]
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
  ProductPlatforms: [],
  LlGroup: '',
  IssueSource: '',
  IssueNo: '',
  IssueUrl: '',
  IssueType: '',
  CPI: '',
  CpiProgram: '',
  Customer: '',
  Program: '',
  PartNo: '',
  PartVersion: '',
  Plant: '',
  Workshop: '',
  ProductionLine: '',
  CellName: '',
  ApprovalOwner: 'Nexteer Issue Owner',
  DiscoveryStage: '',
  IsActive: true,
  PfmeaEnabled: true,
  PfmeaDescription: '',
  PfmeaBefore: newPfmeaScore(),
  PfmeaAfter: newPfmeaScore(),
  DfmeaEnabled: false,
  DfmeaDescription: '',
  DfmeaBefore: newPfmeaScore(),
  DfmeaAfter: newPfmeaScore(),
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
      cpiProgram: 'CpiProgram',
      pfmeaEnabled: 'PfmeaEnabled',
      pfmeaDescription: 'PfmeaDescription',
      pfmeaBefore: 'PfmeaBefore',
      pfmeaAfter: 'PfmeaAfter',
      dfmeaEnabled: 'DfmeaEnabled',
      dfmeaDescription: 'DfmeaDescription',
      dfmeaBefore: 'DfmeaBefore',
      dfmeaAfter: 'DfmeaAfter',
      issueUrl: 'IssueUrl',
      partVersion: 'PartVersion',
      productPlatforms: 'ProductPlatforms',
      isActive: 'IsActive',
      discoveryStage: 'DiscoveryStage'
    }
    const nextKey = specialMap[key] || `${key.charAt(0).toUpperCase()}${key.slice(1)}`
    acc[nextKey] = toPascalCaseKeys(payload[key])
    return acc
  }, {})
}
