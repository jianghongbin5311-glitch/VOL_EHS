using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_TrainingPlan")]
    [PermissionTable(Name = "EHS_TrainingPlan")]
    public partial class EHS_TrainingPlanController : ApiBaseController<IEHS_TrainingPlanService>
    {
        public EHS_TrainingPlanController(IEHS_TrainingPlanService service) : base(service) { }
    }
}