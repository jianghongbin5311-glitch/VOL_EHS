using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_SolidWasteService : ServiceBase<EHS_SolidWaste, IEHS_SolidWasteRepository>
    , IEHS_SolidWasteService, IDependency
    {
        public static IEHS_SolidWasteService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_SolidWasteService>(); }
        }
    }
}