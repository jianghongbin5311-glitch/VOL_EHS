using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_EmergencyPlan")]
    [PermissionTable(Name = "EHS_EmergencyPlan")]
    public partial class EHS_EmergencyPlanController : ApiBaseController<IEHS_EmergencyPlanService>
    {
        public EHS_EmergencyPlanController(IEHS_EmergencyPlanService service) : base(service) { }
    }
}