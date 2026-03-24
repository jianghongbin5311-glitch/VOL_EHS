using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_InformationService : ServiceBase<EHS_Information, IEHS_InformationRepository>
    , IEHS_InformationService, IDependency
    {
        public static IEHS_InformationService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_InformationService>(); }
        }
    }
}