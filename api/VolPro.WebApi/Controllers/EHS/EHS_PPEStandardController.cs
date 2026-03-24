using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_PPEStandard")]
    [PermissionTable(Name = "EHS_PPEStandard")]
    public partial class EHS_PPEStandardController : ApiBaseController<IEHS_PPEStandardService>
    {
        public EHS_PPEStandardController(IEHS_PPEStandardService service) : base(service) { }
    }
}