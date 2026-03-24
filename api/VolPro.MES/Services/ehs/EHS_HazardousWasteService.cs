using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_HazardousWasteService : ServiceBase<EHS_HazardousWaste, IEHS_HazardousWasteRepository>
    , IEHS_HazardousWasteService, IDependency
    {
        public static IEHS_HazardousWasteService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_HazardousWasteService>(); }
        }
    }
}