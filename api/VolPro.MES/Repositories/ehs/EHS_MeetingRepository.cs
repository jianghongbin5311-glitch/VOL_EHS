using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_MeetingRepository : RepositoryBase<EHS_Meeting>, IEHS_MeetingRepository
    {
        public EHS_MeetingRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_MeetingRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_MeetingRepository>(); }
        }
    }
}