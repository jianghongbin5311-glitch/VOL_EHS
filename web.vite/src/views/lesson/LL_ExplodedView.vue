<template>
  <div class="exploded-page">
    <div class="page-header">
      <div>
        <div class="eyebrow">Exploded View Knowledge Base</div>
        <h2>爆炸图知识库</h2>
        <p>为每款产品平台维护标准化爆炸图，点击零件可直达对应 Lesson Learn 记录，形成可视化知识图谱。</p>
      </div>
      <div class="header-actions">
        <el-button @click="$router.push('/LL_Dashboard')">返回 Dashboard</el-button>
        <el-button type="primary" @click="openUpload">上传/更新爆炸图</el-button>
      </div>
    </div>

    <div class="platform-tabs">
      <el-radio-group v-model="activePlatform" size="large">
        <el-radio-button v-for="pl in platforms" :key="pl" :value="pl">{{ pl }}</el-radio-button>
      </el-radio-group>
    </div>

    <div class="exploded-workspace">
      <div class="canvas-area" v-if="currentImage">
        <div class="canvas-container" ref="canvasRef">
          <img :src="currentImage" alt="Exploded View" class="base-image" @load="onImageLoad" />
          <div
            v-for="(hotspot, i) in hotspots"
            :key="`hs-${i}`"
            class="hotspot"
            :style="{ left: hotspot.x + '%', top: hotspot.y + '%' }"
            @click="openHotspotDetail(hotspot)"
          >
            <div class="hotspot-dot" :class="{ active: hotspot.linkedCount > 0 }"></div>
            <div class="hotspot-label">{{ hotspot.partName }}</div>
          </div>
        </div>
      </div>
      <div class="canvas-area empty-canvas" v-else>
        <div class="empty-icon">🔍</div>
        <div>该产品平台暂无爆炸图，请上传标准爆炸图。</div>
      </div>

      <div class="sidebar-panel">
        <div class="panel-header">
          <div class="panel-title">零件关联 LL</div>
          <el-tag size="small" type="info">{{ selectedPart || '点击爆炸图上的标注点' }}</el-tag>
        </div>
        <div v-if="linkedLessons.length === 0" class="empty-state">选择零件以查看关联的 Lesson Learn 记录。</div>
        <div v-else class="ll-link-list">
          <div class="ll-link-row" v-for="item in linkedLessons" :key="item.lessonLearn_Id" @click="openLL(item)">
            <div class="ll-title">{{ item.titleEn || item.lessonNo || '-' }}</div>
            <div class="ll-meta">{{ item.lessonNo }} · {{ item.category || '-' }}</div>
          </div>
        </div>

        <div class="panel-header mt16">
          <div class="panel-title">热区管理</div>
          <el-button size="small" type="primary" @click="addHotspot">新增标注</el-button>
        </div>
        <div class="hotspot-mgmt">
          <div v-for="(hs, i) in hotspots" :key="`mg-${i}`" class="hotspot-entry">
            <el-input v-model="hs.partName" placeholder="零件名称" size="small" style="flex:1" />
            <el-input-number v-model="hs.x" :min="0" :max="100" :step="1" size="small" style="width:70px" />
            <el-input-number v-model="hs.y" :min="0" :max="100" :step="1" size="small" style="width:70px" />
            <el-button link type="danger" size="small" @click="hotspots.splice(i, 1)">删</el-button>
          </div>
        </div>
        <el-button type="success" @click="saveHotspots" style="margin-top:12px;width:100%">保存标注</el-button>
      </div>
    </div>

    <el-dialog v-model="uploadDialogVisible" title="上传爆炸图" width="500px" destroy-on-close>
      <div style="margin-bottom: 12px;">
        <el-select v-model="uploadPlatform" placeholder="选择产品平台" style="width:100%">
          <el-option v-for="pl in platforms" :key="pl" :label="pl" :value="pl" />
        </el-select>
      </div>
      <input type="file" accept="image/*" @change="handleImageUpload" ref="imageUploadRef" />
      <template #footer>
        <el-button @click="uploadDialogVisible = false">取消</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { onMounted, ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import http from '@/api/http.js'

const router = useRouter()
const platforms = ref(['CEPS', 'REPS', 'DPEPS', 'SPEPS', 'BEPS', 'I-Shaft', 'Column', 'MPP'])
const activePlatform = ref('CEPS')
const currentImage = ref('')
const selectedPart = ref('')
const linkedLessons = ref([])
const hotspots = ref([])
const canvasRef = ref(null)
const uploadDialogVisible = ref(false)
const uploadPlatform = ref('')
const imageUploadRef = ref(null)

// 演示数据 - 每个平台的热区标注
const demoHotspots = {
  CEPS: [
    { partName: 'Worm Gear', x: 35, y: 28, linkedCount: 3 },
    { partName: 'Pinion', x: 55, y: 45, linkedCount: 1 },
    { partName: 'Torque Sensor', x: 42, y: 62, linkedCount: 2 },
    { partName: 'Motor', x: 70, y: 35, linkedCount: 0 },
    { partName: 'Bearing', x: 25, y: 50, linkedCount: 1 }
  ],
  REPS: [
    { partName: 'Rack', x: 30, y: 40, linkedCount: 2 },
    { partName: 'Pinion', x: 60, y: 30, linkedCount: 1 },
    { partName: 'Tie Rod', x: 45, y: 55, linkedCount: 0 }
  ]
}

const loadPlatform = () => {
  hotspots.value = demoHotspots[activePlatform.value] || []
  currentImage.value = '' // TODO: 从服务器加载实际爆炸图 URL
  selectedPart.value = ''
  linkedLessons.value = []
}

const openHotspotDetail = async (hs) => {
  selectedPart.value = hs.partName
  // 搜索关联的 LL 记录
  try {
    const res = await http.post('/api/LL_LessonLearn/Search', {
      page: 1,
      pageSize: 10,
      keyword: hs.partName
    }, false)
    if (res.status) {
      linkedLessons.value = res.data?.items || []
    } else {
      linkedLessons.value = []
    }
  } catch {
    linkedLessons.value = []
  }
}

const openLL = (item) => {
  router.push({ path: '/LL_CaseDetail', query: { id: item.lessonLearn_Id } })
}

const addHotspot = () => {
  hotspots.value.push({ partName: '新零件', x: 50, y: 50, linkedCount: 0 })
}

const saveHotspots = async () => {
  // TODO: 保存到后端
  ElMessage.success(`已保存 ${hotspots.value.length} 个热区标注（本地 Demo）`)
}

const openUpload = () => {
  uploadPlatform.value = activePlatform.value
  uploadDialogVisible.value = true
}

const handleImageUpload = async (event) => {
  const file = event.target.files?.[0]
  if (!file) return
  try {
    const forms = new FormData()
    forms.append('fileInput', file, file.name)
    const result = await http.post('/api/LL_LessonLearn/Upload', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
    if (result.status) {
      const base = http.ipAddress.endsWith('/') ? http.ipAddress : `${http.ipAddress}/`
      currentImage.value = `${base}${result.data}`
      uploadDialogVisible.value = false
      ElMessage.success('爆炸图已上传')
    } else {
      ElMessage.error(result.message || '上传失败')
    }
  } catch (e) {
    ElMessage.error('上传失败')
  }
}

const onImageLoad = () => { /* 可在此初始化热区拖拽 */ }

watch(activePlatform, loadPlatform)
onMounted(loadPlatform)
</script>

<style scoped>
.exploded-page { padding: 24px; background: linear-gradient(180deg, #f7f9fd 0%, #eef2f7 100%); min-height: 100%; }
.page-header { display: flex; justify-content: space-between; align-items: end; margin-bottom: 20px; gap: 16px; }
.eyebrow { color: #7c3aed; letter-spacing: 1.4px; font-size: 12px; text-transform: uppercase; font-weight: 600; }
h2 { margin: 6px 0 8px; font-size: 30px; font-weight: 700; color: #0f172a; }
p { margin: 0; color: #64748b; max-width: 600px; }
.header-actions { display: flex; gap: 10px; }
.platform-tabs { margin-bottom: 20px; }
.exploded-workspace { display: grid; grid-template-columns: minmax(0, 1fr) 360px; gap: 20px; }
.canvas-area { background: #fff; border-radius: 20px; padding: 20px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06); min-height: 480px; display: flex; align-items: center; justify-content: center; }
.empty-canvas { flex-direction: column; gap: 12px; color: #94a3b8; font-size: 14px; }
.empty-icon { font-size: 56px; }
.canvas-container { position: relative; width: 100%; }
.base-image { width: 100%; border-radius: 12px; display: block; }
.hotspot { position: absolute; transform: translate(-50%, -50%); cursor: pointer; z-index: 2; }
.hotspot-dot { width: 20px; height: 20px; border-radius: 50%; background: rgba(239, 68, 68, 0.7); border: 3px solid #fff; box-shadow: 0 2px 8px rgba(0,0,0,0.2); transition: transform 0.2s; }
.hotspot-dot.active { background: rgba(34, 197, 94, 0.8); }
.hotspot:hover .hotspot-dot { transform: scale(1.3); }
.hotspot-label { position: absolute; top: 24px; left: 50%; transform: translateX(-50%); white-space: nowrap; background: rgba(15, 23, 42, 0.85); color: #fff; padding: 4px 10px; border-radius: 8px; font-size: 11px; font-weight: 600; opacity: 0; transition: opacity 0.2s; pointer-events: none; }
.hotspot:hover .hotspot-label { opacity: 1; }
.sidebar-panel { background: #fff; border-radius: 20px; padding: 20px; box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06); }
.panel-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.panel-title { font-size: 16px; font-weight: 700; color: #0f172a; }
.mt16 { margin-top: 20px; }
.empty-state { color: #94a3b8; font-size: 13px; padding: 12px 0; }
.ll-link-list { display: grid; gap: 8px; }
.ll-link-row { padding: 12px 14px; background: #f8fafc; border-radius: 12px; border: 1px solid #e7edf5; cursor: pointer; transition: border-color 0.15s; }
.ll-link-row:hover { border-color: #7c3aed; background: #faf5ff; }
.ll-title { font-size: 13px; font-weight: 600; color: #0f172a; }
.ll-meta { font-size: 11px; color: #64748b; margin-top: 4px; }
.hotspot-mgmt { display: grid; gap: 8px; max-height: 240px; overflow-y: auto; }
.hotspot-entry { display: flex; gap: 6px; align-items: center; }
@media (max-width: 960px) { .exploded-workspace { grid-template-columns: 1fr; } }
</style>
