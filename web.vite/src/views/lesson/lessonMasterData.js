export const masterDataRouteMap = {
  '/LL_MasterDataPlant': {
    title: '工厂维护',
    description: '维护 Lesson Learn 可选工厂，用于 Case Detail 与 Search Case 的统一引用。',
    dataType: 'Plant',
    codeLabel: '工厂编码',
    nameLabel: '工厂名称',
    parentType: ''
  },
  '/LL_MasterDataWorkshop': {
    title: '车间维护',
    description: '维护工厂下属车间，并与 Plant 主数据建立父子关系。',
    dataType: 'Workshop',
    codeLabel: '车间编码',
    nameLabel: '车间名称',
    parentType: 'Plant',
    parentLabel: '所属工厂'
  },
  '/LL_MasterDataLine': {
    title: '线体维护',
    description: '维护车间下属线体，并用于问题发生位置的标准化选择。',
    dataType: 'Line',
    codeLabel: '线体编码',
    nameLabel: '线体名称',
    parentType: 'Workshop',
    parentLabel: '所属车间'
  },
  '/LL_MasterDataProductLine': {
    title: '产品线维护',
    description: '维护 LL 适用产品线，用于检索、编号和适用范围复用。',
    dataType: 'ProductLine',
    codeLabel: '产品线编码',
    nameLabel: '产品线名称',
    parentType: ''
  },
  '/LL_MasterDataTag': {
    title: '标签建议维护',
    description: '维护标签建议词，支撑搜索页检索与详情页标签输入指导。',
    dataType: 'Tag',
    codeLabel: '标签编码',
    nameLabel: '标签名称',
    parentType: ''
  },
  '/LL_MasterDataDocumentType': {
    title: '文件类别维护',
    description: '维护标准文件类别，用于 Design / Process / Supplier 文件清单闭环。',
    dataType: 'DocumentType',
    codeLabel: '类别编码',
    nameLabel: '类别名称',
    parentType: ''
  }
}

export const getMasterDataConfig = (path) =>
  masterDataRouteMap[path] || masterDataRouteMap['/LL_MasterDataPlant']
