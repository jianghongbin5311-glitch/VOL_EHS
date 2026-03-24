<template>
  <div>
    <el-dropdown trigger="hover">
      <div class="notification">
        <el-badge
          :value="msgCount"
          :max="99"
          :is-dot="msgCount <= 0"
          class="item"
          :offset="[3, -3]"
          :badge-style="
            msgCount > 0
              ? 'font-size: 10px; width: 18px; height: 18px;background-color: #ff1b0b;'
              : ''
          "
        >
          <el-icon size="15">
            <Bell />
          </el-icon>
        </el-badge>
      </div>
      <template #dropdown>
        <el-tabs v-model="activeName" class="msg-tabs" @tab-click="handleClick">
          <el-tab-pane name="msg">
            <template #label>
              <span class="custom-tabs-label">{{ $ts('消息通知') }}</span>
            </template>
            <message-content :list="list" @itemClick="itemClick"></message-content>
          </el-tab-pane>
          <el-tab-pane label="审批流程" name="audit">
            <message-content :list="auditList" @itemClick="itemClick"></message-content>
          </el-tab-pane>
          <el-tab-pane label="未读消息" name="unread">
            <template #label>
              <span class="custom-tabs-label">
                <el-badge
                  :value="msgCount"
                  :show-zero="false"
                  :offset="[-2, 4]"
                  badge-style="background-color: #ff1b0b;width: 18px; "
                >
                  未读消息<el-icon size="15"> </el-icon>
                </el-badge>
              </span>
            </template>
            <message-content :list="unreadList" @itemClick="itemClick"></message-content>
          </el-tab-pane>
        </el-tabs>
      </template>
    </el-dropdown>
    <ViewGridAudit ref="auditRef"></ViewGridAudit>
    <vol-box :lazy="true" v-model="model" title="消息" :width="700" :padding="10">
      <div v-html="htmlContent"></div>
      <template #footer
        ><div style="text-align: center">
          <el-button type="default" size="small" icon="Close" @click="model = false">{{
            $ts('关闭')
          }}</el-button>
        </div>
      </template>
    </vol-box>
  </div>
</template>

<script setup>
import MessageContent from './MessageContent.vue'
import ViewGridAudit from '@/components/basic/ViewGrid/ViewGridAudit.vue'
import { reactive, ref, getCurrentInstance } from 'vue'
const { proxy } = getCurrentInstance()
const htmlContent = ref('')
const title = ref('')
const model = ref(false)
const activeName = ref('msg')
const msgCount = ref(0)
const list = ref([])
const auditCount = ref(0)
const auditList = ref([])
const unreadList = ref([])

proxy.base.setItem('pushMessage', (item) => {
  msgCount.value = msgCount.value + 1
  // list.
  getList()
})

//获取所有消息
const getList = () => {
  proxy.http.post('api/Sys_Notification/getList', {}, false).then((res) => {
    list.value = res.list
    msgCount.value = res.total
    auditCount.value = res.auditTotal || 0
  })
}
getList()
const handleClick = (item) => {
  if (item.paneName == 'audit') {
    if (auditList.value.length) {
      return
    }
    proxy.http.post('api/Sys_Notification/getAuditList', {}, false).then((res) => {
      auditList.value = res.list
    })
  } else if (item.paneName == 'unread') {
    if (unreadList.value.length) {
      return
    }
    proxy.http.post('api/Sys_Notification/getUnreadList', {}, false).then((res) => {
      unreadList.value = res.list
    })
  }
}

const auditRef = ref()

const itemClick = (item, isRead) => {
  const isAudit = item.notificationType == '审批'
  if (!isRead) {
    msgCount.value = msgCount.value - 1
    if (msgCount.value < 0) {
      msgCount.value = 0
    }
    if (isAudit) {
      auditCount.value = auditCount - 1
      if (auditCount.value < 0) {
        auditCount.value = 0
      }
    }
  }
  if (item.LinkUrl) {
    window.open(item.LinkUrl, '_blank')
    return
  }
  //审批跳转
  if (isAudit) {
    item.WorkTable = item.tableName
    item.WorkTableKey = item.tableKey

    auditRef.value.open([item], true)
    // proxy.$tabs.open({ text: '我的审批', path: '/Sys_WorkFlowTable' })
    return
  }
  if (item.notificationType == '通知' && item.notificationContent) {
    model.value = true
    htmlContent.value = item.notificationContent
    return
  }
}
</script>
<style scoped lang="less">
.notification {
  outline: none;
  color: #000;
}
.msg-tabs {
  width: 300px;
}

::v-deep(.el-tabs__header) {
  margin: 0;
}
::v-deep(.el-tabs__content) {
  min-height: 200px;
}
::v-deep(.el-tabs__nav) {
  width: 100%;
  padding: 0 10px;
}
::v-deep(.el-tabs__item) {
  padding: 0 6px;
  flex: 1;
}
</style>
