using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_SupplierRepository : RepositoryBase<EHS_Supplier>, IEHS_SupplierRepository
    {
        public EHS_SupplierRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_SupplierRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_SupplierRepository>(); }
        }
    }
}