/*
 Navicat Premium Data Transfer

 Source Server         : 111
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : 111.231.4.207:3306
 Source Schema         : vol_pro_service

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 20/03/2025 22:50:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for MES_Bom_Detail
-- ----------------------------
DROP TABLE IF EXISTS `MES_Bom_Detail`;
CREATE TABLE `MES_Bom_Detail`  (
  `DomDetailId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `BomId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Bom编号',
  `Sequence` int(11) NOT NULL COMMENT '序号',
  `MaterialCode` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子件物料编码',
  `MaterialName` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子件物料名称',
  `Spec` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `UsageQty` decimal(24, 3) NOT NULL COMMENT '单台用量',
  `ConsumeModel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消耗方式',
  `Warehouse` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '投料仓库',
  `SupplierCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `KitScale` decimal(24, 3) NULL DEFAULT NULL COMMENT '齐套比例',
  `Enable` int(11) NULL DEFAULT NULL COMMENT '启用状态',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `Creator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '更新人',
  `Modifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`DomDetailId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'BOM明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_Bom_Detail
-- ----------------------------
INSERT INTO `MES_Bom_Detail` VALUES ('401fa70b-ef49-436e-9782-35b6d887759b', '1dc84b0c-2cd7-4709-b488-df42ce36ab88', 1, 'BO01-0002-4', '机壳毛坯p38x66.3', '个', 400.000, '推式', '成品仓库', 'fd83f9a1-0289-11f0-92bb-52540099312c', 1.000, NULL, 1, '超级管理员', '2025-03-19 01:33:00', 1, '超级管理员', '2025-03-19 01:31:31');
INSERT INTO `MES_Bom_Detail` VALUES ('531e804a-df10-499b-ab26-775f68cb35ae', 'd57095e6-ef91-4f00-87cb-82e2dbb633d6', 2, 'BO01-0001-2', '机壳毛坯p38x66.2', NULL, 200.000, '推式', '成品仓库', 'fd8f3146-0289-11f0-92bb-52540099312c', 1.000, NULL, 1, '超级管理员', '2025-03-19 01:32:24', 1, '超级管理员', '2025-03-19 01:31:31');
INSERT INTO `MES_Bom_Detail` VALUES ('80dc11d2-ace8-479b-b60c-18454bba5cdb', '1dc84b0c-2cd7-4709-b488-df42ce36ab88', 2, 'BO01-0001-3', '机壳毛坯p38x66.3', '个', 300.000, '推式', '成品仓库', 'fd8f3146-0289-11f0-92bb-52540099312c', 1.000, NULL, 1, '超级管理员', '2025-03-19 01:33:00', 1, '超级管理员', '2025-03-19 01:31:31');
INSERT INTO `MES_Bom_Detail` VALUES ('91ad77cf-f062-4c4f-87b2-7fe6ab942bbf', '0b713f05-5871-471e-8f03-8c0e8654c063', 1, 'BO01-0001', '机壳镀锌p38x66.1', '个', 100.000, '推式', '成品仓库', 'fd83f9a1-0289-11f0-92bb-52540099312c', 1.000, NULL, 1, '超级管理员', '2025-03-19 01:25:00', 1, '超级管理员', '2025-03-19 01:31:31');
INSERT INTO `MES_Bom_Detail` VALUES ('c88c38b6-cbb5-44c4-a4ea-d9e1192e0359', '0b713f05-5871-471e-8f03-8c0e8654c063', 2, 'BO01-0001-1', '机壳镀锌p38x66.1', NULL, 200.000, '推式', '成品仓库', 'fd8f3146-0289-11f0-92bb-52540099312c', 1.000, NULL, 1, '超级管理员', '2025-03-19 01:31:31', 1, '超级管理员', '2025-03-19 01:31:31');
INSERT INTO `MES_Bom_Detail` VALUES ('ef77c899-95e9-48ab-9958-9ceb752788cd', 'd57095e6-ef91-4f00-87cb-82e2dbb633d6', 1, 'BO01-0002', '机壳毛坯p38x66.2', '个', 100.000, '推式', '成品仓库', 'fd83f9a1-0289-11f0-92bb-52540099312c', 1.000, NULL, 1, '超级管理员', '2025-03-19 01:32:24', 1, '超级管理员', '2025-03-19 01:31:31');

-- ----------------------------
-- Table structure for MES_Bom_Main
-- ----------------------------
DROP TABLE IF EXISTS `MES_Bom_Main`;
CREATE TABLE `MES_Bom_Main`  (
  `BomId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `Code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'BOM编号',
  `MaterialCode` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '母件物料编码',
  `MaterialName` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '母件物料名称',
  `Spec` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `Purpose` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用途',
  `Edition` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版本',
  `EffectiveDate` datetime(0) NOT NULL COMMENT '有效日期',
  `InvalidDate` datetime(0) NOT NULL COMMENT '失效日期',
  `Enable` int(11) NOT NULL COMMENT '启用状态',
  `CreateID` int(11) NOT NULL COMMENT '创建人',
  `Creator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人名称',
  `CreateDate` datetime(0) NOT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '更新人',
  `Modifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`BomId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'BOM' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_Bom_Main
-- ----------------------------
INSERT INTO `MES_Bom_Main` VALUES ('0b713f05-5871-471e-8f03-8c0e8654c063', '001-BO01-0001', '001-BO01-0001', 'H1001机壳镀锌p38x66.1', '个', '机加工', 'v1.0', '2025-03-19 00:00:00', '2025-03-19 00:00:00', 0, 1, '超级管理员', '2025-03-19 01:24:59', 1, '超级管理员', '2025-03-19 01:31:31');
INSERT INTO `MES_Bom_Main` VALUES ('1dc84b0c-2cd7-4709-b488-df42ce36ab88', '001-BO01-0003', '001-BO01-0003', 'H1001机壳镀锌p38x66.3', '个', '机加工', 'v1.0', '2025-03-19 00:00:00', '2025-03-19 00:00:00', 0, 1, '超级管理员', '2025-03-19 01:33:00', NULL, NULL, NULL);
INSERT INTO `MES_Bom_Main` VALUES ('d57095e6-ef91-4f00-87cb-82e2dbb633d6', '001-BO01-0002', '001-BO01-0002', 'H1001机壳镀锌p38x66.1', '个', '机加工', 'v1.0', '2025-03-19 00:00:00', '2025-03-19 00:00:00', 0, 1, '超级管理员', '2025-03-19 01:32:24', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_Customer
-- ----------------------------
DROP TABLE IF EXISTS `MES_Customer`;
CREATE TABLE `MES_Customer`  (
  `CustomerID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户ID',
  `CustomerName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `ContactPerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `ContactPhone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `Address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `CustomerType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户类型',
  `CreditRating` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '信用评级',
  `BusinessScope` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务范围',
  `Remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`CustomerID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_Customer
-- ----------------------------
INSERT INTO `MES_Customer` VALUES ('0aeb3835-0289-11f0-92bb-52540099312c', '辉煌科技集团', '李阳', '13900139000', 'liyang@huihuang.com', '北京市海淀区创新大道2号', '重要客户', 'A', '通信设备研发与生产', '业务量大，需重点跟进', 1, 'admin', '2023-02-01 09:00:00', NULL, NULL, NULL);
INSERT INTO `MES_Customer` VALUES ('0aeb39e8-0289-11f0-92bb-52540099312c', '星辰电子公司', '王芳', '13600136000', 'wangfang@xingchen.com', '深圳市南山区创业路3号', '新客户', 'B+', '电子零部件生产', '潜力较大，需加强沟通', 1, 'admin', '2023-03-01 10:00:00', NULL, NULL, NULL);
INSERT INTO `MES_Customer` VALUES ('0aeb3aeb-0289-11f0-92bb-52540099312c', '阳光电子集团', '陈静', '13300133000', 'chenjing@yangguang.com', '杭州市西湖区科技园区5号', '长期合作客户', 'A', 'LED照明产品制造', '合作良好，定期回访', 1, 'admin', '2023-05-01 12:00:00', NULL, NULL, NULL);
INSERT INTO `MES_Customer` VALUES ('0aeb3b9c-0289-11f0-92bb-52540099312c', '瑞风科技有限公司', '赵刚', '13700137000', 'zhaogang@ruifeng.com', '广州市天河区软件园4号', '普通客户', 'B', '智能家居产品研发', '偶尔下单，保持联系', 1, 'admin', '2023-04-01 11:00:00', NULL, NULL, NULL);
INSERT INTO `MES_Customer` VALUES ('0aeb3c2c-0289-11f0-92bb-52540099312c', '卓越电子有限公司', '张悦', '13800138000', 'zhangyue@zhuoyue.com', '上海市浦东新区科技路1号', '长期合作客户', 'A+', '消费电子产品制造', '合作多年，订单稳定', 1, 'admin', '2023-01-01 08:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_DefectiveProductDisposalRecord
-- ----------------------------
DROP TABLE IF EXISTS `MES_DefectiveProductDisposalRecord`;
CREATE TABLE `MES_DefectiveProductDisposalRecord`  (
  `DisposalRecordID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理记录ID',
  `DefectiveID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '不良品ID',
  `DisposalPerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人',
  `DisposalStartTime` datetime(0) NULL DEFAULT NULL COMMENT '处理开始时间',
  `DisposalEndTime` datetime(0) NULL DEFAULT NULL COMMENT '处理结束时间',
  `DisposalResult` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理结果',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`DisposalRecordID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_DefectiveProductDisposalRecord
-- ----------------------------
INSERT INTO `MES_DefectiveProductDisposalRecord` VALUES ('dr010101-1010-1010-1010-101010101010', 'de010101-1010-1010-1010-101010101010', '王五', '2024-06-01 15:30:00', '2024-06-01 16:00:00', '成功报废', 1, 'admin', '2024-06-01 15:30:00', NULL, NULL, NULL);
INSERT INTO `MES_DefectiveProductDisposalRecord` VALUES ('dr020202-2020-2020-2020-202020202020', 'de020202-2020-2020-2020-202020202020', '赵六', '2024-06-02 16:30:00', '2024-06-02 17:00:00', '成功报废', 1, 'admin', '2024-06-02 16:30:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_DefectiveProductRecord
-- ----------------------------
DROP TABLE IF EXISTS `MES_DefectiveProductRecord`;
CREATE TABLE `MES_DefectiveProductRecord`  (
  `DefectiveID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '不良品ID',
  `ReportingID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报工ID',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料名称',
  `MaterialSpecification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料规格',
  `DefectiveQuantity` int(11) NOT NULL COMMENT '不良品数量',
  `DefectType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '缺陷类型',
  `DefectReason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '缺陷原因',
  `DisposalMethod` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理方式',
  `DisposalStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理状态',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`DefectiveID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_DefectiveProductRecord
-- ----------------------------
INSERT INTO `MES_DefectiveProductRecord` VALUES ('84348030-03e0-11f0-92bb-52540099312c', '7e80d01e-03e0-11f0-92bb-52540099312c', 'M001', '电阻', '100Ω', 20, '阻值偏差', '生产工艺问题', '报废', '已处理', 1, 'admin', '2024-06-01 15:00:00', NULL, NULL, NULL);
INSERT INTO `MES_DefectiveProductRecord` VALUES ('843483f9-03e0-11f0-92bb-52540099312c', '7e80d290-03e0-11f0-92bb-52540099312c', 'M002', '电容', '10μF', 20, '容量不达标', '原材料质量问题', '报废', '已处理', 1, 'admin', '2024-06-02 16:00:00', NULL, NULL, NULL);
INSERT INTO `MES_DefectiveProductRecord` VALUES ('84348505-03e0-11f0-92bb-52540099312c', '7e80d2d4-03e0-11f0-92bb-52540099312c', 'M003', '线路板', 'PCB-A100', 20, '线路短路', '加工过程失误', '维修后再检验', '已处理', 1, 'admin', '2024-06-03 17:00:00', NULL, NULL, NULL);
INSERT INTO `MES_DefectiveProductRecord` VALUES ('843485ab-03e0-11f0-92bb-52540099312c', '7e80d2fe-03e0-11f0-92bb-52540099312c', 'M004', '塑料粒子', 'PP-500', 50, '产品变形', '注塑参数不当', '报废', '已处理', 1, 'admin', '2024-06-04 18:00:00', NULL, NULL, NULL);
INSERT INTO `MES_DefectiveProductRecord` VALUES ('8434864a-03e0-11f0-92bb-52540099312c', '7e80d322-03e0-11f0-92bb-52540099312c', 'M005', '螺丝', 'M3x10', 50, '螺纹损坏', '加工精度不够', '报废', '已处理', 1, 'admin', '2024-06-05 19:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_EquipmentFaultRecord
-- ----------------------------
DROP TABLE IF EXISTS `MES_EquipmentFaultRecord`;
CREATE TABLE `MES_EquipmentFaultRecord`  (
  `FaultRecordID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '故障记录ID',
  `EquipmentID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `FaultDate` datetime(0) NULL DEFAULT NULL COMMENT '故障日期',
  `FaultType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '故障类型',
  `FaultDescription` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '故障描述',
  `FaultImpact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '故障影响',
  `FaultReportedBy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '故障报告人',
  `FaultStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '故障状态',
  `TroubleshootingStartTime` datetime(0) NULL DEFAULT NULL COMMENT '故障排查开始时间',
  `TroubleshootingEndTime` datetime(0) NULL DEFAULT NULL COMMENT '故障排查结束时间',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`FaultRecordID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_EquipmentFaultRecord
-- ----------------------------
INSERT INTO `MES_EquipmentFaultRecord` VALUES ('f349f43c-0290-11f0-92bb-52540099312c', 'bdbb3938-028f-11f0-92bb-52540099312c', '2024-06-01 08:00:00', '电气故障', '设备突然断电', '生产中断', '李明', '已解决', '2024-06-01 08:15:00', '2024-06-01 09:30:00', 1, 'admin', '2024-06-01 08:00:00', 1, '超级管理员', '2025-03-17 02:04:14');
INSERT INTO `MES_EquipmentFaultRecord` VALUES ('f349f60c-0290-11f0-92bb-52540099312c', 'bdbb36ec-028f-11f0-92bb-52540099312c', '2024-06-02 09:00:00', '机械故障', '模具开合异常', '影响产品成型质量', '张华', '已解决', '2024-06-02 09:10:00', '2024-06-02 11:00:00', 1, 'admin', '2024-06-02 09:00:00', 1, '超级管理员', '2025-03-17 02:04:11');
INSERT INTO `MES_EquipmentFaultRecord` VALUES ('f349f707-0290-11f0-92bb-52540099312c', 'bdbb37ef-028f-11f0-92bb-52540099312c', '2024-06-03 10:00:00', '软件故障', '检测程序报错', '无法正常检测产品', '陈丽', '已解决', '2024-06-03 10:15:00', '2024-06-03 12:00:00', 1, 'admin', '2024-06-03 10:00:00', 1, '超级管理员', '2025-03-17 02:04:05');
INSERT INTO `MES_EquipmentFaultRecord` VALUES ('f349f7b4-0290-11f0-92bb-52540099312c', 'bdbb3938-028f-11f0-92bb-52540099312c', '2024-06-04 11:00:00', '传感器故障', '螺丝拧紧量检测传感器失灵', '螺丝拧紧质量不稳定', '王强', '已解决', '2024-06-04 11:10:00', '2024-06-04 13:00:00', 1, 'admin', '2024-06-04 11:00:00', 1, '超级管理员', '2025-03-17 02:04:01');
INSERT INTO `MES_EquipmentFaultRecord` VALUES ('f349f849-0290-11f0-92bb-52540099312c', 'bdbb34f1-028f-11f0-92bb-52540099312c', '2024-06-05 12:00:00', '加热故障', '回流焊温度达不到设定值', '焊接效果不佳', '李明', '已解决', '2024-06-05 12:15:00', '2024-06-05 14:00:00', 1, 'admin', '2024-06-05 12:00:00', 1, '超级管理员', '2025-03-17 02:03:57');

-- ----------------------------
-- Table structure for MES_EquipmentMaintenance
-- ----------------------------
DROP TABLE IF EXISTS `MES_EquipmentMaintenance`;
CREATE TABLE `MES_EquipmentMaintenance`  (
  `MaintenanceID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '保养ID',
  `EquipmentID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `MaintenanceDate` datetime(0) NULL DEFAULT NULL COMMENT '保养日期',
  `MaintenanceType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保养类型',
  `MaintenanceContent` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保养内容',
  `MaintenancePerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保养人员',
  `MaintenanceStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保养状态',
  `NextMaintenanceDate` datetime(0) NULL DEFAULT NULL COMMENT '下次保养日期',
  `MaintenanceCost` decimal(10, 2) NULL DEFAULT NULL COMMENT '保养成本',
  `MaintenanceRemarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保养备注',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`MaintenanceID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_EquipmentMaintenance
-- ----------------------------
INSERT INTO `MES_EquipmentMaintenance` VALUES ('4f488d2d-0291-11f0-92bb-52540099312c', 'bdbb3938-028f-11f0-92bb-52540099312c', '2024-02-06 09:00:00', '日常保养', '润滑机械部件、检查电路', '王师傅', '已完成', '2024-03-06 09:00:00', 600.00, '无异常', 1, 'admin', '2024-02-06 09:00:00', 1, '超级管理员', '2025-03-17 02:06:41');
INSERT INTO `MES_EquipmentMaintenance` VALUES ('4f488e2d-0291-11f0-92bb-52540099312c', 'bdbb36ec-028f-11f0-92bb-52540099312c', '2024-03-07 10:00:00', '深度保养', '更换易损件、全面检测', '张师傅', '已完成', '2024-04-07 10:00:00', 1200.00, '设备性能稳定', 1, 'admin', '2024-03-07 10:00:00', 1, '超级管理员', '2025-03-17 02:06:33');
INSERT INTO `MES_EquipmentMaintenance` VALUES ('4f488eea-0291-11f0-92bb-52540099312c', 'bdbb36ec-028f-11f0-92bb-52540099312c', '2024-04-08 11:00:00', '定期保养', '清洁、调试设备', '李师傅', '已完成', '2024-05-08 11:00:00', 900.00, '设备正常运行', 1, 'admin', '2024-04-08 11:00:00', 1, '超级管理员', '2025-03-17 02:06:29');
INSERT INTO `MES_EquipmentMaintenance` VALUES ('4f488fb2-0291-11f0-92bb-52540099312c', 'bdbb36ec-028f-11f0-92bb-52540099312c', '2024-05-09 12:00:00', '日常保养', '检查焊接头、清理灰尘', '赵师傅', '已完成', '2024-06-09 12:00:00', 700.00, '无明显问题', 1, 'admin', '2024-05-09 12:00:00', 1, '超级管理员', '2025-03-17 02:06:26');

-- ----------------------------
-- Table structure for MES_EquipmentManagement
-- ----------------------------
DROP TABLE IF EXISTS `MES_EquipmentManagement`;
CREATE TABLE `MES_EquipmentManagement`  (
  `EquipmentID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备ID',
  `EquipmentCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备编码',
  `EquipmentName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备名称',
  `EquipmentType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备类型',
  `Manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制造商',
  `PurchaseDate` datetime(0) NULL DEFAULT NULL COMMENT '购买日期',
  `WarrantyPeriod` int(11) NULL DEFAULT NULL COMMENT '保修期（月）',
  `InstallationLocation` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '安装位置',
  `EquipmentStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备状态',
  `ResponsiblePerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '责任人',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`EquipmentID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_EquipmentManagement
-- ----------------------------
INSERT INTO `MES_EquipmentManagement` VALUES ('bdbb34f1-028f-11f0-92bb-52540099312c', 'EQ001', 'SMT贴片机', '电子制造设备', '三星电子', '2023-01-01 08:00:00', 12, '生产车间A区1号', '运行正常', '李明', 1, 'admin', '2024-01-01 08:00:00', NULL, NULL, NULL);
INSERT INTO `MES_EquipmentManagement` VALUES ('bdbb36ec-028f-11f0-92bb-52540099312c', 'EQ002', '注塑机', '塑料加工设备', '海天塑机', '2023-02-01 09:00:00', 10, '生产车间B区2号', '运行中', '张华', 1, 'admin', '2024-02-01 09:00:00', NULL, NULL, NULL);
INSERT INTO `MES_EquipmentManagement` VALUES ('bdbb37ef-028f-11f0-92bb-52540099312c', 'EQ003', '检测仪器', '质量检测设备', '泰瑞达科技', '2023-03-01 10:00:00', 15, '生产车间D区4号', '正常使用', '陈丽', 1, 'admin', '2024-03-01 10:00:00', NULL, NULL, NULL);
INSERT INTO `MES_EquipmentManagement` VALUES ('bdbb38a2-028f-11f0-92bb-52540099312c', 'EQ004', '自动螺丝机', '装配设备', '拓普机械', '2023-04-01 11:00:00', 11, '生产车间C区3号', '运行平稳', '王强', 1, 'admin', '2024-04-01 11:00:00', NULL, NULL, NULL);
INSERT INTO `MES_EquipmentManagement` VALUES ('bdbb3938-028f-11f0-92bb-52540099312c', 'EQ005', '回流焊炉', '焊接设备', '日东电子', '2023-05-01 12:00:00', 13, '生产车间A区1号', '正常运转', '李明', 1, 'admin', '2024-05-01 12:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_EquipmentRepair
-- ----------------------------
DROP TABLE IF EXISTS `MES_EquipmentRepair`;
CREATE TABLE `MES_EquipmentRepair`  (
  `RepairID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '维修ID',
  `EquipmentID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备ID',
  `RepairDate` datetime(0) NULL DEFAULT NULL COMMENT '维修日期',
  `RepairReason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修原因',
  `RepairContent` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修内容',
  `RepairPerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修人员',
  `RepairCost` decimal(10, 2) NULL DEFAULT NULL COMMENT '维修成本',
  `RepairStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修状态',
  `RepairStartTime` datetime(0) NULL DEFAULT NULL COMMENT '维修开始时间',
  `RepairEndTime` datetime(0) NULL DEFAULT NULL COMMENT '维修结束时间',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`RepairID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_EquipmentRepair
-- ----------------------------
INSERT INTO `MES_EquipmentRepair` VALUES ('5132a230-0290-11f0-92bb-52540099312c', 'bdbb3938-028f-11f0-92bb-52540099312c', '2024-01-10 09:00:00', '贴装头故障', '更换贴装头', '张师傅', 5000.00, '已完成', '2024-01-10 09:30:00', '2024-01-10 15:00:00', 1, 'admin', '2024-01-10 09:00:00', 1, '超级管理员', '2025-03-17 02:00:41');
INSERT INTO `MES_EquipmentRepair` VALUES ('5132a3fb-0290-11f0-92bb-52540099312c', 'bdbb3938-028f-11f0-92bb-52540099312c', '2024-02-15 10:00:00', '注塑压力不稳定', '检查液压系统并维修', '李师傅', 3500.00, '已完成', '2024-02-15 10:30:00', '2024-02-15 16:00:00', 1, 'admin', '2024-02-15 10:00:00', 1, '超级管理员', '2025-03-17 02:00:36');
INSERT INTO `MES_EquipmentRepair` VALUES ('5132a509-0290-11f0-92bb-52540099312c', 'bdbb38a2-028f-11f0-92bb-52540099312c', '2024-03-20 11:00:00', '检测精度下降', '校准检测传感器', '赵师傅', 2000.00, '已完成', '2024-03-20 11:30:00', '2024-03-20 14:00:00', 1, 'admin', '2024-03-20 11:00:00', 1, '超级管理员', '2025-03-17 02:00:56');
INSERT INTO `MES_EquipmentRepair` VALUES ('5132a5c0-0290-11f0-92bb-52540099312c', 'bdbb34f1-028f-11f0-92bb-52540099312c', '2024-04-25 12:00:00', '螺丝拧紧力度不均匀', '调整拧紧扭矩装置', '孙师傅', 1500.00, '已完成', '2024-04-25 12:30:00', '2024-04-25 15:30:00', 1, 'admin', '2024-04-25 12:00:00', 1, '超级管理员', '2025-03-17 02:00:24');
INSERT INTO `MES_EquipmentRepair` VALUES ('5132a654-0290-11f0-92bb-52540099312c', 'bdbb34f1-028f-11f0-92bb-52540099312c', '2024-05-30 13:00:00', '温度控制异常', '维修温度控制器', '周师傅', 2500.00, '已完成', '2024-05-30 13:30:00', '2024-05-30 17:00:00', 1, 'admin', '2024-05-30 13:00:00', 1, '超级管理员', '2025-03-17 02:00:21');

-- ----------------------------
-- Table structure for MES_InventoryManagement
-- ----------------------------
DROP TABLE IF EXISTS `MES_InventoryManagement`;
CREATE TABLE `MES_InventoryManagement`  (
  `InventoryID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '库存ID',
  `DocumentNo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料名称',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料编号',
  `SpecificationModel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `WarehouseID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库ID',
  `LocationID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货位ID',
  `InventoryQuantity` int(11) NOT NULL COMMENT '库存数量',
  `InventoryUnit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库存单位',
  `InventoryCost` decimal(10, 2) NOT NULL COMMENT '库存成本',
  `InventoryStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库存状态',
  `InboundDate` datetime(0) NULL DEFAULT NULL COMMENT '入库日期',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`InventoryID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_InventoryManagement
-- ----------------------------
INSERT INTO `MES_InventoryManagement` VALUES ('5e6f978c-2f87-4046-9577-29c96a95724d', 'INV001', '螺丝', 'S001', 'M5*10', '3a765f84-49a6-4f42-9639-2a9c58d832c5', '1c19c214-9d78-4596-b078-789f7755896b', 500, '个', 0.50, '在库', '2024-01-01 08:00:00', 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:46:23');
INSERT INTO `MES_InventoryManagement` VALUES ('5e6f978c-2f87-4046-9577-29c96a95724e', 'INV002', '螺母', 'N001', 'M5', '3a765f84-49a6-4f42-9639-2a9c58d832c5', '1c19c214-9d78-4596-b078-789f7755896b', 300, '个', 0.30, '在库', '2024-01-02 09:00:00', 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:47:04');
INSERT INTO `MES_InventoryManagement` VALUES ('5e6f978c-2f87-4046-9577-29c96a95724f', 'INV003', '成品A', 'P001', 'V1.0', '3a765f84-49a6-4f42-9639-2a9c58d832c5', '1c19c214-9d78-4596-b078-789f7755896b', 200, '件', 100.00, '在库', '2024-01-03 10:00:00', 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:46:40');
INSERT INTO `MES_InventoryManagement` VALUES ('5e6f978c-2f87-4046-9577-29c96a957250', 'INV004', '半成品B', 'SP001', '半加工状态', '3a765f84-49a6-4f42-9639-2a9c58d832c6', '1c19c214-9d78-4596-b078-789f7755896c', 150, '件', 50.00, '在库', '2024-01-04 11:00:00', 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:46:49');
INSERT INTO `MES_InventoryManagement` VALUES ('5e6f978c-2f87-4046-9577-29c96a957251', 'INV005', '包装纸箱', 'C001', '50*40*30cm', '3a765f84-49a6-4f42-9639-2a9c58d832c8', '1c19c214-9d78-4596-b078-789f7755896e', 400, '个', 5.00, '在库', '2024-01-05 12:00:00', 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:46:55');

-- ----------------------------
-- Table structure for MES_LocationManagement
-- ----------------------------
DROP TABLE IF EXISTS `MES_LocationManagement`;
CREATE TABLE `MES_LocationManagement`  (
  `LocationID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位ID',
  `WarehouseID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属仓库ID',
  `LocationCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位编码',
  `LocationName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位名称',
  `LocationType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货位类型',
  `LocationCapacity` int(11) NOT NULL COMMENT '货位容量',
  `LocationStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货位状态',
  `LocationRow` int(11) NOT NULL COMMENT '货位行号',
  `LocationColumn` int(11) NOT NULL COMMENT '货位列号',
  `LocationFloor` int(11) NOT NULL COMMENT '货位层数',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`LocationID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_LocationManagement
-- ----------------------------
INSERT INTO `MES_LocationManagement` VALUES ('3a765f84-49a6-4f42-9639-2a9c58d832c4', '1c19c214-9d78-4596-b078-789f7755896a', 'L001', 'A区001', '普通货位', 100, '空闲', 1, 1, 1, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:47:51');
INSERT INTO `MES_LocationManagement` VALUES ('3a765f84-49a6-4f42-9639-2a9c58d832c5', '1c19c214-9d78-4596-b078-789f7755896b', 'L002', 'B区002', '普通货位', 150, '占用', 2, 2, 1, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:47:57');
INSERT INTO `MES_LocationManagement` VALUES ('3a765f84-49a6-4f42-9639-2a9c58d832c6', '1c19c214-9d78-4596-b078-789f7755896c', 'L003', 'C区003', '普通货位', 120, '空闲', 3, 3, 1, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:48:03');
INSERT INTO `MES_LocationManagement` VALUES ('3a765f84-49a6-4f42-9639-2a9c58d832c7', '1c19c214-9d78-4596-b078-789f7755896d', 'L004', 'D区004', '不良品货位', 50, '占用', 4, 4, 1, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:48:13');
INSERT INTO `MES_LocationManagement` VALUES ('3a765f84-49a6-4f42-9639-2a9c58d832c8', '1c19c214-9d78-4596-b078-789f7755896e', 'L005', 'E区005', '普通货位', 180, '空闲', 5, 5, 1, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:48:19');

-- ----------------------------
-- Table structure for MES_Material
-- ----------------------------
DROP TABLE IF EXISTS `MES_Material`;
CREATE TABLE `MES_Material`  (
  `MaterialID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料ID',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编码',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料名称',
  `MaterialType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料类型',
  `CatalogID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料分类',
  `Specification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `Unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计量单位',
  `Price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价信息',
  `Img` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料图片',
  `Remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`MaterialID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_Material
-- ----------------------------
INSERT INTO `MES_Material` VALUES ('8754ed7a-e845-42a1-9b51-6735091653f4', 'AKG0000004', '米其林轮胎', NULL, '40f6f014-b41f-400e-ad49-ed4b109cf5f3', '。。。。。。。', '件', NULL, NULL, '。。。。。。。。', 1, '超级管理员', '2025-03-18 14:12:26', 1, '超级管理员', '2025-03-18 14:13:00');
INSERT INTO `MES_Material` VALUES ('9f7e972a-028b-11f0-92bb-52540099312c', 'AKG0000001', '碳素结构钢', '金属材料', '40f6f014-b41f-400e-ad49-ed4b109cf5f3', 'Q235B，厚度 5mm', '吨', 4500.00, 'Upload/Tables/MES_Material/202503170240379198/wechat.jpg', '常用于建筑结构', 1, '管理员', '2025-03-17 01:25:14', 1, '超级管理员', '2025-03-17 11:47:53');
INSERT INTO `MES_Material` VALUES ('9f7e990f-028b-11f0-92bb-52540099312c', 'AKG0000002', '架构芯片', '电子元器件', '40f6f014-b41f-400e-ad49-ed4b109cf5f3', 'Cortex - M3 内核，主频 100MHz', '片', 50.00, 'Upload/Tables/MES_Material/202503170240426945/wechat.jpg', '适用于嵌入式系统开发', 1, '管理员', '2025-03-17 01:25:14', 1, '超级管理员', '2025-03-17 11:48:28');
INSERT INTO `MES_Material` VALUES ('9f7e99fd-028b-11f0-92bb-52540099312c', 'AKG0000003', '聚乙烯（PE）', '化工原料', '0b24acbf-ac77-4355-966a-71f394020c6d', '低密度，颗粒状', '件', 10.00, 'Upload/Tables/MES_Material/202503170240509540/wechat.jpg', '可用于塑料制品生产', 1, '管理员', '2025-03-17 01:25:14', 1, '超级管理员', '2025-03-17 11:49:11');
INSERT INTO `MES_Material` VALUES ('9f7e9a54-028b-11f0-92bb-52540099312c', 'AKG0000004', '双层瓦楞纸箱', '包装材料', '43175a13-251a-4481-b515-87a9d22a547b', '尺寸：500mm×300mm×200mm', '件', 5.00, NULL, '用于产品包装运输', 1, '管理员', '2025-03-17 01:25:14', 1, '超级管理员', '2025-03-17 11:49:17');
INSERT INTO `MES_Material` VALUES ('9f7e9aac-028b-11f0-92bb-52540099312c', 'AKG0000005', 'A4 复印纸', '办公用品', '43175a13-251a-4481-b515-87a9d22a547b', '70g，500 张/包', '包', 20.00, NULL, '适用于日常办公复印', 1, '管理员', '2025-03-17 01:25:14', 1, '超级管理员', '2025-03-17 11:48:52');

-- ----------------------------
-- Table structure for MES_MaterialCatalog
-- ----------------------------
DROP TABLE IF EXISTS `MES_MaterialCatalog`;
CREATE TABLE `MES_MaterialCatalog`  (
  `CatalogID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类ID',
  `CatalogCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类编码',
  `CatalogName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `CatalogType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类类型',
  `ParentId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上级分类',
  `Enable` int(11) NULL DEFAULT NULL COMMENT '启用状态',
  `Remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`CatalogID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_MaterialCatalog
-- ----------------------------
INSERT INTO `MES_MaterialCatalog` VALUES ('0b24acbf-ac77-4355-966a-71f394020c6d', 'A0008', '助焊剂', NULL, '40f6f014-b41f-400e-ad49-ed4b109cf5f3', 1, '。。。', 1, '超级管理员', '2025-03-17 11:45:07', 1, '超级管理员', '2025-03-17 11:45:14');
INSERT INTO `MES_MaterialCatalog` VALUES ('40f6f014-b41f-400e-ad49-ed4b109cf5f3', 'A0001', '原材料', NULL, NULL, 1, '。。。。', 1, '超级管理员', '2025-03-17 11:36:25', 1, '超级管理员', '2025-03-17 11:46:03');
INSERT INTO `MES_MaterialCatalog` VALUES ('43175a13-251a-4481-b515-87a9d22a547b', 'A0005', '引线框架', NULL, 'ef241017-fbce-42af-942a-6d2531929cc4', 1, '。。。。。', 1, '超级管理员', '2025-03-17 11:43:42', 1, '超级管理员', '2025-03-17 11:44:36');
INSERT INTO `MES_MaterialCatalog` VALUES ('8f258988-157e-4e81-9076-44a86d1946cb', 'A0006', '覆铜板', NULL, 'ef241017-fbce-42af-942a-6d2531929cc4', 1, NULL, 1, '超级管理员', '2025-03-17 11:44:24', 1, '超级管理员', '2025-03-17 11:46:22');
INSERT INTO `MES_MaterialCatalog` VALUES ('b8ccd002-73b9-4bb0-b40f-fbca161b3443', 'A0007', '粘合剂', NULL, '40f6f014-b41f-400e-ad49-ed4b109cf5f3', 1, '。。。', 1, '超级管理员', '2025-03-17 11:44:52', 1, '超级管理员', '2025-03-17 11:46:25');
INSERT INTO `MES_MaterialCatalog` VALUES ('ef241017-fbce-42af-942a-6d2531929cc4', 'A0003', '半成品', NULL, NULL, 1, '。。。。。。', 1, '超级管理员', '2025-03-17 11:36:47', 1, '超级管理员', '2025-03-17 11:36:53');

-- ----------------------------
-- Table structure for MES_Process
-- ----------------------------
DROP TABLE IF EXISTS `MES_Process`;
CREATE TABLE `MES_Process`  (
  `ProcessID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工序ID',
  `ProcessCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工序编码',
  `ProcessName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工序名称',
  `ProcessType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工序类型',
  `ProcessSequence` int(11) NOT NULL COMMENT '工序顺序',
  `ProcessDescription` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工序描述',
  `WorkCenter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作中心',
  `StandardWorkingHours` decimal(10, 2) NOT NULL COMMENT '标准工时',
  `ProcessStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工序状态',
  `ResponsibleWorker` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '责任人',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ProcessID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_Process
-- ----------------------------
INSERT INTO `MES_Process` VALUES ('4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', 'PAK00001', '切割工序', '加工工序', 1, '对原材料进行切割处理', 'WC01', 2.50, '正常', '张师傅', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-18 14:00:07');
INSERT INTO `MES_Process` VALUES ('4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', 'PAK00002', '焊接工序', '加工工序', 2, '将切割后的部件进行焊接组装', 'WC02', 3.00, '正常', '李师傅', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-18 14:00:58');
INSERT INTO `MES_Process` VALUES ('4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', 'PAK00003', '打磨工序', '加工工序', 3, '对焊接后的产品进行打磨处理', 'WC03', 2.00, '正常', '王师傅', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-17 02:17:40');
INSERT INTO `MES_Process` VALUES ('4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', 'PAK00004', '喷漆工序', '表面处理工序', 4, '对打磨后的产品进行喷漆操作', 'WC04', 1.50, '正常', '赵师傅', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-17 02:17:45');
INSERT INTO `MES_Process` VALUES ('4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', 'PAK00005', '质检工序', '质量检测工序', 5, '对产品进行质量检测', 'WC05', 1.00, '正常', '孙师傅', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-17 02:17:50');

-- ----------------------------
-- Table structure for MES_ProcessReport
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProcessReport`;
CREATE TABLE `MES_ProcessReport`  (
  `ReportID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '汇报ID',
  `ProcessID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工序ID',
  `ReportDate` datetime(0) NOT NULL COMMENT '汇报日期',
  `CompletedQuantity` int(11) NOT NULL COMMENT '完成数量',
  `DefectiveQuantity` int(11) NOT NULL COMMENT '不良数量',
  `ReportedBy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '汇报人',
  `ReportStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '汇报状态',
  `ReportRemarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '汇报备注',
  `StartTime` datetime(0) NULL DEFAULT NULL COMMENT '工序开始时间',
  `EndTime` datetime(0) NULL DEFAULT NULL COMMENT '工序结束时间',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ReportID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProcessReport
-- ----------------------------
INSERT INTO `MES_ProcessReport` VALUES ('5b348b0e-0295-11f0-92bb-52540099312c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', '2024-01-16 08:00:00', 50, 2, '张师傅', '已完成', '切割过程中发现2个次品', '2024-01-16 07:00:00', '2024-01-16 08:00:00', 1, 'admin', '2025-03-16 23:16:25', 1, 'admin', '2025-03-16 23:16:25');
INSERT INTO `MES_ProcessReport` VALUES ('5b348cd3-0295-11f0-92bb-52540099312c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', '2024-01-16 09:30:00', 40, 1, '李师傅', '已完成', '焊接时有1个产品焊接不牢', '2024-01-16 08:30:00', '2024-01-16 09:30:00', 1, 'admin', '2025-03-16 23:16:25', 1, 'admin', '2025-03-16 23:16:25');
INSERT INTO `MES_ProcessReport` VALUES ('5b348dd7-0295-11f0-92bb-52540099312c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', '2024-01-16 11:00:00', 35, 0, '王师傅', '已完成', '打磨过程顺利', '2024-01-16 10:00:00', '2024-01-16 11:00:00', 1, 'admin', '2025-03-16 23:16:25', 1, 'admin', '2025-03-16 23:16:25');
INSERT INTO `MES_ProcessReport` VALUES ('5b348e97-0295-11f0-92bb-52540099312c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', '2024-01-16 12:30:00', 45, 3, '赵师傅', '已完成', '喷漆颜色有偏差3个产品', '2024-01-16 11:30:00', '2024-01-16 12:30:00', 1, 'admin', '2025-03-16 23:16:25', 1, 'admin', '2025-03-16 23:16:25');
INSERT INTO `MES_ProcessReport` VALUES ('5b348f65-0295-11f0-92bb-52540099312c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', '2024-01-16 14:00:00', 50, 1, '孙师傅', '已完成', '1个产品质检不合格', '2024-01-16 13:00:00', '2024-01-16 14:00:00', 1, 'admin', '2025-03-16 23:16:25', 1, 'admin', '2025-03-16 23:16:25');

-- ----------------------------
-- Table structure for MES_ProcessRoute
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProcessRoute`;
CREATE TABLE `MES_ProcessRoute`  (
  `RouteID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路线ID',
  `ProcessID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工序ID',
  `ProductID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产品ID',
  `ProductName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `RouteSequence` int(11) NOT NULL COMMENT '路线顺序',
  `RouteDescription` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路线描述',
  `PreProcessID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前工序ID',
  `NextProcessID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后工序ID',
  `RouteStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路线状态',
  `RouteResponsible` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路线责任人',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`RouteID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProcessRoute
-- ----------------------------
INSERT INTO `MES_ProcessRoute` VALUES ('30142e89-8086-40e3-a0c4-ea8bc24ebc7d', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', NULL, '工艺路径03', 3, '工艺路径03', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', '1', NULL, 1, '超级管理员', '2025-03-18 14:00:07', 1, '超级管理员', '2025-03-18 14:00:07');
INSERT INTO `MES_ProcessRoute` VALUES ('7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2a', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', 'P0001', '工艺路径01', 1, '产品A的工艺路线第一步 - 切割', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', '启用', '项目经理1', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-18 14:00:07');
INSERT INTO `MES_ProcessRoute` VALUES ('7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2b', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', 'P0001', '喷漆01', 1, '喷漆01', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', '启用', '项目经理1', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-18 14:00:58');
INSERT INTO `MES_ProcessRoute` VALUES ('7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', 'P0001', '产品A', 3, '产品A的工艺路线第三步 - 打磨', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', '启用', '项目经理1', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-17 02:17:40');
INSERT INTO `MES_ProcessRoute` VALUES ('7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2d', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', 'P0001', '产品A', 4, '产品A的工艺路线第四步 - 喷漆', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', '启用', '项目经理1', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-17 02:17:45');
INSERT INTO `MES_ProcessRoute` VALUES ('7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2e', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', 'P0001', '产品A', 5, '产品A的工艺路线第五步 - 质检', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', NULL, '启用', '项目经理1', 1, 'admin', '2025-03-16 23:16:25', 1, '超级管理员', '2025-03-17 02:17:50');
INSERT INTO `MES_ProcessRoute` VALUES ('be7bca96-d2b1-42be-a23c-a5e75b26fc8d', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', NULL, '工艺路径02', 2, '工艺路径01', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', '1', NULL, 1, '超级管理员', '2025-03-17 02:22:19', 1, '超级管理员', '2025-03-18 14:00:07');
INSERT INTO `MES_ProcessRoute` VALUES ('c33a1f4e-5ace-4f58-95c2-6f15f8e64950', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', NULL, '喷漆02', 2, '喷漆02', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', '4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', '1', NULL, 1, '超级管理员', '2025-03-18 14:00:58', 1, '超级管理员', '2025-03-18 14:00:58');

-- ----------------------------
-- Table structure for MES_ProductInbound
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductInbound`;
CREATE TABLE `MES_ProductInbound`  (
  `InboundID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库ID',
  `DocumentNo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料名称',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料编号',
  `SpecificationModel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `WarehouseID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库ID',
  `LocationID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '货位ID',
  `InboundQuantity` int(11) NOT NULL COMMENT '入库数量',
  `InboundUnit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库单位',
  `InboundDate` datetime(0) NULL DEFAULT NULL COMMENT '入库日期',
  `InboundOperator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库操作员',
  `InboundReason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库原因',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`InboundID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductInbound
-- ----------------------------
INSERT INTO `MES_ProductInbound` VALUES ('528599a8-a80b-4854-9184-03b998fcf75a', 'IN202503170001', '双层瓦楞纸箱', 'AKG0000004', '尺寸：500mm×300mm×200mm', NULL, '1c19c214-9d78-4596-b078-789f7755896b', 200, '个', '2024-01-06 08:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:58:21', 1, '超级管理员', '2025-03-20 17:36:23');
INSERT INTO `MES_ProductInbound` VALUES ('687c6fe1-6849-46c6-a9d7-96f80e10e827', 'IN202503170001', '米其林轮胎', 'AKG0000004', '。。。。。。。', NULL, '1c19c214-9d78-4596-b078-789f7755896d', 200, '个', '2024-01-06 08:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:59:01', 1, '超级管理员', '2025-03-20 17:35:59');
INSERT INTO `MES_ProductInbound` VALUES ('75013787-8e21-49c7-a488-1cff0b051f6e', 'IN202503170001', '聚乙烯（PE）', 'AKG0000003', '低密度，颗粒状', NULL, '1c19c214-9d78-4596-b078-789f7755896a', 200, '个', '2024-01-06 08:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:58:24', 1, '超级管理员', '2025-03-20 17:36:14');
INSERT INTO `MES_ProductInbound` VALUES ('e080e4f0-1fd8-4bbf-97b0-045fda9a5207', 'IN202503170001', '碳素结构钢', 'AKG0000001', 'Q235B，厚度 5mm', NULL, '1c19c214-9d78-4596-b078-789f7755896d', 200, '个', '2024-01-06 08:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:58:55', 1, '超级管理员', '2025-03-20 17:36:06');

-- ----------------------------
-- Table structure for MES_ProductOutbound
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductOutbound`;
CREATE TABLE `MES_ProductOutbound`  (
  `OutboundID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出库ID',
  `DocumentNo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单据号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料名称',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编号',
  `SpecificationModel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格型号',
  `WarehouseID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库ID',
  `LocationID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '货位ID',
  `OutboundQuantity` int(11) NOT NULL COMMENT '出库数量',
  `OutboundUnit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单位',
  `OutboundDate` datetime(0) NULL DEFAULT NULL COMMENT '出库日期',
  `OutboundOperator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库操作员',
  `OutboundReason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库原因',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`OutboundID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductOutbound
-- ----------------------------
INSERT INTO `MES_ProductOutbound` VALUES ('087d6390-c914-4949-b397-3cf5bfe66df0', 'OB20250317006', '聚乙烯（PE）', 'AKG0000003', '低密度，颗粒状', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, '件', '2024-01-14 11:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:14', 1, '超级管理员', '2025-03-20 17:38:07');
INSERT INTO `MES_ProductOutbound` VALUES ('323adf96-5391-45a6-bd03-69ebe526a933', 'OB20250317008', '碳素结构钢', 'AKG0000001', 'Q235B，厚度 5mm', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, '件', '2024-01-14 11:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:26', 1, '超级管理员', '2025-03-20 17:37:58');
INSERT INTO `MES_ProductOutbound` VALUES ('623a152c-d7d6-4aba-9456-092d1b5902b1', 'OB20250317010', '双层瓦楞纸箱', 'AKG0000004', '尺寸：500mm×300mm×200mm', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c8', 50, '个', '2024-01-15 12:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:34', 1, '超级管理员', '2025-03-20 17:37:47');
INSERT INTO `MES_ProductOutbound` VALUES ('688f2d79-c448-4c91-99ff-ca65448a38d7', 'OB20250317012', '聚乙烯（PE）', 'AKG0000003', '低密度，颗粒状', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c8', 12, '箱', '2024-01-15 12:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:47', 1, '超级管理员', '2025-03-20 17:37:34');
INSERT INTO `MES_ProductOutbound` VALUES ('7ac2fe76-c1a5-49af-b441-91c722e35759', 'OB20250317003', '包装纸箱', 'C001', '50*40*30cm', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c8', 50, '个', '2024-01-15 12:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:38:12', NULL, NULL, NULL);
INSERT INTO `MES_ProductOutbound` VALUES ('80f59df8-dbd6-47c8-b1ee-9700ad876902', 'OB20250317009', '米其林轮胎', 'AKG0000004', '。。。。。。。', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, '件', '2024-01-14 11:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:29', 1, '超级管理员', '2025-03-20 17:37:52');
INSERT INTO `MES_ProductOutbound` VALUES ('84a80744-df64-4b5e-b810-4028f57f405a', 'OB20250317005', 'A4 复印纸', 'AKG0000005', '70g，500 张/包', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, '件', '2024-01-14 11:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:53:48', 1, '超级管理员', '2025-03-20 17:38:15');
INSERT INTO `MES_ProductOutbound` VALUES ('9784e034-5ef3-4a5f-bd4e-6183c2e8ee25', 'OB20250317011', '碳素结构钢', 'AKG0000001', 'Q235B，厚度 5mm', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c8', 12, '箱', '2024-01-15 12:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:39', 1, '超级管理员', '2025-03-20 17:37:41');
INSERT INTO `MES_ProductOutbound` VALUES ('c1151e9d-704b-4abc-b8b9-8989eff162a7', 'OB20250317007', '双层瓦楞纸箱', 'AKG0000004', '尺寸：500mm×300mm×200mm', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, '件', '2024-01-14 11:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:54:23', 1, '超级管理员', '2025-03-20 17:38:02');
INSERT INTO `MES_ProductOutbound` VALUES ('de425c5f-114b-4f25-a5e2-a1e6f6fa166e', 'OB20250317004', '包装纸箱', 'E00X', '50*40*30cm', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c8', 12, '箱', '2024-01-15 12:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:53:44', 1, '超级管理员', '2025-03-17 00:54:06');
INSERT INTO `MES_ProductOutbound` VALUES ('e3b460f4-7caa-4017-92f7-e116b7920a57', 'OB20250317002', '半成品B', 'SP001', '半加工状态', NULL, '3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, '件', '2024-01-14 11:00:00', NULL, NULL, 1, '超级管理员', '2025-03-17 00:38:02', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_ProductionLine
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionLine`;
CREATE TABLE `MES_ProductionLine`  (
  `ProductionLineID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产线ID',
  `LineName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产线名称',
  `LineType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产线类型',
  `Capacity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产能信息',
  `Status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产线状态',
  `ResponsiblePerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `Location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产线位置',
  `StartDate` datetime(0) NULL DEFAULT NULL COMMENT '启用日期',
  `EndDate` datetime(0) NULL DEFAULT NULL COMMENT '停用日期',
  `Remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ProductionLineID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionLine
-- ----------------------------
INSERT INTO `MES_ProductionLine` VALUES ('d44efa4a-028a-11f0-92bb-52540099312c', '手机组装产线 1 号', '电子设备组装线', '每天 5000 部手机', '运行中', '张工', '工厂 1 楼 A 区', '2024-01-01 08:00:00', '2025-03-17 00:00:00', '效率较高', 1, '管理员', '2025-03-17 01:19:33', 1, '超级管理员', '2025-03-17 01:36:33');
INSERT INTO `MES_ProductionLine` VALUES ('d44efc2e-028a-11f0-92bb-52540099312c', '汽车发动机零部件加工线', '机械加工线', '每月 3000 套零部件', '运行中', '李工', '工厂 2 楼 B 区', '2024-03-15 09:30:00', '2025-03-17 00:00:00', '质量稳定', 1, '管理员', '2025-03-17 01:19:33', 1, '超级管理员', '2025-03-17 01:36:00');
INSERT INTO `MES_ProductionLine` VALUES ('d44efd10-028a-11f0-92bb-52540099312c', '饼干包装产线 2 号', '食品包装线', '每小时 10000 包饼干', '运行中', '王工', '工厂 3 楼 C 区', '2024-05-20 10:15:00', '2025-03-17 00:00:00', '包装精美', 1, '管理员', '2025-03-17 01:19:33', 1, '超级管理员', '2025-03-17 01:49:46');
INSERT INTO `MES_ProductionLine` VALUES ('d44efd6c-028a-11f0-92bb-52540099312c', '衬衫裁剪产线', '服装裁剪线', '每周 2000 件衬衫裁剪量', '运行中', '赵工', '工厂 4 楼 D 区', '2024-07-05 11:00:00', '2025-03-17 00:00:00', '裁剪精度高', 1, '管理员', '2025-03-17 01:19:33', 1, '超级管理员', '2025-03-17 01:21:04');
INSERT INTO `MES_ProductionLine` VALUES ('d44efdbd-028a-11f0-92bb-52540099312c', '平板电脑检测线', '电子产品检测线', '每天 2000 台平板电脑', '运行中', '孙工', '工厂 5 楼 E 区', '2024-09-10 14:45:00', '2025-03-17 00:00:00', '检测全面', 1, '管理员', '2025-03-17 01:19:33', 1, '超级管理员', '2025-03-17 01:21:07');

-- ----------------------------
-- Table structure for MES_ProductionLineDevice
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionLineDevice`;
CREATE TABLE `MES_ProductionLineDevice`  (
  `DeviceID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备ID',
  `ProductionLineID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产线ID',
  `DeviceName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备名称',
  `DeviceModel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备型号',
  `Manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '制造商',
  `PurchaseDate` datetime(0) NULL DEFAULT NULL COMMENT '购买日期',
  `WarrantyDate` datetime(0) NULL DEFAULT NULL COMMENT '保修日期',
  `Status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备状态',
  `LocationOnLine` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '线上位置',
  `Remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`DeviceID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionLineDevice
-- ----------------------------
INSERT INTO `MES_ProductionLineDevice` VALUES ('000fc915-0453-4938-a964-c63c13b00b15', 'd44efd10-028a-11f0-92bb-52540099312c', '奥利奥', '奥利奥', '奥利奥', '2025-03-17 00:00:00', '2025-03-18 00:00:00', '异常', NULL, '奥利奥', 1, '超级管理员', '2025-03-17 01:49:46', 1, '超级管理员', '2025-03-17 01:49:45');
INSERT INTO `MES_ProductionLineDevice` VALUES ('164d145d-7672-4993-b994-cb0cdbe12e77', 'd44efa4a-028a-11f0-92bb-52540099312c', '贴片机', 'TA0001', '台积电', '2025-03-03 00:00:00', '2025-03-18 00:00:00', '正常', NULL, '....', 1, '超级管理员', '2025-03-17 01:34:42', 1, '超级管理员', '2025-03-17 01:36:33');
INSERT INTO `MES_ProductionLineDevice` VALUES ('6b98a0c9-988b-401e-aff9-aa88440c80d7', 'd44efa4a-028a-11f0-92bb-52540099312c', '点胶机', 'TA0002', NULL, '2025-03-10 00:00:00', '2025-03-19 00:00:00', '正常', NULL, '...', 1, '超级管理员', '2025-03-17 01:36:33', 1, '超级管理员', '2025-03-17 01:36:32');
INSERT INTO `MES_ProductionLineDevice` VALUES ('8a9567b6-ab7a-4194-a152-aab255ba0c72', 'd44efd10-028a-11f0-92bb-52540099312c', '奥利奥plus', '奥利奥plus', '奥利奥plus', '2025-03-12 00:00:00', '2025-03-11 00:00:00', '正常', NULL, '奥利奥plus', 1, '超级管理员', '2025-03-17 01:49:46', 1, '超级管理员', '2025-03-17 01:49:45');
INSERT INTO `MES_ProductionLineDevice` VALUES ('a6ac613e-241a-41fa-a4cc-e5f08d0a0dce', 'd44efc2e-028a-11f0-92bb-52540099312c', '磨床', 'CA0002', '..。', '2025-03-11 00:00:00', NULL, '正常', NULL, '12..。', 1, '超级管理员', '2025-03-17 01:36:00', 1, '超级管理员', '2025-03-17 01:35:59');
INSERT INTO `MES_ProductionLineDevice` VALUES ('cd9a6f48-5d81-46c4-9189-7f7c5fc9e163', 'd44efc2e-028a-11f0-92bb-52540099312c', '车床', 'CA0001', 'xxxx', '2025-03-03 00:00:00', NULL, '正常', NULL, '11', 1, '超级管理员', '2025-03-17 01:36:00', 1, '超级管理员', '2025-03-17 01:35:59');

-- ----------------------------
-- Table structure for MES_ProductionOrder
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionOrder`;
CREATE TABLE `MES_ProductionOrder`  (
  `OrderID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单ID',
  `OrderNumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `CustomerName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `OrderDate` datetime(0) NOT NULL COMMENT '订单日期',
  `DeliveryDate` datetime(0) NOT NULL COMMENT '交货日期',
  `OrderQty` int(11) NULL DEFAULT NULL COMMENT '订单数量',
  `OrderStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产状态',
  `LV` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '优先级',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`OrderID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionOrder
-- ----------------------------
INSERT INTO `MES_ProductionOrder` VALUES ('6648a795-02f5-11f0-92bb-52540099312c', 'PO00000005', '阳光电子集团', '2024-01-05 13:00:00', '2024-02-05 21:00:00', 300, '待生产', '1', 1, 'admin', '2024-01-05 13:00:00', 1, '超级管理员', '2025-03-18 14:50:47');
INSERT INTO `MES_ProductionOrder` VALUES ('6648abb7-02f5-11f0-92bb-52540099312c', 'PO00000004', '瑞风科技有限公司', '2024-01-04 12:00:00', '2024-02-04 20:00:00', 8000, '待生产', '1', 1, 'admin', '2024-01-04 12:00:00', 1, '超级管理员', '2025-03-18 14:50:49');
INSERT INTO `MES_ProductionOrder` VALUES ('6648aca8-02f5-11f0-92bb-52540099312c', 'PO00000003', '星辰电子公司', '2024-01-03 11:00:00', '2024-02-03 19:00:00', 1700, '生产中', '1', 1, 'admin', '2024-01-03 11:00:00', 1, '超级管理员', '2025-03-18 14:50:51');

-- ----------------------------
-- Table structure for MES_ProductionPlanChangeRecord
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionPlanChangeRecord`;
CREATE TABLE `MES_ProductionPlanChangeRecord`  (
  `ChangeRecordID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '变更记录ID',
  `PlanDetailID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计划明细ID',
  `OrderNumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `CustomerName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `OrderDate` datetime(0) NULL DEFAULT NULL COMMENT '订单日期',
  `ChangeDate` datetime(0) NOT NULL COMMENT '变更日期',
  `OriginalPlanQuantity` int(11) NOT NULL COMMENT '原计划数量',
  `NewPlanQuantity` int(11) NOT NULL COMMENT '新计划数量',
  `OriginalPlannedStartTime` datetime(0) NULL DEFAULT NULL COMMENT '原计划开始时间',
  `NewPlannedStartTime` datetime(0) NULL DEFAULT NULL COMMENT '新计划开始时间',
  `OriginalPlannedEndTime` datetime(0) NULL DEFAULT NULL COMMENT '原计划结束时间',
  `NewPlannedEndTime` datetime(0) NULL DEFAULT NULL COMMENT '新计划结束时间',
  `ChangeReason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '变更原因',
  `ChangedBy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '变更人',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ChangeRecordID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionPlanChangeRecord
-- ----------------------------
INSERT INTO `MES_ProductionPlanChangeRecord` VALUES ('92fd73c5-f999-4a17-a4f2-fb94253e62da', NULL, 'CA2025021000001', '星星电子', '2025-03-10 00:00:00', '2025-03-18 00:00:00', 12000, 8000, NULL, NULL, NULL, NULL, '。。。。。', 'admin', 1, '超级管理员', '2025-03-17 19:34:06', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_ProductionPlanDetail
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionPlanDetail`;
CREATE TABLE `MES_ProductionPlanDetail`  (
  `PlanDetailID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计划明细ID',
  `OrderID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单ID',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料名称',
  `MaterialSpecification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料规格',
  `Unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `PlanQuantity` int(11) NULL DEFAULT NULL COMMENT '计划数量',
  `PlannedStartTime` datetime(0) NULL DEFAULT NULL COMMENT '计划开始时间',
  `PlannedEndTime` datetime(0) NULL DEFAULT NULL COMMENT '计划结束时间',
  `PlanStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计划状态',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`PlanDetailID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionPlanDetail
-- ----------------------------
INSERT INTO `MES_ProductionPlanDetail` VALUES ('1012861c-89f2-4337-9718-3c79c72d3fd6', '6648aca8-02f5-11f0-92bb-52540099312c', 'AKG0000004', '双层瓦楞纸箱', '尺寸：500mm×300mm×200mm', '件', 800, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 19:08:34', 1, '超级管理员', '2025-03-18 14:50:51');
INSERT INTO `MES_ProductionPlanDetail` VALUES ('40139c6f-6697-489d-8bee-46d888a1bb53', '6648aca8-02f5-11f0-92bb-52540099312c', 'AKG0000005', 'A4 复印纸', '70g，500 张/包', '包', 900, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 19:08:34', 1, '超级管理员', '2025-03-18 14:50:51');
INSERT INTO `MES_ProductionPlanDetail` VALUES ('4d1ed687-fc78-419a-8128-29b0dc75e486', '6648abb7-02f5-11f0-92bb-52540099312c', 'AKG0000002', '架构芯片', 'Cortex - M3 内核，主频 100MHz', '片', 2000, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 19:08:29', 1, '超级管理员', '2025-03-18 14:50:49');
INSERT INTO `MES_ProductionPlanDetail` VALUES ('6a7a9c6f-61f3-4cf4-9c1c-4304f8bc2eff', '6648abb7-02f5-11f0-92bb-52540099312c', 'AKG0000003', '聚乙烯（PE）', '低密度，颗粒状', '件', 2000, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 19:08:29', 1, '超级管理员', '2025-03-18 14:50:49');
INSERT INTO `MES_ProductionPlanDetail` VALUES ('af2d3f94-5912-412d-89a1-26a16d9d00ae', '6648abb7-02f5-11f0-92bb-52540099312c', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', '吨', 4000, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 19:08:29', 1, '超级管理员', '2025-03-18 14:50:49');
INSERT INTO `MES_ProductionPlanDetail` VALUES ('afebc1a7-e112-43a4-a766-2e8987e0dbcc', '6648a795-02f5-11f0-92bb-52540099312c', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', '吨', 100, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 18:43:57', 1, '超级管理员', '2025-03-18 14:50:47');
INSERT INTO `MES_ProductionPlanDetail` VALUES ('c1876253-995a-4303-bc1a-15af7742515a', '6648a795-02f5-11f0-92bb-52540099312c', 'AKG0000002', '架构芯片', 'Cortex - M3 内核，主频 100MHz', '片', 200, NULL, NULL, NULL, 1, '超级管理员', '2025-03-17 18:43:57', 1, '超级管理员', '2025-03-18 14:50:47');

-- ----------------------------
-- Table structure for MES_ProductionReporting
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionReporting`;
CREATE TABLE `MES_ProductionReporting`  (
  `ReportingID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '报工ID',
  `ReportingNumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报工单号',
  `OrderID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单ID',
  `ReportedBy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '报工人',
  `ReportingTime` datetime(0) NULL DEFAULT NULL COMMENT '报工时间',
  `ReportHour` decimal(2, 0) NULL DEFAULT NULL COMMENT '工时(小时)',
  `Total` int(11) NULL DEFAULT NULL COMMENT '报工数量',
  `AcceptedQuantity` int(11) NULL DEFAULT NULL COMMENT '合格数量',
  `RejectedQuantity` int(11) NULL DEFAULT NULL COMMENT '不合格数量',
  `AuditStatus` int(11) NULL DEFAULT NULL COMMENT '审批状态',
  `Auditor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批人',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ReportingID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionReporting
-- ----------------------------
INSERT INTO `MES_ProductionReporting` VALUES ('34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', 'BG202503180007', NULL, '3362', '2024-06-05 19:00:00', 10, 380, 490, 60, 0, NULL, 1, '超级管理员', '2025-03-20 21:42:04', NULL, NULL, '2025-03-20 21:42:04');
INSERT INTO `MES_ProductionReporting` VALUES ('d902044f-abd1-42ab-b3d8-9e63f431b410', 'BG202503180006', NULL, '3362', '2024-06-05 19:00:00', 4, 300, 390, 10, 0, NULL, 1, '超级管理员', '2025-03-20 21:42:04', NULL, NULL, '2025-03-20 21:42:04');
INSERT INTO `MES_ProductionReporting` VALUES ('f8fb5b93-0b38-4892-aa8d-7d3a00b89afd', 'BG202503180004', NULL, '3362', '2024-06-05 19:00:00', 7, 180, 280, 30, 0, NULL, 1, '超级管理员', '2025-03-20 21:42:04', NULL, NULL, '2025-03-20 21:42:04');

-- ----------------------------
-- Table structure for MES_ProductionReportingDetail
-- ----------------------------
DROP TABLE IF EXISTS `MES_ProductionReportingDetail`;
CREATE TABLE `MES_ProductionReportingDetail`  (
  `DetailID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '明细ID',
  `ReportingID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报工ID',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料名称',
  `MaterialSpecification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料规格',
  `ReportHour` decimal(11, 2) NULL DEFAULT NULL COMMENT '工时(小时)',
  `ReportedQuantity` int(11) NOT NULL COMMENT '报工数量',
  `AcceptedQuantity` int(11) NOT NULL COMMENT '合格数量',
  `RejectedQuantity` int(11) NOT NULL COMMENT '不合格数量',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`DetailID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_ProductionReportingDetail
-- ----------------------------
INSERT INTO `MES_ProductionReportingDetail` VALUES ('017f792c-4520-43a8-a649-c5e1ed5a28c1', 'd902044f-abd1-42ab-b3d8-9e63f431b410', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', 1.50, 200, 200, 0, 1, '超级管理员', '2025-03-18 16:09:41', 1, '超级管理员', '2025-03-18 15:58:24');
INSERT INTO `MES_ProductionReportingDetail` VALUES ('0ae90653-97a9-43a2-9ede-a38967d7b434', '34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', 1.50, 200, 200, 0, 1, '超级管理员', '2025-03-18 16:09:52', 1, '超级管理员', '2025-03-18 16:09:24');
INSERT INTO `MES_ProductionReportingDetail` VALUES ('3f665f4b-ace1-4644-a706-d31552c84cb5', 'f8fb5b93-0b38-4892-aa8d-7d3a00b89afd', 'AKG0000004', '米其林轮胎', '。。。。。。。', 5.00, 80, 90, 20, 1, '超级管理员', '2025-03-18 16:09:20', NULL, NULL, NULL);
INSERT INTO `MES_ProductionReportingDetail` VALUES ('7d48b30b-8b7c-4403-abf8-690e52762e44', '34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', 'AKG0000004', '米其林轮胎', '。。。。。。。', 6.00, 80, 100, 50, 1, '超级管理员', '2025-03-18 16:09:52', 1, '超级管理员', '2025-03-18 16:09:24');
INSERT INTO `MES_ProductionReportingDetail` VALUES ('c1cf52d2-e98a-43ba-92de-3c757d7c41f1', 'f8fb5b93-0b38-4892-aa8d-7d3a00b89afd', 'AKG0000002', '架构芯片', 'Cortex - M3 内核，主频 100MHz', 2.00, 100, 190, 10, 1, '超级管理员', '2025-03-18 16:09:20', 1, '超级管理员', '2025-03-18 15:58:24');
INSERT INTO `MES_ProductionReportingDetail` VALUES ('c437274d-2be9-44ef-b8f0-85b8c6040c31', 'd902044f-abd1-42ab-b3d8-9e63f431b410', 'AKG0000002', '架构芯片', 'Cortex - M3 内核，主频 100MHz', 2.00, 100, 190, 10, 1, '超级管理员', '2025-03-18 16:09:41', 1, '超级管理员', '2025-03-18 15:58:24');
INSERT INTO `MES_ProductionReportingDetail` VALUES ('e13eda90-0c3e-436e-8b49-2631f916dbdc', '34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', 'AKG0000002', '架构芯片', 'Cortex - M3 内核，主频 100MHz', 2.00, 100, 190, 10, 1, '超级管理员', '2025-03-18 16:09:52', 1, '超级管理员', '2025-03-18 16:09:24');

-- ----------------------------
-- Table structure for MES_QualityInspectionPlan
-- ----------------------------
DROP TABLE IF EXISTS `MES_QualityInspectionPlan`;
CREATE TABLE `MES_QualityInspectionPlan`  (
  `InspectionPlanID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验计划ID',
  `InspectionPlanNumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验计划单号',
  `OrderID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单ID',
  `PlanStartTime` datetime(0) NOT NULL COMMENT '计划开始时间',
  `PlanEndTime` datetime(0) NOT NULL COMMENT '计划结束时间',
  `ResponsiblePerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '责任人',
  `PlanStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计划状态',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`InspectionPlanID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_QualityInspectionPlan
-- ----------------------------
INSERT INTO `MES_QualityInspectionPlan` VALUES ('60475294-c153-4c7c-8645-9209d9eb7be4', 'QIP202503190001', NULL, '2024-07-01 09:00:00', '2024-07-02 17:00:00', '3362', NULL, 1, '超级管理员', '2025-03-19 01:48:58', 1, '超级管理员', '2025-03-19 01:50:48');
INSERT INTO `MES_QualityInspectionPlan` VALUES ('6e58e213-f8e9-4032-9dc7-d62d76a418d9', 'QIP202503190003', NULL, '2024-07-01 09:00:00', '2024-07-02 17:00:00', '3362', NULL, 1, '超级管理员', '2025-03-19 01:49:46', 1, '超级管理员', '2025-03-19 01:50:41');
INSERT INTO `MES_QualityInspectionPlan` VALUES ('cc7fe857-0608-4872-8e8b-754e41c4609a', 'QIP202503190002', NULL, '2024-07-01 09:00:00', '2024-07-02 17:00:00', '1', NULL, 1, '超级管理员', '2025-03-19 01:49:40', 1, '超级管理员', '2025-03-19 01:50:44');
INSERT INTO `MES_QualityInspectionPlan` VALUES ('fc4a1634-e1e0-4455-acf8-4d097a95ca56', 'QIP202503190004', NULL, '2024-07-01 09:00:00', '2024-07-02 17:00:00', '1', NULL, 1, '超级管理员', '2025-03-19 01:49:50', 1, '超级管理员', '2025-03-19 01:50:38');

-- ----------------------------
-- Table structure for MES_QualityInspectionPlanDetail
-- ----------------------------
DROP TABLE IF EXISTS `MES_QualityInspectionPlanDetail`;
CREATE TABLE `MES_QualityInspectionPlanDetail`  (
  `InspectionPlanDetailID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验计划明细ID',
  `InspectionPlanID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '检验计划ID',
  `MaterialCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编号',
  `MaterialName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物料名称',
  `MaterialSpecification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料规格',
  `QuantityToInspect` int(11) NOT NULL COMMENT '检验数量',
  `InspectionMethod` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验方法',
  `InspectionStandard` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验标准',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`InspectionPlanDetailID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_QualityInspectionPlanDetail
-- ----------------------------
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('3151bae6-9b91-46cc-8615-11c3cb2afaa6', '6e58e213-f8e9-4032-9dc7-d62d76a418d9', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', 100, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:49:47', 1, '超级管理员', '2025-03-19 01:50:41');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('4c946033-91ae-4f7e-a11e-c9fd20f0e373', 'cc7fe857-0608-4872-8e8b-754e41c4609a', 'AKG0000003', '聚乙烯（PE）', '低密度，颗粒状', 290, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:49:41', 1, '超级管理员', '2025-03-19 01:50:44');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('8270f2e3-71ba-4074-bbd5-c97c981dda3d', '60475294-c153-4c7c-8645-9209d9eb7be4', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', 100, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:48:59', 1, '超级管理员', '2025-03-19 01:50:48');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('89d373c2-5fce-4915-a661-0f10d47112a5', '6e58e213-f8e9-4032-9dc7-d62d76a418d9', 'AKG0000003', '聚乙烯（PE）', '低密度，颗粒状', 290, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:49:47', 1, '超级管理员', '2025-03-19 01:50:41');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('b7ad76cd-0c56-40da-beee-0a096148b00f', '60475294-c153-4c7c-8645-9209d9eb7be4', 'AKG0000003', '聚乙烯（PE）', '低密度，颗粒状', 290, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:48:59', 1, '超级管理员', '2025-03-19 01:50:48');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('bb066d57-83ad-45c5-bb6e-3041b1ea65f6', 'fc4a1634-e1e0-4455-acf8-4d097a95ca56', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', 100, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:49:51', 1, '超级管理员', '2025-03-19 01:50:38');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('c6291518-07ca-4abd-bd9a-63f51ff4a68f', 'fc4a1634-e1e0-4455-acf8-4d097a95ca56', 'AKG0000003', '聚乙烯（PE）', '低密度，颗粒状', 290, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:49:51', 1, '超级管理员', '2025-03-19 01:50:38');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('e29789ce-3501-4a57-87d6-9ea292f193f8', 'cc7fe857-0608-4872-8e8b-754e41c4609a', 'AKG0000001', '碳素结构钢', 'Q235B，厚度 5mm', 100, '抽样检查', '抽样检查', 1, '超级管理员', '2025-03-19 01:49:41', 1, '超级管理员', '2025-03-19 01:50:44');
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('ec9d80f7-041f-11f0-92bb-52540099312c', 'e92bea50-041f-11f0-92bb-52540099312c', 'M001', '电阻', '100Ω', 500, '抽样检验', '阻值偏差±5%', 1, 'admin', '2024-07-01 08:00:00', NULL, NULL, NULL);
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('ec9d82a2-041f-11f0-92bb-52540099312c', 'e92becd6-041f-11f0-92bb-52540099312c', 'M002', '电容', '10μF', 300, '全检', '容量偏差±3%', 1, 'admin', '2024-07-03 09:00:00', NULL, NULL, NULL);
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('ec9d83cd-041f-11f0-92bb-52540099312c', 'e92bed65-041f-11f0-92bb-52540099312c', 'M003', '线路板', 'PCB-A100', 200, '功能测试', '无短路、断路', 1, 'admin', '2024-07-05 10:00:00', NULL, NULL, NULL);
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('ec9d8477-041f-11f0-92bb-52540099312c', 'e92bedcf-041f-11f0-92bb-52540099312c', 'M004', '塑料粒子', 'PP-500', 400, '外观检验', '无杂质、色泽均匀', 1, 'admin', '2024-07-07 11:00:00', NULL, NULL, NULL);
INSERT INTO `MES_QualityInspectionPlanDetail` VALUES ('ec9d8507-041f-11f0-92bb-52540099312c', 'e92bee39-041f-11f0-92bb-52540099312c', 'M005', '螺丝', 'M3x10', 600, '尺寸检验', '直径偏差±0.1mm', 1, 'admin', '2024-07-09 12:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MES_QualityInspectionRecord
-- ----------------------------
DROP TABLE IF EXISTS `MES_QualityInspectionRecord`;
CREATE TABLE `MES_QualityInspectionRecord`  (
  `InspectionRecordID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验记录ID',
  `InspectionPlanDetailID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '检验计划明细ID',
  `InspectionNumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验单号',
  `Inspector` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验员',
  `InspectionTime` datetime(0) NOT NULL COMMENT '检验时间',
  `InspectedQuantity` int(11) NOT NULL COMMENT '实际检验数量',
  `PassedQuantity` int(11) NOT NULL COMMENT '合格数量',
  `FailedQuantity` int(11) NOT NULL COMMENT '不合格数量',
  `InspectionResult` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检验结果（合格、不合格）',
  `DefectDescription` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缺陷描述',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`InspectionRecordID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_QualityInspectionRecord
-- ----------------------------
INSERT INTO `MES_QualityInspectionRecord` VALUES ('f769acb9-0421-11f0-92bb-52540099312c', 'ff1b025b-0421-11f0-92bb-52540099312c', 'QIR001', '1', '2024-07-01 10:00:00', 500, 480, 20, '不合格', '部分电阻阻值偏差超过±5%', 1, 'admin', '2024-07-01 10:00:00', 1, '超级管理员', '2025-03-19 01:56:01');
INSERT INTO `MES_QualityInspectionRecord` VALUES ('f769ae7c-0421-11f0-92bb-52540099312c', 'ff1b049d-0421-11f0-92bb-52540099312c', 'QIR002', '3362', '2024-07-03 11:00:00', 300, 290, 10, '不合格', '少数电容容量偏差超过±3%', 1, 'admin', '2024-07-03 11:00:00', 1, '超级管理员', '2025-03-19 01:55:58');
INSERT INTO `MES_QualityInspectionRecord` VALUES ('f769af6b-0421-11f0-92bb-52540099312c', 'ff1b0534-0421-11f0-92bb-52540099312c', 'QIR003', '3362', '2024-07-05 12:00:00', 200, 190, 10, '不合格', '几块线路板存在短路问题', 1, 'admin', '2024-07-05 12:00:00', 1, '超级管理员', '2025-03-19 01:55:54');
INSERT INTO `MES_QualityInspectionRecord` VALUES ('f769b023-0421-11f0-92bb-52540099312c', 'ff1b05a7-0421-11f0-92bb-52540099312c', 'QIR004', '3362', '2024-07-07 13:00:00', 400, 380, 20, '合格', '部分塑料粒子有杂质', 1, 'admin', '2024-07-07 13:00:00', 1, '超级管理员', '2025-03-19 01:56:49');
INSERT INTO `MES_QualityInspectionRecord` VALUES ('f769b22d-0421-11f0-92bb-52540099312c', 'ff1b0616-0421-11f0-92bb-52540099312c', 'QIR005', '1', '2024-07-09 14:00:00', 600, 570, 30, '合格', '部分螺丝直径偏差超过±0.1mm', 1, 'admin', '2024-07-09 14:00:00', 1, '超级管理员', '2025-03-19 01:56:46');

-- ----------------------------
-- Table structure for MES_SchedulingPlan
-- ----------------------------
DROP TABLE IF EXISTS `MES_SchedulingPlan`;
CREATE TABLE `MES_SchedulingPlan`  (
  `SchedulePlanID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '排班计划ID',
  `PlanName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '排班计划名称',
  `ProductionLine` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产线名称',
  `TeamName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班组名称',
  `StartDate` datetime(0) NOT NULL COMMENT '开始时间',
  `EndDate` datetime(0) NOT NULL COMMENT '结束时间',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`SchedulePlanID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_SchedulingPlan
-- ----------------------------
INSERT INTO `MES_SchedulingPlan` VALUES ('9c2c24f1-0422-11f0-92bb-52540099312c', 'SMT产线1月排班计划', 'SMT贴片生产线', 'SMT一组', '2024-01-01 08:00:00', '2024-01-31 17:00:00', 1, 'admin', '2024-01-01 09:00:00', 1, '超级管理员', '2025-03-19 02:00:45');
INSERT INTO `MES_SchedulingPlan` VALUES ('9c2c268a-0422-11f0-92bb-52540099312c', '注塑产线1月排班计划', '注塑生产线', '注塑一组', '2024-01-01 09:00:00', '2024-01-31 18:00:00', 1, 'admin', '2024-01-02 10:00:00', 1, '超级管理员', '2025-03-19 02:00:44');
INSERT INTO `MES_SchedulingPlan` VALUES ('9c2c279a-0422-11f0-92bb-52540099312c', '总装产线1月排班计划', '总装生产线', '总装一组', '2024-01-01 10:00:00', '2024-01-31 19:00:00', 1, 'admin', '2024-01-03 11:00:00', 1, '超级管理员', '2025-03-19 02:00:42');
INSERT INTO `MES_SchedulingPlan` VALUES ('9c2c2835-0422-11f0-92bb-52540099312c', '检测产线1月排班计划', '检测生产线', '检测一组', '2024-01-01 11:00:00', '2024-01-31 20:00:00', 1, 'admin', '2024-01-04 12:00:00', 1, '超级管理员', '2025-03-19 02:00:40');
INSERT INTO `MES_SchedulingPlan` VALUES ('9c2c28b9-0422-11f0-92bb-52540099312c', '包装产线1月排班计划', '包装生产线', '包装一组', '2024-01-01 12:00:00', '2024-01-31 21:00:00', 1, 'admin', '2024-01-05 13:00:00', 1, '超级管理员', '2025-03-19 02:00:38');

-- ----------------------------
-- Table structure for MES_Supplier
-- ----------------------------
DROP TABLE IF EXISTS `MES_Supplier`;
CREATE TABLE `MES_Supplier`  (
  `SupplierID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商ID',
  `SupplierName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商名',
  `ContactPerson` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `ContactPhone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `Address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `SupplierType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商类型',
  `ProductRange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应范围',
  `QualityRating` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '质量评级',
  `Remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`SupplierID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_Supplier
-- ----------------------------
INSERT INTO `MES_Supplier` VALUES ('fd83f9a1-0289-11f0-92bb-52540099312c', '绿韵包装材料供应商', '刘女士', '13378901234', 'lvyun@example.com', '杭州市西湖区', '包装材料供应商', '环保包装材料', 'A', '。。。。。。。。。', 1, '管理员', '2025-03-17 01:13:33', 1, '超级管理员', '2025-03-17 01:14:36');
INSERT INTO `MES_Supplier` VALUES ('fd83fb2f-0289-11f0-92bb-52540099312c', '宝盛包装用品供应商', '孙先生', '13289012345', 'baosheng@example.com', '南京市鼓楼区', '包装材料供应商', '各类包装用品', 'B', '。。。。。。', 1, '管理员', '2025-03-17 01:13:33', 1, '超级管理员', '2025-03-17 01:14:53');
INSERT INTO `MES_Supplier` VALUES ('fd83fb7b-0289-11f0-92bb-52540099312c', '逸彩印刷包装供应商', '周先生', '13190123456', 'yicai@example.com', '成都市武侯区', '包装材料供应商', '印刷包装产品', 'A', '印刷工艺。。。。。。', 1, '管理员', '2025-03-17 01:13:33', 1, '超级管理员', '2025-03-17 01:14:59');
INSERT INTO `MES_Supplier` VALUES ('fd8f3146-0289-11f0-92bb-52540099312c', '宏泰生产设备供应商', '吴先生', '13001234567', 'hongtai@example.com', '武汉市武昌区', '设备供应商', '生产设备', 'A', '。。。。。。', 1, '管理员', '2025-03-17 01:13:33', 1, '超级管理员', '2025-03-17 01:15:03');
INSERT INTO `MES_Supplier` VALUES ('fd8f32c3-0289-11f0-92bb-52540099312c', '锐翔检测设备供应商', '郑女士', '18812345678', 'ruixiang@example.com', '西安市碑林区', '设备供应商', '检测设备', 'B', '检测精度较高。。。。。。', 1, '管理员', '2025-03-17 01:13:33', 1, '超级管理员', '2025-03-17 01:15:11');
INSERT INTO `MES_Supplier` VALUES ('fd8f3302-0289-11f0-92bb-52540099312c', '丰能能源设备供应商', '钱先生', '18923456789', 'fengneng@example.com', '沈阳市和平区', '设备供应商', '能源设备', 'A', '。。。。。。', 1, '管理员', '2025-03-17 01:13:33', 1, '超级管理员', '2025-03-17 01:15:07');

-- ----------------------------
-- Table structure for MES_WarehouseManagement
-- ----------------------------
DROP TABLE IF EXISTS `MES_WarehouseManagement`;
CREATE TABLE `MES_WarehouseManagement`  (
  `WarehouseID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库ID',
  `WarehouseCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库编码',
  `WarehouseName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库名称',
  `WarehouseType` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库类型',
  `WarehouseArea` decimal(10, 2) NOT NULL COMMENT '仓库面积',
  `WarehouseAddress` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库地址',
  `WarehousePhone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库电话',
  `WarehouseManager` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库管理员',
  `WarehouseStatus` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库状态',
  `WarehouseCapacity` int(11) NOT NULL COMMENT '仓库容量',
  `CreateID` int(11) NULL DEFAULT NULL COMMENT '创建人ID',
  `Creator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CreateDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ModifyID` int(11) NULL DEFAULT NULL COMMENT '修改人ID',
  `Modifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `ModifyDate` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`WarehouseID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MES_WarehouseManagement
-- ----------------------------
INSERT INTO `MES_WarehouseManagement` VALUES ('1c19c214-9d78-4596-b078-789f7755896a', 'WH001', '原材料仓库', '原材料存储', 1000.50, '工厂A区', '021-12345678', '李明', '1', 5000, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:16:34');
INSERT INTO `MES_WarehouseManagement` VALUES ('1c19c214-9d78-4596-b078-789f7755896b', 'WH002', '成品仓库', '成品存储', 1200.00, '工厂B区', '021-23456789', '张华', '1', 6000, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:16:37');
INSERT INTO `MES_WarehouseManagement` VALUES ('1c19c214-9d78-4596-b078-789f7755896c', 'WH003', '半成品仓库', '半成品存储', 800.25, '工厂C区', '021-34567890', '王强', '0', 3500, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:16:44');
INSERT INTO `MES_WarehouseManagement` VALUES ('1c19c214-9d78-4596-b078-789f7755896d', 'WH004', '不良品仓库', '不良品暂存', 300.75, '工厂D区', '021-45678901', '刘悦', '1', 1000, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:16:41');
INSERT INTO `MES_WarehouseManagement` VALUES ('1c19c214-9d78-4596-b078-789f7755896e', 'WH005', '包装材料仓库', '包装材料存储', 650.00, '工厂E区', '021-56789012', '陈杰', '0', 4500, 1, 'admin', '2025-03-16 23:16:24', 1, '超级管理员', '2025-03-17 00:16:47');

-- ----------------------------
-- Table structure for TestDb
-- ----------------------------
DROP TABLE IF EXISTS `TestDb`;
CREATE TABLE `TestDb`  (
  `Id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TestDbName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TestDbContent` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CreateDate` datetime(0) NULL DEFAULT NULL,
  `CreateID` int(11) NULL DEFAULT NULL,
  `Creator` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Modifier` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ModifyDate` datetime(0) NULL DEFAULT NULL,
  `ModifyID` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TestDb
-- ----------------------------

-- ----------------------------
-- Table structure for TestService
-- ----------------------------
DROP TABLE IF EXISTS `TestService`;
CREATE TABLE `TestService`  (
  `Id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DbName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DbContent` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CreateDate` datetime(0) NULL DEFAULT NULL,
  `CreateID` int(11) NULL DEFAULT NULL,
  `Creator` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Modifier` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ModifyDate` datetime(0) NULL DEFAULT NULL,
  `ModifyID` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TestService
-- ----------------------------
INSERT INTO `TestService` VALUES ('C0737155-AC39-4F35-87DC-22DD83896CAD', '这是业务数据库', '这是业务数据库。。', '2023-05-19 11:46:34', 3362, '测试管理员', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
