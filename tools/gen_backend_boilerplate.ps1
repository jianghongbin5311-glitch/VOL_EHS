$root = "C:\Users\FZP28D\Desktop\AI Created\VOL_Pro_Antigravity"
$tables = @(
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
)

function WF($path,$content){
    $dir=Split-Path $path -Parent
    if(!(Test-Path $dir)){New-Item $dir -ItemType Directory -Force|Out-Null}
    [IO.File]::WriteAllText($path,$content,[Text.UTF8Encoding]::new($false))
}

foreach($t in $tables){
# IRepository
WF "$root\api\VolPro.MES\IRepositories\ehs\I${t}Repository.cs" @"
using VolPro.Core.BaseProvider;
using VolPro.Entity.DomainModels;
using VolPro.Core.Extensions.AutofacManager;
namespace VolPro.MES.IRepositories
{
    public partial interface I${t}Repository : IDependency,IRepository<${t}>
    {
    }
}
"@

# Repository
WF "$root\api\VolPro.MES\Repositories\ehs\${t}Repository.cs" @"
using VolPro.MES.IRepositories;
using VolPro.Core.BaseProvider;
using VolPro.Core.EFDbContext;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Repositories
{
    public partial class ${t}Repository : RepositoryBase<${t}>, I${t}Repository
    {
        public ${t}Repository(ServiceDbContext dbContext) : base(dbContext) { }
        public static I${t}Repository Instance
        {
            get { return AutofacContainerModule.GetService<I${t}Repository>(); }
        }
    }
}
"@

# IService
WF "$root\api\VolPro.MES\IServices\ehs\I${t}Service.cs" @"
using VolPro.Core.BaseProvider;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.IServices
{
    public partial interface I${t}Service : IService<${t}>
    {
    }
}
"@

# Service
WF "$root\api\VolPro.MES\Services\ehs\${t}Service.cs" @"
using VolPro.MES.IRepositories;
using VolPro.MES.IServices;
using VolPro.Core.BaseProvider;
using VolPro.Core.Extensions.AutofacManager;
using VolPro.Entity.DomainModels;
namespace VolPro.MES.Services
{
    public partial class ${t}Service : ServiceBase<${t}, I${t}Repository>
    , I${t}Service, IDependency
    {
        public static I${t}Service Instance
        {
            get { return AutofacContainerModule.GetService<I${t}Service>(); }
        }
    }
}
"@

# Controller
WF "$root\api\VolPro.WebApi\Controllers\EHS\${t}Controller.cs" @"
using Microsoft.AspNetCore.Mvc;
using VolPro.Core.Controllers.Basic;
using VolPro.Entity.AttributeManager;
using VolPro.MES.IServices;
namespace VolPro.MES.Controllers
{
    [Route("api/${t}")]
    [PermissionTable(Name = "${t}")]
    public partial class ${t}Controller : ApiBaseController<I${t}Service>
    {
        public ${t}Controller(I${t}Service service) : base(service) { }
    }
}
"@

Write-Host "[OK] Backend boilerplate: $t"
}
Write-Host "`n=== Done: $(($tables.Count)*5) backend boilerplate files generated ==="
