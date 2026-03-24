using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_HazardReportRepository : RepositoryBase<EHS_HazardReport>, IEHS_HazardReportRepository
    {
        public EHS_HazardReportRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_HazardReportRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_HazardReportRepository>(); }
        }
    }
}