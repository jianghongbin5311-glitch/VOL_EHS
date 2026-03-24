using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_DocumentService : ServiceBase<EHS_Document, IEHS_DocumentRepository>
    , IEHS_DocumentService, IDependency
    {
        public static IEHS_DocumentService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_DocumentService>(); }
        }
    }
}