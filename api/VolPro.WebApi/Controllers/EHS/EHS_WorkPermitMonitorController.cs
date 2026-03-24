using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_WorkPermitMonitor")]
    [PermissionTable(Name = "EHS_WorkPermitMonitor")]
    public partial class EHS_WorkPermitMonitorController : ApiBaseController<IEHS_WorkPermitMonitorService>
    {
        public EHS_WorkPermitMonitorController(IEHS_WorkPermitMonitorService service) : base(service) { }
    }
}