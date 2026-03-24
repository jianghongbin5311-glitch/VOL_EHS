using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_SolidWasteRepository : RepositoryBase<EHS_SolidWaste>, IEHS_SolidWasteRepository
    {
        public EHS_SolidWasteRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_SolidWasteRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_SolidWasteRepository>(); }
        }
    }
}