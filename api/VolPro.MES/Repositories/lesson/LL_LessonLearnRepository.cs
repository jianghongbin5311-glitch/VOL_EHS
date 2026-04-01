using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;

namespace VolPro.MES.Repositories
{
    public partial class LL_LessonLearnRepository : RepositoryBase<LL_LessonLearn>, ILL_LessonLearnRepository
    {
        public LL_LessonLearnRepository(ServiceDbContext dbContext) : base(dbContext)
        {
        }

        public static ILL_LessonLearnRepository Instance
        {
            get { return AutofacContainerModule.GetService<ILL_LessonLearnRepository>(); }
        }
    }
}
