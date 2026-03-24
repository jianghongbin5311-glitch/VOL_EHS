using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_ConstructionProjectService : ServiceBase<EHS_ConstructionProject, IEHS_ConstructionProjectRepository>
    , IEHS_ConstructionProjectService, IDependency
    {
        public static IEHS_ConstructionProjectService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ConstructionProjectService>(); }
        }
    }
}