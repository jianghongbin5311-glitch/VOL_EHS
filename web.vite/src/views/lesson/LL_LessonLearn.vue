<template>
  <div class="ll-page">
    <div class="ll-toolbar">
      <div class="toolbar-left">
        <el-input v-model="searchForm.keyword" placeholder="搜索 LL 编号/标题/标签" clearable style="width: 260px" />
        <el-input v-model="searchForm.tag" placeholder="标签" clearable style="width: 160px" />
        <el-select v-model="searchForm.category" placeholder="分类" clearable style="width: 140px">
          <el-option v-for="item in categoryOptions" :key="item" :label="item" :value="item" />
        </el-select>
        <el-select v-model="searchForm.lessonLevel" placeholder="LL属性" clearable style="width: 150px">
          <el-option v-for="item in lessonLevelOptions" :key="item" :label="item" :value="item" />
        </el-select>
        <el-select v-model="searchForm.status" placeholder="状态" clearable style="width: 140px">
          <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <el-select v-model="searchForm.isActive" placeholder="生效状态" clearable style="width: 140px">
          <el-option label="Active" :value="true" />
          <el-option label="Inactive" :value="false" />
        </el-select>
        <el-select v-model="searchForm.productLine" placeholder="产品线" clearable filterable style="width: 170px">
          <el-option v-for="item in productLineOptions" :key="item" :label="item" :value="item" />
        </el-select>
        <el-button type="primary" @click="loadList">查询</el-button>
        <el-button @click="resetSearch">重置</el-button>
      </div>
      <div class="toolbar-right">
        <el-button @click="exportExcel" :loading="exportLoading">导出 Excel</el-button>
        <el-button type="success" @click="openCreate">新建 Lesson Learn</el-button>
      </div>
    </div>

    <div class="ll-table">
      <el-tabs v-model="searchType" class="list-tabs" @tab-change="handleTabChange">
        <el-tab-pane label="所有数据" name="all" />
        <el-tab-pane label="我的收藏" name="favorite" />
        <el-tab-pane label="我的任务" name="task" />
      </el-tabs>
      <el-table :data="tableData" stripe border v-loading="listLoading" @row-click="openEdit">
        <el-table-column prop="LessonNo" label="LL编号" width="160" />
        <el-table-column label="标题" min-width="260">
          <template #default="{ row }">
            <div class="title-cell">{{ row.TitleEn || '-' }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="Category" label="分类" width="110" />
        <el-table-column prop="LessonLevel" label="LL属性" width="130" />
        <el-table-column prop="ProductPlatformsText" label="产品平台" min-width="160" />
        <el-table-column prop="ApplicableProductLinesText" label="适用产品线" min-width="180" />
        <el-table-column label="生效状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.IsActive === false ? 'info' : 'success'">{{ row.IsActive === false ? 'Inactive' : 'Active' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="statusTagType(row.Status)">{{ statusText(row.Status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="Progress" label="进度" width="90">
          <template #default="{ row }">{{ row.Progress || 0 }}%</template>
        </el-table-column>
        <el-table-column prop="ViewCount" label="浏览" width="70" />
        <el-table-column prop="FavoriteCount" label="收藏" width="70" />
        <el-table-column prop="LikeCount" label="点赞" width="70" />
        <el-table-column prop="VersionNo" label="版本" width="70" />
        <el-table-column prop="ModifyDate" label="最后修改" width="170">
          <template #default="{ row }">{{ formatDateTime(row.ModifyDate || row.CreateDate) }}</template>
        </el-table-column>
        <el-table-column label="操作" width="110" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click.stop="openEdit(row)">打开</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination-wrap">
        <el-pagination
          v-model:current-page="page.current"
          v-model:page-size="page.size"
          :total="page.total"
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next, jumper"
          @current-change="loadList"
          @size-change="loadList"
        />
      </div>
    </div>

    <el-drawer v-model="drawerVisible" :size="'88%'" destroy-on-close>
      <template #header>
        <div class="drawer-header">
          <div>
            <div class="drawer-title">{{ form.TitleEn || '新建 Lesson Learn' }}</div>
            <div class="drawer-subtitle">{{ form.TitleCn || '结构化沉淀经验教训、评审、任务与附件' }}</div>
          </div>
          <div class="drawer-actions">
            <span class="autosave-text">{{ autoSaveText }}</span>
            <input ref="pptInputRef" type="file" accept=".pptx" style="display: none" @change="parsePpt" />
            <el-button @click="triggerPptImport">导入PPT</el-button>
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
      </template>

      <div class="summary-cards">
        <div class="summary-card"><div class="label">状态</div><div class="value">{{ statusText(form.Status) }}</div></div>
        <div class="summary-card"><div class="label">完成进度</div><div class="value">{{ form.Progress || 0 }}%</div></div>
        <div class="summary-card"><div class="label">分析周期</div><div class="value">{{ form.AnalysisCycleDays || 0 }} 天</div></div>
        <div class="summary-card clickable" @click="updateMetric('favorite')"><div class="label">收藏次数</div><div class="value">{{ form.FavoriteCount || 0 }}</div></div>
        <div class="summary-card clickable" @click="updateMetric('like')"><div class="label">点赞次数</div><div class="value">{{ form.LikeCount || 0 }}</div></div>
        <div class="summary-card"><div class="label">浏览次数</div><div class="value">{{ form.ViewCount || 0 }}</div></div>
      </div>

      <el-tabs>
        <el-tab-pane label="基础信息">
          <div class="section-grid">
            <el-card>
              <template #header>标题与编号</template>
              <div class="form-grid">
                <div class="inline-field">
                  <el-input v-model="form.LessonNo" placeholder="LL-CEPS-D-001" />
                  <el-button @click="generateLessonNo">自动编号</el-button>
                </div>
                <el-select v-model="form.Category" placeholder="LL分类">
                  <el-option v-for="item in categoryOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-select v-model="form.LessonLevel" placeholder="LL属性">
                  <el-option v-for="item in lessonLevelOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-select v-model="form.ProductPlatforms" multiple filterable allow-create default-first-option placeholder="产品所属平台" collapse-tags collapse-tags-tooltip>
                  <el-option v-for="item in sharedProductPlatformOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-input v-model="form.TitleEn" placeholder="英文标题（必填）" />
                <el-input v-model="form.BasicInfo.VersionRemark" placeholder="版本备注 / Export Template Note" />
              </div>
            </el-card>

            <el-card>
              <template #header>问题发生位置与业务字段</template>
              <div class="form-grid">
                <div style="display:flex;gap:8px">
                  <el-select v-model="form.IssueSource" filterable allow-create default-first-option placeholder="Issue System" style="width:140px">
                    <el-option v-for="item in sharedIssueSourceOptions" :key="item" :label="item" :value="item" />
                  </el-select>
                  <el-input v-model="form.IssueNo" placeholder="Issue No." style="flex:1" />
                </div>
                <el-input v-model="form.IssueUrl" placeholder="Issue Link（自动/手动）" />
                <el-input v-model="form.IssueType" placeholder="Type / D/P/S/NC" />
                <el-select v-model="form.CpiProgram" filterable allow-create default-first-option placeholder="CPI# + Program Name" style="width:100%">
                  <el-option v-for="item in cpiProgramOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-input v-model="form.Customer" placeholder="Customer" />
                <el-input v-model="form.PartNo" placeholder="Part No." />
                <el-select v-model="form.PartVersion" clearable allow-create default-first-option placeholder="Part Version">
                  <el-option v-for="item in sharedPartVersionOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-select v-model="form.DiscoveryStage" clearable placeholder="Discovery Stage / 发现阶段">
                  <el-option v-for="item in sharedDiscoveryStageOptions" :key="item" :label="item" :value="item" />
                </el-select>
                <el-select v-model="form.Plant" clearable filterable placeholder="Plant / 工厂"><el-option v-for="item in plantOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-select v-model="form.Workshop" clearable filterable placeholder="Workshop / 车间"><el-option v-for="item in workshopOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-select v-model="form.ProductionLine" clearable filterable placeholder="Line / 线体"><el-option v-for="item in lineOptions" :key="item" :label="item" :value="item" /></el-select>
                <el-input v-model="form.CellName" placeholder="Cell / 工位" />
                <el-input v-model="form.ApprovalOwner" placeholder="Nexteer Issue Owner" />
              </div>
            </el-card>
          </div>

          <el-card class="mt16">
            <template #header>适用产品线与标签</template>
            <div class="section-grid">
              <div>
                <div class="field-title">适用产品线</div>
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
              <div>
                <div class="field-title">标签</div>
                <el-select v-model="form.Tags" multiple filterable allow-create default-first-option style="width: 100%" placeholder="请输入或选择标签">
                  <el-option-group v-for="group in tagGroupDefinitions" :key="group.key" :label="`${group.icon} ${group.label}`">
                    <el-option v-for="item in group.examples" :key="item" :label="item" :value="item" />
                  </el-option-group>
                  <el-option-group label="📌 其他" v-if="ungroupedTags.length > 0">
                    <el-option v-for="item in ungroupedTags" :key="item" :label="item" :value="item" />
                  </el-option-group>
                </el-select>
              </div>
            </div>
          </el-card>
        </el-tab-pane>

        <el-tab-pane label="四段内容">
          <div class="content-columns">
            <el-card>
              <template #header>
                问题描述
                <el-button type="primary" link @click="addTextBlock('IssueDescription')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.IssueDescription" :key="'issue-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('IssueDescription', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'IssueDescription', index)" />
                </div>
                <div class="attachment-list">
                  <div v-for="(img, imgIndex) in item.Images" :key="img.Path + imgIndex" class="attachment-row">
                    <div>{{ img.Name }}</div>
                    <div class="attachment-actions">
                      <el-input v-model="img.CaptionEn" placeholder="图片英文说明" size="small" />
                      <el-input v-model="img.CaptionZh" placeholder="图片中文说明" size="small" />
                      <el-button link @click="downloadAttachment(img)">下载</el-button>
                      <el-button type="danger" link @click="item.Images.splice(imgIndex, 1)">删除</el-button>
                    </div>
                  </div>
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                根本原因
                <el-button type="primary" link @click="addTextBlock('RootCause')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.RootCause" :key="'root-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('RootCause', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'RootCause', index)" />
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                纠正措施
                <el-button type="primary" link @click="addTextBlock('CorrectiveActions')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.CorrectiveActions" :key="'action-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('CorrectiveActions', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'CorrectiveActions', index)" />
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                全球经验教训
                <el-button type="primary" link @click="addTextBlock('GlobalLessons')">新增条目</el-button>
              </template>
              <div v-for="(item, index) in form.GlobalLessons" :key="'global-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>条目 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="removeTextBlock('GlobalLessons', index)">删除</el-button>
                </div>
                <el-input v-model="item.En" type="textarea" :rows="3" placeholder="English" />
                <el-input v-model="item.Zh" type="textarea" :rows="3" placeholder="中文" class="mt8" />
                <div class="upload-line">
                  <input type="file" multiple accept="image/*" @change="uploadSectionFiles($event, 'GlobalLessons', index)" />
                </div>
              </div>
            </el-card>
          </div>
        </el-tab-pane>

        <el-tab-pane label="文档与附件">
          <el-card>
            <template #header>标准文件清单与变更前后文件</template>
            <div class="section-grid">
              <el-select v-model="form.DocumentTypes" multiple placeholder="选择文件类型" style="width: 100%">
                <el-option v-for="item in currentDocumentTypeOptions" :key="item" :label="item" :value="item" />
              </el-select>
              <el-button type="primary" @click="addDocumentChange">新增变更条目</el-button>
            </div>
            <div v-for="(item, index) in form.DocumentChanges" :key="'doc-' + index" class="doc-card">
              <div class="block-toolbar">
                <span>变更条目 {{ index + 1 }}</span>
                <el-button type="danger" link @click="form.DocumentChanges.splice(index, 1)">删除</el-button>
              </div>
              <div class="form-grid">
                <el-input v-model="item.ChangeType" placeholder="文件类型" />
                <el-input v-model="item.BeforeFileName" placeholder="更改前文件名" />
                <el-input v-model="item.AfterFileName" placeholder="更改后文件名" />
              </div>
              <div class="section-grid mt8">
                <div>
                  <div class="field-title">更改前文件</div>
                  <input type="file" multiple @change="uploadDocumentFiles($event, item, 'BeforeFiles')" />
                </div>
                <div>
                  <div class="field-title">更改后文件</div>
                  <input type="file" multiple @change="uploadDocumentFiles($event, item, 'AfterFiles')" />
                </div>
              </div>
            </div>
          </el-card>

          <el-card class="mt16">
            <template #header>通用附件</template>
            <div class="section-grid">
              <input type="file" multiple @change="uploadGeneralFiles" />
              <el-button @click="downloadAll">下载全部</el-button>
            </div>
            <div class="attachment-grid">
              <div v-for="(item, index) in form.Attachments" :key="'file-' + index" class="attachment-card">
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
            <el-dialog v-model="imagePreviewVisible" title="图片预览" width="80%" append-to-body destroy-on-close>
              <img :src="imagePreviewUrl" style="width:100%;max-height:80vh;object-fit:contain" />
            </el-dialog>
            <el-dialog v-model="pdfPreviewVisible" title="PDF 预览" width="90%" top="3vh" append-to-body destroy-on-close>
              <iframe :src="pdfPreviewUrl" style="width:100%;height:80vh;border:none" />
            </el-dialog>
          </el-card>
        </el-tab-pane>

        <el-tab-pane label="评审与任务">
          <div class="section-grid">
            <el-card>
              <template #header>
                多轮评审
                <el-button type="primary" link @click="form.ReviewRecords.push(newReview())">新增评审</el-button>
              </template>
              <div v-for="(item, index) in form.ReviewRecords" :key="'review-' + index" class="block-card">
                <div class="block-toolbar">
                  <span>评审 {{ index + 1 }}</span>
                  <el-button type="danger" link @click="form.ReviewRecords.splice(index, 1)">删除</el-button>
                </div>
                <div class="form-grid">
                  <el-input v-model="item.Round" placeholder="轮次" />
                  <el-input v-model="item.ReviewDate" placeholder="日期" />
                  <el-input v-model="item.Reviewer" placeholder="评审人" />
                  <el-input v-model="item.ReviewerTitle" placeholder="职位" />
                  <el-input v-model="item.Result" placeholder="结果" />
                  <el-input v-model="item.Comments" placeholder="意见" />
                </div>
              </div>
            </el-card>

            <el-card>
              <template #header>
                参与人员
                <el-button type="primary" link @click="form.Participants.push(newParticipant())">新增人员</el-button>
              </template>
              <div v-for="(item, index) in form.Participants" :key="'person-' + index" class="mini-row">
                <el-input v-model="item.Name" placeholder="姓名" />
                <el-input v-model="item.Title" placeholder="职位" />
                <el-button type="danger" link @click="form.Participants.splice(index, 1)">删除</el-button>
              </div>
            </el-card>
          </div>

          <el-card class="mt16">
            <template #header>
              任务分配
              <el-button type="primary" link @click="form.Tasks.push(newTask())">新增任务</el-button>
            </template>
            <div v-for="(item, index) in form.Tasks" :key="'task-' + index" class="block-card">
              <div class="block-toolbar">
                <span>任务 {{ index + 1 }}</span>
                <el-button type="danger" link @click="form.Tasks.splice(index, 1)">删除</el-button>
              </div>
              <div class="form-grid">
                <el-input v-model="item.Title" placeholder="任务名称" />
                <el-input v-model="item.Owner" placeholder="责任人" />
                <el-input v-model="item.DueDate" placeholder="完成时间" />
                <el-input-number v-model="item.Progress" :min="0" :max="100" />
                <el-select v-model="item.Status" placeholder="任务状态">
                  <el-option label="待开始" value="待开始" />
                  <el-option label="进行中" value="进行中" />
                  <el-option label="待审批" value="待审批" />
                  <el-option label="已完成" value="已完成" />
                </el-select>
                <el-input v-model="item.Notes" placeholder="说明" />
              </div>
            </div>
          </el-card>
        </el-tab-pane>

        <el-tab-pane label="历史版本">
          <el-timeline>
            <el-timeline-item
              v-for="(item, index) in form.HistoryRecords"
              :key="'history-' + index"
              :timestamp="item.Time"
              placement="top"
            >
              <div class="history-item">
                <div>V{{ item.VersionNo }} / {{ item.Action }} / {{ item.StatusText }}</div>
                <div class="muted">{{ item.Operator }} {{ item.Comment || '' }}</div>
              </div>
            </el-timeline-item>
          </el-timeline>
        </el-tab-pane>

        <el-tab-pane label="FMEA分析">
          <div class="section-grid">
            <el-card>
              <template #header>PFMEA Analysis</template>
              <div class="form-grid">
                <div style="display:flex;gap:8px;align-items:center">
                  <span>启用 PFMEA</span>
                  <el-switch v-model="form.PfmeaEnabled" />
                </div>
                <el-input v-model="form.PfmeaDescription" type="textarea" :rows="2" placeholder="FMEA文件编号&版本号-Issue编号-Function-Failure" />
              </div>
              <div v-if="form.PfmeaEnabled" style="margin-top:12px">
                <div class="form-grid">
                  <div><div class="field-title">改善前</div>
                    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:8px">
                      <div><div class="muted">Severity</div><el-input-number v-model="form.PfmeaBefore.Severity" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Occurrence</div><el-input-number v-model="form.PfmeaBefore.Occurrence" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Detection</div><el-input-number v-model="form.PfmeaBefore.Detection" :min="0" :max="10" style="width:100%" /></div>
                    </div>
                    <div class="muted" style="margin-top:6px">RPN: {{ calcRpn(form.PfmeaBefore) }}</div>
                  </div>
                  <div><div class="field-title">改善后</div>
                    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:8px">
                      <div><div class="muted">Severity</div><el-input-number v-model="form.PfmeaAfter.Severity" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Occurrence</div><el-input-number v-model="form.PfmeaAfter.Occurrence" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Detection</div><el-input-number v-model="form.PfmeaAfter.Detection" :min="0" :max="10" style="width:100%" /></div>
                    </div>
                    <div class="muted" style="margin-top:6px">RPN: {{ calcRpn(form.PfmeaAfter) }}</div>
                  </div>
                </div>
              </div>
            </el-card>
            <el-card>
              <template #header>DFMEA Analysis</template>
              <div class="form-grid">
                <div style="display:flex;gap:8px;align-items:center">
                  <span>启用 DFMEA</span>
                  <el-switch v-model="form.DfmeaEnabled" />
                </div>
                <el-input v-model="form.DfmeaDescription" type="textarea" :rows="2" placeholder="FMEA文件编号&版本号-Issue编号-Function-Failure" />
              </div>
              <div v-if="form.DfmeaEnabled" style="margin-top:12px">
                <div class="form-grid">
                  <div><div class="field-title">改善前</div>
                    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:8px">
                      <div><div class="muted">Severity</div><el-input-number v-model="form.DfmeaBefore.Severity" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Occurrence</div><el-input-number v-model="form.DfmeaBefore.Occurrence" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Detection</div><el-input-number v-model="form.DfmeaBefore.Detection" :min="0" :max="10" style="width:100%" /></div>
                    </div>
                    <div class="muted" style="margin-top:6px">RPN: {{ calcRpn(form.DfmeaBefore) }}</div>
                  </div>
                  <div><div class="field-title">改善后</div>
                    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:8px">
                      <div><div class="muted">Severity</div><el-input-number v-model="form.DfmeaAfter.Severity" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Occurrence</div><el-input-number v-model="form.DfmeaAfter.Occurrence" :min="0" :max="10" style="width:100%" /></div>
                      <div><div class="muted">Detection</div><el-input-number v-model="form.DfmeaAfter.Detection" :min="0" :max="10" style="width:100%" /></div>
                    </div>
                    <div class="muted" style="margin-top:6px">RPN: {{ calcRpn(form.DfmeaAfter) }}</div>
                  </div>
                </div>
              </div>
            </el-card>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-drawer>
  </div>
</template>

<script setup>
import { nextTick, onMounted, reactive, ref, watch, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import http from '@/api/http.js'
import {
  calcRpn,
  categoryOptions as sharedCategoryOptions,
  defaultTextBlock as sharedDefaultTextBlock,
  discoveryStageOptions as sharedDiscoveryStageOptions,
  documentTypeOptions as defaultDocumentTypeOptions,
  emptyForm as sharedEmptyForm,
  formatDateTime as sharedFormatDateTime,
  formatSize as sharedFormatSize,
  issueSourceOptions as sharedIssueSourceOptions,
  lessonLevelOptions as sharedLessonLevelOptions,
  newDocumentChange as sharedNewDocumentChange,
  newParticipant as sharedNewParticipant,
  newReview as sharedNewReview,
  newTask as sharedNewTask,
  partVersionOptions as sharedPartVersionOptions,
  productLineOptions as defaultProductLineOptions,
  productPlatformOptions as sharedProductPlatformOptions,
  statusTagType as sharedStatusTagType,
  statusText as sharedStatusText,
  suggestedTags as defaultSuggestedTags,
  tagGroupDefinitions,
  productLineTree
} from './lessonLearnShared'

const statusOptions = [
  { label: '编辑中', value: 0 },
  { label: '待审核', value: 1 },
  { label: '已驳回', value: 2 },
  { label: '已发布', value: 3 }
]
const categoryOptions = sharedCategoryOptions
const lessonLevelOptions = sharedLessonLevelOptions
const currentProductLineOptions = ref([...defaultProductLineOptions])
const currentTagSuggestions = ref([...defaultSuggestedTags])
const currentDocumentTypeOptions = ref([...defaultDocumentTypeOptions])
const cpiProgramOptions = ref(['3373-PSA-A51-Halfshafts-BR', '5005-Chery-T21-CEPS-SU', '5123-Suzuki-YV7-CIS-IN'])
const masterBundle = ref({ plants: [], workshops: [], lines: [] })

const listLoading = ref(false)
const saveLoading = ref(false)
const exportLoading = ref(false)
const drawerVisible = ref(false)
const tableData = ref([])
const pptInputRef = ref(null)
const autoSaveText = ref('自动保存未开始')
const suppressWatch = ref(false)
let autoSaveTimer = null
const router = useRouter()

const searchForm = reactive({ keyword: '', tag: '', category: '', lessonLevel: '', status: null, isActive: null, productLine: '' })
const searchType = ref('all')
const page = reactive({ current: 1, size: 10, total: 0 })

const defaultTextBlock = sharedDefaultTextBlock
const newReview = sharedNewReview
const newParticipant = sharedNewParticipant
const newTask = sharedNewTask
const newDocumentChange = sharedNewDocumentChange
const emptyForm = sharedEmptyForm

const form = ref(emptyForm())

const toNames = (rows, field = 'DataName') => (rows || []).map(item => item?.[field] || item?.dataName).filter(Boolean)
const appendCurrent = (values, current) => current && !values.includes(current) ? [...values, current] : values
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

const keyAliasMap = {
  cpi: 'CPI',
  createId: 'CreateID',
  modifyId: 'ModifyID',
  pfmeaEnabled: 'PfmeaEnabled',
  pfmeaDescription: 'PfmeaDescription',
  pfmeaBefore: 'PfmeaBefore',
  pfmeaAfter: 'PfmeaAfter',
  dfmeaEnabled: 'DfmeaEnabled',
  dfmeaDescription: 'DfmeaDescription',
  dfmeaBefore: 'DfmeaBefore',
  dfmeaAfter: 'DfmeaAfter',
  issueUrl: 'IssueUrl',
  partVersion: 'PartVersion',
  productPlatforms: 'ProductPlatforms',
  cpiProgram: 'CpiProgram',
  isActive: 'IsActive',
  discoveryStage: 'DiscoveryStage'
}

const toPascalCaseKeys = (value) => {
  if (Array.isArray(value)) {
    return value.map((item) => toPascalCaseKeys(item))
  }
  if (!value || Object.prototype.toString.call(value) !== '[object Object]') {
    return value
  }
  return Object.keys(value).reduce((result, key) => {
    const normalizedKey = keyAliasMap[key] || (key ? `${key.charAt(0).toUpperCase()}${key.slice(1)}` : key)
    result[normalizedKey] = toPascalCaseKeys(value[key])
    return result
  }, {})
}

const statusText = sharedStatusText
const statusTagType = sharedStatusTagType
const formatDateTime = sharedFormatDateTime
const formatSize = sharedFormatSize

const loadMasterBundle = async () => {
  const res = await http.get('/api/LL_MasterData/Bundle', {}, false)
  if (res.status) {
    const data = res.data || {}
    masterBundle.value = data
    const plRows = data.productLines || data.ProductLines || []
    const plValues = plRows.map((item) => item.dataName || item.DataName).filter(Boolean)
    if (plValues.length) currentProductLineOptions.value = plValues
    const tagRows = data.tagSuggestions || data.TagSuggestions || []
    const tagValues = tagRows.map((item) => item.dataName || item.DataName).filter(Boolean)
    if (tagValues.length) currentTagSuggestions.value = tagValues
    const docRows = data.documentTypes || data.DocumentTypes || []
    const docValues = docRows.map((item) => item.dataName || item.DataName).filter(Boolean)
    if (docValues.length) currentDocumentTypeOptions.value = docValues
    const cpiRows = data.cpiPrograms || data.CpiPrograms || []
    const cpiValues = cpiRows.map((item) => item.dataName || item.DataName).filter(Boolean)
    if (cpiValues.length) cpiProgramOptions.value = cpiValues
  }
}

const handleTabChange = () => {
  page.current = 1
  loadList()
}

const loadList = async () => {
  listLoading.value = true
  try {
    const res = await http.post('/api/LL_LessonLearn/Search', {
      page: page.current,
      pageSize: page.size,
      keyword: searchForm.keyword,
      tag: searchForm.tag,
      category: searchForm.category,
      lessonLevel: searchForm.lessonLevel,
      status: searchForm.status,
      isActive: searchForm.isActive,
      productLine: searchForm.productLine,
      listType: searchType.value
    }, false)
    if (res.status) {
      const data = toPascalCaseKeys(res.data || {})
      tableData.value = data.Items || []
      page.total = data.Total || 0
      
      // ==== Mock Data 注入开始 (应对空数据库展示需求) ====
      if (tableData.value.length === 0) {
        tableData.value = [
          { LessonLearn_Id: 101, LessonNo: 'LL-CEPS-001', TitleEn: 'Torque Sensor Connector Issue Resolving', Category: 'Issue', LessonLevel: 'P0', ProductPlatformsText: 'Global CEPS', ApplicableProductLinesText: 'Chery, GM', IsActive: true, Status: 3, Progress: 100, ViewCount: 204, FavoriteCount: 15, LikeCount: 45, VersionNo: 'V2', CreateDate: '2026-03-01T10:00:00Z', ModifyDate: '2026-04-10T15:30:00Z' },
          { LessonLearn_Id: 102, LessonNo: 'LL-REPS-005', TitleEn: 'Ball Nut Machining Tool Life Improvement', Category: 'Improvement', LessonLevel: 'P1', ProductPlatformsText: 'REPS', ApplicableProductLinesText: 'VW, Ford', IsActive: true, Status: 1, Progress: 50, ViewCount: 56, FavoriteCount: 2, LikeCount: 8, VersionNo: 'V1', CreateDate: '2026-04-05T09:12:00Z', ModifyDate: '2026-04-15T11:20:00Z' },
          { LessonLearn_Id: 103, LessonNo: 'LL-MTR-012', TitleEn: 'Stator Winding Defect RCA', Category: 'Quality Issue', LessonLevel: 'P1', ProductPlatformsText: 'Motor', ApplicableProductLinesText: 'All Lines', IsActive: false, Status: 0, Progress: 10, ViewCount: 12, FavoriteCount: 0, LikeCount: 0, VersionNo: 'V1', CreateDate: '2026-04-12T14:45:00Z', ModifyDate: '2026-04-14T08:00:00Z' },
          { LessonLearn_Id: 104, LessonNo: 'LL-SYS-008', TitleEn: 'Steering ECU Thermal Resistance Test Note', Category: 'Software/System', LessonLevel: 'P2', ProductPlatformsText: 'ECU', ApplicableProductLinesText: 'Generic', IsActive: true, Status: 3, Progress: 100, ViewCount: 430, FavoriteCount: 32, LikeCount: 110, VersionNo: 'V1', CreateDate: '2025-11-20T10:00:00Z', ModifyDate: '2026-01-05T15:30:00Z' },
          { LessonLearn_Id: 105, LessonNo: 'LL-REPS-018', TitleEn: 'Belt Drive Belt Tension Validation', Category: 'Best Practice', LessonLevel: 'P0', ProductPlatformsText: 'REPS', ApplicableProductLinesText: 'Stellantis', IsActive: true, Status: 3, Progress: 100, ViewCount: 120, FavoriteCount: 5, LikeCount: 22, VersionNo: 'V3', CreateDate: '2026-02-14T09:30:00Z', ModifyDate: '2026-04-01T10:15:00Z' }
        ]
        if (searchType.value === 'favorite') { tableData.value = [tableData.value[0], tableData.value[3]] }
        if (searchType.value === 'task') { tableData.value = [tableData.value[1], tableData.value[2]] }
        page.total = tableData.value.length
      }
      // ==== Mock Data 注入结束 ====
    }
  } finally {
    listLoading.value = false
  }
}

const resetSearch = () => {
  searchForm.keyword = ''
  searchForm.tag = ''
  searchForm.category = ''
  searchForm.lessonLevel = ''
  searchForm.status = null
  searchForm.isActive = null
  searchForm.productLine = ''
  page.current = 1
  loadList()
}

const mergeForm = (data) => {
  suppressWatch.value = true
  form.value = Object.assign(emptyForm(), data || {})
  form.value.ApplicableProductLines ||= []
  form.value.Tags ||= []
  form.value.ProductPlatforms ||= []
  if (!form.value.ProductPlatforms.length && form.value.ProductPlatform) form.value.ProductPlatforms = [form.value.ProductPlatform]
  form.value.IssueDescription = form.value.IssueDescription?.length ? form.value.IssueDescription : [defaultTextBlock()]
  form.value.RootCause = form.value.RootCause?.length ? form.value.RootCause : [defaultTextBlock()]
  form.value.CorrectiveActions = form.value.CorrectiveActions?.length ? form.value.CorrectiveActions : [defaultTextBlock()]
  form.value.GlobalLessons = form.value.GlobalLessons?.length ? form.value.GlobalLessons : [defaultTextBlock()]
  form.value.SupplementalNotes ||= []
  form.value.DocumentTypes ||= []
  form.value.DocumentChanges ||= []
  form.value.Attachments ||= []
  form.value.ReviewRecords ||= []
  form.value.Participants ||= []
  form.value.Tasks ||= []
  form.value.HistoryRecords ||= []
  nextTick(() => {
    suppressWatch.value = false
  })
}

const openCreate = () => {
  router.push('/LL_CaseDetail')
}

const openEdit = async (row) => {
  const id = row?.LessonLearn_Id || row
  router.push({ path: '/LL_CaseDetail', query: { id } })
}

const addTextBlock = (field) => {
  form.value[field].push({ ...defaultTextBlock(), Sort: form.value[field].length + 1 })
}

const removeTextBlock = (field, index) => {
  form.value[field].splice(index, 1)
  if (!form.value[field].length) {
    form.value[field].push(defaultTextBlock())
  }
}

const uploadFiles = async (files) => {
  const forms = new FormData()
  Array.from(files).forEach((file) => forms.append('fileInput', file, file.name))
  const result = await http.post('/api/LL_LessonLearn/Upload', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
  if (!result.status) {
    throw new Error(result.message || '上传失败')
  }
  return Array.from(files).map((file) => ({
    Category: '',
    Name: file.name,
    Path: `${result.data || ''}${file.name}`,
    Size: file.size,
    DownloadCount: 0,
    UploadTime: new Date().toLocaleString(),
    CaptionEn: '',
    CaptionZh: ''
  }))
}

const uploadSectionFiles = async (event, field, index) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const rows = await uploadFiles(files)
    form.value[field][index].Images.push(...rows)
    ElMessage.success('图片上传成功')
  } catch (error) {
    ElMessage.error(error.message || '图片上传失败')
  } finally {
    event.target.value = ''
  }
}

const uploadDocumentFiles = async (event, item, field) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const rows = await uploadFiles(files)
    item[field].push(...rows)
    ElMessage.success('文件上传成功')
  } catch (error) {
    ElMessage.error(error.message || '文件上传失败')
  } finally {
    event.target.value = ''
  }
}

const uploadGeneralFiles = async (event) => {
  const files = event.target.files
  if (!files?.length) return
  try {
    const rows = await uploadFiles(files)
    form.value.Attachments.push(...rows)
    ElMessage.success('附件上传成功')
  } catch (error) {
    ElMessage.error(error.message || '附件上传失败')
  } finally {
    event.target.value = ''
  }
}

const normalizePayload = () => JSON.parse(JSON.stringify(form.value))

const saveDraft = async (silent = false) => {
  if (saveLoading.value) return
  saveLoading.value = !silent
  try {
    const res = await http.post('/api/LL_LessonLearn/SaveDraft', normalizePayload(), false)
    if (!res.status) {
      if (!silent) ElMessage.error(res.message || '保存失败')
      return
    }
    mergeForm(toPascalCaseKeys(res.data))
    autoSaveText.value = `最近保存：${new Date().toLocaleTimeString()}`
    if (!silent) {
      ElMessage.success(res.message || '保存成功')
      loadList()
    }
  } finally {
    saveLoading.value = false
  }
}

const postAction = async (path, message) => {
  if (!form.value.LessonLearn_Id) {
    ElMessage.warning('请先保存记录')
    return
  }
  const res = await http.post(path, { comment: '' }, false)
  if (!res.status) {
    ElMessage.error(res.message || '操作失败')
    return
  }
  mergeForm(toPascalCaseKeys(res.data))
  ElMessage.success(message)
  loadList()
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
    loadList()
  } catch (error) {
    if (error !== 'cancel') ElMessage.error(error?.message || `${actionText}失败`)
  }
}

const generateLessonNo = async () => {
  const productLine = form.value.ApplicableProductLines?.[0] || ''
  const category = form.value.Category || ''
  const res = await http.post('/api/LL_LessonLearn/GenerateLessonNo', {
    lessonLearn_Id: form.value.LessonLearn_Id || 0,
    productLine,
    category
  }, false)
  if (!res.status) {
    ElMessage.warning(res.message || '编号生成失败')
    return
  }
  const data = toPascalCaseKeys(res.data || {})
  form.value.LessonNo = data.LessonNo || form.value.LessonNo
  ElMessage.success(res.message || '编号已生成')
}

const updateMetric = async (metric) => {
  if (!form.value.LessonLearn_Id) {
    ElMessage.warning('请先保存记录')
    return
  }
  const res = await http.post(`/api/LL_LessonLearn/Metric/${form.value.LessonLearn_Id}/${metric}`, {}, false)
  if (res.status) {
    mergeForm(toPascalCaseKeys(res.data))
  }
}

const addDocumentChange = () => form.value.DocumentChanges.push(newDocumentChange())

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

const downloadAll = () => {
  form.value.Attachments.forEach((item) => downloadAttachment(item))
}

const triggerPptImport = () => {
  pptInputRef.value?.click()
}

const parsePpt = async (event) => {
  const file = event.target.files?.[0]
  if (!file) return
  const forms = new FormData()
  forms.append('file', file)
  const res = await http.post('/api/LL_LessonLearn/ParsePpt', forms, false, { headers: { 'Content-Type': 'multipart/form-data' } })
  if (!res.status) {
    ElMessage.error(res.message || 'PPT解析失败')
    event.target.value = ''
    return
  }
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
  if (data.ProductLine) {
    form.value.ApplicableProductLines = Array.from(new Set([...(form.value.ApplicableProductLines || []), data.ProductLine]))
  }
  if (data.IssueDescription?.length) form.value.IssueDescription = data.IssueDescription
  if (data.RootCause?.length) form.value.RootCause = data.RootCause
  if (data.CorrectiveActions?.length) form.value.CorrectiveActions = data.CorrectiveActions
  if (data.GlobalLessons?.length) form.value.GlobalLessons = data.GlobalLessons
  if (data.SupplementalNotes?.length) form.value.SupplementalNotes = data.SupplementalNotes
  ElMessage.success('PPT 内容已带入表单')
  event.target.value = ''
}

const scheduleAutoSave = () => {
  if (suppressWatch.value || !drawerVisible.value) return
  clearTimeout(autoSaveTimer)
  autoSaveTimer = setTimeout(() => {
    if (form.value.TitleEn || form.value.TitleCn || form.value.LessonNo) {
      saveDraft(true)
    }
  }, 30000)
}

watch(form, () => {
  scheduleAutoSave()
}, { deep: true })

watch(drawerVisible, (visible) => {
  if (!visible) {
    clearTimeout(autoSaveTimer)
  }
})

const exportExcel = async () => {
  exportLoading.value = true
  try {
    const params = new URLSearchParams()
    if (searchForm.keyword) params.append('keyword', searchForm.keyword)
    if (searchForm.tag) params.append('tag', searchForm.tag)
    if (searchForm.category) params.append('category', searchForm.category)
    if (searchForm.lessonLevel) params.append('lessonLevel', searchForm.lessonLevel)
    if (searchForm.status !== null && searchForm.status !== undefined) params.append('status', searchForm.status)
    if (searchForm.isActive !== null && searchForm.isActive !== undefined) params.append('isActive', searchForm.isActive)
    if (searchForm.productLine) params.append('productLine', searchForm.productLine)
    if (searchType.value) params.append('listType', searchType.value)
    const url = `${http.ipAddress}/api/LL_LessonLearn/ExportExcel?${params.toString()}`
    window.open(url, '_blank')
    ElMessage.success('导出请求已发送')
  } catch (e) {
    ElMessage.error('导出失败')
  } finally {
    exportLoading.value = false
  }
}

// Tree logic for product lines
const productLineTreeData = computed(() => productLineTree)
const isGroupAllChecked = (group) => {
  const targets = group.children.length ? group.children : [group.label]
  return targets.every(c => (form.value.ApplicableProductLines || []).includes(c))
}
const isGroupIndeterminate = (group) => {
  const targets = group.children.length ? group.children : [group.label]
  const checked = targets.filter(c => (form.value.ApplicableProductLines || []).includes(c))
  return checked.length > 0 && checked.length < targets.length
}
const getGroupCheckedCount = (group) => {
  const targets = group.children.length ? group.children : [group.label]
  return targets.filter(c => (form.value.ApplicableProductLines || []).includes(c)).length
}
const toggleGroup = (group, checked) => {
  const targets = group.children.length ? group.children : [group.label]
  const current = new Set(form.value.ApplicableProductLines || [])
  targets.forEach(t => { if (checked) current.add(t); else current.delete(t) })
  form.value.ApplicableProductLines = [...current]
}

// ungroupedTags logic
const ungroupedTags = computed(() => {
  const grouped = new Set(tagGroupDefinitions.flatMap(g => g.examples))
  const allCurrent = new Set([...currentTagSuggestions.value, ...(form.value.Tags || [])])
  return Array.from(allCurrent).filter(t => !grouped.has(t))
})

// Attachments preview logic
const imagePreviewVisible = ref(false)
const imagePreviewUrl = ref('')
const pdfPreviewVisible = ref(false)
const pdfPreviewUrl = ref('')
const isImage = (name) => /\.(jpe?g|png|gif|bmp|webp|svg|tif|tiff)$/i.test(name || '')
const isPdf = (name) => /\.pdf$/i.test(name || '')
const previewImage = (item) => { 
  imagePreviewUrl.value = buildFileUrl(item.Path)
  imagePreviewVisible.value = true 
}
const previewPdf = (item) => { 
  pdfPreviewUrl.value = buildFileUrl(item.Path)
  pdfPreviewVisible.value = true 
}

onMounted(async () => {
  await loadMasterBundle()
  await loadList()
})
</script>

<style scoped>
.ll-page {
  padding: 16px;
}
.ll-toolbar {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 16px;
}
.toolbar-left {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}
.ll-table {
  background: #fff;
  padding: 16px;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(15, 23, 42, 0.06);
}
.pagination-wrap {
  margin-top: 16px;
  display: flex;
  justify-content: flex-end;
}
.title-cell {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
.title-cn,
.muted {
  color: #6b7280;
  font-size: 12px;
}
.drawer-header {
  width: 100%;
  display: flex;
  justify-content: space-between;
  gap: 16px;
}
.drawer-title {
  font-size: 20px;
  font-weight: 700;
}
.drawer-subtitle,
.autosave-text {
  color: #6b7280;
  font-size: 12px;
}
.drawer-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
}
.summary-cards {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 12px;
  margin-bottom: 16px;
}
.summary-card {
  padding: 12px 14px;
  border-radius: 10px;
  background: linear-gradient(180deg, #f8fafc 0%, #eef2ff 100%);
}
.summary-card.clickable {
  cursor: pointer;
}
.summary-card .label {
  font-size: 12px;
  color: #6b7280;
}
.summary-card .value {
  margin-top: 6px;
  font-size: 22px;
  font-weight: 700;
}
.section-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}
.form-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 12px;
}
.field-title {
  margin-bottom: 8px;
  font-size: 13px;
  font-weight: 600;
}
.inline-field {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 8px;
}
.option-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 8px;
}
.content-columns {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}
.block-card,
.doc-card {
  padding: 12px;
  margin-bottom: 12px;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
}
.block-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  font-weight: 600;
}
.upload-line,
.attachment-list {
  margin-top: 8px;
}
.attachment-row,
.mini-row {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 12px;
  align-items: center;
  padding: 10px 0;
  border-bottom: 1px solid #eef2f7;
}
.attachment-actions {
  display: flex;
  gap: 8px;
  align-items: center;
}
.history-item {
  line-height: 1.7;
}
.mt8 {
  margin-top: 8px;
}
.mt16 {
  margin-top: 16px;
}
@media (max-width: 1200px) {
  .summary-cards,
  .section-grid,
  .content-columns,
  .form-grid {
    grid-template-columns: 1fr;
  }
  .option-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}
.list-tabs{margin-bottom:16px;}
.attachment-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:14px;margin-top:12px}
.attachment-card{border:1px solid #e7edf5;border-radius:14px;overflow:hidden;background:#fbfdff;transition:box-shadow .2s}.attachment-card:hover{box-shadow:0 8px 20px rgba(15,23,42,.08)}
.thumb{position:relative;height:140px;overflow:hidden;cursor:pointer;background:#f1f5f9;display:flex;align-items:center;justify-content:center}.thumb img{width:100%;height:100%;object-fit:cover}.thumb-overlay{position:absolute;inset:0;background:rgba(0,0,0,.4);color:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;opacity:0;transition:opacity .2s}.thumb:hover .thumb-overlay{opacity:1}
.pdf-thumb{background:linear-gradient(135deg,#fff1f0,#fef3f2)}.pdf-icon{font-size:32px;font-weight:800;color:#dc2626;letter-spacing:2px}
.file-info{padding:10px 12px}.file-name{font-weight:600;color:#111827;font-size:13px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.file-actions{display:flex;gap:8px;padding:0 12px 10px}

/* 产品线分组折叠样式 */
.pl-collapse{border:none;margin-top:8px}
:deep(.pl-collapse .el-collapse-item__header){background:#f8fafc;border-radius:12px;padding:4px 14px;border:1px solid #e7edf5;margin-bottom:6px;font-size:14px}
:deep(.pl-collapse .el-collapse-item__wrap){border:none;background:transparent}
:deep(.pl-collapse .el-collapse-item__content){padding:8px 14px 12px}
.pl-children{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:6px}
.pl-no-sub{color:#94a3b8;font-size:13px;padding:4px 0}
</style>
