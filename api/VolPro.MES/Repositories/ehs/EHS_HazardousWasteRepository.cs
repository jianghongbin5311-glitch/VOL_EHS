using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_HazardousWasteRepository : RepositoryBase<EHS_HazardousWaste>, IEHS_HazardousWasteRepository
    {
        public EHS_HazardousWasteRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_HazardousWasteRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_HazardousWasteRepository>(); }
        }
    }
}