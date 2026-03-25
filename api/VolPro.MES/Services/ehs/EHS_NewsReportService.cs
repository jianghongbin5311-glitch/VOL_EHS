using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_NewsReportService : ServiceBase<EHS_NewsReport, IEHS_NewsReportRepository>
    , IEHS_NewsReportService, IDependency
    {
        public static IEHS_NewsReportService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_NewsReportService>(); }
        }
    }
}
