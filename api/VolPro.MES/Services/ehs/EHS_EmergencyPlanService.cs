using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_EmergencyPlanService : ServiceBase<EHS_EmergencyPlan, IEHS_EmergencyPlanRepository>
    , IEHS_EmergencyPlanService, IDependency
    {
        public static IEHS_EmergencyPlanService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_EmergencyPlanService>(); }
        }
    }
}