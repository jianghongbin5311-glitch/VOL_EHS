using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace VolPro.MES.Controllers
{
    /// <summary>
    /// AI 代理控制器 - 代理前端发往 AI 翻译/润色 API 的请求，
    /// 避免 CORS 问题并保护 API Key。
    /// 支持两种模式：TranslateText（单字段翻译）和 TranslateForm（批量表单翻译）。
    /// 配置来源：appsettings.json → EhsAi 段。
    /// </summary>
    [Route("api/AI")]
    [ApiController]
    public class AIProxyController : ControllerBase
    {
        private static readonly HttpClient _httpClient = new HttpClient { Timeout = TimeSpan.FromSeconds(60) };

        private readonly string _aiEndpoint;
        private readonly string _aiKey;
        private readonly string _aiModel;

        public AIProxyController(IConfiguration configuration)
        {
            // 从 appsettings.json 的 EhsAi 配置段读取
            _aiEndpoint = configuration["EhsAi:BaseUrl"] ?? "http://10.243.22.43/v1/chat/completions";
            _aiKey = configuration["EhsAi:ApiKey"] ?? "";
            _aiModel = configuration["EhsAi:Model"] ?? "Azure-GPT-4O-Internal";
        }

        /// <summary>
        /// 翻译单段文本。direction: "en2zh" 或 "zh2en"
        /// </summary>
        [HttpPost("TranslateText")]
        public async Task<IActionResult> TranslateText([FromBody] TranslateTextRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.Text))
                {
                    return Ok(new { status = false, message = "翻译文本不能为空" });
                }

                if (string.IsNullOrWhiteSpace(_aiKey))
                {
                    // Fallback: 无 API Key 时使用简单的标记翻译
                    var fallback = request.Direction == "en2zh"
                        ? $"[AI翻译待配置] {request.Text}"
                        : $"[AI Translation pending] {request.Text}";
                    return Ok(new { status = true, data = new { result = fallback }, message = "AI 密钥未配置，返回占位翻译" });
                }

                var prompt = request.Direction == "en2zh"
                    ? $"Translate the following English text to Chinese. Return only the translated text:\n\n{request.Text}"
                    : $"Translate the following Chinese text to English. Return only the translated text:\n\n{request.Text}";

                var result = await CallAiAsync(prompt);
                return Ok(new { status = true, data = new { result }, message = "翻译成功" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"翻译失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 润色文本。
        /// </summary>
        [HttpPost("PolishText")]
        public async Task<IActionResult> PolishText([FromBody] PolishTextRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.Text))
                {
                    return Ok(new { status = false, message = "润色文本不能为空" });
                }

                if (string.IsNullOrWhiteSpace(_aiKey))
                {
                    return Ok(new { status = true, data = new { result = request.Text }, message = "AI 密钥未配置，返回原文" });
                }

                var lang = request.Language == "zh" ? "Chinese" : "English";
                var prompt = $"You are a quality engineering expert. Polish the following {lang} text for clarity, grammar, and professionalism. Preserve technical accuracy. Return only the polished text:\n\n{request.Text}";

                var result = await CallAiAsync(prompt);
                return Ok(new { status = true, data = new { result }, message = "润色成功" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"润色失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 批量翻译表单中的多个文本块。
        /// </summary>
        [HttpPost("TranslateForm")]
        public async Task<IActionResult> TranslateForm([FromBody] TranslateFormRequest request)
        {
            try
            {
                if (request?.Fields == null || request.Fields.Count == 0)
                {
                    return Ok(new { status = false, message = "待翻译字段不能为空" });
                }

                if (string.IsNullOrWhiteSpace(_aiKey))
                {
                    var fallbackResults = new System.Collections.Generic.Dictionary<string, string>();
                    foreach (var kv in request.Fields)
                    {
                        fallbackResults[kv.Key] = $"[AI翻译待配置] {kv.Value}";
                    }
                    return Ok(new { status = true, data = fallbackResults, message = "AI 密钥未配置，返回占位翻译" });
                }

                var results = new System.Collections.Generic.Dictionary<string, string>();
                var direction = request.Direction == "en2zh" ? "English to Chinese" : "Chinese to English";
                foreach (var kv in request.Fields)
                {
                    if (string.IsNullOrWhiteSpace(kv.Value))
                    {
                        results[kv.Key] = string.Empty;
                        continue;
                    }
                    var prompt = $"Translate the following from {direction}. Return only the translated text:\n\n{kv.Value}";
                    results[kv.Key] = await CallAiAsync(prompt);
                }
                return Ok(new { status = true, data = results, message = "批量翻译成功" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"批量翻译失败: {ex.Message}" });
            }
        }

        /// <summary>
        /// 拼写检查。
        /// </summary>
        [HttpPost("SpellCheck")]
        public async Task<IActionResult> SpellCheck([FromBody] PolishTextRequest request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request?.Text))
                {
                    return Ok(new { status = false, message = "检查文本不能为空" });
                }

                if (string.IsNullOrWhiteSpace(_aiKey))
                {
                    return Ok(new { status = true, data = new { result = request.Text }, message = "AI 密钥未配置，返回原文" });
                }

                var lang = request.Language == "zh" ? "Chinese" : "English";
                var prompt = $"You are a professional quality engineering proofreader. Check the following {lang} text for spelling errors, grammar mistakes, and typos. Fix any issues found. Return only the corrected text:\n\n{request.Text}";

                var result = await CallAiAsync(prompt);
                return Ok(new { status = true, data = new { result }, message = "拼写检查完成" });
            }
            catch (Exception ex)
            {
                return Ok(new { status = false, message = $"拼写检查失败: {ex.Message}" });
            }
        }

        private async Task<string> CallAiAsync(string prompt)
        {
            var body = Newtonsoft.Json.JsonConvert.SerializeObject(new
            {
                model = _aiModel,
                messages = new[]
                {
                    new { role = "system", content = "You are a professional translation and quality engineering assistant." },
                    new { role = "user", content = prompt }
                },
                temperature = 0.3,
                max_tokens = 2000
            });

            var httpRequest = new HttpRequestMessage(HttpMethod.Post, _aiEndpoint)
            {
                Content = new StringContent(body, Encoding.UTF8, "application/json")
            };
            httpRequest.Headers.Add("Authorization", $"Bearer {_aiKey}");

            var response = await _httpClient.SendAsync(httpRequest);
            var responseBody = await response.Content.ReadAsStringAsync();
            if (!response.IsSuccessStatusCode)
            {
                throw new Exception($"AI API 返回错误: {response.StatusCode} - {responseBody}");
            }

            dynamic jsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(responseBody);
            return jsonResponse?.choices?[0]?.message?.content?.ToString()?.Trim() ?? string.Empty;
        }
    }

    public class TranslateTextRequest
    {
        public string Text { get; set; }
        public string Direction { get; set; } = "en2zh";
    }

    public class PolishTextRequest
    {
        public string Text { get; set; }
        public string Language { get; set; } = "en";
    }

    public class TranslateFormRequest
    {
        public System.Collections.Generic.Dictionary<string, string> Fields { get; set; }
        public string Direction { get; set; } = "en2zh";
    }
}
