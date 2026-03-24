using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_QuestionBankRepository : RepositoryBase<EHS_QuestionBank>, IEHS_QuestionBankRepository
    {
        public EHS_QuestionBankRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_QuestionBankRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_QuestionBankRepository>(); }
        }
    }
}