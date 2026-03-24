using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Supplier")]
    [PermissionTable(Name = "EHS_Supplier")]
    public partial class EHS_SupplierController : ApiBaseController<IEHS_SupplierService>
    {
        public EHS_SupplierController(IEHS_SupplierService service) : base(service) { }
    }
}