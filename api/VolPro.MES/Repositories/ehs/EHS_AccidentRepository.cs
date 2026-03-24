using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_AccidentRepository : RepositoryBase<EHS_Accident>, IEHS_AccidentRepository
    {
        public EHS_AccidentRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_AccidentRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_AccidentRepository>(); }
        }
    }
}