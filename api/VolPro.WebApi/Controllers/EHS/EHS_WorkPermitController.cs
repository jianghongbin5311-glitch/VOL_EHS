using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_WorkPermit")]
    [PermissionTable(Name = "EHS_WorkPermit")]
    public partial class EHS_WorkPermitController : ApiBaseController<IEHS_WorkPermitService>
    {
        public EHS_WorkPermitController(IEHS_WorkPermitService service) : base(service) { }
    }
}