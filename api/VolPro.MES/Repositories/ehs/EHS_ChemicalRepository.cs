using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_ChemicalRepository : RepositoryBase<EHS_Chemical>, IEHS_ChemicalRepository
    {
        public EHS_ChemicalRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_ChemicalRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ChemicalRepository>(); }
        }
    }
}