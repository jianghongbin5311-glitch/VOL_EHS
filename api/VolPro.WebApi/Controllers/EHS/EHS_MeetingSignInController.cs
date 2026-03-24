using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_MeetingSignIn")]
    [PermissionTable(Name = "EHS_MeetingSignIn")]
    public partial class EHS_MeetingSignInController : ApiBaseController<IEHS_MeetingSignInService>
    {
        public EHS_MeetingSignInController(IEHS_MeetingSignInService service) : base(service) { }
    }
}