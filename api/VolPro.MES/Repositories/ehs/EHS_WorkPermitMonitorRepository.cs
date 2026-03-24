using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_WorkPermitMonitorRepository : RepositoryBase<EHS_WorkPermitMonitor>, IEHS_WorkPermitMonitorRepository
    {
        public EHS_WorkPermitMonitorRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_WorkPermitMonitorRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_WorkPermitMonitorRepository>(); }
        }
    }
}