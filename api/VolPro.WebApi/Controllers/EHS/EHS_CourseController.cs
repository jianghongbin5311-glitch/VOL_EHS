using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_Course")]
    [PermissionTable(Name = "EHS_Course")]
    public partial class EHS_CourseController : ApiBaseController<IEHS_CourseService>
    {
        public EHS_CourseController(IEHS_CourseService service) : base(service) { }
    }
}