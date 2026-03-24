using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/EHS_QuestionBank")]
    [PermissionTable(Name = "EHS_QuestionBank")]
    public partial class EHS_QuestionBankController : ApiBaseController<IEHS_QuestionBankService>
    {
        public EHS_QuestionBankController(IEHS_QuestionBankService service) : base(service) { }
    }
}