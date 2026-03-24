using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_HazardousWaste")]
    [PermissionTable(Name = "EHS_HazardousWaste")]
    public partial class EHS_HazardousWasteController : ApiBaseController<IEHS_HazardousWasteService>
    {
        public EHS_HazardousWasteController(IEHS_HazardousWasteService service) : base(service) { }
    }
}