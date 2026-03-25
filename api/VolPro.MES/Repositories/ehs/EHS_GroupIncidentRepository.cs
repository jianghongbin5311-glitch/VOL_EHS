using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_GroupIncidentRepository : RepositoryBase<EHS_GroupIncident>, IEHS_GroupIncidentRepository
    {
        public EHS_GroupIncidentRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_GroupIncidentRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_GroupIncidentRepository>(); }
        }
    }
}
