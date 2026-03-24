using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_MeetingSignInRepository : RepositoryBase<EHS_MeetingSignIn>, IEHS_MeetingSignInRepository
    {
        public EHS_MeetingSignInRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_MeetingSignInRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_MeetingSignInRepository>(); }
        }
    }
}