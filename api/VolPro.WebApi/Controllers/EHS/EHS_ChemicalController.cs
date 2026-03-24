using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Chemical")]
    [PermissionTable(Name = "EHS_Chemical")]
    public partial class EHS_ChemicalController : ApiBaseController<IEHS_ChemicalService>
    {
        public EHS_ChemicalController(IEHS_ChemicalService service) : base(service) { }
    }
}