/*
 *代码由框架生成,任何更改都可能导致被代码生成器覆盖
 *如果要增加方法请在当前目录下Partial文件夹Sys_NotificationController编写
 */
using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.Sys.IServices;
namespace VolPro.Sys.Controllers
{
    [Route("api/Sys_Notification")]
    [PermissionTable(Name = "Sys_Notification")]
    public partial class Sys_NotificationController : ApiBaseController<ISys_NotificationService>
    {
        public Sys_NotificationController(ISys_NotificationService service)
        : base(service)
        {
        }
    }
}

