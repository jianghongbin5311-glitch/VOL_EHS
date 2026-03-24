using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_ChemicalService : ServiceBase<EHS_Chemical, IEHS_ChemicalRepository>
    , IEHS_ChemicalService, IDependency
    {
        public static IEHS_ChemicalService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ChemicalService>(); }
        }
    }
}