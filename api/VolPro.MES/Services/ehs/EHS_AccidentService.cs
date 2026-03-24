using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_AccidentService : ServiceBase<EHS_Accident, IEHS_AccidentRepository>
    , IEHS_AccidentService, IDependency
    {
        public static IEHS_AccidentService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_AccidentService>(); }
        }
    }
}