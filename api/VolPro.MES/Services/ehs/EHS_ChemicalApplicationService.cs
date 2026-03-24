using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_ChemicalApplicationService : ServiceBase<EHS_ChemicalApplication, IEHS_ChemicalApplicationRepository>
    , IEHS_ChemicalApplicationService, IDependency
    {
        public static IEHS_ChemicalApplicationService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ChemicalApplicationService>(); }
        }
    }
}