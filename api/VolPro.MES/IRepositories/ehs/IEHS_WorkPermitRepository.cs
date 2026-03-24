using VolPro.Core.BaseProvider;
using VolPro.Entity.DomainModels;
using VolPro.Core.Extensions.AutofacManager;
namespace VolPro.MES.IRepositories
{
    public partial interface IEHS_WorkPermitRepository : IDependency,IRepository<EHS_WorkPermit>
    {
    }
}