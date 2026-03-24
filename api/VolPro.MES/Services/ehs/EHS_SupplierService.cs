using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_SupplierService : ServiceBase<EHS_Supplier, IEHS_SupplierRepository>
    , IEHS_SupplierService, IDependency
    {
        public static IEHS_SupplierService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_SupplierService>(); }
        }
    }
}