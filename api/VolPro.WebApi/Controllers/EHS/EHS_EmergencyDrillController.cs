using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_EmergencyDrill")]
    [PermissionTable(Name = "EHS_EmergencyDrill")]
    public partial class EHS_EmergencyDrillController : ApiBaseController<IEHS_EmergencyDrillService>
    {
        public EHS_EmergencyDrillController(IEHS_EmergencyDrillService service) : base(service) { }
    }
}