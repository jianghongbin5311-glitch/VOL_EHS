using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Accident")]
    [PermissionTable(Name = "EHS_Accident")]
    public partial class EHS_AccidentController : ApiBaseController<IEHS_AccidentService>
    {
        public EHS_AccidentController(IEHS_AccidentService service) : base(service) { }
    }
}