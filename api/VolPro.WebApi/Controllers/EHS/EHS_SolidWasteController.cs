using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_SolidWaste")]
    [PermissionTable(Name = "EHS_SolidWaste")]
    public partial class EHS_SolidWasteController : ApiBaseController<IEHS_SolidWasteService>
    {
        public EHS_SolidWasteController(IEHS_SolidWasteService service) : base(service) { }
    }
}