using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_TrainingPlanRepository : RepositoryBase<EHS_TrainingPlan>, IEHS_TrainingPlanRepository
    {
        public EHS_TrainingPlanRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_TrainingPlanRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_TrainingPlanRepository>(); }
        }
    }
}