using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_ChemicalInOutService : ServiceBase<EHS_ChemicalInOut, IEHS_ChemicalInOutRepository>
    , IEHS_ChemicalInOutService, IDependency
    {
        public static IEHS_ChemicalInOutService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ChemicalInOutService>(); }
        }
    }
}