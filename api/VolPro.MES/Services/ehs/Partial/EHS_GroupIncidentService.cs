using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Core.SignalR;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using VolPro.Core.Utilities;

namespace VolPro.MES.Services
{
    public partial class EHS_GroupIncidentService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_GroupIncidentRepository _repository;
        private readonly IExternalNotificationService _externalNotificationService;

        [ActivatorUtilitiesConstructor]
        public EHS_GroupIncidentService(
            IEHS_GroupIncidentRepository dbRepository,
            IHttpContextAccessor httpContextAccessor,
            IExternalNotificationService externalNotificationService
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
            _externalNotificationService = externalNotificationService;

            // 新增事件后 — 判断等级触发紧急推送
            AddOnExecuted = (EHS_GroupIncident incident, object list) =>
            {
                TryTriggerUrgentNotification(incident);
                return new WebResponseContent().OK();
            };

            // 编辑事件后 — 等级变更也可能触发推送
            UpdateOnExecuted = (EHS_GroupIncident incident, object addList, object updateList, List<object> delKeys) =>
            {
                TryTriggerUrgentNotification(incident);
                return new WebResponseContent().OK();
            };
        }

        /// <summary>
        /// 判断集团事件等级，触发紧急推送
        /// </summary>
        private void TryTriggerUrgentNotification(EHS_GroupIncident incident)
        {
            if (incident == null || !_externalNotificationService.IsUrgentLevel(incident.IncidentLevel))
                return;

            try
            {
                _ = _externalNotificationService.TriggerUrgentNotificationAsync(
                    module: "集团内部事件",
                    title: incident.Title,
                    level: incident.IncidentLevel,
                    description: incident.Description ?? "",
                    factoryName: incident.FactoryName ?? incident.CompanyName ?? "",
                    occurDate: incident.OccurDate?.ToString("yyyy-MM-dd HH:mm") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                );
            }
            catch (Exception ex)
            {
                Console.WriteLine($"集团事件紧急推送异常: {ex.Message}");
            }
        }
    }
}
