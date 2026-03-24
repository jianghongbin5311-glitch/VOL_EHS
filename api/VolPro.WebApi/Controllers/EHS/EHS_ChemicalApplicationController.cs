using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_ChemicalApplication")]
    [PermissionTable(Name = "EHS_ChemicalApplication")]
    public partial class EHS_ChemicalApplicationController : ApiBaseController<IEHS_ChemicalApplicationService>
    {
        public EHS_ChemicalApplicationController(IEHS_ChemicalApplicationService service) : base(service) { }
    }
}