using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_TrainingPlanService : ServiceBase<EHS_TrainingPlan, IEHS_TrainingPlanRepository>
    , IEHS_TrainingPlanService, IDependency
    {
        public static IEHS_TrainingPlanService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_TrainingPlanService>(); }
        }
    }
}