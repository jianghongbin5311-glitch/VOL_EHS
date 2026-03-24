using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_ConstructionProjectRepository : RepositoryBase<EHS_ConstructionProject>, IEHS_ConstructionProjectRepository
    {
        public EHS_ConstructionProjectRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_ConstructionProjectRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ConstructionProjectRepository>(); }
        }
    }
}