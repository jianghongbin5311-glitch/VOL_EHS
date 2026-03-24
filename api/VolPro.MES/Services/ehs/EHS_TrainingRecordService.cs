using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class EHS_TrainingRecordService : ServiceBase<EHS_TrainingRecord, IEHS_TrainingRecordRepository>
    , IEHS_TrainingRecordService, IDependency
    {
        public static IEHS_TrainingRecordService Instance
        {
            get { return AutofacContainerModule.GetService<IEHS_TrainingRecordService>(); }
        }
    }
}