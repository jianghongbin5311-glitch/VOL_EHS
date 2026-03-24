/*
 *代码由框架生成,任何更改都可能导致被代码生成器覆盖
 *如果要增加方法请在当前目录下Partial文件夹Sys_NotificationTemplateController编写
 */
using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.Sys.IServices;
namespace VolPro.Sys.Controllers
{
    [Route("api/Sys_NotificationTemplate")]
    [PermissionTable(Name = "Sys_NotificationTemplate")]
    public partial class Sys_NotificationTemplateController : ApiBaseController<ISys_NotificationTemplateService>
    {
        public Sys_NotificationTemplateController(ISys_NotificationTemplateService service)
        : base(service)
        {
        }
    }
}

