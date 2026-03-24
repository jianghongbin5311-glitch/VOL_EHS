using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_EmergencyPlanRepository : RepositoryBase<EHS_EmergencyPlan>, IEHS_EmergencyPlanRepository
    {
        public EHS_EmergencyPlanRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_EmergencyPlanRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_EmergencyPlanRepository>(); }
        }
    }
}