<template>
  <div class="page">
    <div class="layout">
      <aside class="side">
        <div class="card nav">
          <div class="nav-title">快速导航</div>
          <div v-for="item in quickSectionAnchors" :key="item.key" class="nav-item" @click="scrollToSection(item.key)">{{ item.label }}</div>
        </div>
      </aside>
      <main class="main">
        <section class="hero">
          <div class="hero-top">
            <div>
              <el-button link @click="goBack">返回 Search Case</el-button>
              <h1>{{ form.TitleEn || '新建 Lesson Learn 分析报告' }}</h1>
              <div class="meta">
                <span>浏览: {{ form.ViewCount || 0 }}</span>
                <span @click="updateMetric('favorite')">我的收藏: {{ form.FavoriteCount || 0 }}</span>
                <span @click="updateMetric('like')">点赞: {{ form.LikeCount || 0 }}</span>
              </div>
            </div>
            <div class="actions">
              <input ref="pptInputRef" type="file" accept=".pptx" class="hidden" @change="parsePpt" />
              <el-button @click="triggerPptImport">导入PPT</el-button>
              <el-button @click="exportOnePage" type="success" plain>导出 One Page</el-button>
              <el-button @click="translateFormToEnglish" type="info">一键翻译(AI)</el-button>
              <el-button type="primary" :loading="saveLoading" @click="saveDraft(false)">保存</el-button>
              <el-button type="warning" :disabled="!form.LessonLearn_Id" @click="submitLesson">提交审批</el-button>
              <el-button :disabled="!form.LessonLearn_Id" @click="rejectLesson">驳回</el-button>
              <el-button type="success" :disabled="!form.LessonLearn_Id" @click="publishLesson">发布</el-button>
              <el-button :disabled="!form.LessonLearn_Id" @click="unlockLesson">解锁</el-button>
              <el-button :type="form.IsActive ? 'danger' : 'primary'" :disabled="!form.LessonLearn_Id" @click="setActiveStatus(!form.IsActive)">
                {{ form.IsActive ? 'Inactive' : 'Active' }}
              </el-button>
            </div>
          </div>
          <div class="toolbar">
            <el-tag size="large" :type="statusTagType(form.Status)">{{ statusText(form.Status) }}</el-tag>
            <el-tag size="large" :type="form.IsActive ? 'success' : 'info'">{{ form.IsActive ? 'Active' : 'Inactive' }}</el-tag>
            <el-select v-model="uiLanguage" class="mini"><el-option label="English" value="en" /><el-option label="中文" value="zh" /></el-select>
            <el-button @click="updateMetric('like')">点赞</el-button>
            <el-button @click="updateMetric('favorite')">我的收藏</el-button>
            <el-button @click="exportOnePage">导出 One Page</el-button>
            <el-button type="primary" @click="translateFormToEnglish">AI 全页翻译</el-button>
          </div>
        </section>

        <section class="summary">
          <div class="card stat"><div class="label">页面状态</div><div class="value">{{ statusText(form.Status) }}</div></div>
          <div class="card stat"><div class="label">完成进度</div><div class="value">{{ form.Progress || 0 }}%</div></div>
          <div class="card stat"><div class="label">分析周期</div><div class="value">{{ form.AnalysisCycleDays || 0 }} 天</div></div>
          <div class="card stat"><div class="label">当前版本</div><div class="value">V{{ form.VersionNo || 0 }}</div></div>
          <div class="card stat"><div class="label">生效状态</div><div class="value small">{{ form.IsActive ? 'Active' : 'Inactive' }}</div></div>
        </section>

        <section id="basic" class="card panel">
          <div class="head"><div class="title">基础信息</div><el-button link @click="generateLessonNo">自动编号</el-button></div>
          <div class="body cols">
            <div class="card inner">
              <div class="subtitle">标题与编号</div>
              <div class="grid">
                <el-input v-model="form.LessonNo" placeholder="LL-CEPS-NC-0001" />
                <el-select v-model="form.Category" placeholder="LL分类"><el-option v-for="item in categoryOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-select v-model="form.LessonLevel" placeholder="LL属性"><el-option v-for="item in lessonLevelOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-select v-model="form.ProductPlatforms" multiple filterable allow-create default-first-option placeholder="产品所属平台" collapse-tags collapse-tags-tooltip>
                  <el-option v-for="item in productPlatformOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-input v-model="form.TitleEn" placeholder="英文标题（必填）" />
                <el-input v-model="form.BasicInfo.VersionRemark" placeholder="版本备注 / Export Template Note" />
              </div>
            </div>
            <div class="card inner">
              <div class="subtitle">问题发生位置与业务字段</div>
              <div class="grid">
                <div style="display: flex; gap: 8px;">
                  <el-select v-model="form.IssueSource" filterable allow-create default-first-option placeholder="Issue System" style="width: 140px;">
                    <el-option v-for="item in issueSourceOptions" :key="item" :label="item" :value="item" />
                  </el-select>
                  <el-input v-model="form.IssueNo" placeholder="Issue No." style="flex: 1;">
                    <template #append v-if="form.IssueSource">
                      <el-button @click="navigateToIssueSystem(form.IssueSource, form.IssueNo)">跳转</el-button>
                    </template>
                  </el-input>
                </div>
                <el-input v-model="form.IssueUrl" placeholder="Issue Link（自动生成，可手动修改）" />
                <el-input v-model="form.IssueType" placeholder="Type / D/P/S/NC" />
                <el-select v-model="form.CpiProgram" filterable placeholder="CPI# + Program Name" style="width:100%">
                  <el-option v-for="item in cpiProgramOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-input v-model="form.Customer" placeholder="Customer" />
                <el-input v-model="form.PartNo" placeholder="Part No." />
                <el-select v-model="form.PartVersion" clearable allow-create default-first-option placeholder="Part Version">
                  <el-option v-for="item in partVersionOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-select v-model="form.DiscoveryStage" clearable placeholder="Discovery Stage / 发现阶段">
                  <el-option v-for="item in discoveryStageOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-select v-model="form.Plant" clearable filterable placeholder="Plant / 工厂"><el-option v-for="item in plantOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-select v-model="form.Workshop" clearable filterable placeholder="Workshop / 车间"><el-option v-for="item in workshopOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-select v-model="form.ProductionLine" clearable filterable placeholder="Line / 线体"><el-option v-for="item in lineOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-input v-model="form.CellName" placeholder="Cell / 工位" />
                <el-input v-model="form.ApprovalOwner" placeholder="Nexteer Issue Owner" />
              </div>
            </div>
          </div>
        </section>

        <section id="lines" class="card panel">
          <div class="head"><div class="title">LL适用产品线</div><el-tag size="small" type="info">已选: {{ form.ApplicableProductLines.length }} 项</el-tag></div>
          <div class="body">
            <el-collapse class="pl-collapse">
              <el-collapse-item v-for="group in productLineTreeData" :key="group.label" :name="group.label">
                <template #title>
                  <el-checkbox
                    :model-value="isGroupAllChecked(group)"
                    :indeterminate="isGroupIndeterminate(group)"
                    @change="toggleGroup(group, $event)"
                    @click.stop
                  >{{ group.label }}</el-checkbox>
                  <el-tag size="small" type="info" style="margin-left:8px" v-if="getGroupCheckedCount(group) > 0">{{ getGroupCheckedCount(group) }}</el-tag>
                </template>
                <div class="pl-children" v-if="group.children.length">
                  <el-checkbox-group v-model="form.ApplicableProductLines">
                    <el-checkbox v-for="child in group.children" :key="child" :label="child">{{ child }}</el-checkbox>
                  </el-checkbox-group>
                </div>
                <div v-else class="pl-no-sub">该产品线无细分子选项，选中即可</div>
              </el-collapse-item>
            </el-collapse>
          </div>
        </section>

        <section id="tags" class="card panel">
          <div class="head"><div class="title">标签</div><el-button link @click="focusTagInput">添加</el-button></div>
          <div class="body">
            <el-select ref="tagSelectRef" v-model="form.Tags" multiple filterable allow-create default-first-option style="width:100%" placeholder="请输入或选择标签">
              <el-option-group v-for="group in tagGroupDefinitions" :key="group.key" :label="`${group.icon} ${group.label}`">
                <el-option v-for="item in group.examples" :key="item" :label="item" :value="item" />
              </el-option-group>
              <el-option-group label="📌 其他" v-if="ungroupedTags.length > 0">
                <el-option v-for="item in ungroupedTags" :key="item" :label="item" :value="item" />
              </el-option-group>
            </el-select>
          </div>
        </section>

        <section id="issue" class="card panel">
          <div class="head red"><div class="title">Issue Description / 问题描述</div><el-button link @click="addTextBlock('IssueDescription')">新增条目</el-button></div>
          <div class="body"><div v-for="(item, index) in form.IssueDescription" :key="`issue-${index}`" class="block">
            <div class="block-head">
              <span>条目 {{ index + 1 }}</span>
              <div>
                <el-button link type="primary" @click="aiTranslateField(item, 'IssueDescription')">AI翻译/润色</el-button>
                <el-button link type="danger" @click="removeTextBlock('IssueDescription', index)">删除</el-button>
              </div>
            </div>
            <el-input v-model="item.En" type="textarea" :rows="4" placeholder="Example: Pinion abnormal wear found during DV build, issue linked to 5phase lot 3373-PSA-A51-Halfshafts-BR." />
            <el-input v-model="item.Zh" type="textarea" :rows="4" placeholder="示例：DV 试制阶段发现 Pinion 异常磨损，关联 5phase 批次 3373-PSA-A51-Halfshafts-BR。" class="mt8" />
            <div class="upload"><input type="file" multiple accept="image/*,.pdf,.ppt,.pptx,.tif,.tiff,.mp4,.avi,.mov,.mp3,.wav,.aac,.m4a" @change="uploadSectionFiles($event, 'IssueDescription', index)" /></div>
          </div></div>
        </section>

        <section id="root" class="card panel">
          <div class="head amber"><div class="title">Root Cause / 根本原因</div><el-button link @click="addTextBlock('RootCause')">新增条目</el-button></div>
          <div class="body"><div v-for="(item, index) in form.RootCause" :key="`root-${index}`" class="block">
            <div class="block-head">
              <span>条目 {{ index + 1 }}</span>
              <div>
                <el-button link type="primary" @click="aiTranslateField(item, 'RootCause')">AI翻译/润色</el-button>
                <el-button link type="danger" @click="removeTextBlock('RootCause', index)">删除</el-button>
              </div>
            </div>
            <el-input v-model="item.En" type="textarea" :rows="4" placeholder="Example: Template DFMEA did not include low-temperature grease separation mode, so validation coverage was incomplete." />
            <el-input v-model="item.Zh" type="textarea" :rows="4" placeholder="示例：模板 DFMEA 未覆盖低温油脂分离失效模式，导致验证覆盖不完整。" class="mt8" />
            <div class="upload"><input type="file" multiple accept="image/*,.pdf,.ppt,.pptx,.tif,.tiff,.mp4,.avi,.mov,.mp3,.wav,.aac,.m4a" @change="uploadSectionFiles($event, 'RootCause', index)" /></div>
          </div></div>
        </section>

        <section id="action" class="card panel">
          <div class="head green"><div class="title">Corrective Actions / 纠正措施</div><el-button link @click="addTextBlock('CorrectiveActions')">新增条目</el-button></div>
          <div class="body"><div v-for="(item, index) in form.CorrectiveActions" :key="`action-${index}`" class="block">
            <div class="block-head">
              <span>条目 {{ index + 1 }}</span>
              <div>
                <el-button link type="primary" @click="aiTranslateField(item, 'CorrectiveActions')">AI翻译/润色</el-button>
                <el-button link type="danger" @click="removeTextBlock('CorrectiveActions', index)">删除</el-button>
              </div>
            </div>
            <el-input v-model="item.En" type="textarea" :rows="4" placeholder="Example: Updated DFMEA to include low-temperature cure criteria. Added incoming inspection gate for grease viscosity." />
            <el-input v-model="item.Zh" type="textarea" :rows="4" placeholder="示例：更新 DFMEA 增加低温固化标准条目；增加油脂粘度来料检验把关工序。" class="mt8" />
            <div class="upload"><input type="file" multiple accept="image/*,.pdf,.ppt,.pptx,.tif,.tiff,.mp4,.avi,.mov,.mp3,.wav,.aac,.m4a" @change="uploadSectionFiles($event, 'CorrectiveActions', index)" /></div>
          </div></div>
        </section>

        <section id="global" class="card panel">
          <div class="head blue"><div class="title">Global Lessons Learned / 全球经验教训</div><el-button link @click="addTextBlock('GlobalLessons')">新增条目</el-button></div>
          <div class="body"><div v-for="(item, index) in form.GlobalLessons" :key="`global-${index}`" class="block">
            <div class="block-head">
              <span>条目 {{ index + 1 }}</span>
              <div>
                <el-button link type="primary" @click="aiTranslateField(item, 'GlobalLessons')">AI翻译/润色</el-button>
                <el-button link type="danger" @click="removeTextBlock('GlobalLessons', index)">删除</el-button>
              </div>
            </div>
            <el-input v-model="item.En" type="textarea" :rows="4" placeholder="Example: Issue CEPS design alert to global teams – all FMEA templates must include cold-temperature failure modes." />
            <el-input v-model="item.Zh" type="textarea" :rows="4" placeholder="示例：向全球团队发出 CEPS 设计通报，要求所有 FMEA 模板必须包含低温失效模式。" class="mt8" />
            <div class="upload"><input type="file" multiple accept="image/*,.pdf,.ppt,.pptx,.tif,.tiff,.mp4,.avi,.mov,.mp3,.wav,.aac,.m4a" @change="uploadSectionFiles($event, 'GlobalLessons', index)" /></div>
          </div></div>
        </section>

        <section id="document" class="card panel">
          <div class="head"><div class="title">标准文件清单、PFMEA 与 DFMEA Analysis</div><el-button link @click="addDocumentChange">新增文件变更</el-button></div>
          <div class="body cols">
            <div class="card inner">
              <div class="subtitle">标准文件清单</div>
              <el-select v-model="form.DocumentTypes" multiple placeholder="选择文件类型" style="width:100%">
                <el-option v-for="item in currentDocumentTypeOptions" :key="item" :label="item" :value="item" />
              </el-select>
              <div v-for="(item, index) in form.DocumentChanges" :key="`doc-${index}`" class="block doc">
                <div class="block-head"><span>变更条目 {{ index + 1 }}</span><el-button link type="danger" @click="form.DocumentChanges.splice(index, 1)">删除</el-button></div>
                <div class="grid">
                  <el-input v-model="item.ChangeType" placeholder="文件类型" />
                  <el-input v-model="item.BeforeFileName" placeholder="变更前文件名" />
                  <el-input v-model="item.AfterFileName" placeholder="变更后文件名" />
                </div>
                <div class="mini-grid">
                  <div><div class="mini-title">变更前文件</div><input type="file" multiple @change="uploadDocumentFiles($event, item, 'BeforeFiles')" /></div>
                  <div><div class="mini-title">变更后文件</div><input type="file" multiple @change="uploadDocumentFiles($event, item, 'AfterFiles')" /></div>
                </div>
              </div>
            </div>
            <div class="card inner">
              <div class="subtitle">PFMEA / DFMEA Analysis</div>
              <div class="pfmea-grid">
                <div class="pfmea-box">
                  <div class="switch"><span>启用 PFMEA 分析</span><el-switch v-model="form.PfmeaEnabled" /></div>
                  <el-input v-model="form.PfmeaDescription" type="textarea" :rows="3" placeholder="FMEA文件编号&版本号-Issue编号-Lv3 Function-Failure Effect-Failure Mode-Failure cause" />
                  <div v-if="form.PfmeaEnabled" class="analysis-block">
                    <div class="mini-title">改善前</div>
                    <div class="score-grid">
                      <div class="score-item">
                        <div class="score-label">Severity</div>
                        <el-input-number v-model="form.PfmeaBefore.Severity" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Occurrence</div>
                        <el-input-number v-model="form.PfmeaBefore.Occurrence" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Detection</div>
                        <el-input-number v-model="form.PfmeaBefore.Detection" :min="0" :max="10" />
                      </div>
                    </div>
                    <div class="rpn">RPN: {{ calcRpn(form.PfmeaBefore) }}</div>
                    <div class="mini-title mt8">改善后</div>
                    <div class="score-grid">
                      <div class="score-item">
                        <div class="score-label">Severity</div>
                        <el-input-number v-model="form.PfmeaAfter.Severity" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Occurrence</div>
                        <el-input-number v-model="form.PfmeaAfter.Occurrence" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Detection</div>
                        <el-input-number v-model="form.PfmeaAfter.Detection" :min="0" :max="10" />
                      </div>
                    </div>
                    <div class="rpn">RPN: {{ calcRpn(form.PfmeaAfter) }}</div>
                  </div>
                </div>
                <div class="pfmea-box">
                  <div class="switch"><span>启用 DFMEA 分析</span><el-switch v-model="form.DfmeaEnabled" /></div>
                  <el-input v-model="form.DfmeaDescription" type="textarea" :rows="3" placeholder="FMEA文件编号&版本号-Issue编号-Lv3 Function-Failure Effect-Failure Mode-Failure cause" />
                  <div v-if="form.DfmeaEnabled" class="analysis-block">
                    <div class="mini-title">改善前</div>
                    <div class="score-grid">
                      <div class="score-item">
                        <div class="score-label">Severity</div>
                        <el-input-number v-model="form.DfmeaBefore.Severity" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Occurrence</div>
                        <el-input-number v-model="form.DfmeaBefore.Occurrence" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Detection</div>
                        <el-input-number v-model="form.DfmeaBefore.Detection" :min="0" :max="10" />
                      </div>
                    </div>
                    <div class="rpn">RPN: {{ calcRpn(form.DfmeaBefore) }}</div>
                    <div class="mini-title mt8">改善后</div>
                    <div class="score-grid">
                      <div class="score-item">
                        <div class="score-label">Severity</div>
                        <el-input-number v-model="form.DfmeaAfter.Severity" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Occurrence</div>
                        <el-input-number v-model="form.DfmeaAfter.Occurrence" :min="0" :max="10" />
                      </div>
                      <div class="score-item">
                        <div class="score-label">Detection</div>
                        <el-input-number v-model="form.DfmeaAfter.Detection" :min="0" :max="10" />
                      </div>
                    </div>
                    <div class="rpn">RPN: {{ calcRpn(form.DfmeaAfter) }}</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="supplement" class="card panel">
          <div class="head"><div class="title">补充文本信息</div><el-button link @click="addTextBlock('SupplementalNotes')">新增条目</el-button></div>
          <div class="body"><div v-for="(item, index) in form.SupplementalNotes" :key="`note-${index}`" class="block">
            <div class="block-head"><span>补充信息 {{ index + 1 }}</span><el-button link type="danger" @click="removeTextBlock('SupplementalNotes', index)">删除</el-button></div>
            <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English notes" />
            <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文补充信息" class="mt8" />
          </div></div>
        </section>

        <section id="attachment" class="card panel">
          <div class="head"><div class="title">相关文档</div><el-button link @click="downloadAll">下载全部</el-button></div>
          <div class="body">
            <div class="upload"><input type="file" multiple @change="uploadGeneralFiles" /></div>
            <div class="attachment-grid">
              <div v-for="(item, index) in form.Attachments" :key="`file-${index}`" class="attachment-card">
                <div v-if="isImage(item.Name)" class="thumb" @click="previewImage(item)">
                  <img :src="buildFileUrl(item.Path)" :alt="item.Name" loading="lazy" />
                  <div class="thumb-overlay">点击放大</div>
                </div>
                <div v-else-if="isPdf(item.Name)" class="thumb pdf-thumb" @click="previewPdf(item)">
                  <div class="pdf-icon">PDF</div>
                  <div class="thumb-overlay">在线预览</div>
                </div>
                <div class="file-info">
                  <div class="file-name" :title="item.Name">{{ item.Name }}</div>
                  <div class="muted">{{ formatSize(item.Size) }} / 下载 {{ item.DownloadCount || 0 }} 次</div>
                </div>
                <div class="file-actions">
                  <el-button link size="small" @click="downloadAttachment(item)">下载</el-button>
                  <el-button link size="small" v-if="isPdf(item.Name)" @click="previewPdf(item)">预览</el-button>
                  <el-button link type="danger" size="small" @click="form.Attachments.splice(index, 1)">删除</el-button>
                </div>
              </div>
            </div>
            <el-dialog v-model="imagePreviewVisible" title="图片预览" width="80%" destroy-on-close>
              <img :src="imagePreviewUrl" style="width:100%;max-height:80vh;object-fit:contain" />
            </el-dialog>
            <el-dialog v-model="pdfPreviewVisible" title="PDF 预览" width="90%" top="3vh" destroy-on-close>
              <iframe :src="pdfPreviewUrl" style="width:100%;height:80vh;border:none" />
            </el-dialog>
          </div>
        </section>

        <section id="review" class="card panel" v-if="isPL">
          <div class="head"><div class="title">多轮评审</div><el-button link @click="form.ReviewRecords.push(newReview())">新增评审</el-button></div>
          <div class="body">
            <div v-for="(item, index) in form.ReviewRecords" :key="`review-${index}`" class="block">
              <div class="block-head"><span>评审 {{ index + 1 }}</span><el-button link type="danger" @click="form.ReviewRecords.splice(index, 1)">删除</el-button></div>
              <div class="grid">
                <el-input v-model="item.Round" placeholder="轮次" />
                <el-input v-model="item.ReviewDate" placeholder="日期" />
                <el-input v-model="item.Reviewer" placeholder="评审人" />
                <el-input v-model="item.ReviewerTitle" placeholder="职位" />
                <el-input v-model="item.Result" placeholder="评审结果" />
                <el-input v-model="item.Comments" placeholder="评审意见" />
              </div>
            </div>
          </div>
        </section>

        <section id="participant" class="card panel" v-if="isPL">
          <div class="head"><div class="title">参与人员</div><el-button link @click="form.Participants.push(newParticipant())">新增人员</el-button></div>
          <div class="body">
            <div v-for="(item, index) in form.Participants" :key="`person-${index}`" class="mini-row">
              <el-input v-model="item.Name" placeholder="姓名" />
              <el-input v-model="item.Title" placeholder="职位" />
              <el-button link type="danger" @click="form.Participants.splice(index, 1)">删除</el-button>
            </div>
          </div>
        </section>

        <section id="task" class="card panel">
          <div class="head">
            <div class="title">任务分配</div>
            <div style="display:flex;gap:10px;align-items:center">
              <el-button link type="primary" @click="router.push('/LL_TaskCenter')">📋 查看任务闭环中心</el-button>
              <el-button link @click="form.Tasks.push(newTask())">新增任务</el-button>
            </div>
          </div>
          <div class="body">
            <div v-for="(item, index) in form.Tasks" :key="`task-${index}`" class="block">
              <div class="block-head"><span>任务 {{ index + 1 }}</span><el-button link type="danger" @click="form.Tasks.splice(index, 1)">删除</el-button></div>
              <div class="grid">
                <el-input v-model="item.Title" placeholder="任务名称" />
                <el-input v-model="item.Owner" placeholder="责任人" />
                <el-date-picker v-model="item.DueDate" type="date" value-format="YYYY-MM-DD" placeholder="目标完成时间" style="width:100%" />
                <el-input-number v-model="item.Progress" :min="0" :max="100" />
                <el-select v-model="item.Status" placeholder="任务状态">
                  <el-option label="待开始" value="待开始" />
                  <el-option label="进行中" value="进行中" />
                  <el-option label="上传完成" value="上传完成" />
                  <el-option label="审批完成" value="审批完成" />
                </el-select>
                <el-input v-model="item.Notes" placeholder="备注" />
              </div>
            </div>
          </div>
        </section>

        <section id="history" class="card panel">
          <div class="head"><div class="title">历史版本</div></div>
          <div class="body">
            <el-timeline>
              <el-timeline-item v-for="(item, index) in form.HistoryRecords" :key="`history-${index}`" :timestamp="item.Time" placement="top">
                <div class="history-title">V{{ item.VersionNo }} / {{ item.Action }} / {{ item.StatusText }}</div>
                <div class="muted">{{ item.Operator }} {{ item.Comment || '' }}</div>
              </el-timeline-item>
            </el-timeline>
          </div>
        </section>
      </main>
    </div>
  </div>
</template>

<script setup>
import { computed, nextTick, onMounted, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/api/http.js'
import { calcRpn, categoryOptions, defaultTextBlock, discoveryStageOptions, documentTypeOptions as defaultDocumentTypeOptions, emptyForm, formatDateTime, formatSize, issueSourceOptions, lessonLevelOptions, newDocumentChange, newParticipant, newReview, newTask, partVersionOptions, productLineOptions as defaultProductLineOptions, productLineTree, productPlatformOptions, quickSectionAnchors, statusTagType, statusText, suggestedTags as defaultSuggestedTags, tagGroupDefinitions, toPascalCaseKeys } from './lessonLearnShared'

const route = useRoute()
const router = useRouter()
const store = useStore()

const userInfo = store.getters.getUserInfo()
const isPL = computed(() => {
  const roleName = userInfo?.roleName || ''
  return roleName === 'PL' || roleName.includes('PL') || roleName.includes('APQP') || userInfo?.userName === 'admin'
})
const form = ref(emptyForm())
const saveLoading = ref(false)
const autoSaveText = ref('自动保存未开始')
const cpiProgramOptions = ref(['3373-PSA-A51-Halfshafts-BR', '5005-Chery-T21-CEPS-SU', '5123-Suzuki-YV7-CIS-IN'])
const pptInputRef = ref(null)
const tagSelectRef = ref(null)
const uiLanguage = ref('en')
const suppressWatch = ref(false)
const masterBundle = ref({ plants: [], workshops: [], lines: [], productLines: [], tagSuggestions: [], documentTypes: [] })
let autoSaveTimer = null
const imagePreviewVisible = ref(false)
const imagePreviewUrl = ref('')
const pdfPreviewVisible = ref(false)
const pdfPreviewUrl = ref('')
const isImage = (name) => /\.(jpe?g|png|gif|bmp|webp|svg|tif|tiff)$/i.test(name || '')
const isPdf = (name) => /\.pdf$/i.test(name || '')
const previewImage = (item) => { imagePreviewUrl.value = buildFileUrl(item.Path); imagePreviewVisible.value = true }
const previewPdf = (item) => { pdfPreviewUrl.value = buildFileUrl(item.Path); pdfPreviewVisible.value = true }

const toNames = (rows, field = 'DataName') => (rows || []).map(item => item?.[field] || item?.dataName).filter(Boolean)
const appendCurrent = (values, current) => current && !values.includes(current) ? [...values, current] : values
const currentProductLineOptions = computed(() => {
  const values = toNames(masterBundle.value.productLines || masterBundle.value.ProductLines)
  return values.length ? values : defaultProductLineOptions
})

// 产品线二级树形数据
const productLineTreeData = computed(() => {
  // 如果后端有层级数据，优先使用；否则使用默认 productLineTree
  return productLineTree
})
const isGroupAllChecked = (group) => {
  const targets = group.children.length ? group.children : [group.label]
  return targets.every(c => form.value.ApplicableProductLines.includes(c))
}
const isGroupIndeterminate = (group) => {
  const targets = group.children.length ? group.children : [group.label]
  const checked = targets.filter(c => form.value.ApplicableProductLines.includes(c))
  return checked.length > 0 && checked.length < targets.length
}
const getGroupCheckedCount = (group) => {
  const targets = group.children.length ? group.children : [group.label]
  return targets.filter(c => form.value.ApplicableProductLines.includes(c)).length
}
const toggleGroup = (group, checked) => {
  const targets = group.children.length ? group.children : [group.label]
  const current = new Set(form.value.ApplicableProductLines)
  targets.forEach(t => { if (checked) current.add(t); else current.delete(t) })
  form.value.ApplicableProductLines = [...current]
}
const currentTagSuggestions = computed(() => {
  const values = toNames(masterBundle.value.tagSuggestions || masterBundle.value.TagSuggestions)
  return values.length ? values : defaultSuggestedTags
})
const ungroupedTags = computed(() => {
  const grouped = new Set(tagGroupDefinitions.flatMap(g => g.examples))
  const allCurrent = new Set([...currentTagSuggestions.value, ...(form.value.Tags || [])])
  return Array.from(allCurrent).filter(t => !grouped.has(t))
})
const currentDocumentTypeOptions = computed(() => {
  const values = toNames(masterBundle.value.documentTypes || masterBundle.value.DocumentTypes)
  return values.length ? values : defaultDocumentTypeOptions
})
const plantOptions = computed(() => appendCurrent(toNames(masterBundle.value.plants || masterBundle.value.Plants), form.value.Plant))
const workshopOptions = computed(() => {
  let rows = masterBundle.value.workshops || masterBundle.value.Workshops || []
  if (form.value.Plant) {
    rows = rows.filter(item => !item.ParentName || item.ParentName === form.value.Plant || item.parentName === form.value.Plant)
  }
  return appendCurrent(toNames(rows), form.value.Workshop)
})
const lineOptions = computed(() => {
  let rows = masterBundle.value.lines || masterBundle.value.Lines || []
  if (form.value.Workshop) {
    rows = rows.filter(item => !item.ParentName || item.ParentName === form.value.Workshop || item.parentName === form.value.Workshop)
  }
  return appendCurrent(toNames(rows), form.value.ProductionLine)
})

const mergeForm = (payload) => {
  suppressWatch.value = true
  form.value = {
    ...emptyForm(),
    ...payload,
    BasicInfo: { ...emptyForm().BasicInfo, ...(payload?.BasicInfo || {}) },
    PfmeaBefore: { ...emptyForm().PfmeaBefore, ...(payload?.PfmeaBefore || {}) },
    PfmeaAfter: { ...emptyForm().PfmeaAfter, ...(payload?.PfmeaAfter || {}) },
    DfmeaBefore: { ...emptyForm().DfmeaBefore, ...(payload?.DfmeaBefore || {}) },
    DfmeaAfter: { ...emptyForm().DfmeaAfter, ...(payload?.DfmeaAfter || {}) }
  }
  if (!form.value.ProductPlatforms?.length && form.value.ProductPlatform) form.value.ProductPlatforms = [form.value.ProductPlatform]
  form.value.IssueDescription = form.value.IssueDescription?.length ? form.value.IssueDescription : [defaultTextBlock()]
  form.value.RootCause = form.value.RootCause?.length ? form.value.RootCause : [defaultTextBlock()]
  form.value.CorrectiveActions = form.value.CorrectiveActions?.length ? form.value.CorrectiveActions : [defaultTextBlock()]
  form.value.GlobalLessons = form.value.GlobalLessons?.length ? form.value.GlobalLessons : [defaultTextBlock()]
  form.value.SupplementalNotes = form.value.SupplementalNotes?.length ? form.value.SupplementalNotes : [defaultTextBlock()]
  nextTick(() => { suppressWatch.value = false })
}

const loadMasterBundle = async () => {
  const res = await http.get('/api/LL_MasterData/Bundle', {}, false)
  if (res.status) {
    masterBundle.value = res.data || masterBundle.value
  }
}

const loadDetail = async () => {
  const id = Number(route.query.id || 0)
  if (!id) { mergeForm(emptyForm()); return }
  const res = await http.get(`/api/LL_LessonLearn/Detail/${id}?increaseView=true`, {}, false)
  if (!res.status) { ElMessage.error(res.message || '加载详情失败'); return }
  mergeForm(toPascalCaseKeys(res.data))
}

const saveDraft = async (silent = false) => {
  if (saveLoading.value) return
  saveLoading.value = !silent
  try {
    const res = await http.post('/api/LL_LessonLearn/SaveDraft', JSON.parse(JSON.stringify(form.value)), false)
    if (!res.status) { if (!silent) ElMessage.error(res.message || '保存失败'); return }
    const data = toPascalCaseKeys(res.data)
    mergeForm(data)
    autoSaveText.value = `最近保存：${new Date().toLocaleTimeString()}`
    if (!route.query.id && data.LessonLearn_Id) router.replace({ path: route.path, query: { id: data.LessonLearn_Id } })
    if (!silent) ElMessage.success(res.message || '保存成功')
  } finally { saveLoading.value = false }
}

const postAction = async (path, message) => {
  if (!form.value.LessonLearn_Id) { ElMessage.warning('请先保存记录'); return }
  const res = await http.post(path, { comment: '' }, false)
  if (!res.status) { ElMessage.error(res.message || '操作失败'); return }
  mergeForm(toPascalCaseKeys(res.data))
  ElMessage.success(message)
}

const submitLesson = () => postAction(`/api/LL_LessonLearn/Submit/${form.value.LessonLearn_Id}`, '已提交审批')
const rejectLesson = () => postAction(`/api/LL_LessonLearn/Reject/${form.value.LessonLearn_Id}`, '已驳回')
const publishLesson = () => postAction(`/api/LL_LessonLearn/Publish/${form.value.LessonLearn_Id}`, '已发布并锁定')
const unlockLesson = () => postAction(`/api/LL_LessonLearn/Unlock/${form.value.LessonLearn_Id}`, '已解锁')
const setActiveStatus = async (isActive) => {
  if (!form.value.LessonLearn_Id) { ElMessage.warning('请先保存记录'); return }
  const actionText = isActive ? '启用' : '停用'
  try {
    await ElMessageBox.confirm(`确认${actionText}当前 LL 记录？`, `${actionText}确认`, { type: 'warning' })
    const res = await http.post(`/api/LL_LessonLearn/SetActive/${form.value.LessonLearn_Id}`, { isActive }, false)
    if (!res.status) { ElMessage.error(res.message || `${actionText}失败`); return }
    mergeForm(toPascalCaseKeys(res.data))
    ElMessage.success(res.message || `${actionText}成功`)
  } catch (error) {
    if (error !== 'cancel') ElMessage.error(error?.message || `${actionText}失败`)
  }
}
const addTextBlock = (field) => form.value[field].push({ ...defaultTextBlock(), Sort: form.value[field].length + 1 })
const removeTextBlock = (field, index) => { form.value[field].splice(index, 1); if (!form.value[field].length) form.value[field].push(defaultTextBlock()) }
const addDocumentChange = () => form.value.DocumentChanges.push(newDocumentChange())
const triggerPptImport = () => pptInputRef.value?.click()
const uploadFiles = async (files) => {
  const forms = new FormData()
  Array.from(files).forEach((file) => forms.append('fileInput', file, file.name))
  const result = await http.post('/api/LL_LessonLearn/Upload', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
  if (!result.status) throw new Error(result.message || '上传失败')
  return Array.from(files).map((file) => ({ Category: '', Name: file.name, Path: `${result.data || ''}${file.name}`, Size: file.size, DownloadCount: 0, UploadTime: formatDateTime(new Date()), CaptionEn: '', CaptionZh: '' }))
}
const uploadSectionFiles = async (event, field, index) => {
  const files = event.target.files
  if (!files?.length) return
  try { form.value[field][index].Images.push(...await uploadFiles(files)); ElMessage.success('图片上传成功') } catch (error) { ElMessage.error(error.message || '图片上传失败') } finally { event.target.value = '' }
}
const uploadDocumentFiles = async (event, item, field) => {
  const files = event.target.files
  if (!files?.length) return
  try { item[field].push(...await uploadFiles(files)); ElMessage.success('文件上传成功') } catch (error) { ElMessage.error(error.message || '文件上传失败') } finally { event.target.value = '' }
}
const uploadGeneralFiles = async (event) => {
  const files = event.target.files
  if (!files?.length) return
  try { form.value.Attachments.push(...await uploadFiles(files)); ElMessage.success('附件上传成功') } catch (error) { ElMessage.error(error.message || '附件上传失败') } finally { event.target.value = '' }
}
const buildFileUrl = (path) => {
  if (!path) return ''
  if (/^https?:/i.test(path)) return path
  const base = http.ipAddress.endsWith('/') ? http.ipAddress : `${http.ipAddress}/`
  return `${base}${path.replace(/^\/+/, '')}`
}
const downloadAttachment = async (item) => {
  if (!item?.Path) return
  if (form.value.LessonLearn_Id) {
    await http.post(`/api/LL_LessonLearn/RecordDownload/${form.value.LessonLearn_Id}`, { path: item.Path }, false)
    item.DownloadCount = (item.DownloadCount || 0) + 1
  }
  window.open(buildFileUrl(item.Path), '_blank')
}
const downloadAll = () => form.value.Attachments.forEach((item) => downloadAttachment(item))
const parsePpt = async (event) => {
  const file = event.target.files?.[0]
  if (!file) return
  const forms = new FormData()
  forms.append('file', file)
  const res = await http.post('/api/LL_LessonLearn/ParsePpt', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
  if (!res.status) { ElMessage.error(res.message || 'PPT解析失败'); event.target.value = ''; return }
  const data = toPascalCaseKeys(res.data || {})
  form.value.TitleEn = data.TitleEn || form.value.TitleEn
  form.value.LessonNo = data.LessonNo || form.value.LessonNo
  form.value.Category = data.Category || form.value.Category
  form.value.IssueSource = data.IssueSource || form.value.IssueSource
  form.value.IssueNo = data.IssueNo || form.value.IssueNo
  form.value.IssueType = data.IssueType || form.value.IssueType
  form.value.CPI = data.CPI || form.value.CPI
  form.value.Customer = data.Customer || form.value.Customer
  form.value.Program = data.Program || form.value.Program
  form.value.PartNo = data.PartNo || form.value.PartNo
  form.value.Plant = data.Plant || form.value.Plant
  if (data.ProductLine) form.value.ApplicableProductLines = Array.from(new Set([...(form.value.ApplicableProductLines || []), data.ProductLine]))
  if (data.IssueDescription?.length) form.value.IssueDescription = data.IssueDescription
  if (data.RootCause?.length) form.value.RootCause = data.RootCause
  if (data.CorrectiveActions?.length) form.value.CorrectiveActions = data.CorrectiveActions
  if (data.GlobalLessons?.length) form.value.GlobalLessons = data.GlobalLessons
  if (data.SupplementalNotes?.length) form.value.SupplementalNotes = data.SupplementalNotes
  ElMessage.success('PPT 内容已带入表单')
  event.target.value = ''
}
const generateLessonNo = async () => {
  const productPlatform = form.value.ProductPlatforms?.[0] || form.value.ProductPlatform || ''
  const category = form.value.Category || ''
  const res = await http.post('/api/LL_LessonLearn/GenerateLessonNo', { lessonLearn_Id: form.value.LessonLearn_Id || 0, productPlatform, category }, false)
  if (!res.status) { ElMessage.warning(res.message || '编号生成失败'); return }
  const data = toPascalCaseKeys(res.data || {})
  form.value.LessonNo = data.LessonNo || form.value.LessonNo
  ElMessage.success(res.message || '编号已生成')
}
const updateMetric = async (metric) => {
  if (!form.value.LessonLearn_Id || metric === 'view') return
  const res = await http.post(`/api/LL_LessonLearn/Metric/${form.value.LessonLearn_Id}/${metric}`, {}, false)
  if (res.status) mergeForm(toPascalCaseKeys(res.data))
}
const scrollToSection = (key) => document.getElementById(key)?.scrollIntoView({ behavior: 'smooth', block: 'start' })
const focusTagInput = () => tagSelectRef.value?.focus?.()
const goBack = () => router.push('/LL_LessonLearn')

const exportOnePage = () => {
  if (!form.value.LessonLearn_Id) {
    ElMessage.warning('请先保存或提交后，再导出 One Page 报告')
    return
  }
  const url = `${http.ipAddress}/api/LL_LessonLearn/ExportOnePage?id=${form.value.LessonLearn_Id}`
  window.open(url, '_blank')
}

const translateFormToEnglish = async () => {
  try {
    const fieldsEn2Zh = {}
    const fieldsZh2En = {}
    const mappers = {}

    // 收集所有四段内容中需要互译的字段
    const sections = ['IssueDescription', 'RootCause', 'CorrectiveActions', 'GlobalLessons', 'SupplementalNotes']
    sections.forEach((sec) => {
      if(form.value[sec]) {
        form.value[sec].forEach((item, idx) => {
          if (item.En && !item.Zh) {
            const key = `${sec}_${idx}_zh`
            fieldsEn2Zh[key] = item.En
            mappers[key] = { obj: item, target: 'Zh' }
          } else if (item.Zh && !item.En) {
            const key = `${sec}_${idx}_en`
            fieldsZh2En[key] = item.Zh
            mappers[key] = { obj: item, target: 'En' }
          }
        })
      }
    })

    if (Object.keys(fieldsEn2Zh).length === 0 && Object.keys(fieldsZh2En).length === 0) {
      ElMessage.success('全页字段目前皆已填满，无需自动翻译')
      return
    }
    
    ElMessage.info('AI 正在全篇翻译空缺字段，请稍候...')
    
    // 发送两轮翻译（根据方向）
    let hasError = false
    if (Object.keys(fieldsEn2Zh).length > 0) {
      const res = await http.post('/api/AI/TranslateForm', { fields: fieldsEn2Zh, direction: 'en2zh' }, false)
      if (res.status && res.data) {
        Object.entries(res.data).forEach(([k, v]) => { if (mappers[k]) mappers[k].obj[mappers[k].target] = v })
      } else { hasError = true }
    }
    
    if (Object.keys(fieldsZh2En).length > 0) {
      const res = await http.post('/api/AI/TranslateForm', { fields: fieldsZh2En, direction: 'zh2en' }, false)
      if (res.status && res.data) {
        Object.entries(res.data).forEach(([k, v]) => { if (mappers[k]) mappers[k].obj[mappers[k].target] = v })
      } else { hasError = true }
    }

    if (hasError) ElMessage.warning('部分段落翻译可能失败，请核实')
    else ElMessage.success('全页翻译自动补全完成，请检查后保存！')

  } catch (e) {
    ElMessage.error('调用 AI 服务异常: ' + e.message)
  }
}

const aiTranslateField = async (item, fieldType) => {
  if (!item.Zh && !item.En) {
    ElMessage.warning('请至少填写中英文之一')
    return
  }
  try {
    // 智能判断方向：有 En 无 Zh → en2zh；有 Zh 无 En → zh2en；两者都有 → 润色 En
    if (item.En && !item.Zh) {
      ElMessage.info('AI 正在将英文翻译为中文...')
      const res = await http.post('/api/AI/TranslateText', { text: item.En, direction: 'en2zh' }, false)
      if (res.status && res.data?.result) { item.Zh = res.data.result; ElMessage.success('翻译完成') }
      else { ElMessage.error(res.message || '翻译失败') }
    } else if (item.Zh && !item.En) {
      ElMessage.info('AI 正在将中文翻译为英文...')
      const res = await http.post('/api/AI/TranslateText', { text: item.Zh, direction: 'zh2en' }, false)
      if (res.status && res.data?.result) { item.En = res.data.result; ElMessage.success('翻译完成') }
      else { ElMessage.error(res.message || '翻译失败') }
    } else {
      ElMessage.info('AI 正在润色英文内容...')
      const res = await http.post('/api/AI/PolishText', { text: item.En, language: 'en' }, false)
      if (res.status && res.data?.result) { item.En = res.data.result; ElMessage.success('润色完成') }
      else { ElMessage.error(res.message || '润色失败') }
    }
  } catch (e) {
    ElMessage.error('AI 服务调用异常')
  }
}

const navigateToIssueSystem = (source, no) => {
  if (!no) {
    ElMessage.warning('请先输入 Issue No.')
    return
  }
  const targetUrl = source.toLowerCase().includes('deviation') 
    ? `http://nexteer.systems/deviation/${no}` 
    : `http://nexteer.systems/issue/${no}`
  window.open(targetUrl, '_blank')
}

watch(() => route.query.id, loadDetail)
watch(() => form.value.Plant, (next, prev) => {
  if (next === prev) return
  const options = workshopOptions.value
  if (form.value.Workshop && !options.includes(form.value.Workshop)) form.value.Workshop = ''
  const lineVals = lineOptions.value
  if (form.value.ProductionLine && !lineVals.includes(form.value.ProductionLine)) form.value.ProductionLine = ''
})
watch(() => form.value.Workshop, (next, prev) => {
  if (next === prev) return
  const options = lineOptions.value
  if (form.value.ProductionLine && !options.includes(form.value.ProductionLine)) form.value.ProductionLine = ''
})
watch(() => form.value.ProductPlatforms, (next) => {
  form.value.ProductPlatform = next?.[0] || ''
}, { deep: true })
watch(form, () => {
  if (suppressWatch.value) return
  clearTimeout(autoSaveTimer)
  autoSaveTimer = setTimeout(() => {
    if (form.value.TitleEn || form.value.LessonNo) saveDraft(true)
  }, 30000)
}, { deep: true })

onMounted(async () => {
  await loadMasterBundle()
  await loadDetail()
})
</script>

<style scoped>
.page{min-height:100%;background:radial-gradient(circle at top center,rgba(22,93,255,.08),transparent 24%),linear-gradient(180deg,#f7f9fd 0%,#eef2f7 100%)}
.layout{display:grid;grid-template-columns:280px minmax(0,1fr);gap:24px;padding:24px}
.side{position:sticky;top:18px;align-self:start}.main{display:grid;gap:18px}
.card,.hero{background:rgba(255,255,255,.94);border:1px solid rgba(15,23,42,.06);border-radius:22px;box-shadow:0 16px 38px rgba(15,23,42,.06)}
.nav{padding:18px}.nav-title{font-size:28px;font-weight:700;margin-bottom:14px;color:#101828}.nav-item{padding:12px 10px;border-radius:12px;color:#3b4a60;cursor:pointer}.nav-item:hover{background:#eef4ff;color:#165dff}
.hero{padding:24px 28px;border-radius:28px;background:linear-gradient(135deg,#fff 0%,#f3f8ff 100%);border-color:rgba(22,93,255,.08);box-shadow:0 18px 45px rgba(22,93,255,.08)}
.hero-top,.head,.block-head,.switch{display:flex;justify-content:space-between;align-items:center;gap:12px}.hero-top{align-items:flex-start}.meta,.actions,.toolbar,.wide-actions{display:flex;flex-wrap:wrap;gap:10px;align-items:center}.meta{margin-top:8px;color:#50627a}.meta span{cursor:pointer}
h1{margin:8px 0 10px;font-size:34px;line-height:1.2;color:#16315c}.toolbar{margin-top:18px;padding-top:18px;border-top:1px solid #e8edf5}.mini{width:140px}
.summary{display:grid;grid-template-columns:repeat(5,minmax(0,1fr));gap:16px}.stat{padding:18px 20px}.label{color:#667085;font-size:13px}.value{margin-top:8px;font-size:22px;font-weight:700;color:#111827}.value.small{font-size:14px;font-weight:500;line-height:1.6}
.panel{overflow:hidden}.head{padding:18px 22px;border-bottom:1px solid #edf2f7}.title,.subtitle{font-size:18px;font-weight:700;color:#0f172a}.body{padding:22px}.cols{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:18px}.inner{padding:18px}.subtitle{margin-bottom:14px}
.grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px}.chip-grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:12px}
.red{background:linear-gradient(90deg,rgba(245,63,63,.08),rgba(245,63,63,.02))}.amber{background:linear-gradient(90deg,rgba(255,125,0,.08),rgba(255,125,0,.02))}.green{background:linear-gradient(90deg,rgba(0,180,42,.08),rgba(0,180,42,.02))}.blue{background:linear-gradient(90deg,rgba(22,93,255,.08),rgba(22,93,255,.02))}
.block{padding:16px;border:1px solid #e7edf5;border-radius:16px;background:#fbfdff}.block+.block{margin-top:12px}.upload,.mini-grid,.pfmea-grid{margin-top:12px}.mini-grid,.pfmea-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:14px}.mini-title{margin-bottom:8px;color:#475467;font-size:13px;font-weight:600}
.file,.mini-row{display:grid;grid-template-columns:minmax(0,1fr) auto;gap:12px;align-items:center;padding:12px 0;border-bottom:1px solid #eef2f6}.file-name{font-weight:600;color:#111827}.muted{font-size:12px;color:#667085}.wide-actions{display:grid;grid-template-columns:220px 220px auto auto}
.pfmea-box{padding:14px;border-radius:16px;background:#f7faff;border:1px solid #e5efff}.score-grid{display:grid;grid-template-columns:repeat(3,minmax(140px,1fr));gap:12px;margin-top:10px}.score-item{display:grid;gap:8px}.score-label{font-size:12px;font-weight:600;color:#667085}.rpn{margin-top:14px;font-size:16px;font-weight:700;color:#165dff}.mt8{margin-top:8px}.hidden{display:none}
:deep(.score-item .el-input-number){width:100%}
@media (max-width:1440px){.layout{grid-template-columns:1fr}.side{position:static}.summary,.cols,.pfmea-grid{grid-template-columns:1fr}}
@media (max-width:960px){.layout{padding:12px}.grid,.chip-grid,.mini-grid,.wide-actions,.score-grid{grid-template-columns:1fr}h1{font-size:26px}.summary{grid-template-columns:1fr}}
.attachment-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:14px;margin-top:12px}
.attachment-card{border:1px solid #e7edf5;border-radius:14px;overflow:hidden;background:#fbfdff;transition:box-shadow .2s}.attachment-card:hover{box-shadow:0 8px 20px rgba(15,23,42,.08)}
.thumb{position:relative;height:140px;overflow:hidden;cursor:pointer;background:#f1f5f9;display:flex;align-items:center;justify-content:center}.thumb img{width:100%;height:100%;object-fit:cover}.thumb-overlay{position:absolute;inset:0;background:rgba(0,0,0,.4);color:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;opacity:0;transition:opacity .2s}.thumb:hover .thumb-overlay{opacity:1}
.pdf-thumb{background:linear-gradient(135deg,#fff1f0,#fef3f2)}.pdf-icon{font-size:32px;font-weight:800;color:#dc2626;letter-spacing:2px}
.file-info{padding:10px 12px}.file-name{font-weight:600;color:#111827;font-size:13px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.file-actions{display:flex;gap:8px;padding:0 12px 10px}
/* 产品线分组折叠样式 */
.pl-collapse{border:none}
:deep(.pl-collapse .el-collapse-item__header){background:#f8fafc;border-radius:12px;padding:4px 14px;border:1px solid #e7edf5;margin-bottom:6px;font-size:14px}
:deep(.pl-collapse .el-collapse-item__wrap){border:none;background:transparent}
:deep(.pl-collapse .el-collapse-item__content){padding:8px 14px 12px}
.pl-children{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:6px}
.pl-no-sub{color:#94a3b8;font-size:13px;padding:4px 0}
</style>
