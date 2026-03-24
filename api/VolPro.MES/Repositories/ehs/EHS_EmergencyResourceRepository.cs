using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_EmergencyResourceRepository : RepositoryBase<EHS_EmergencyResource>, IEHS_EmergencyResourceRepository
    {
        public EHS_EmergencyResourceRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_EmergencyResourceRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_EmergencyResourceRepository>(); }
        }
    }
}