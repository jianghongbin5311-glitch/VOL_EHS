using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_EmergencyResourceService : ServiceBase<EHS_EmergencyResource, IEHS_EmergencyResourceRepository>
    , IEHS_EmergencyResourceService, IDependency
    {
        public static IEHS_EmergencyResourceService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_EmergencyResourceService>(); }
        }
    }
}