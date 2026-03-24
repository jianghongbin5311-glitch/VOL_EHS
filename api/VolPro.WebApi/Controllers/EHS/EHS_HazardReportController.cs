using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_HazardReport")]
    [PermissionTable(Name = "EHS_HazardReport")]
    public partial class EHS_HazardReportController : ApiBaseController<IEHS_HazardReportService>
    {
        public EHS_HazardReportController(IEHS_HazardReportService service) : base(service) { }
    }
}