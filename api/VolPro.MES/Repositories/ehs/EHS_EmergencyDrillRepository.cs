using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_EmergencyDrillRepository : RepositoryBase<EHS_EmergencyDrill>, IEHS_EmergencyDrillRepository
    {
        public EHS_EmergencyDrillRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_EmergencyDrillRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_EmergencyDrillRepository>(); }
        }
    }
}