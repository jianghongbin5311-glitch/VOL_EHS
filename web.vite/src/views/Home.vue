<template>
  <div class="ehs-dashboard">
    <el-scrollbar style="height: 100%">
      <!-- 欢迎横幅 -->
      <div class="welcome-banner">
        <div class="banner-content">
          <div class="banner-left">
            <h1>EHS 管理驾驶舱</h1>
            <p>Environment, Health & Safety Management Dashboard</p>
            <div class="banner-date">{{ currentDate }}</div>
          </div>
          <div class="banner-right">
            <div class="safety-days">
              <div class="days-number">{{ safetyDays }}</div>
              <div class="days-label">连续安全天数</div>
            </div>
          </div>
        </div>
      </div>

      <!-- KPI 卡片区 -->
      <div class="kpi-section">
        <div class="kpi-card" v-for="(kpi, idx) in kpiCards" :key="idx"
             :style="{ borderTopColor: kpi.color }">
          <div class="kpi-icon" :style="{ background: kpi.bgColor }">
            <el-icon :size="28" :color="kpi.color"><component :is="kpi.icon" /></el-icon>
          </div>
          <div class="kpi-info">
            <div class="kpi-value" :style="{ color: kpi.color }">{{ kpi.value }}</div>
            <div class="kpi-label">{{ kpi.label }}</div>
          </div>
          <div class="kpi-trend" v-if="kpi.trend">
            <span :class="kpi.trendUp ? 'trend-up' : 'trend-down'">
              {{ kpi.trendUp ? '↑' : '↓' }} {{ kpi.trend }}
            </span>
            <span class="trend-label">vs 上月</span>
          </div>
        </div>
      </div>

      <!-- 中间内容区 -->
      <div class="content-row">
        <!-- 最新法规新闻 -->
        <div class="content-card news-card">
          <div class="card-header">
            <h3>📰 最新法规与新闻</h3>
            <el-button type="primary" link @click="goToPage('/EHS_NewsReport')">查看全部 →</el-button>
          </div>
          <div class="news-list">
            <div class="news-item" v-for="(news, idx) in latestNews" :key="idx" @click="goToPage('/EHS_NewsReport')">
              <el-tag :type="getCategoryType(news.category)" size="small" effect="dark">{{ news.category }}</el-tag>
              <span class="news-title">{{ news.title }}</span>
              <span class="news-date">{{ news.date }}</span>
            </div>
            <div v-if="latestNews.length === 0" class="empty-hint">
              暂无数据，请先执行种子数据SQL或等待AI自动生成
            </div>
          </div>
        </div>

        <!-- 内部事件概览 -->
        <div class="content-card incident-card">
          <div class="card-header">
            <h3>🏭 内部事件概览</h3>
            <el-button type="primary" link @click="goToPage('/EHS_GroupIncident')">查看全部 →</el-button>
          </div>
          <div class="incident-list">
            <div class="incident-item" v-for="(inc, idx) in latestIncidents" :key="idx" @click="goToPage('/EHS_GroupIncident')">
              <div class="inc-header">
                <el-tag :type="getIncidentLevelType(inc.level)" size="small">{{ inc.level }}</el-tag>
                <span class="inc-company">{{ inc.company }}</span>
              </div>
              <div class="inc-title">{{ inc.title }}</div>
              <div class="inc-meta">
                <span>📍 {{ inc.location }}</span>
                <span>📅 {{ inc.date }}</span>
              </div>
            </div>
            <div v-if="latestIncidents.length === 0" class="empty-hint">
              暂无数据，请先执行种子数据SQL
            </div>
          </div>
        </div>
      </div>

      <!-- 快捷导航区 -->
      <div class="quick-nav-section">
        <h3 class="section-title">🚀 快捷导航</h3>
        <div class="nav-grid">
          <div class="nav-item" v-for="(nav, idx) in quickNavs" :key="idx" @click="goToPage(nav.path)"
               :style="{ background: nav.gradient }">
            <div class="nav-icon">{{ nav.icon }}</div>
            <div class="nav-name">{{ nav.name }}</div>
            <div class="nav-desc">{{ nav.desc }}</div>
          </div>
        </div>
      </div>

      <!-- 底部信息 -->
      <div class="footer-info">
        <p>Nexteer EHS Management System v2.0 · Powered by VOL Pro & AI</p>
        <p>Environment, Health and Safety — 安全第一 · 预防为主 · 综合治理</p>
      </div>
    </el-scrollbar>
  </div>
</template>

<script>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import {
  Warning, Document, Notification, DataLine,
  OfficeBuilding, Tickets, Trophy, Timer
} from '@element-plus/icons-vue'
import http from '@/api/http.js'

export default {
  name: 'Home',
  components: { Warning, Document, Notification, DataLine, OfficeBuilding, Tickets, Trophy, Timer },
  setup() {
    const router = useRouter()
    const safetyDays = ref(127)
    const latestNews = ref([])
    const latestIncidents = ref([])

    const currentDate = computed(() => {
      const now = new Date()
      const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' }
      return now.toLocaleDateString('zh-CN', options)
    })

    const kpiCards = reactive([
      { label: '本月安全隐患', value: '12', icon: 'Warning', color: '#e6a23c',
        bgColor: '#fdf6ec', trend: '3', trendUp: false },
      { label: '本月完成整改', value: '9', icon: 'Tickets', color: '#67c23a',
        bgColor: '#f0f9eb', trend: '15%', trendUp: true },
      { label: '外部法规动态', value: '6', icon: 'Document', color: '#409eff',
        bgColor: '#ecf5ff', trend: '2', trendUp: true },
      { label: '集团事件通报', value: '5', icon: 'Notification', color: '#f56c6c',
        bgColor: '#fef0f0', trend: '1', trendUp: false },
      { label: '本月培训完成率', value: '92%', icon: 'Trophy', color: '#9b59b6',
        bgColor: '#f5eef8', trend: '8%', trendUp: true },
      { label: '环保达标率', value: '100%', icon: 'DataLine', color: '#00b894',
        bgColor: '#e8faf3', trend: '-', trendUp: true },
    ])

    const quickNavs = reactive([
      { name: '外部法规新闻', desc: 'AI自动生成的法规新闻报告', path: '/EHS_NewsReport',
        icon: '📰', gradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' },
      { name: '内部事件管理', desc: '集团事件跟踪与教训分享', path: '/EHS_GroupIncident',
        icon: '🏭', gradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)' },
      { name: '安全检查台账', desc: '日常安全检查与隐患排查', path: '/EHS_SafetyLedger',
        icon: '📋', gradient: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)' },
      { name: '事故管理', desc: '事故记录与调查报告', path: '/EHS_Accident',
        icon: '⚠️', gradient: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)' },
      { name: '培训管理', desc: '安全培训计划与记录', path: '/EHS_Training',
        icon: '🎓', gradient: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)' },
      { name: '应急预案', desc: '应急预案与演练管理', path: '/EHS_EmergencyPlan',
        icon: '🚨', gradient: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)' },
    ])

    const getCategoryType = (cat) => {
      const map = { '事故': 'danger', '处罚': 'warning', '法规': '', '检查': 'success', '预警': 'danger', '综合': 'info' }
      return map[cat] || 'info'
    }

    const getIncidentLevelType = (level) => {
      const map = { '重大': 'danger', '较大': 'warning', '一般': 'info' }
      return map[level] || 'info'
    }

    const goToPage = (path) => {
      router.push(path)
    }

    const loadDashboardData = () => {
      // 加载最新法规新闻
      http.post('/api/EHS_NewsReport/GetPageData', {
        page: 1, rows: 5, sort: 'ReportDate', order: 'desc', wheres: '[]'
      }, true).then(res => {
        if (res.rows) {
          latestNews.value = res.rows.map(r => ({
            title: r.Title,
            category: r.Category || '综合',
            date: r.ReportDate ? r.ReportDate.substring(0, 10) : ''
          }))
          // 更新KPI
          kpiCards[2].value = String(res.total || 0)
        }
      }).catch(() => {})

      // 加载最新内部事件
      http.post('/api/EHS_GroupIncident/GetPageData', {
        page: 1, rows: 4, sort: 'OccurDate', order: 'desc', wheres: '[]'
      }, true).then(res => {
        if (res.rows) {
          latestIncidents.value = res.rows.map(r => ({
            title: r.Title,
            company: r.CompanyName,
            level: r.IncidentLevel || '一般',
            location: r.OccurLocation || '-',
            date: r.OccurDate ? r.OccurDate.substring(0, 10) : ''
          }))
          kpiCards[3].value = String(res.total || 0)
        }
      }).catch(() => {})
    }

    onMounted(() => {
      loadDashboardData()
    })

    return {
      currentDate, safetyDays, kpiCards, quickNavs,
      latestNews, latestIncidents,
      getCategoryType, getIncidentLevelType, goToPage
    }
  }
}
</script>

<style scoped>
.ehs-dashboard {
  position: absolute;
  height: 100%;
  width: 100%;
  background: #f0f2f5;
}

/* 欢迎横幅 */
.welcome-banner {
  background: linear-gradient(135deg, #1a237e 0%, #0d47a1 40%, #01579b 100%);
  color: #fff;
  padding: 28px 32px;
  margin: 0;
}
.banner-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1400px;
  margin: 0 auto;
}
.banner-left h1 {
  margin: 0 0 6px 0;
  font-size: 26px;
  font-weight: 700;
  letter-spacing: 2px;
}
.banner-left p {
  margin: 0 0 8px 0;
  font-size: 13px;
  opacity: 0.8;
  letter-spacing: 1px;
}
.banner-date {
  font-size: 13px;
  opacity: 0.7;
}
.safety-days {
  text-align: center;
  background: rgba(255,255,255,0.15);
  border-radius: 16px;
  padding: 16px 32px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.2);
}
.days-number {
  font-size: 48px;
  font-weight: 800;
  line-height: 1;
  background: linear-gradient(180deg, #4caf50, #81c784);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
.days-label {
  font-size: 13px;
  opacity: 0.9;
  margin-top: 4px;
}

/* KPI 卡片 */
.kpi-section {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 16px;
  padding: 20px 24px;
  max-width: 1440px;
  margin: 0 auto;
}
.kpi-card {
  background: #fff;
  border-radius: 12px;
  padding: 18px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  box-shadow: 0 2px 12px rgba(0,0,0,0.06);
  border-top: 3px solid transparent;
  transition: transform 0.3s, box-shadow 0.3s;
  cursor: default;
}
.kpi-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}
.kpi-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 10px;
}
.kpi-value {
  font-size: 28px;
  font-weight: 800;
  line-height: 1.2;
}
.kpi-label {
  font-size: 12px;
  color: #909399;
  margin-top: 4px;
}
.kpi-trend {
  margin-top: 8px;
  font-size: 11px;
}
.trend-up { color: #67c23a; font-weight: 600; }
.trend-down { color: #f56c6c; font-weight: 600; }
.trend-label { color: #c0c4cc; margin-left: 4px; }

/* 内容卡片区 */
.content-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  padding: 0 24px 20px;
  max-width: 1440px;
  margin: 0 auto;
}
.content-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.06);
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #f0f0f0;
}
.card-header h3 {
  margin: 0;
  font-size: 16px;
  color: #303133;
}

/* 新闻列表 */
.news-item {
  display: flex;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px dashed #f0f0f0;
  cursor: pointer;
  transition: background 0.2s;
}
.news-item:hover {
  background: #f5f7fa;
  margin: 0 -8px;
  padding: 10px 8px;
  border-radius: 6px;
}
.news-item:last-child { border-bottom: none; }
.news-title {
  flex: 1;
  margin-left: 10px;
  font-size: 13px;
  color: #303133;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.news-date {
  font-size: 12px;
  color: #c0c4cc;
  margin-left: 12px;
  white-space: nowrap;
}

/* 事件列表 */
.incident-item {
  padding: 12px;
  margin-bottom: 10px;
  border-radius: 8px;
  background: #fafbfc;
  border-left: 3px solid #e4e7ed;
  cursor: pointer;
  transition: all 0.2s;
}
.incident-item:hover {
  background: #f0f5ff;
  border-left-color: #409eff;
}
.inc-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 6px;
}
.inc-company {
  font-size: 12px;
  color: #909399;
}
.inc-title {
  font-size: 13px;
  color: #303133;
  font-weight: 500;
  margin-bottom: 4px;
}
.inc-meta {
  font-size: 11px;
  color: #c0c4cc;
  display: flex;
  gap: 16px;
}

.empty-hint {
  text-align: center;
  color: #c0c4cc;
  font-size: 13px;
  padding: 32px 0;
}

/* 快捷导航 */
.quick-nav-section {
  padding: 0 24px 20px;
  max-width: 1440px;
  margin: 0 auto;
}
.section-title {
  font-size: 16px;
  color: #303133;
  margin: 0 0 16px 0;
}
.nav-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 16px;
}
.nav-item {
  border-radius: 14px;
  padding: 22px 16px;
  color: #fff;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
  text-align: center;
}
.nav-item:hover {
  transform: translateY(-6px);
  box-shadow: 0 12px 32px rgba(0,0,0,0.2);
}
.nav-icon {
  font-size: 36px;
  margin-bottom: 8px;
}
.nav-name {
  font-size: 14px;
  font-weight: 700;
  margin-bottom: 6px;
}
.nav-desc {
  font-size: 11px;
  opacity: 0.85;
  line-height: 1.4;
}

/* 底部 */
.footer-info {
  text-align: center;
  padding: 20px 0 30px;
  color: #c0c4cc;
  font-size: 12px;
}
.footer-info p {
  margin: 2px 0;
}

/* 响应式 */
@media (max-width: 1200px) {
  .kpi-section { grid-template-columns: repeat(3, 1fr); }
  .content-row { grid-template-columns: 1fr; }
  .nav-grid { grid-template-columns: repeat(3, 1fr); }
}
@media (max-width: 768px) {
  .kpi-section { grid-template-columns: repeat(2, 1fr); }
  .nav-grid { grid-template-columns: repeat(2, 1fr); }
  .banner-content { flex-direction: column; text-align: center; gap: 16px; }
}
</style>
