using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_QuestionBankService : ServiceBase<EHS_QuestionBank, IEHS_QuestionBankRepository>
    , IEHS_QuestionBankService, IDependency
    {
        public static IEHS_QuestionBankService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_QuestionBankService>(); }
        }
    }
}