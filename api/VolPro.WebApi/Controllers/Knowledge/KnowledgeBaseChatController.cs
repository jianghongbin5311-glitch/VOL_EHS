using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace VolPro.WebApi.Controllers.Knowledge
{
    [Route("api/knowledgeBaseChat")]
    [ApiController]
    public class KnowledgeBaseChatController : ControllerBase
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _configuration;
        private readonly ILogger<KnowledgeBaseChatController> _logger;

        public KnowledgeBaseChatController(
            IHttpClientFactory httpClientFactory,
            IConfiguration configuration,
            ILogger<KnowledgeBaseChatController> logger)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
            _logger = logger;
        }

        /// <summary>
        /// 知识库问答 - 代理转发
        /// </summary>
        [HttpPost("query")]
        public async Task<IActionResult> Query([FromBody] KbQueryRequest request)
        {
            var sw = Stopwatch.StartNew();

            if (string.IsNullOrWhiteSpace(request?.Question))
            {
                return Ok(new KbQueryResponse
                {
                    Status = false,
                    Message = "请输入问题"
                });
            }

            var baseUrl = _configuration["KnowledgeBaseChat:BaseUrl"];
            var queryPath = _configuration["KnowledgeBaseChat:QueryPath"] ?? "/api/v1/chat/query";
            var apiKey = _configuration["KnowledgeBaseChat:ApiKey"];
            var timeoutStr = _configuration["KnowledgeBaseChat:TimeoutSeconds"] ?? "120";

            if (string.IsNullOrEmpty(baseUrl) || string.IsNullOrEmpty(apiKey))
            {
                return Ok(new KbQueryResponse
                {
                    Status = false,
                    Message = "知识库配置缺失，请联系管理员检查appsettings.json中的KnowledgeBaseChat节"
                });
            }

            var apiUrl = baseUrl.TrimEnd('/') + queryPath;

            try
            {
                var client = _httpClientFactory.CreateClient();
                client.Timeout = TimeSpan.FromSeconds(int.Parse(timeoutStr));

                // 构建请求体
                var requestBody = new Dictionary<string, object>
                {
                    { "question", request.Question }
                };

                if (!string.IsNullOrEmpty(request.SessionId))
                {
                    requestBody["session_id"] = request.SessionId;
                }

                var json = JsonSerializer.Serialize(requestBody);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                using var httpRequest = new HttpRequestMessage(HttpMethod.Post, apiUrl);
                httpRequest.Headers.Add("X-API-Key", apiKey);
                httpRequest.Content = content;

                _logger.LogInformation("[KB] 问答请求: url={Url}, question={Question}",
                    apiUrl, request.Question.Length > 50 ? request.Question[..50] + "..." : request.Question);

                var response = await client.SendAsync(httpRequest);
                var responseBody = await response.Content.ReadAsStringAsync();

                sw.Stop();

                _logger.LogInformation("[KB] 响应: status={StatusCode}, elapsed={Elapsed}ms, bodyLen={BodyLen}",
                    (int)response.StatusCode, sw.ElapsedMilliseconds, responseBody.Length);

                if (!response.IsSuccessStatusCode)
                {
                    return Ok(new KbQueryResponse
                    {
                        Status = false,
                        Message = $"知识库服务返回错误: HTTP {(int)response.StatusCode}",
                        Question = request.Question,
                        ElapsedMilliseconds = sw.ElapsedMilliseconds
                    });
                }

                // 归一化解析响应
                return Ok(NormalizeResponse(responseBody, request.Question, sw.ElapsedMilliseconds));
            }
            catch (TaskCanceledException)
            {
                sw.Stop();
                _logger.LogWarning("[KB] 请求超时: url={Url}", apiUrl);
                return Ok(new KbQueryResponse
                {
                    Status = false,
                    Message = "知识库服务响应超时，请稍后重试",
                    Question = request.Question,
                    ElapsedMilliseconds = sw.ElapsedMilliseconds
                });
            }
            catch (HttpRequestException ex)
            {
                sw.Stop();
                _logger.LogError(ex, "[KB] 网络异常: url={Url}", apiUrl);
                return Ok(new KbQueryResponse
                {
                    Status = false,
                    Message = $"知识库服务连接失败: {ex.Message}",
                    Question = request.Question,
                    ElapsedMilliseconds = sw.ElapsedMilliseconds
                });
            }
            catch (Exception ex)
            {
                sw.Stop();
                _logger.LogError(ex, "[KB] 未知异常");
                return Ok(new KbQueryResponse
                {
                    Status = false,
                    Message = $"请求处理失败: {ex.Message}",
                    Question = request.Question,
                    ElapsedMilliseconds = sw.ElapsedMilliseconds
                });
            }
        }

        /// <summary>
        /// 连接测试
        /// </summary>
        [HttpGet("testConnection")]
        public async Task<IActionResult> TestConnection()
        {
            var sw = Stopwatch.StartNew();
            var baseUrl = _configuration["KnowledgeBaseChat:BaseUrl"];
            var queryPath = _configuration["KnowledgeBaseChat:QueryPath"] ?? "/api/v1/chat/query";
            var apiKey = _configuration["KnowledgeBaseChat:ApiKey"];
            var timeoutStr = _configuration["KnowledgeBaseChat:TimeoutSeconds"] ?? "120";
            var apiUrl = baseUrl?.TrimEnd('/') + queryPath;

            if (string.IsNullOrEmpty(baseUrl) || string.IsNullOrEmpty(apiKey))
            {
                return Ok(new
                {
                    status = false,
                    message = "KnowledgeBaseChat配置缺失",
                    targetUrl = apiUrl
                });
            }

            try
            {
                var client = _httpClientFactory.CreateClient();
                client.Timeout = TimeSpan.FromSeconds(int.Parse(timeoutStr));

                var requestBody = JsonSerializer.Serialize(new { question = "你好" });
                var content = new StringContent(requestBody, Encoding.UTF8, "application/json");

                using var httpRequest = new HttpRequestMessage(HttpMethod.Post, apiUrl);
                httpRequest.Headers.Add("X-API-Key", apiKey);
                httpRequest.Content = content;

                var response = await client.SendAsync(httpRequest);
                var body = await response.Content.ReadAsStringAsync();
                sw.Stop();

                return Ok(new
                {
                    status = response.IsSuccessStatusCode,
                    statusCode = (int)response.StatusCode,
                    message = response.IsSuccessStatusCode ? "连接成功" : $"HTTP {(int)response.StatusCode}",
                    targetUrl = apiUrl,
                    elapsedMs = sw.ElapsedMilliseconds,
                    responsePreview = body.Length > 200 ? body[..200] + "..." : body
                });
            }
            catch (Exception ex)
            {
                sw.Stop();
                return Ok(new
                {
                    status = false,
                    message = $"连接失败: {ex.Message}",
                    targetUrl = apiUrl,
                    elapsedMs = sw.ElapsedMilliseconds
                });
            }
        }

        /// <summary>
        /// 归一化解析外部知识库响应
        /// </summary>
        private KbQueryResponse NormalizeResponse(string responseBody, string question, long elapsedMs)
        {
            try
            {
                using var doc = JsonDocument.Parse(responseBody);
                var root = doc.RootElement;

                // 提取 answer（兼容多种字段名和层级）
                string answer = null;
                foreach (var key in new[] { "answer", "response", "content", "message", "result" })
                {
                    if (root.TryGetProperty(key, out var prop) && prop.ValueKind == JsonValueKind.String)
                    {
                        answer = prop.GetString();
                        if (!string.IsNullOrEmpty(answer)) break;
                    }
                }
                // 尝试 data.answer 层级
                if (string.IsNullOrEmpty(answer) && root.TryGetProperty("data", out var dataProp))
                {
                    foreach (var key in new[] { "answer", "response", "content", "message" })
                    {
                        if (dataProp.TryGetProperty(key, out var prop) && prop.ValueKind == JsonValueKind.String)
                        {
                            answer = prop.GetString();
                            if (!string.IsNullOrEmpty(answer)) break;
                        }
                    }
                }

                // 提取 session_id
                string sessionId = null;
                foreach (var key in new[] { "session_id", "sessionId", "session" })
                {
                    if (root.TryGetProperty(key, out var prop) && prop.ValueKind == JsonValueKind.String)
                    {
                        sessionId = prop.GetString();
                        if (!string.IsNullOrEmpty(sessionId)) break;
                    }
                }
                if (string.IsNullOrEmpty(sessionId) && root.TryGetProperty("data", out var dataForSession))
                {
                    foreach (var key in new[] { "session_id", "sessionId" })
                    {
                        if (dataForSession.TryGetProperty(key, out var prop) && prop.ValueKind == JsonValueKind.String)
                        {
                            sessionId = prop.GetString();
                            break;
                        }
                    }
                }

                // 提取 sources
                var sources = new List<KbSource>();
                JsonElement sourcesArray = default;
                bool foundSources = false;
                foreach (var key in new[] { "sources", "references", "docs", "documents" })
                {
                    if (root.TryGetProperty(key, out sourcesArray) && sourcesArray.ValueKind == JsonValueKind.Array)
                    {
                        foundSources = true;
                        break;
                    }
                }
                if (!foundSources && root.TryGetProperty("data", out var dataForSources))
                {
                    foreach (var key in new[] { "sources", "references" })
                    {
                        if (dataForSources.TryGetProperty(key, out sourcesArray) && sourcesArray.ValueKind == JsonValueKind.Array)
                        {
                            foundSources = true;
                            break;
                        }
                    }
                }

                if (foundSources)
                {
                    foreach (var item in sourcesArray.EnumerateArray())
                    {
                        var source = new KbSource();
                        if (item.TryGetProperty("title", out var t)) source.Title = t.GetString();
                        if (item.TryGetProperty("name", out var n) && string.IsNullOrEmpty(source.Title)) source.Title = n.GetString();
                        if (item.TryGetProperty("content", out var c)) source.Content = c.GetString();
                        if (item.TryGetProperty("snippet", out var sn)) source.Content ??= sn.GetString();
                        if (item.TryGetProperty("source_type", out var st)) source.SourceType = st.GetString();
                        if (item.TryGetProperty("sourceType", out var st2)) source.SourceType ??= st2.GetString();
                        if (item.TryGetProperty("score", out var sc) && sc.ValueKind == JsonValueKind.Number)
                            source.Score = Math.Round(sc.GetDouble(), 3);
                        if (item.TryGetProperty("url", out var u)) source.Url = u.GetString();
                        if (item.TryGetProperty("link", out var l)) source.Url ??= l.GetString();
                        sources.Add(source);
                    }
                }

                // 判断成功条件：有非空 answer 即视为成功
                bool isSuccess = !string.IsNullOrWhiteSpace(answer);

                return new KbQueryResponse
                {
                    Status = isSuccess,
                    Message = isSuccess ? "" : "知识库未返回有效答案",
                    Question = question,
                    Answer = answer ?? "",
                    SessionId = sessionId,
                    Sources = sources,
                    ElapsedMilliseconds = elapsedMs
                };
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "[KB] 响应解析失败, body={Body}", responseBody.Length > 300 ? responseBody[..300] : responseBody);
                return new KbQueryResponse
                {
                    Status = false,
                    Message = "知识库响应解析失败",
                    Question = question,
                    Answer = responseBody,
                    ElapsedMilliseconds = elapsedMs
                };
            }
        }

        #region Models

        public class KbQueryRequest
        {
            public string Question { get; set; }
            public string SessionId { get; set; }
        }

        public class KbQueryResponse
        {
            public bool Status { get; set; }
            public string Message { get; set; }
            public string Question { get; set; }
            public string Answer { get; set; }
            public string SessionId { get; set; }
            public List<KbSource> Sources { get; set; } = new();
            public long ElapsedMilliseconds { get; set; }
        }

        public class KbSource
        {
            public string Title { get; set; }
            public string Content { get; set; }
            public string SourceType { get; set; }
            public double? Score { get; set; }
            public string Url { get; set; }
        }

        #endregion
    }
}
