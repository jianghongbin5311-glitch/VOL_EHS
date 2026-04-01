<template>
  <div class="hazard-dashboard">
    <!-- ===== 顶部区域 ===== -->
    <div class="top-row">
      <!-- 左侧：排查计划列表 -->
      <div class="card plan-card">
        <div class="card-header">
          <span class="card-icon">📋</span>
          <span class="card-title">隐患排查计划列表</span>
          <el-button size="small" type="primary" plain @click="openCrudDialog('inspection')">
            查看全部 →
          </el-button>
        </div>
        <div class="plan-table-wrap">
          <table class="mini-table">
            <thead>
              <tr>
                <th>计划名称</th>
                <th>类型</th>
                <th>负责人</th>
                <th>排查时间</th>
                <th>状态</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="p in dashData.recentPlans" :key="p.id">
                <td class="title-cell">{{ p.title || '-' }}</td>
                <td><el-tag size="small" effect="plain">{{ p.type || '-' }}</el-tag></td>
                <td>{{ p.inspector || '-' }}</td>
                <td class="date-cell">{{ p.planDate || p.actualDate || '-' }}</td>
                <td>
                  <el-tag :type="statusTagType(p.status)" size="small" effect="dark">{{ p.statusText }}</el-tag>
                </td>
              </tr>
              <tr v-if="!dashData.recentPlans?.length">
                <td colspan="5" class="empty-msg">暂无排查计划数据</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 右侧 -->
      <div class="right-col">
        <!-- 快捷入口 -->
        <div class="card quick-card">
          <div class="card-header">
            <span class="card-icon">🚀</span>
            <span class="card-title">快捷入口</span>
          </div>
          <div class="quick-grid">
            <div class="quick-btn" @click="openCrudDialog('inspection')">
              <span class="qb-icon">📝</span><span>排查任务管理</span>
            </div>
            <div class="quick-btn" @click="openCrudDialog('hazard')">
              <span class="qb-icon">📥</span><span>录入排查结果</span>
            </div>
            <div class="quick-btn" @click="showQr = true">
              <span class="qb-icon">📱</span><span>随手拍</span>
            </div>
            <div class="quick-btn" @click="openCrudDialog('points')">
              <span class="qb-icon">🎁</span><span>积分兑换</span>
            </div>
            <div class="quick-btn" @click="openCrudDialog('inspection')">
              <span class="qb-icon">📂</span><span>专项检查表</span>
            </div>
            <div class="quick-btn" @click="openCrudDialog('inspection')">
              <span class="qb-icon">🎄</span><span>节假日检查表</span>
            </div>
          </div>
        </div>

        <!-- KPI卡片 -->
        <div class="card kpi-card">
          <div class="kpi-row">
            <div class="kpi-item kpi-blue">
              <div class="kpi-value">{{ dashData.hazardStats?.today ?? 0 }}</div>
              <div class="kpi-label">今日隐患数</div>
            </div>
            <div class="kpi-item kpi-orange">
              <div class="kpi-value">{{ dashData.hazardStats?.pendingCount ?? 0 }}</div>
              <div class="kpi-label">待处理隐患</div>
            </div>
            <div class="kpi-item kpi-green">
              <div class="kpi-value">{{ dashData.hazardStats?.rectifyRate ?? 0 }}%</div>
              <div class="kpi-label">整改到期率</div>
            </div>
            <div class="kpi-item kpi-purple">
              <div class="kpi-value">{{ dashData.hazardStats?.monthNew ?? 0 }}</div>
              <div class="kpi-label">本月新增</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ===== 图表行 ===== -->
    <div class="chart-row">
      <div class="card chart-sm">
        <div class="card-header">
          <span class="card-icon">📊</span>
          <span class="card-title">排查计划统计</span>
        </div>
        <div class="stats-overview">
          <div ref="donutRef" class="chart-container donut-chart"></div>
          <div class="stats-numbers">
            <div class="stat-box stat-done">
              <div class="stat-val">{{ dashData.planStats?.completed ?? 0 }}</div>
              <div class="stat-lbl">已排查(次)</div>
            </div>
            <div class="stat-box stat-pending">
              <div class="stat-val">{{ (dashData.planStats?.pending ?? 0) + (dashData.planStats?.inProgress ?? 0) }}</div>
              <div class="stat-lbl">未排查(次)</div>
            </div>
            <div class="stat-box stat-overdue">
              <div class="stat-val">{{ dashData.planStats?.overdue ?? 0 }}</div>
              <div class="stat-lbl">超时未排查</div>
            </div>
          </div>
        </div>
      </div>

      <div class="card chart-md">
        <div class="card-header">
          <span class="card-icon">📈</span>
          <span class="card-title">隐患数量趋势</span>
        </div>
        <div ref="trendRef" class="chart-container trend-chart"></div>
      </div>

      <div class="card chart-sm">
        <div class="card-header">
          <span class="card-icon">🎯</span>
          <span class="card-title">隐患类型分布</span>
        </div>
        <div ref="pieRef" class="chart-container pie-chart"></div>
      </div>
    </div>

    <!-- ===== 隐患台账清单 ===== -->
    <div class="card ledger-card">
      <div class="card-header">
        <span class="card-icon">📑</span>
        <span class="card-title">隐患台账清单</span>
        <el-button size="small" type="primary" plain @click="openCrudDialog('hazard')">
          管理全部 →
        </el-button>
      </div>
      <div class="ledger-table-wrap">
        <table class="mini-table ledger-table">
          <thead>
            <tr>
              <th>时间</th>
              <th>隐患描述</th>
              <th>位置</th>
              <th>严重度</th>
              <th>类型</th>
              <th>责任部门</th>
              <th>责任人</th>
              <th>状态</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="h in dashData.recentHazards" :key="h.id">
              <td class="date-cell">{{ h.date || '-' }}</td>
              <td class="title-cell">{{ h.title || '-' }}</td>
              <td>{{ h.location || '-' }}</td>
              <td><el-tag :type="levelTagType(h.level)" size="small" effect="dark">{{ h.level || '-' }}</el-tag></td>
              <td>{{ h.type || '-' }}</td>
              <td>{{ h.dept || '-' }}</td>
              <td>{{ h.rectifier || h.reporter || '-' }}</td>
              <td><el-tag :type="hazardStatusType(h.status)" size="small" effect="dark">{{ h.statusText }}</el-tag></td>
            </tr>
            <tr v-if="!dashData.recentHazards?.length">
              <td colspan="8" class="empty-msg">暂无隐患记录</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- ===== CRUD弹窗：排查计划 ===== -->
    <el-dialog v-model="showInspectionCrud" fullscreen @close="closeCrud">
      <template #header>
        <div class="dialog-header-bar">
          <el-button @click="closeCrud" size="small" type="info" plain>← 返回主界面</el-button>
          <span class="dialog-title">隐患排查 - 排查任务管理</span>
        </div>
      </template>
      <view-grid v-if="showInspectionCrud" ref="grid" :columns="columns" :detail="detail" :details="details"
                 :editFormFields="editFormFields" :editFormOptions="editFormOptions"
                 :searchFormFields="searchFormFields" :searchFormOptions="searchFormOptions"
                 :table="table" :extend="extend" :onInit="onInit" :onInited="onInited"
                 :searchBefore="searchBefore" :addBefore="addBefore" :updateBefore="updateBefore">
        <template #gridHeader>
          <EhsMobileQrCode />
        </template>
      </view-grid>
    </el-dialog>

    <!-- ===== CRUD弹窗：隐患上报 ===== -->
    <el-dialog v-model="showHazardCrud" fullscreen @close="closeCrud">
      <template #header>
        <div class="dialog-header-bar">
          <el-button @click="closeCrud" size="small" type="info" plain>← 返回主界面</el-button>
          <span class="dialog-title">隐患台账 - 数据管理</span>
        </div>
      </template>
      <view-grid v-if="showHazardCrud" ref="hazardGrid"
                 :columns="hazardColumns" :detail="hazardDetail" :details="hazardDetails"
                 :editFormFields="hazardEditFields" :editFormOptions="hazardEditOptions"
                 :searchFormFields="hazardSearchFields" :searchFormOptions="hazardSearchOptions"
                 :table="hazardTable" :extend="hazardExtend"
                 :onInit="onHazardInit" :onInited="onHazardInited"
                 :searchBefore="searchBefore" :addBefore="addBefore" :updateBefore="updateBefore">
      </view-grid>
    </el-dialog>

    <!-- ===== CRUD弹窗：积分兑换 ===== -->
    <el-dialog v-model="showPointsCrud" width="680px" @close="closeCrud">
      <template #header>
        <div class="dialog-header-bar">
          <el-button @click="closeCrud" size="small" type="info" plain>← 返回</el-button>
          <span class="dialog-title">🎁 安全积分兑换</span>
        </div>
      </template>
      <div class="points-content">
        <div class="points-summary">
          <div class="points-total">
            <div class="points-num">580</div>
            <div class="points-lbl">当前积分</div>
          </div>
          <div class="points-info">
            <div class="pi-row"><span>🏆 累计获得</span><strong>1,280 分</strong></div>
            <div class="pi-row"><span>🎯 已兑换</span><strong>700 分</strong></div>
            <div class="pi-row"><span>📅 本月新增</span><strong>+120 分</strong></div>
          </div>
        </div>
        <div class="points-title">积分获取规则</div>
        <div class="points-rules">
          <div class="rule-item">✅ 按时完成排查计划 <strong>+20分/次</strong></div>
          <div class="rule-item">📱 随手拍上报隐患 <strong>+10分/次</strong></div>
          <div class="rule-item">🔧 隐患整改验收通过 <strong>+15分/次</strong></div>
          <div class="rule-item">📚 完成安全培训 <strong>+30分/次</strong></div>
          <div class="rule-item">🏅 月度零事故 <strong>+50分/月</strong></div>
        </div>
        <div class="points-title">可兑换奖品</div>
        <div class="reward-grid">
          <div class="reward-card">
            <div class="reward-icon">☕</div>
            <div class="reward-name">咖啡券</div>
            <div class="reward-pts">100分</div>
          </div>
          <div class="reward-card">
            <div class="reward-icon">🎫</div>
            <div class="reward-name">电影票</div>
            <div class="reward-pts">200分</div>
          </div>
          <div class="reward-card">
            <div class="reward-icon">🎧</div>
            <div class="reward-name">蓝牙耳机</div>
            <div class="reward-pts">500分</div>
          </div>
          <div class="reward-card">
            <div class="reward-icon">📱</div>
            <div class="reward-name">充电宝</div>
            <div class="reward-pts">800分</div>
          </div>
        </div>
      </div>
    </el-dialog>

    <!-- ===== 手机扫码 ===== -->
    <el-dialog v-model="showQr" title="📱 手机扫码快速上报" width="340px" align-center>
      <div style="text-align:center;">
        <div style="margin-bottom:12px;color:#666;font-size:13px;">用微信/浏览器扫描二维码，即可在手机上拍照上报</div>
        <QrcodeVue :value="mobileUrl" :size="220" level="M" style="margin:0 auto;" />
        <div style="margin-top:12px;font-size:11px;color:#aaa;word-break:break-all;background:#f5f5f5;padding:6px 10px;border-radius:6px;">{{ mobileUrl }}</div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup lang="jsx">
import { ref, reactive, onMounted, onBeforeUnmount, nextTick, getCurrentInstance, computed } from 'vue'
import * as echarts from 'echarts'
import QrcodeVue from 'qrcode.vue'
import http from '@/api/http'
import extend from '@/extension/ehs/EHS_HazardInspection.jsx'
import viewOptions from './EHS_HazardInspection/options.js'
import EhsMobileQrCode from '@/components/ehs/EhsMobileQrCode.vue'

const { proxy } = getCurrentInstance()

// === 排查计划 CRUD options ===
const { table, editFormFields, editFormOptions, searchFormFields, searchFormOptions, columns, detail, details } = reactive(viewOptions())

// === 隐患上报 CRUD options (内联配置) ===
const hazardTable = reactive({
  key: 'Hazard_Id', footer: 'Foots', cnName: '隐患上报', name: 'EHS_HazardReport', newTabEdit: false, url: '/EHS_HazardReport/', sortName: 'CreateDate'
})
const hazardEditFields = reactive({ HazardNo:'', HazardLevel:'', HazardType:'', Title:'', Description:'', Location:'', DeptName:'', DiscoveryDate:'', ReporterName:'', Status:'', RectifyPersonName:'', RectifyDeadline:'' })
const hazardEditOptions = [
  [{ title:'隐患编号', field:'HazardNo' }, { title:'隐患等级', field:'HazardLevel', required:true, type:'select', data:[{key:'低风险',value:'低风险'},{key:'一般风险',value:'一般风险'},{key:'较大风险',value:'较大风险'},{key:'重大隐患',value:'重大隐患'}] }],
  [{ title:'隐患类别', field:'HazardType', type:'select', data:[{key:'机械安全',value:'机械安全'},{key:'电气安全',value:'电气安全'},{key:'消防安全',value:'消防安全'},{key:'化学品',value:'化学品'},{key:'高处作业',value:'高处作业'},{key:'环境保护',value:'环境保护'},{key:'人因工程',value:'人因工程'},{key:'密闭空间',value:'密闭空间'},{key:'其他',value:'其他'}] }, { title:'发现位置', field:'Location' }],
  [{ title:'隐患描述', field:'Title', required:true, colSize:12 }],
  [{ title:'详细描述', field:'Description', type:'textarea', colSize:12 }],
  [{ title:'责任部门', field:'DeptName' }, { title:'发现日期', field:'DiscoveryDate', type:'datetime' }],
  [{ title:'上报人', field:'ReporterName' }, { title:'整改责任人', field:'RectifyPersonName' }],
  [{ title:'整改期限', field:'RectifyDeadline', type:'datetime' }, { title:'状态', field:'Status', type:'select', data:[{key:'0',value:'待整改'},{key:'1',value:'整改中'},{key:'2',value:'待验收'},{key:'3',value:'已关闭'}] }]
]
const hazardSearchFields = reactive({ HazardLevel:'', HazardType:'', Title:'', DiscoveryDate:'' })
const hazardSearchOptions = [[
  { title:'隐患等级', field:'HazardLevel', type:'select', data:[{key:'低风险',value:'低风险'},{key:'一般风险',value:'一般风险'},{key:'较大风险',value:'较大风险'},{key:'重大隐患',value:'重大隐患'}] },
  { title:'隐患类别', field:'HazardType', type:'select', data:[{key:'机械安全',value:'机械安全'},{key:'电气安全',value:'电气安全'},{key:'消防安全',value:'消防安全'},{key:'化学品',value:'化学品'}] },
  { title:'隐患描述', field:'Title', type:'like' },
  { title:'发现日期', field:'DiscoveryDate', type:'datetime' }
]]
const hazardColumns = [
  { field:'Hazard_Id', title:'ID', type:'int', width:60, hidden:true, readonly:true },
  { field:'HazardNo', title:'隐患编号', type:'string', width:120 },
  { field:'HazardLevel', title:'隐患等级', type:'string', width:100, align:'center' },
  { field:'HazardType', title:'隐患类别', type:'string', width:100, align:'center' },
  { field:'Title', title:'隐患描述', type:'string', width:200 },
  { field:'Location', title:'发现位置', type:'string', width:130 },
  { field:'DeptName', title:'责任部门', type:'string', width:100 },
  { field:'DiscoveryDate', title:'发现日期', type:'date', width:110 },
  { field:'ReporterName', title:'上报人', type:'string', width:80 },
  { field:'RectifyPersonName', title:'整改责任人', type:'string', width:100 },
  { field:'RectifyDeadline', title:'整改期限', type:'date', width:110 },
  { field:'Status', title:'状态', type:'int', width:80, align:'center', bind:{ key:'0', data:[{key:'0',value:'待整改'},{key:'1',value:'整改中'},{key:'2',value:'待验收'},{key:'3',value:'已关闭'}] }},
  { field:'CreateDate', title:'创建时间', type:'datetime', width:150 }
]
const hazardDetail = { columns:[] }
const hazardDetails = []
const hazardExtend = {}

// === State ===
const grid = ref(null)
const hazardGrid = ref(null)
const showInspectionCrud = ref(false)
const showHazardCrud = ref(false)
const showPointsCrud = ref(false)
const showQr = ref(false)
const dashData = reactive({
  planStats: {}, recentPlans: [], hazardStats: {},
  monthlyTrend: [], typeDistribution: [], recentHazards: []
})

const donutRef = ref(null)
const trendRef = ref(null)
const pieRef = ref(null)
let donutChart, trendChart, pieChart

const mobileUrl = computed(() => `${window.location.origin}/#/mobile/ehs-report`)

// === CRUD ===
let gridRef, hazardGridRef
const onInit = async ($vm) => { gridRef = $vm }
const onInited = async () => {}
const onHazardInit = async ($vm) => { hazardGridRef = $vm }
const onHazardInited = async () => {}
const searchBefore = async () => true
const addBefore = async () => true
const updateBefore = async () => true

function openCrudDialog(type) {
  if (type === 'inspection') showInspectionCrud.value = true
  else if (type === 'hazard') showHazardCrud.value = true
  else if (type === 'points') showPointsCrud.value = true
}
function closeCrud() {
  showInspectionCrud.value = false
  showHazardCrud.value = false
  showPointsCrud.value = false
  loadDashboard()
}

// === Tag Helpers ===
function statusTagType(s) { return s === 2 ? 'success' : s === 3 ? 'info' : s === 1 ? 'warning' : '' }
function levelTagType(lv) {
  if (lv === '重大隐患' || lv === '特别重大隐患') return 'danger'
  if (lv === '较大风险') return 'warning'
  if (lv === '一般风险') return ''
  return 'success'
}
function hazardStatusType(s) { return s === 3 ? 'success' : s === 2 ? 'info' : s === 1 ? 'warning' : 'danger' }

// === Load Dashboard ===
async function loadDashboard() {
  try {
    const res = await http.get('/api/EHS_HazardInspection/Dashboard')
    if (res?.status && res.data) {
      Object.assign(dashData, res.data)
      await nextTick()
      renderCharts()
    }
  } catch (e) {
    console.warn('Dashboard load error:', e)
  }
}

// === Charts ===
function renderCharts() {
  renderDonut()
  renderTrend()
  renderPie()
}

function renderDonut() {
  if (!donutRef.value) return
  if (donutChart) donutChart.dispose()
  donutChart = echarts.init(donutRef.value)
  const rate = dashData.planStats?.completionRate ?? 0
  donutChart.setOption({
    tooltip: { trigger: 'item' },
    series: [{
      type: 'pie', radius: ['55%', '80%'], center: ['50%', '50%'],
      avoidLabelOverlap: false,
      label: {
        show: true, position: 'center',
        formatter: () => `{a|${rate}%}\n{b|排查完成率}`,
        rich: { a: { fontSize: 26, fontWeight: 700, color: '#1a73e8', lineHeight: 36 }, b: { fontSize: 12, color: '#999', lineHeight: 20 } }
      },
      data: [
        { value: dashData.planStats?.completed ?? 0, name: '已完成', itemStyle: { color: '#1a73e8' } },
        { value: (dashData.planStats?.pending ?? 0) + (dashData.planStats?.inProgress ?? 0), name: '未完成', itemStyle: { color: '#e8eaed' } }
      ]
    }]
  })
}

function renderTrend() {
  if (!trendRef.value) return
  if (trendChart) trendChart.dispose()
  trendChart = echarts.init(trendRef.value)
  const labels = (dashData.monthlyTrend || []).map(m => m.label || '')
  const counts = (dashData.monthlyTrend || []).map(m => m.count || 0)
  trendChart.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: 46, right: 20, top: 20, bottom: 30 },
    xAxis: { type: 'category', data: labels, axisLabel: { fontSize: 11 } },
    yAxis: { type: 'value', minInterval: 1, axisLabel: { fontSize: 11 } },
    series: [{
      type: 'line', data: counts, smooth: true,
      lineStyle: { width: 3, color: '#1a73e8' },
      areaStyle: { color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{ offset: 0, color: 'rgba(26,115,232,0.35)' }, { offset: 1, color: 'rgba(26,115,232,0.03)' }]) },
      itemStyle: { color: '#1a73e8', borderWidth: 2 }, symbolSize: 8
    }]
  })
}

function renderPie() {
  if (!pieRef.value) return
  if (pieChart) pieChart.dispose()
  pieChart = echarts.init(pieRef.value)
  const colors = ['#1a73e8', '#ea4335', '#fbbc04', '#34a853', '#ff6d01', '#46bdc6', '#7b61ff', '#e8710a']
  const data = (dashData.typeDistribution || []).map((d, i) => ({
    name: d.name, value: d.count, itemStyle: { color: colors[i % colors.length] }
  }))
  if (data.length === 0) data.push({ name: '暂无数据', value: 0, itemStyle: { color: '#e8eaed' } })
  pieChart.setOption({
    tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
    legend: { type: 'scroll', bottom: 0, itemWidth: 10, itemHeight: 10, textStyle: { fontSize: 11 } },
    series: [{ type: 'pie', radius: ['30%', '65%'], center: ['50%', '42%'], roseType: 'radius', label: { show: false }, data }]
  })
}

function handleResize() { donutChart?.resize(); trendChart?.resize(); pieChart?.resize() }

onMounted(() => {
  loadDashboard()
  window.addEventListener('resize', handleResize)
})
onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize)
  donutChart?.dispose(); trendChart?.dispose(); pieChart?.dispose()
})

defineExpose({})
</script>

<style scoped>
.hazard-dashboard { padding: 14px; min-height: calc(100vh - 120px); background: #f0f2f5; }

/* Card */
.card { background: #fff; border-radius: 10px; box-shadow: 0 1px 6px rgba(0,0,0,0.06); overflow: hidden; }
.card-header { display: flex; align-items: center; gap: 6px; padding: 12px 16px; border-bottom: 1px solid #f0f0f0; font-size: 15px; font-weight: 600; color: #1a1a2e; }
.card-header .el-button { margin-left: auto; }
.card-icon { font-size: 18px; }

/* Top Row */
.top-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; margin-bottom: 14px; }
.right-col { display: flex; flex-direction: column; gap: 14px; }

/* Plan Table */
.plan-card { display: flex; flex-direction: column; }
.plan-table-wrap { flex: 1; overflow-y: auto; max-height: 260px; }
.mini-table { width: 100%; border-collapse: collapse; font-size: 13px; }
.mini-table thead { position: sticky; top: 0; z-index: 1; }
.mini-table th { background: #f7f8fa; color: #5f6368; font-weight: 600; padding: 9px 12px; text-align: left; white-space: nowrap; border-bottom: 1px solid #e8eaed; }
.mini-table td { padding: 8px 12px; border-bottom: 1px solid #f5f5f5; color: #333; }
.mini-table tbody tr:hover { background: #f0f6ff; }
.title-cell { max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.date-cell { white-space: nowrap; font-size: 12px; color: #666; }
.empty-msg { text-align: center; color: #ccc; padding: 30px 0 !important; font-size: 13px; }

/* Quick Actions */
.quick-card { flex: 1; }
.quick-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; padding: 14px; }
.quick-btn { display: flex; flex-direction: column; align-items: center; gap: 5px; padding: 14px 6px; border-radius: 10px; cursor: pointer; transition: all 0.2s; background: #f7f8fa; font-size: 12px; color: #333; font-weight: 500; }
.quick-btn:hover { background: #e8f0fe; color: #1a73e8; transform: translateY(-2px); box-shadow: 0 3px 12px rgba(26,115,232,0.15); }
.qb-icon { font-size: 26px; }

/* KPI */
.kpi-card { flex: 0 0 auto; }
.kpi-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; padding: 16px 14px; }
.kpi-item { text-align: center; padding: 14px 6px; border-radius: 12px; }
.kpi-value { font-size: 28px; font-weight: 700; line-height: 1.2; }
.kpi-label { font-size: 12px; margin-top: 4px; opacity: 0.85; font-weight: 500; }
.kpi-blue { background: linear-gradient(135deg, #e8f0fe, #d2e3fc); color: #1a73e8; }
.kpi-orange { background: linear-gradient(135deg, #fef3e0, #fde5c5); color: #e8710a; }
.kpi-green { background: linear-gradient(135deg, #e6f4ea, #ceead6); color: #137333; }
.kpi-purple { background: linear-gradient(135deg, #f3e8fd, #e8d5f5); color: #7b2ff7; }

/* Chart Row */
.chart-row { display: grid; grid-template-columns: 260px 1fr 260px; gap: 14px; margin-bottom: 14px; }
.chart-container { width: 100%; }
.donut-chart { height: 170px; }
.trend-chart { height: 200px; padding: 8px 8px 0; }
.pie-chart { height: 220px; }

/* Stats */
.stats-overview { padding: 8px 12px 12px; }
.stats-numbers { display: flex; gap: 8px; margin-top: 8px; }
.stat-box { flex: 1; text-align: center; padding: 8px 4px; border-radius: 8px; font-weight: 600; }
.stat-val { font-size: 20px; line-height: 1.3; }
.stat-lbl { font-size: 11px; opacity: 0.7; }
.stat-done { background: #e8f0fe; color: #1a73e8; }
.stat-pending { background: #fef3e0; color: #e8710a; }
.stat-overdue { background: #fce8e6; color: #c5221f; }

/* Ledger */
.ledger-card { margin-bottom: 14px; }
.ledger-table-wrap { max-height: 300px; overflow-y: auto; }
.ledger-table th { font-size: 12px; }
.ledger-table td { font-size: 12.5px; }

/* Dialog Header */
.dialog-header-bar { display: flex; align-items: center; gap: 14px; width: 100%; }
.dialog-title { font-size: 16px; font-weight: 700; color: #1a1a2e; }

/* Points / Rewards */
.points-content { padding: 0 6px; }
.points-summary { display: flex; gap: 20px; padding: 20px; background: linear-gradient(135deg, #1a73e8, #4285f4); border-radius: 14px; color: #fff; margin-bottom: 20px; }
.points-total { text-align: center; padding-right: 20px; border-right: 1px solid rgba(255,255,255,0.3); }
.points-num { font-size: 42px; font-weight: 800; }
.points-lbl { font-size: 13px; opacity: 0.85; }
.points-info { flex: 1; display: flex; flex-direction: column; justify-content: center; gap: 6px; }
.pi-row { display: flex; justify-content: space-between; font-size: 13px; opacity: 0.9; }
.pi-row strong { opacity: 1; }
.points-title { font-size: 15px; font-weight: 700; color: #333; margin-bottom: 10px; }
.points-rules { margin-bottom: 20px; }
.rule-item { padding: 8px 12px; background: #f7f8fa; border-radius: 8px; margin-bottom: 6px; font-size: 13px; color: #444; display: flex; justify-content: space-between; }
.reward-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 10px; }
.reward-card { text-align: center; padding: 16px 8px; border-radius: 12px; background: #f7f8fa; cursor: pointer; transition: all 0.2s; }
.reward-card:hover { background: #e8f0fe; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
.reward-icon { font-size: 32px; margin-bottom: 6px; }
.reward-name { font-size: 13px; font-weight: 600; color: #333; }
.reward-pts { font-size: 12px; color: #1a73e8; font-weight: 600; margin-top: 4px; }
</style>
