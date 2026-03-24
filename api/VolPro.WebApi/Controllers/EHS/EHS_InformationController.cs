using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Information")]
    [PermissionTable(Name = "EHS_Information")]
    public partial class EHS_InformationController : ApiBaseController<IEHS_InformationService>
    {
        public EHS_InformationController(IEHS_InformationService service) : base(service) { }
    }
}