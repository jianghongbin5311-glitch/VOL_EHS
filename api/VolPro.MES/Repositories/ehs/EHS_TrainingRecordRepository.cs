using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_TrainingRecordRepository : RepositoryBase<EHS_TrainingRecord>, IEHS_TrainingRecordRepository
    {
        public EHS_TrainingRecordRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_TrainingRecordRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_TrainingRecordRepository>(); }
        }
    }
}