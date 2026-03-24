using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Document")]
    [PermissionTable(Name = "EHS_Document")]
    public partial class EHS_DocumentController : ApiBaseController<IEHS_DocumentService>
    {
        public EHS_DocumentController(IEHS_DocumentService service) : base(service) { }
    }
}