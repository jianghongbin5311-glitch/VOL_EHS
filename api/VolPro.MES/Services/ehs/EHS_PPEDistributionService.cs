using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_PPEDistributionService : ServiceBase<EHS_PPEDistribution, IEHS_PPEDistributionRepository>
    , IEHS_PPEDistributionService, IDependency
    {
        public static IEHS_PPEDistributionService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_PPEDistributionService>(); }
        }
    }
}