import http from '@/api/http.js'

export const categoryOptions = ['Design', 'Process', 'Supplier']
export const productLineOptions = ['All EPS', 'REPS', 'SPEPS', 'DPEPS', 'Manual Gear', 'RWA', 'CEPS', 'BEPS', 'I-Shaft', 'Column', 'MPP', 'Motor']

export const statusText = (status) => {
  if (status === 1) return '待审核'
  if (status === 2) return '已驳回'
  if (status === 3) return '已发布'
  return '编辑中'
}

export const statusType = (status) => {
  if (status === 1) return 'warning'
  if (status === 2) return 'danger'
  if (status === 3) return 'success'
  return 'info'
}

export const formatDateTime = (value) => {
  if (!value) return '-'
  return `${value}`.replace('T', ' ').substring(0, 19)
}

export const getLessonTitle = (item) => {
  return item?.titleEn || item?.titleCn || item?.lessonNo || '-'
}

const createSearchPayload = (overrides = {}) => {
  return Object.assign(
    {
      page: 1,
      pageSize: 20,
      keyword: '',
      tag: '',
      category: '',
      status: null,
      productLine: ''
    },
    overrides
  )
}

export const fetchLessonPage = async (overrides = {}) => {
  const response = await http.post('/api/LL_LessonLearn/Search', createSearchPayload(overrides), false)
  if (!response?.status) {
    return { total: 0, items: [] }
  }
  return {
    total: response.data?.total || 0,
    items: response.data?.items || []
  }
}

export const fetchLessonDetail = async (id) => {
  try {
    const response = await http.get(`/api/LL_LessonLearn/Detail/${id}?increaseView=false`, {}, false)
    if (!response?.status) {
      return null
    }
    return response.data || null
  } catch {
    return null
  }
}

const sumField = (rows, field) => {
  return rows.reduce((sum, row) => {
    return sum + (Number(row?.[field]) || 0)
  }, 0)
}

const accumulateTextCounts = (map, values) => {
  values.forEach((value) => {
    if (!value) return
    map.set(value, (map.get(value) || 0) + 1)
  })
}

const toRankedList = (map, keyName) => {
  return [...map.entries()]
    .map(([key, count]) => ({ [keyName]: key, count }))
    .sort((a, b) => b.count - a.count)
}

export const loadLessonWorkspace = async (options = {}) => {
  const pageSize = options.pageSize || 30
  const detailSize = options.detailSize || 8
  const page = await fetchLessonPage({ pageSize })
  const items = page.items || []
  const detailResponses = await Promise.allSettled(items.slice(0, detailSize).map((item) => fetchLessonDetail(item.lessonLearn_Id)))
  const details = detailResponses
    .filter((result) => result.status === 'fulfilled' && result.value)
    .map((result) => result.value)

  const reviewRows = []
  const taskRows = []
  const versionRows = []
  const documentRows = []
  const tagMap = new Map()
  const productLineMap = new Map()

  items.forEach((item) => {
    const tags = (item.tagsText || '').split(',').map((x) => x.trim()).filter(Boolean)
    const productLines = (item.applicableProductLinesText || '').split(',').map((x) => x.trim()).filter(Boolean)
    accumulateTextCounts(tagMap, tags)
    accumulateTextCounts(productLineMap, productLines)
  })

  details.forEach((detail) => {
    const lessonMeta = {
      lessonLearn_Id: detail.lessonLearn_Id,
      lessonNo: detail.lessonNo,
      title: getLessonTitle(detail),
      status: detail.status
    }
    ;(detail.reviewRecords || []).forEach((review) => {
      reviewRows.push({
        ...lessonMeta,
        round: review.round,
        reviewer: review.reviewer,
        reviewerTitle: review.reviewerTitle,
        reviewDate: review.reviewDate,
        result: review.result,
        comments: review.comments
      })
    })
    ;(detail.tasks || []).forEach((task) => {
      taskRows.push({
        ...lessonMeta,
        title: task.title,
        owner: task.owner,
        dueDate: task.dueDate,
        progress: task.progress,
        taskStatus: task.status,
        notes: task.notes
      })
    })
    ;(detail.historyRecords || []).forEach((history) => {
      versionRows.push({
        ...lessonMeta,
        versionNo: history.versionNo,
        action: history.action,
        operator: history.operator,
        time: history.time,
        statusText: history.statusText,
        comment: history.comment
      })
    })
    ;(detail.attachments || []).forEach((attachment) => {
      documentRows.push({
        ...lessonMeta,
        source: '附件中心',
        name: attachment.name,
        category: attachment.category || 'General',
        size: attachment.size,
        downloadCount: attachment.downloadCount,
        uploadTime: attachment.uploadTime
      })
    })
    ;(detail.documentChanges || []).forEach((change) => {
      documentRows.push({
        ...lessonMeta,
        source: '变更前文件',
        name: change.beforeFileName,
        category: change.changeType,
        size: sumField(change.beforeFiles || [], 'size'),
        downloadCount: sumField(change.beforeFiles || [], 'downloadCount'),
        uploadTime: change.beforeFiles?.[0]?.uploadTime || ''
      })
      documentRows.push({
        ...lessonMeta,
        source: '变更后文件',
        name: change.afterFileName,
        category: change.changeType,
        size: sumField(change.afterFiles || [], 'size'),
        downloadCount: sumField(change.afterFiles || [], 'downloadCount'),
        uploadTime: change.afterFiles?.[0]?.uploadTime || ''
      })
    })
  })

  const summary = {
    all: page.total,
    draft: items.filter((item) => item.status === 0 || item.status === null || item.status === undefined).length,
    review: items.filter((item) => item.status === 1).length,
    rejected: items.filter((item) => item.status === 2).length,
    published: items.filter((item) => item.status === 3).length,
    locked: items.filter((item) => item.isLocked).length,
    totalViews: sumField(items, 'viewCount'),
    totalFavorites: sumField(items, 'favoriteCount'),
    totalLikes: sumField(items, 'likeCount')
  }

  return {
    items,
    details,
    summary,
    reviewRows: reviewRows.sort((a, b) => `${b.reviewDate || ''}`.localeCompare(`${a.reviewDate || ''}`)),
    taskRows: taskRows.sort((a, b) => (b.progress || 0) - (a.progress || 0)),
    versionRows: versionRows.sort((a, b) => `${b.time || ''}`.localeCompare(`${a.time || ''}`)),
    documentRows,
    topTags: toRankedList(tagMap, 'name').slice(0, 8),
    topProductLines: toRankedList(productLineMap, 'name').slice(0, 8)
  }
}
