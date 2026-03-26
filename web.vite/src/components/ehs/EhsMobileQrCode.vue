<template>
  <div class="ehs-qr-wrapper">
    <el-popover placement="bottom" :width="280" trigger="click">
      <template #reference>
        <el-button type="primary" size="small" plain>
          📱 手机扫码上报
        </el-button>
      </template>
      <div class="qr-popover">
        <div class="qr-title">📱 手机扫码快速上报</div>
        <div class="qr-desc">用微信/浏览器扫描二维码，即可在手机上拍照上报隐患、事故、巡查记录</div>
        <div class="qr-canvas">
          <QrcodeVue :value="mobileUrl" :size="200" level="M" />
        </div>
        <div class="qr-url">{{ mobileUrl }}</div>
        <el-button size="small" type="primary" @click="copyUrl" style="margin-top:8px;width:100%">
          📋 复制链接
        </el-button>
        <div class="qr-tip">
          💡 PC 测试：按 F12 → 点左上角手机图标 → 选择机型模拟
        </div>
      </div>
    </el-popover>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import QrcodeVue from 'qrcode.vue'
import { ElMessage } from 'element-plus'

const mobileUrl = computed(() => {
  // 动态获取当前页面的 origin（协议+域名+端口）
  return `${window.location.origin}/#/mobile/ehs-report`
})

function copyUrl() {
  navigator.clipboard.writeText(mobileUrl.value).then(() => {
    ElMessage.success('链接已复制')
  }).catch(() => {
    // fallback
    const textarea = document.createElement('textarea')
    textarea.value = mobileUrl.value
    document.body.appendChild(textarea)
    textarea.select()
    document.execCommand('copy')
    document.body.removeChild(textarea)
    ElMessage.success('链接已复制')
  })
}
</script>

<style scoped>
.ehs-qr-wrapper {
  display: inline-block;
  margin-right: 10px;
}
.qr-popover {
  text-align: center;
  padding: 4px 0;
}
.qr-title {
  font-size: 16px;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 6px;
}
.qr-desc {
  font-size: 12px;
  color: #7f8c8d;
  margin-bottom: 12px;
  line-height: 1.5;
}
.qr-canvas {
  display: flex;
  justify-content: center;
  padding: 12px;
  background: #f8f9fa;
  border-radius: 12px;
  margin-bottom: 8px;
}
.qr-url {
  font-size: 11px;
  color: #95a5a6;
  word-break: break-all;
  background: #f1f3f5;
  padding: 6px 8px;
  border-radius: 6px;
}
.qr-tip {
  font-size: 11px;
  color: #e67e22;
  margin-top: 10px;
  padding: 6px 8px;
  background: #fef9e7;
  border-radius: 6px;
  line-height: 1.5;
}
</style>
