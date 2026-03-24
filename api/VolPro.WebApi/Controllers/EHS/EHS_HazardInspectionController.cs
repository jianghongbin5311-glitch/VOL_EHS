using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_HazardInspection")]
    [PermissionTable(Name = "EHS_HazardInspection")]
    public partial class EHS_HazardInspectionController : ApiBaseController<IEHS_HazardInspectionService>
    {
        public EHS_HazardInspectionController(IEHS_HazardInspectionService service) : base(service) { }
    }
}