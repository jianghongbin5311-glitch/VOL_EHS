using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_HazardInspectionService : ServiceBase<EHS_HazardInspection, IEHS_HazardInspectionRepository>
    , IEHS_HazardInspectionService, IDependency
    {
        public static IEHS_HazardInspectionService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_HazardInspectionService>(); }
        }
    }
}