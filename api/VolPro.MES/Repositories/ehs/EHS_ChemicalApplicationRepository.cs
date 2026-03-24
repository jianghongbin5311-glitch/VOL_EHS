using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_ChemicalApplicationRepository : RepositoryBase<EHS_ChemicalApplication>, IEHS_ChemicalApplicationRepository
    {
        public EHS_ChemicalApplicationRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_ChemicalApplicationRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_ChemicalApplicationRepository>(); }
        }
    }
}