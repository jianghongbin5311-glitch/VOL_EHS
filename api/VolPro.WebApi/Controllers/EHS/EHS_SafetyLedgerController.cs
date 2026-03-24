using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_SafetyLedger")]
    [PermissionTable(Name = "EHS_SafetyLedger")]
    public partial class EHS_SafetyLedgerController : ApiBaseController<IEHS_SafetyLedgerService>
    {
        public EHS_SafetyLedgerController(IEHS_SafetyLedgerService service) : base(service) { }
    }
}