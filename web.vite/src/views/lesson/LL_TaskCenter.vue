<template>
  <div class="portal-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Task Loop & Tracking</div>
        <h2>任务闭环中心</h2>
        <p>用于横展与借鉴的 Lesson Learn 后续行动派发跟踪。看板拖拽更新与状态闭环监控。</p>
      </div>
      <el-button type="primary" class="glow-button" @click="goTo('/LL_LessonLearn')">回到 LL 知识库</el-button>
    </div>

    <div class="summary-grid">
      <div class="summary-card">
        <div class="icon-wrap todo-bg"><el-icon><Calendar /></el-icon></div>
        <div class="stat-content">
          <div class="label">任务总数</div>
          <div class="value">{{ rows.length }}</div>
        </div>
      </div>
      <div class="summary-card">
        <div class="icon-wrap warning-bg"><el-icon><Timer /></el-icon></div>
        <div class="stat-content">
          <div class="label">进行中 (50%)</div>
          <div class="value">{{ middleCount }}</div>
        </div>
      </div>
      <div class="summary-card">
        <div class="icon-wrap info-bg"><el-icon><Document /></el-icon></div>
        <div class="stat-content">
          <div class="label">待评审</div>
          <div class="value">{{ reviewCount }}</div>
        </div>
      </div>
      <div class="summary-card">
        <div class="icon-wrap success-bg"><el-icon><CircleCheck /></el-icon></div>
        <div class="stat-content">
          <div class="label">已完成 (100%)</div>
          <div class="value">{{ fullCount }}</div>
        </div>
      </div>
    </div>

    <!-- Kanban Layout -->
    <div class="kanban-board">
      <div class="kanban-column" v-for="col in columns" :key="col.id">
        <div class="column-header" :style="{ borderTopColor: col.color }">
          <h3>{{ col.title }} <span>{{ getTasksByStatus(col.id).length }}</span></h3>
        </div>
        <div class="column-body">
          <div v-for="task in getTasksByStatus(col.id)" :key="task.id" class="task-card" @click="openDetail(task)">
            <div class="task-head">
              <span class="task-no">{{ task.lessonNo }}</span>
              <el-tag size="small" :type="taskTagType(task.progress)" effect="dark">{{ task.progress }}%</el-tag>
            </div>
            <div class="task-title">{{ task.title }}</div>
            <div class="task-notes">{{ task.notes }}</div>
            <div class="task-footer">
              <div class="task-owner">
                <el-avatar :size="24">{{ task.owner.charAt(0) }}</el-avatar>
                <span>{{ task.owner }}</span>
              </div>
              <div class="task-date">
                <el-icon><Clock /></el-icon> {{ task.dueDate }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { loadLessonWorkspace } from './lessonLearnPortal'
import { Calendar, Timer, Document, CircleCheck, Clock } from '@element-plus/icons-vue'

const router = useRouter()
const loading = ref(false)
const rows = ref([])

const columns = [
  { id: 'todo', title: '待开始 / To Do', color: '#94a3b8' },
  { id: 'doing', title: '进行中 / In Progress', color: '#eab308' },
  { id: 'review', title: '待审批 / Review', color: '#3b82f6' },
  { id: 'done', title: '已完成 / Done', color: '#22c55e' }
]

const zeroCount = computed(() => rows.value.filter((item) => (item.progress || 0) === 0).length)
const middleCount = computed(() => rows.value.filter((item) => (item.progress || 0) > 0 && (item.progress || 0) < 100).length)
const reviewCount = computed(() => rows.value.filter((item) => item.taskStatus === '待审批' || item.taskStatus === '待审核').length)
const fullCount = computed(() => rows.value.filter((item) => (item.progress || 0) >= 100).length)

const progressLabel = (progress) => {
  if ((progress || 0) >= 100) return '审批完成'
  if ((progress || 0) >= 50) return '上传完成'
  return '待发布'
}

const taskTagType = (progress) => {
  if ((progress || 0) >= 100) return 'success'
  if ((progress || 0) >= 50) return 'warning'
  return 'info'
}

const getTaskColId = (task) => {
  if (task.progress >= 100) return 'done'
  if (task.taskStatus === '待审批' || task.taskStatus === 'Review') return 'review'
  if (task.progress > 0) return 'doing'
  return 'todo'
}

const getTasksByStatus = (statusId) => {
  return rows.value.filter(t => getTaskColId(t) === statusId)
}

const loadData = async () => {
  loading.value = true
  try {
    const workspace = await loadLessonWorkspace({ pageSize: 30, detailSize: 12 })
    if (workspace && workspace.taskRows && workspace.taskRows.length > 0) {
      rows.value = workspace.taskRows
    } else {
      // Mock Data 注入，用于演示高级美面与排版
      rows.value = [
        { lessonNo: 'LL-STEER-2026-001', title: '横向扩展PFMEA及控制计划防错检查要求', owner: 'Kevin Jiang', dueDate: '2026-05-10', progress: 50, taskStatus: '进行中', notes: '等待 ME 团队更新系统', id: 1 },
        { lessonNo: 'LL-EPS-2026-015', title: '开展新装配防错夹具的操作工技能培训', owner: 'Alice Wang', dueDate: '2026-04-20', progress: 100, taskStatus: '已完成', notes: '培训签到表已上传系统', id: 2 },
        { lessonNo: 'LL-Mtr-2026-003', title: '修订马达产线的标准作业指导书 (WI)', owner: 'Bob Zhang', dueDate: '2026-06-01', progress: 0, taskStatus: '待开始', notes: '安排在下月大修期间进行', id: 3 },
        { lessonNo: 'LL-SW-2026-008', title: '更新软件烧录站的效验逻辑', owner: 'David Xu', dueDate: '2026-04-25', progress: 80, taskStatus: '待审批', notes: '验证报告已出，等待经理批准', id: 4 },
        { lessonNo: 'LL-EPS-2026-012', title: 'Line 3 扭矩传感器追加失效判断预警', owner: 'Kevin Jiang', dueDate: '2026-05-05', progress: 0, taskStatus: '待开始', notes: '等待预选设备采购', id: 5 },
        { lessonNo: 'LL-GEAR-2026-022', title: '更新蜗轮蜗杆啮合区域的光学检测规范', owner: 'Alice Wang', dueDate: '2026-05-15', progress: 50, taskStatus: '进行中', notes: 'AOI 视觉算法调试中', id: 6 }
      ]
    }
  } catch(e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

const goTo = (path) => router.push(path)
const openDetail = (row) => {
  const id = row.lessonLearn_Id || row.LessonLearn_Id
  if (id) {
    router.push({ path: '/LL_CaseDetail', query: { id } })
  } else {
     // fallback for mock data
    router.push({ path: '/LL_CaseDetail' })
  }
}
onMounted(loadData)
</script>

<style scoped>
.portal-page { padding: 32px; background: #eef2f6; min-height: 100%; font-family: 'Inter', system-ui, sans-serif; }
.page-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 32px; }
.eyebrow { color: #0284c7; letter-spacing: 1.5px; font-size: 13px; font-weight: 600; text-transform: uppercase; margin-bottom: 4px; }
h2 { margin: 0 0 8px; font-size: 32px; color: #0f172a; font-weight: 700; letter-spacing: -0.5px; }
p { margin: 0; color: #64748b; font-size: 15px; }
.glow-button {
  background: linear-gradient(135deg, #0ea5e9, #2563eb);
  border: none;
  border-radius: 8px;
  box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3);
  padding: 10px 24px;
}

.summary-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 32px; }
.summary-card { 
  background: #fff; border-radius: 16px; padding: 24px; 
  box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.04); 
  display: flex; align-items: center; gap: 20px; 
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.summary-card:hover {
  transform: translateY(-4px); box-shadow: 0 20px 25px -5px rgba(15, 23, 42, 0.08);
}
.icon-wrap {
  width: 56px; height: 56px; border-radius: 16px; 
  display: flex; align-items: center; justify-content: center;
  font-size: 24px; color: #fff;
}
.todo-bg { background: linear-gradient(135deg, #94a3b8, #64748b); }
.warning-bg { background: linear-gradient(135deg, #fcd34d, #f59e0b); }
.info-bg { background: linear-gradient(135deg, #7dd3fc, #0284c7); }
.success-bg { background: linear-gradient(135deg, #4ade80, #16a34a); }

.stat-content { display: flex; flex-direction: column; }
.label { color: #64748b; font-size: 14px; font-weight: 500;}
.value { font-size: 32px; font-weight: 800; color: #0f172a; line-height: 1.1; margin-top: 4px; }

/* Kanban Styles */
.kanban-board {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
  min-height: 500px;
}
.kanban-column {
  background: #f8fafc;
  border-radius: 12px;
  display: flex;
  flex-direction: column;
}
.column-header {
  padding: 16px 20px;
  border-top: 4px solid #ccc;
  border-radius: 12px 12px 0 0;
}
.column-header h3 {
  margin: 0; font-size: 15px; color: #334155; font-weight: 600;
  display: flex; justify-content: space-between; align-items: center;
}
.column-header span {
  background: #e2e8f0; color: #475569; padding: 2px 8px; border-radius: 12px; font-size: 12px;
}
.column-body {
  padding: 12px;
  flex-grow: 1;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.task-card {
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 10px;
  padding: 16px;
  cursor: pointer;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  transition: all 0.2s ease;
}
.task-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  border-color: #cbd5e1;
}
.task-head {
  display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;
}
.task-no {
  font-size: 12px; font-family: monospace; color: #0284c7; background: #e0f2fe; padding: 4px 8px; border-radius: 6px; font-weight: 600;
}
.task-title {
  font-size: 14px; font-weight: 600; color: #1e293b; margin-bottom: 8px; line-height: 1.4;
}
.task-notes {
  font-size: 12px; color: #64748b; margin-bottom: 16px;
  display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.task-footer {
  display: flex; justify-content: space-between; align-items: center;
  padding-top: 12px; border-top: 1px dashed #e2e8f0;
}
.task-owner {
  display: flex; align-items: center; gap: 8px; font-size: 12px; color: #475569; font-weight: 500;
}
.task-date {
  font-size: 11px; color: #94a3b8; display: flex; align-items: center; gap: 4px; border-radius: 4px; background: #f1f5f9; padding: 2px 6px;
}

@media (max-width: 1200px) {
  .kanban-board { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 768px) {
  .kanban-board { grid-template-columns: 1fr; }
  .page-header { flex-direction: column; align-items: flex-start; gap: 16px; }
}
</style>
