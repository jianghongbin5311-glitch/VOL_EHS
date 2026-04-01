using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;

namespace VolPro.MES.Controllers
{
    [Route("api/LL_LessonLearn")]
    [PermissionTable(Name = "LL_LessonLearn")]
    public partial class LL_LessonLearnController : ApiBaseController<ILL_LessonLearnService>
    {
        public LL_LessonLearnController(ILL_LessonLearnService service) : base(service)
        {
        }
    }
}
