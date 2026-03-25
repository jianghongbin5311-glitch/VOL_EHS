using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_GroupIncidentService : ServiceBase<EHS_GroupIncident, IEHS_GroupIncidentRepository>
    , IEHS_GroupIncidentService, IDependency
    {
        public static IEHS_GroupIncidentService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_GroupIncidentService>(); }
        }
    }
}
