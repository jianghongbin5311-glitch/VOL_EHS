using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_WorkPermitRepository : RepositoryBase<EHS_WorkPermit>, IEHS_WorkPermitRepository
    {
        public EHS_WorkPermitRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_WorkPermitRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_WorkPermitRepository>(); }
        }
    }
}