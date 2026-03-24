using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_WorkPermitService : ServiceBase<EHS_WorkPermit, IEHS_WorkPermitRepository>
    , IEHS_WorkPermitService, IDependency
    {
        public static IEHS_WorkPermitService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_WorkPermitService>(); }
        }
    }
}