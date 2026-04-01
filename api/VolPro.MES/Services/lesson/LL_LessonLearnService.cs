using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using VolPro.MES.IServices;

namespace VolPro.MES.Services
{
    public partial class LL_LessonLearnService : ServiceBase<LL_LessonLearn, ILL_LessonLearnRepository>, ILL_LessonLearnService, IDependency
    {
        public LL_LessonLearnService(ILL_LessonLearnRepository repository) : base(repository)
        {
        }

        public static ILL_LessonLearnService Instance
        {
            get { return AutofacContainerModule.GetService<ILL_LessonLearnService>(); }
        }
    }
}
