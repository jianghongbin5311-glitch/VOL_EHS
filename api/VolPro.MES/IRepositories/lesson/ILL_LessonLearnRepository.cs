using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;

namespace VolPro.MES.IRepositories
{
    public partial interface ILL_LessonLearnRepository : IDependency, IRepository<LL_LessonLearn>
    {
    }
}
