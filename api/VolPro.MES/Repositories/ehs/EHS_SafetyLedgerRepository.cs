using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_SafetyLedgerRepository : RepositoryBase<EHS_SafetyLedger>, IEHS_SafetyLedgerRepository
    {
        public EHS_SafetyLedgerRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_SafetyLedgerRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_SafetyLedgerRepository>(); }
        }
    }
}