using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Meeting")]
    [PermissionTable(Name = "EHS_Meeting")]
    public partial class EHS_MeetingController : ApiBaseController<IEHS_MeetingService>
    {
        public EHS_MeetingController(IEHS_MeetingService service) : base(service) { }
    }
}