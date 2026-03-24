using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_ConstructionProject")]
    [PermissionTable(Name = "EHS_ConstructionProject")]
    public partial class EHS_ConstructionProjectController : ApiBaseController<IEHS_ConstructionProjectService>
    {
        public EHS_ConstructionProjectController(IEHS_ConstructionProjectService service) : base(service) { }
    }
}