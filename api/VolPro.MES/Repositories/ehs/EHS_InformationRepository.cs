using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_InformationRepository : RepositoryBase<EHS_Information>, IEHS_InformationRepository
    {
        public EHS_InformationRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_InformationRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_InformationRepository>(); }
        }
    }
}