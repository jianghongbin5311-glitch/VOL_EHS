using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;

namespace VolPro.MES.Services
{
    public partial class EHS_EmergencyPlanService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_EmergencyPlanRepository _repository;

        [ActivatorUtilitiesConstructor]
        public EHS_EmergencyPlanService(
            IEHS_EmergencyPlanRepository dbRepository,
            IHttpContextAccessor httpContextAccessor
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
        }
    }
}
