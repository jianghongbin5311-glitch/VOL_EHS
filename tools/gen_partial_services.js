const fs = require('fs');
const path = require('path');
const root = 'C:\\Users\\FZP28D\\Desktop\\AI Created\\VOL_Pro_Antigravity';
function wf(p,c){const d=path.dirname(p);fs.mkdirSync(d,{recursive:true});fs.writeFileSync(p,c,'utf8');}

const tables = [
'EHS_SafetyLedger','EHS_HazardInspection','EHS_HazardReport',
'EHS_Course','EHS_QuestionBank','EHS_TrainingPlan','EHS_TrainingRecord',
'EHS_WorkPermit','EHS_WorkPermitMonitor',
'EHS_EmergencyResource','EHS_EmergencyPlan','EHS_EmergencyDrill',
'EHS_Accident','EHS_HazardousWaste','EHS_SolidWaste',
'EHS_PPEStandard','EHS_PPEDistribution',
'EHS_Chemical','EHS_ChemicalApplication','EHS_ChemicalInOut',
'EHS_Document','EHS_Information',
'EHS_Meeting','EHS_MeetingSignIn',
'EHS_Supplier','EHS_ConstructionProject'
];

tables.forEach(t => {
  // Partial Service with constructor
  const svcContent = `using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
using VolPro.MES.IRepositories;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Http;

namespace VolPro.MES.Services
{
    public partial class ${t}Service
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly I${t}Repository _repository;

        [ActivatorUtilitiesConstructor]
        public ${t}Service(
            I${t}Repository dbRepository,
            IHttpContextAccessor httpContextAccessor
        ) : base(dbRepository)
        {
            _httpContextAccessor = httpContextAccessor;
            _repository = dbRepository;
        }
    }
}
`;
  wf(path.join(root,'api','VolPro.MES','Services','ehs','Partial',t+'Service.cs'), svcContent);
  console.log('[OK] Partial Service:', t);
});

console.log(`\n=== Done: ${tables.length} Partial Service files generated ===`);
