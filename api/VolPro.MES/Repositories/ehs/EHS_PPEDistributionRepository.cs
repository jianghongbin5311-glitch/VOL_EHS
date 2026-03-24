using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_PPEDistributionRepository : RepositoryBase<EHS_PPEDistribution>, IEHS_PPEDistributionRepository
    {
        public EHS_PPEDistributionRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_PPEDistributionRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_PPEDistributionRepository>(); }
        }
    }
}