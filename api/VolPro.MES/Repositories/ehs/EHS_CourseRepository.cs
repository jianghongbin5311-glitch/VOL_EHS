using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class EHS_CourseRepository : RepositoryBase<EHS_Course>, IEHS_CourseRepository
    {
        public EHS_CourseRepository(ServiceDbContext dbContext) : base(dbContext) { }
        public static IEHS_CourseRepository Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_CourseRepository>(); }
        }
    }
}