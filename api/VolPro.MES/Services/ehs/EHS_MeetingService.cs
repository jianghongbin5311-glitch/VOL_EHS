using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_MeetingService : ServiceBase<EHS_Meeting, IEHS_MeetingRepository>
    , IEHS_MeetingService, IDependency
    {
        public static IEHS_MeetingService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_MeetingService>(); }
        }
    }
}