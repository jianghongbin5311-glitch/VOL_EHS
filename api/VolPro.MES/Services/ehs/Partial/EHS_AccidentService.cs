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
    public partial class EHS_AccidentService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IEHS_AccidentRepository _repository;
        private readonly IExternalNotificationService _externalNotificationService;

        [ActivatorUtilitiesConstructor]
        public EHS_AccidentService(
            IEHS_AccidentRepository dbRepository,
            IHttpContextAccessor httpContextAccessor,
            IExternalNotificationService externalNotificationService
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
            _externalNotificationService = externalNotificationService;

            // 新增事故后 — 判断等级触发紧急推送
            AddOnExecuted = (EHS_Accident accident, object list) =>
            {
                TryTriggerUrgentNotification(accident);
                return new WebResponseContent().OK();
            };

            // 编辑事故后 — 等级变更也可能触发推送
            UpdateOnExecuted = (EHS_Accident accident, object addList, object updateList, List<object> delKeys) =>
            {
                TryTriggerUrgentNotification(accident);
                return new WebResponseContent().OK();
            };
        }

        /// <summary>
        /// 判断事故等级，触发紧急推送
        /// </summary>
        private void TryTriggerUrgentNotification(EHS_Accident accident)
        {
            if (accident == null || !_externalNotificationService.IsUrgentLevel(accident.AccidentLevel))
                return;

            try
            {
                _ = _externalNotificationService.TriggerUrgentNotificationAsync(
                    module: "事故管理",
                    title: accident.Title,
                    level: accident.AccidentLevel,
                    description: accident.Description ?? "",
                    factoryName: accident.DeptName ?? "",
                    occurDate: accident.OccurDate?.ToString("yyyy-MM-dd HH:mm") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                );
            }
            catch (Exception ex)
            {
                Console.WriteLine($"事故紧急推送异常: {ex.Message}");
            }
        }
    }
}
