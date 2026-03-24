using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_EmergencyResource")]
    [PermissionTable(Name = "EHS_EmergencyResource")]
    public partial class EHS_EmergencyResourceController : ApiBaseController<IEHS_EmergencyResourceService>
    {
        public EHS_EmergencyResourceController(IEHS_EmergencyResourceService service) : base(service) { }
    }
}