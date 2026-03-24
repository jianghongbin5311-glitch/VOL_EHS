using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_WorkPermitMonitorService : ServiceBase<EHS_WorkPermitMonitor, IEHS_WorkPermitMonitorRepository>
    , IEHS_WorkPermitMonitorService, IDependency
    {
        public static IEHS_WorkPermitMonitorService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_WorkPermitMonitorService>(); }
        }
    }
}