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
    public partial class EHS_HazardReportService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_HazardReportRepository _repository;
        private readonly IExternalNotificationService _externalNotificationService;

        [ActivatorUtilitiesConstructor]
        public EHS_HazardReportService(
            IEHS_HazardReportRepository dbRepository,
            IHttpContextAccessor httpContextAccessor,
            IExternalNotificationService externalNotificationService
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
            _externalNotificationService = externalNotificationService;

            // 新增隐患后 — 判断等级触发紧急推送
            AddOnExecuted = (EHS_HazardReport hazard, object list) =>
            {
                TryTriggerUrgentNotification(hazard);
                return new WebResponseContent().OK();
            };

            // 编辑隐患后 — 等级变更也可能触发推送
            UpdateOnExecuted = (EHS_HazardReport hazard, object addList, object updateList, List<object> delKeys) =>
            {
                TryTriggerUrgentNotification(hazard);
                return new WebResponseContent().OK();
            };
        }

        /// <summary>
        /// 判断隐患等级，触发紧急推送
        /// </summary>
        private void TryTriggerUrgentNotification(EHS_HazardReport hazard)
        {
            if (hazard == null || !_externalNotificationService.IsUrgentLevel(hazard.HazardLevel))
                return;

            try
            {
                _ = _externalNotificationService.TriggerUrgentNotificationAsync(
                    module: "隐患上报",
                    title: hazard.Title,
                    level: hazard.HazardLevel,
                    description: hazard.Description ?? "",
                    factoryName: hazard.DeptName ?? "",
                    occurDate: hazard.DiscoveryDate?.ToString("yyyy-MM-dd HH:mm") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                );
            }
            catch (Exception ex)
            {
                Console.WriteLine($"隐患紧急推送异常: {ex.Message}");
            }
        }
    }
}
