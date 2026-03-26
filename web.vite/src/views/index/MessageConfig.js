import * as signalR from '@microsoft/signalr';
import { ElNotification } from 'element-plus';
import { ElMessageBox } from 'element-plus';
import store from '@/store/index';
export default function(http, receive) {
  let connection;
  http.post('api/user/GetCurrentUserInfo').then((result) => {
    connection = new signalR.HubConnectionBuilder()
      .withAutomaticReconnect()
      .withUrl(`${http.ipAddress}hub/message?userName=${result.data.userName}`,{
        //withCredentials: true // 启用凭证模式
       // accessTokenFactory: () => store.getters.getToken()
    })
      //.withUrl(`${http.ipAddress}message`)
      .build();

    connection.start().catch((err) => console.log(err.message));
    //自动重连成功后的处理
    connection.onreconnected((connectionId) => {
      console.log(connectionId);
    });
    connection.on('ReceiveHomePageMessage', function(data) {
      console.log(data);
      switch (data.code) {
        case '-1':
          showLogoutMessage(data);
          return;
        case 'EHS_URGENT':
          showEhsUrgentAlert(data);
          store.getters.data().pushMessage(data);
          receive && receive(data);
          return;
        default:
          ElNotification.success({
            title:'消息' ,
            message: data.title,
            type: 'warning'
          });
          store.getters.data().pushMessage(data)
          receive && receive(data);
          break;
      }
    });
  });
}
//强制用户下线
function showLogoutMessage(data) {
  store.commit('clearUserInfo', '');
  const timerId = setTimeout(() => {
    clearTimeout(timerId);
    window.location.href = '/';
  }, 15000);
  ElMessageBox.confirm(data.message, '警告', {
    center: true,
    showCancelButton: false,
    closeOnClickModal: false,
    closeOnPressEscape: false,
    showClose: false
  }).then(() => {
    clearTimeout(timerId);
    window.location.href = '/';
  });
}

// EHS 紧急安全通报弹窗（重大事故/隐患）
function showEhsUrgentAlert(data) {
  // Web Audio API 蜂鸣警报（无需音频文件）
  try {
    const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    const oscillator = audioCtx.createOscillator();
    const gainNode = audioCtx.createGain();
    oscillator.type = 'square';
    oscillator.frequency.value = 800;
    gainNode.gain.value = 0.3;
    oscillator.connect(gainNode);
    gainNode.connect(audioCtx.destination);
    oscillator.start();
    // 蜂鸣 2 秒后自动停止
    setTimeout(() => {
      oscillator.stop();
      audioCtx.close();
    }, 2000);
  } catch (e) {
    console.warn('无法播放警报声:', e);
  }

  // 全屏模态弹窗 — 红色紧急通报
  ElMessageBox.alert(
    `<div style="text-align:center;padding:10px 0;">
      <div style="font-size:56px;line-height:1;">🚨</div>
      <h2 style="color:#e74c3c;margin:12px 0 8px;font-size:22px;">紧急安全通报</h2>
      <div style="background:#fef0f0;border:1px solid #fde2e2;border-radius:8px;padding:16px;margin:12px 0;text-align:left;">
        <p style="margin:0 0 8px;font-size:16px;font-weight:bold;color:#333;">${data.title || data.message || '重大安全事件'}</p>
        <p style="margin:0;font-size:14px;color:#666;line-height:1.6;">${data.message || ''}</p>
      </div>
      <p style="font-size:12px;color:#999;margin:8px 0 0;">发布时间：${new Date().toLocaleString('zh-CN')}</p>
    </div>`,
    '⚠️ EHS 紧急通报 — 请立即关注',
    {
      dangerouslyUseHTMLString: true,
      type: 'error',
      center: true,
      showClose: false,
      closeOnClickModal: false,
      closeOnPressEscape: false,
      confirmButtonText: '我已知悉',
      confirmButtonClass: 'ehs-urgent-confirm-btn',
      customStyle: { maxWidth: '520px' }
    }
  );
}

