using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_HazardInspectionRepository : RepositoryBase<EHS_HazardInspection>, IEHS_HazardInspectionRepository
    {
        public EHS_HazardInspectionRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_HazardInspectionRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_HazardInspectionRepository>(); }
        }
    }
}