using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_ChemicalInOut")]
    [PermissionTable(Name = "EHS_ChemicalInOut")]
    public partial class EHS_ChemicalInOutController : ApiBaseController<IEHS_ChemicalInOutService>
    {
        public EHS_ChemicalInOutController(IEHS_ChemicalInOutService service) : base(service) { }
    }
}