using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_NewsReportRepository : RepositoryBase<EHS_NewsReport>, IEHS_NewsReportRepository
    {
        public EHS_NewsReportRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_NewsReportRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_NewsReportRepository>(); }
        }
    }
}
