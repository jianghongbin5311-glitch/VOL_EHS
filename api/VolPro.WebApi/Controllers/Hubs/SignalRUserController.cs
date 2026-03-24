using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using VolPro.Core;
using VolPro.Core.Controllers.Basic;
using VolPro.Core.Enums;
using VolPro.Core.Extensions;
using VolPro.Core.Filters;
using VolPro.Core.SignalR;
using VolPro.Entity.DomainModels;

namespace VolPro.WebApi.Controllers.Hubs
{
    [Route("api/signalRUser")]
    public class SignalRUserController : VolController
    {
        IMessageService _messageService;
        public SignalRUserController(IMessageService messageService)
        {
            _messageService = messageService;
        }
        /// <summary>
        /// 强制下线
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        [HttpGet, Route("loginout")]
        [ApiActionPermission((nameof(Sys_User)), ActionPermissionOptions.Add | ActionPermissionOptions.Update)]
        public async Task<IActionResult> Loginout(string userName)
        {
            await _messageService.SendMessageAsync(new
             MessageChannelData()
            {
                UserName = new List<string>() { userName },
                Code = "-1",
                MessageNotification = new MessageNotification()
                {
                    Title = "提示",
                    Content = "您已被强制下线,即将自动退出登录...".Translator(),
                }
            });
            return Content("操作成功".Translator());
        }
    }
}
