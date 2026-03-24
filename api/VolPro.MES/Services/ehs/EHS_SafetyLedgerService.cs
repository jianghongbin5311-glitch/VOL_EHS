using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_SafetyLedgerService : ServiceBase<EHS_SafetyLedger, IEHS_SafetyLedgerRepository>
    , IEHS_SafetyLedgerService, IDependency
    {
        public static IEHS_SafetyLedgerService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_SafetyLedgerService>(); }
        }
    }
}