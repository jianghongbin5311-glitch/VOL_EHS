using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_MeetingSignInService : ServiceBase<EHS_MeetingSignIn, IEHS_MeetingSignInRepository>
    , IEHS_MeetingSignInService, IDependency
    {
        public static IEHS_MeetingSignInService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_MeetingSignInService>(); }
        }
    }
}