using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_GroupIncident")]
    [PermissionTable(Name = "EHS_GroupIncident")]
    public partial class EHS_GroupIncidentController : ApiBaseController<IEHS_GroupIncidentService>
    {
        public EHS_GroupIncidentController(IEHS_GroupIncidentService service) : base(service) { }
    }
}
