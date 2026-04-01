import json
import re
from html import unescape
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE_JSON = ROOT.parent / "LL_System_Final_V5" / "data.json"
TARGET_SQL = ROOT / "db" / "sqlserver" / "51_lesson_learn_migrate_from_v5.sql"


def sql_text(value):
    if value is None:
        return "NULL"
    text = str(value).replace("'", "''")
    return f"N'{text}'"


def sql_number(value):
    if value is None:
        return "NULL"
    return str(int(value))


def split_html_blocks(raw_html):
    if not raw_html:
        return []
    text = str(raw_html)
    text = re.sub(r"(?i)<br\s*/?>", "\n", text)
    text = re.sub(r"(?i)</p\s*>", "\n", text)
    text = re.sub(r"<[^>]+>", "", text)
    text = unescape(text)
    lines = [line.strip() for line in text.splitlines()]
    return [line for line in lines if line]


def old_status_comment(row):
    legacy_status = ((row.get("tags") or {}).get("status") or {}).get("selected") or row.get("status") or ""
    if not legacy_status:
        return "迁移自 V5"
    return f"迁移自 V5；旧系统状态：{legacy_status}"


def collect_tags(row):
    tags = []
    payload = row.get("tags") or {}
    categories = (payload.get("categories") or {}).get("selected") or []
    categories_special = (payload.get("categories") or {}).get("special") or []
    tags.extend([x for x in categories if x])
    tags.extend([x for x in categories_special if x])
    legacy_status = (payload.get("status") or {}).get("selected") or row.get("status")
    if legacy_status:
        tags.append(f"LegacyStatus:{legacy_status}")
    return dedupe(tags)


def collect_product_lines(row):
    payload = row.get("tags") or {}
    selected = (payload.get("product_lines") or {}).get("selected") or []
    special = (payload.get("product_lines") or {}).get("special") or []
    return dedupe([x for x in [*selected, *special] if x])


def dedupe(values):
    seen = set()
    result = []
    for item in values:
        key = str(item).strip()
        if not key or key in seen:
            continue
        seen.add(key)
        result.append(key)
    return result


def map_review(review):
    if not review:
        return None
    return {
        "round": "",
        "date": review.get("date") or "",
        "reviewer": review.get("reviewer") or "",
        "title": "",
        "result": review.get("result") or "",
        "comments": review.get("comments") or ""
    }


def map_file(file_item):
    if not file_item:
        return None
    return {
        "category": "LegacyAttachment",
        "name": file_item.get("name") or "",
        "path": file_item.get("path") or "",
        "size": file_item.get("size") or 0,
        "caption_en": "Migrated from V5",
        "caption_zh": "从V5迁移"
    }


def build_record_sql(row):
    lesson_no = row.get("ll_number") or f"V5-{row.get('id')}"
    title_en = row.get("title") or ""
    category = row.get("category") or ""
    production_line = row.get("line") or ""
    issue_source = row.get("issue_source") or ""
    issue_no = row.get("issue_no") or ""
    issue_type = row.get("issue_type") or ""
    cpi = row.get("cpi") or ""
    customer = row.get("customer") or ""
    program = row.get("program") or ""
    part_no = row.get("part_no") or ""
    plant = row.get("plant") or ""
    create_date = row.get("created_at") or None
    product_lines = collect_product_lines(row)
    tags = collect_tags(row)
    blocks = {
        "IssueDescription": split_html_blocks(row.get("rich_content")),
        "RootCause": split_html_blocks(row.get("root_cause")),
        "CorrectiveActions": split_html_blocks(row.get("actions")),
        "GlobalLessons": split_html_blocks(row.get("global_ll")),
        "SupplementalNotes": split_html_blocks(row.get("supplemental_notes")),
    }
    reviews = [map_review(x) for x in (row.get("reviews") or [])]
    reviews = [x for x in reviews if x]
    files = [map_file(x) for x in (row.get("files") or [])]
    files = [x for x in files if x and x["name"]]
    version_remark = old_status_comment(row)

    lines = []
    lines.append(f"-- V5记录ID: {row.get('id')}, LL编号: {lesson_no}")
    lines.append("BEGIN TRY")
    lines.append("    BEGIN TRAN;")
    lines.append("    DECLARE @LessonLearn_Id INT;")
    lines.append("")
    lines.append(f"    IF EXISTS (SELECT 1 FROM dbo.LL_LessonLearn WHERE LessonNo = {sql_text(lesson_no)})")
    lines.append("    BEGIN")
    lines.append(f"        SELECT @LessonLearn_Id = LessonLearn_Id FROM dbo.LL_LessonLearn WHERE LessonNo = {sql_text(lesson_no)};")
    lines.append("        DELETE FROM dbo.LL_LessonLearnFile WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnDocumentType WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnReview WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnParticipant WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnTask WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnContent WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnDocumentChange WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnProductLine WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnTag WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("        DELETE FROM dbo.LL_LessonLearnVersion WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("")
    lines.append("        UPDATE dbo.LL_LessonLearn")
    lines.append("        SET")
    lines.append(f"            TitleEn = {sql_text(title_en)},")
    lines.append("            TitleCn = NULL,")
    lines.append(f"            Category = {sql_text(category)},")
    lines.append("            ProductPlatform = NULL,")
    lines.append("            LlGroup = NULL,")
    lines.append(f"            IssueSource = {sql_text(issue_source)},")
    lines.append(f"            IssueNo = {sql_text(issue_no)},")
    lines.append(f"            IssueType = {sql_text(issue_type)},")
    lines.append(f"            CPI = {sql_text(cpi)},")
    lines.append(f"            Customer = {sql_text(customer)},")
    lines.append(f"            Program = {sql_text(program)},")
    lines.append(f"            PartNo = {sql_text(part_no)},")
    lines.append(f"            Plant = {sql_text(plant)},")
    lines.append(f"            ProductionLine = {sql_text(production_line)},")
    lines.append("            CellName = NULL,")
    lines.append("            ApprovalOwner = N'PL APQP',")
    lines.append("            LlCategoryCode = NULL,")
    lines.append("            LlGroupNote = NULL,")
    lines.append(f"            VersionRemark = {sql_text(version_remark)},")
    lines.append(f"            ApplicableProductLinesText = {sql_text(', '.join(product_lines))},")
    lines.append(f"            TagsText = {sql_text(', '.join(tags))},")
    lines.append("            DocumentTypesText = NULL,")
    lines.append("            Status = 0,")
    lines.append(f"            Progress = {sql_number(calculate_progress(blocks, product_lines, tags, lesson_no, title_en, category))},")
    lines.append("            AnalysisCycleDays = 0,")
    lines.append("            IsLocked = 0,")
    lines.append(f"            CreateDate = COALESCE(CreateDate, TRY_CONVERT(DATETIME, {sql_text(create_date)})),")
    lines.append("            ModifyDate = GETDATE(),")
    lines.append("            Modifier = N'migration',")
    lines.append("            ModifyID = 0,")
    lines.append("            VersionNo = 1")
    lines.append("        WHERE LessonLearn_Id = @LessonLearn_Id;")
    lines.append("    END")
    lines.append("    ELSE")
    lines.append("    BEGIN")
    lines.append("        INSERT INTO dbo.LL_LessonLearn")
    lines.append("        (")
    lines.append("            LessonNo, TitleEn, TitleCn, Category, ProductPlatform, LlGroup,")
    lines.append("            IssueSource, IssueNo, IssueType, CPI, Customer, Program, PartNo, Plant,")
    lines.append("            ProductionLine, CellName, ApprovalOwner, LlCategoryCode, LlGroupNote, VersionRemark,")
    lines.append("            ApplicableProductLinesText, TagsText, DocumentTypesText,")
    lines.append("            Status, Progress, AnalysisCycleDays, ViewCount, FavoriteCount, LikeCount, VersionNo, IsLocked,")
    lines.append("            CreateDate, Creator, CreateID, ModifyDate, Modifier, ModifyID")
    lines.append("        )")
    lines.append("        VALUES")
    lines.append("        (")
    lines.append(f"            {sql_text(lesson_no)}, {sql_text(title_en)}, NULL, {sql_text(category)}, NULL, NULL,")
    lines.append(f"            {sql_text(issue_source)}, {sql_text(issue_no)}, {sql_text(issue_type)}, {sql_text(cpi)}, {sql_text(customer)}, {sql_text(program)}, {sql_text(part_no)}, {sql_text(plant)},")
    lines.append(f"            {sql_text(production_line)}, NULL, N'PL APQP', NULL, NULL, {sql_text(version_remark)},")
    lines.append(f"            {sql_text(', '.join(product_lines))}, {sql_text(', '.join(tags))}, NULL,")
    lines.append(f"            0, {sql_number(calculate_progress(blocks, product_lines, tags, lesson_no, title_en, category))}, 0, 0, 0, 0, 1, 0,")
    lines.append(f"            TRY_CONVERT(DATETIME, {sql_text(create_date)}), N'migration', 0, GETDATE(), N'migration', 0")
    lines.append("        );")
    lines.append("        SET @LessonLearn_Id = SCOPE_IDENTITY();")
    lines.append("    END")
    lines.append("")

    for index, product_line in enumerate(product_lines, start=1):
        lines.append(
            f"    INSERT INTO dbo.LL_LessonLearnProductLine(LessonLearn_Id, ProductLine, Sort) VALUES(@LessonLearn_Id, {sql_text(product_line)}, {index});"
        )

    for index, tag in enumerate(tags, start=1):
        lines.append(
            f"    INSERT INTO dbo.LL_LessonLearnTag(LessonLearn_Id, TagName, Sort) VALUES(@LessonLearn_Id, {sql_text(tag)}, {index});"
        )

    for module_type, texts in blocks.items():
        for index, text in enumerate(texts, start=1):
            lines.append(
                f"    INSERT INTO dbo.LL_LessonLearnContent(LessonLearn_Id, ModuleType, Sort, ContentEn, ContentZh) VALUES(@LessonLearn_Id, N'{module_type}', {index}, {sql_text(text)}, NULL);"
            )

    for index, review in enumerate(reviews, start=1):
        lines.append(
            "    INSERT INTO dbo.LL_LessonLearnReview(LessonLearn_Id, Round, ReviewDate, Reviewer, ReviewerTitle, Result, Comments, Sort) "
            f"VALUES(@LessonLearn_Id, {sql_text(review['round'])}, {sql_text(review['date'])}, {sql_text(review['reviewer'])}, {sql_text(review['title'])}, {sql_text(review['result'])}, {sql_text(review['comments'])}, {index});"
        )

    for index, file_item in enumerate(files, start=1):
        lines.append(
            "    INSERT INTO dbo.LL_LessonLearnFile"
            "(LessonLearn_Id, FileType, ModuleType, LessonLearnContent_Id, LessonLearnDocumentChange_Id, Category, Name, Path, Size, DownloadCount, UploadTime, CaptionEn, CaptionZh, Sort) "
            f"VALUES(@LessonLearn_Id, N'General', NULL, NULL, NULL, {sql_text(file_item['category'])}, {sql_text(file_item['name'])}, {sql_text(file_item['path'])}, {sql_number(file_item['size'])}, 0, GETDATE(), {sql_text(file_item['caption_en'])}, {sql_text(file_item['caption_zh'])}, {index});"
        )

    snapshot = {
        "LegacyId": row.get("id"),
        "Source": "LL_System_Final_V5",
        "Title": title_en,
        "LessonNo": lesson_no
    }
    lines.append(
        "    INSERT INTO dbo.LL_LessonLearnVersion(LessonLearn_Id, VersionNo, Action, [Operator], StatusText, Comment, SnapshotJson, ActionTime) "
        f"VALUES(@LessonLearn_Id, 1, N'数据迁移', N'migration', N'编辑中', {sql_text(version_remark)}, {sql_text(json.dumps(snapshot, ensure_ascii=False))}, GETDATE());"
    )

    lines.append("    COMMIT TRAN;")
    lines.append("END TRY")
    lines.append("BEGIN CATCH")
    lines.append("    IF @@TRANCOUNT > 0 ROLLBACK TRAN;")
    lines.append("    THROW;")
    lines.append("END CATCH")
    lines.append("GO")
    return "\n".join(lines)


def calculate_progress(blocks, product_lines, tags, lesson_no, title_en, category):
    total = 0
    if lesson_no or title_en or category:
        total += 10
    if product_lines:
        total += 10
    if tags:
        total += 10
    if blocks["IssueDescription"]:
        total += 10
    if blocks["RootCause"]:
        total += 10
    if blocks["CorrectiveActions"]:
        total += 10
    if blocks["GlobalLessons"]:
        total += 30
    return total


def main():
    if not SOURCE_JSON.exists():
        raise FileNotFoundError(f"未找到源数据文件: {SOURCE_JSON}")
    data = json.loads(SOURCE_JSON.read_text(encoding="utf-8"))
    pieces = [
        "USE [vol_pro_service];",
        "GO",
        "",
        "/*",
        "由 tools/lessonlearn_export_v5_to_sql.py 自动生成。",
        "来源：LL_System_Final_V5/data.json",
        "说明：",
        "1. 旧系统 status 不等于新系统审批状态，因此统一迁移为新系统 Status=0（编辑中）。",
        "2. 旧系统 status 会保存在 VersionRemark 和标签 LegacyStatus:* 中。",
        "3. 再次执行本脚本时，会按 LessonNo 覆盖对应记录的子表数据。",
        "*/",
        ""
    ]
    for row in data:
        pieces.append(build_record_sql(row))
        pieces.append("")
    TARGET_SQL.write_text("\n".join(pieces), encoding="utf-8")
    print(f"已生成: {TARGET_SQL}")


if __name__ == "__main__":
    main()
