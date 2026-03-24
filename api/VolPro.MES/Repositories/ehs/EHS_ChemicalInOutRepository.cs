using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_ChemicalInOutRepository : RepositoryBase<EHS_ChemicalInOut>, IEHS_ChemicalInOutRepository
    {
        public EHS_ChemicalInOutRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_ChemicalInOutRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ChemicalInOutRepository>(); }
        }
    }
}