using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_DocumentRepository : RepositoryBase<EHS_Document>, IEHS_DocumentRepository
    {
        public EHS_DocumentRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_DocumentRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_DocumentRepository>(); }
        }
    }
}