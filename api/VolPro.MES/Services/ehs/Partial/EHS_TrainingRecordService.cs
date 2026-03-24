using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;

namespace VolPro.MES.Services
{
    public partial class EHS_TrainingRecordService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_TrainingRecordRepository _repository;

        [ActivatorUtilitiesConstructor]
        public EHS_TrainingRecordService(
            IEHS_TrainingRecordRepository dbRepository,
            IHttpContextAccessor httpContextAccessor
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
        }
    }
}
