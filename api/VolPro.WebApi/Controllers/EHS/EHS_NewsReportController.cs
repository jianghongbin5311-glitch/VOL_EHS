using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_NewsReport")]
    [PermissionTable(Name = "EHS_NewsReport")]
    public partial class EHS_NewsReportController : ApiBaseController<IEHS_NewsReportService>
    {
        public EHS_NewsReportController(IEHS_NewsReportService service) : base(service) { }
    }
}
