using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Quartz.Impl;
using Quartz;
using VolPro.Core.CacheManager;
using VolPro.Core.Configuration;
using VolPro.Core.Dapper;
using VolPro.Core.Filters;
using VolPro.Core.Middleware;
using VolPro.Core.ObjectActionValidator;
using VolPro.Core.Quartz;
using VolPro.Core.Extensions;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Http;
using VolPro.Core.Controllers.Basic;
using VolPro.Core.Language;
using VolPro.WebApi.Controllers.Hubs;
using System.Net;
using VolPro.WebApi;
using VolPro.Core.SignalR;


var builder = WebApplication.CreateBuilder(args);
builder.Services.AddModule(builder.Configuration);

// 添加后台服务
builder.Services.AddHostedService<BackgroundMessageService>();

// 添加消息服务
builder.Services.AddSingleton<IMessageService, MessageService>();
// 添加消息服务 
builder.Services.AddSingleton<MessageChannel>();


builder.Services
    .AddControllers()
        //https://learn.microsoft.com/zh-cn/aspnet/core/web-api/jsonpatch?view=aspnetcore-8.0
        //需要安装Microsoft.AspNetCore.Mvc.NewtonsoftJson包
        .AddNewtonsoftJson(op =>
        {
            op.SerializerSettings.ContractResolver = new Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver();
            op.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
            op.SerializerSettings.Converters.Add(new LongCovert());
        });
DapperParseGuidTypeHandler.InitParseGuid();
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
          .AddJwtBearer(options =>
          {
              options.TokenValidationParameters = new TokenValidationParameters
              {
                  SaveSigninToken = true,//保存token,后台验证token是否生效(重要)
                  ValidateIssuer = true,//是否验证Issuer
                  ValidateAudience = true,//是否验证Audience
                  ValidateLifetime = true,//是否验证失效时间
                  ValidateIssuerSigningKey = true,//是否验证SecurityKey
                  ValidAudience = AppSetting.Secret.Audience,//Audience
                  ValidIssuer = AppSetting.Secret.Issuer,//Issuer，这两项和前面签发jwt的设置一致
                  IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(AppSetting.Secret.JWT))
              };
              options.Events = new JwtBearerEvents()
              {
                  OnChallenge = context =>
                  {
                      context.HandleResponse();
                      context.Response.Clear();
                      context.Response.ContentType = "application/json";
                      context.Response.StatusCode = 401;
                      context.Response.WriteAsync(new { message = "授权未通过", status = false, code = 401 }.Serialize());
                      return Task.CompletedTask;
                  }
              };
          });
//builder.Services.AddCors();
//builder.Services.AddCors(options =>
//{
//    options.AddDefaultPolicy(
//        builder =>
//        {
//            builder.AllowAnyOrigin()
//                         .SetPreflightMaxAge(TimeSpan.FromSeconds(2520))
//                          .AllowAnyHeader().AllowAnyMethod();
//        });
//});
builder.Services.AddCors(options =>
{
    options.AddPolicy("cors", builder =>
    {
        builder.SetIsOriginAllowed(_ => true)
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials();
    });
});

builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "volpro.core.api", Version = "v1" });
    var security = new Dictionary<string, IEnumerable<string>> { { AppSetting.Secret.Issuer, new string[] { } }};
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
    {
        Description = "JWT授权token前面需要加上字段Bearer与一个空格,如Bearer token",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    { { new OpenApiSecurityScheme{  Reference = new OpenApiReference {  Type = ReferenceType.SecurityScheme,  Id = "Bearer" }}, new string[] { }  } });
})
 .AddControllers()
.ConfigureApiBehaviorOptions(options =>
{
    options.SuppressConsumesConstraintForFormFileParameters = true;
    options.SuppressInferBindingSourcesForParameters = true;
    options.SuppressModelStateInvalidFilter = true;
    options.SuppressMapClientErrors = true;
    options.ClientErrorMapping[404].Link =
        "https://*/404";
});
builder.Services.AddSignalR();
builder.Services.AddHttpClient()
.AddHttpContextAccessor()
.AddMemoryCache()
.AddTransient<HttpResultfulJob>()
.AddSingleton<ISchedulerFactory, StdSchedulerFactory>()
.AddSingleton<Quartz.Spi.IJobFactory, IOCJobFactory>()
.AddSingleton<RedisCacheService>();

builder.Services.AddMvc(options =>
{
    options.Filters.Add(typeof(ApiAuthorizeFilter));
    options.Filters.Add(typeof(ActionExecuteFilter));
});
var startup = new Startup(builder.Configuration);

startup.ConfigureContainer();
builder.Services.UseMethodsModelParameters().UseMethodsGeneralParameters();
builder.Services.AddSingleton<IObjectModelValidator>(new NullObjectModelValidator());
//Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.WebHost.UseUrls("http://*:9100");
builder.Services.Configure<FormOptions>(x =>
{
    x.MultipartBodyLengthLimit = 1024 * 1024 * 100;
}).Configure<KestrelServerOptions>(options =>
{
    options.Limits.MaxRequestBodySize = 1024 * 1024 * 100;
}).Configure<IISServerOptions>(options =>
{
    options.MaxRequestBodySize = 1024 * 1024 * 100;
});

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    //定时任务，如果需要本地执行定时任务，请将此代码放在else外面
    app.UseQuartz(app.Environment);
}
app.UseSwagger();
app.UseSwaggerUI();
app.UseLanguagePack().UseMiddleware<LanguageMiddleWare>();
app.UseMiddleware<ExceptionHandlerMiddleWare>();
app.UseDefaultFiles();
app.UseStaticFiles().UseStaticFiles(new StaticFileOptions
{
    ServeUnknownFileTypes = true
});
app.Use(HttpRequestMiddleware.Context);

string _uploadPath = (app.Environment.ContentRootPath + "/Upload").ReplacePath();

if (!Directory.Exists(_uploadPath))
{
    Directory.CreateDirectory(_uploadPath);
}

app.UseStaticFiles(new StaticFileOptions()
{
    FileProvider = new PhysicalFileProvider(
    Path.Combine(Directory.GetCurrentDirectory(), @"Upload")),
    RequestPath = "/Upload",
    OnPrepareResponse = (Microsoft.AspNetCore.StaticFiles.StaticFileResponseContext staticFile) =>{}
});
//配置HttpContext
app.UseStaticHttpContext();
// Configure the HTTP request pipeline.
app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
    options.RoutePrefix = string.Empty;
});
app.UseCors("cors");
app.UseCors();
// 使用 HTTPS 重定向
//app.UseHttpsRedirection();
// 使用路由
app.UseRouting();
app.UseAuthorization();
app.MapControllers();
//app.MapHub<HomePageMessageHub>("/message");
app.MapHub<MessageHub>("/hub/message");
app.MapControllers();
app.Run();