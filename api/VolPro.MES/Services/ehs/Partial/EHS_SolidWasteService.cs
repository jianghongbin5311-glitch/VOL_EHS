using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;

namespace VolPro.MES.Services
{
    public partial class EHS_SolidWasteService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_SolidWasteRepository _repository;

        [ActivatorUtilitiesConstructor]
        public EHS_SolidWasteService(
            IEHS_SolidWasteRepository dbRepository,
            IHttpContextAccessor httpContextAccessor
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
        }
    }
}
