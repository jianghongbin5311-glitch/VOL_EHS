using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_TrainingRecord")]
    [PermissionTable(Name = "EHS_TrainingRecord")]
    public partial class EHS_TrainingRecordController : ApiBaseController<IEHS_TrainingRecordService>
    {
        public EHS_TrainingRecordController(IEHS_TrainingRecordService service) : base(service) { }
    }
}