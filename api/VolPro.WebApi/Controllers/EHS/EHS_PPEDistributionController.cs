using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_PPEDistribution")]
    [PermissionTable(Name = "EHS_PPEDistribution")]
    public partial class EHS_PPEDistributionController : ApiBaseController<IEHS_PPEDistributionService>
    {
        public EHS_PPEDistributionController(IEHS_PPEDistributionService service) : base(service) { }
    }
}