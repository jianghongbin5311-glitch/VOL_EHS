using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_EmergencyDrillService : ServiceBase<EHS_EmergencyDrill, IEHS_EmergencyDrillRepository>
    , IEHS_EmergencyDrillService, IDependency
    {
        public static IEHS_EmergencyDrillService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_EmergencyDrillService>(); }
        }
    }
}