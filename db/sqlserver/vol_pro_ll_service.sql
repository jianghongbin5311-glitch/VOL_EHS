
USE [vol_pro_ll_service]
GO
/****** Object:  Table [dbo].[MES_Bom_Detail]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_Bom_Detail](
	[DomDetailId] uniqueidentifier NOT NULL,
	[BomId] uniqueidentifier NULL,
	[Sequence] [int] NOT NULL,
	[MaterialCode] [nvarchar](200) NULL,
	[MaterialName] [nvarchar](300) NULL,
	[Spec] [nvarchar](200) NULL,
	[UsageQty] [decimal](24, 3) NOT NULL,
	[ConsumeModel] [nvarchar](100) NOT NULL,
	[Warehouse] [nvarchar](100) NULL,
	[SupplierCode] [nvarchar](50) NULL,
	[KitScale] [decimal](24, 3) NULL,
	[Enable] [int] NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](50) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](50) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[DomDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_Bom_Main]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_Bom_Main](
	[BomId] uniqueidentifier NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[MaterialCode] [nvarchar](200) NULL,
	[MaterialName] [nvarchar](300) NULL,
	[Spec] [nvarchar](400) NULL,
	[Purpose] [nvarchar](50) NULL,
	[Edition] [nvarchar](50) NULL,
	[EffectiveDate] datetime NOT NULL,
	[InvalidDate] datetime NOT NULL,
	[Enable] [int] NOT NULL,
	[CreateID] [int] NOT NULL,
	[Creator] [nvarchar](50) NOT NULL,
	[CreateDate] datetime NOT NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](50) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[BomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_Customer]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_Customer](
	[CustomerID] uniqueidentifier NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[ContactPhone] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[CustomerType] [nvarchar](100) NULL,
	[CreditRating] [nvarchar](100) NULL,
	[BusinessScope] [nvarchar](100) NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_DefectiveProductDisposalRecord]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_DefectiveProductDisposalRecord](
	[DisposalRecordID] uniqueidentifier NOT NULL,
	[DefectiveID] uniqueidentifier NULL,
	[DisposalPerson] [nvarchar](100) NULL,
	[DisposalStartTime] datetime NULL,
	[DisposalEndTime] datetime NULL,
	[DisposalResult] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[DisposalRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_DefectiveProductRecord]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_DefectiveProductRecord](
	[DefectiveID] uniqueidentifier NOT NULL,
	[ReportingID] uniqueidentifier NULL,
	[MaterialCode] [nvarchar](100) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[MaterialSpecification] [nvarchar](100) NOT NULL,
	[DefectiveQuantity] [int] NOT NULL,
	[DefectType] [nvarchar](100) NOT NULL,
	[DefectReason] [nvarchar](100) NOT NULL,
	[DisposalMethod] [nvarchar](100) NOT NULL,
	[DisposalStatus] [nvarchar](100) NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[DefectiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_EquipmentFaultRecord]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_EquipmentFaultRecord](
	[FaultRecordID] uniqueidentifier NOT NULL,
	[EquipmentID] uniqueidentifier NULL,
	[FaultDate] datetime NULL,
	[FaultType] [nvarchar](100) NULL,
	[FaultDescription] [nvarchar](100) NULL,
	[FaultImpact] [nvarchar](100) NULL,
	[FaultReportedBy] [nvarchar](100) NULL,
	[FaultStatus] [nvarchar](100) NULL,
	[TroubleshootingStartTime] datetime NULL,
	[TroubleshootingEndTime] datetime NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[FaultRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_EquipmentMaintenance]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_EquipmentMaintenance](
	[MaintenanceID] uniqueidentifier NOT NULL,
	[EquipmentID] uniqueidentifier NULL,
	[MaintenanceDate] datetime NULL,
	[MaintenanceType] [nvarchar](100) NULL,
	[MaintenanceContent] [nvarchar](100) NULL,
	[MaintenancePerson] [nvarchar](100) NULL,
	[MaintenanceStatus] [nvarchar](100) NULL,
	[NextMaintenanceDate] datetime NULL,
	[MaintenanceCost] [decimal](10, 2) NULL,
	[MaintenanceRemarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[MaintenanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_EquipmentManagement]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_EquipmentManagement](
	[EquipmentID] uniqueidentifier NOT NULL,
	[EquipmentCode] [nvarchar](100) NOT NULL,
	[EquipmentName] [nvarchar](100) NOT NULL,
	[EquipmentType] [nvarchar](100) NULL,
	[Manufacturer] [nvarchar](100) NULL,
	[PurchaseDate] datetime NULL,
	[WarrantyPeriod] [int] NULL,
	[InstallationLocation] [nvarchar](100) NULL,
	[EquipmentStatus] [nvarchar](100) NULL,
	[ResponsiblePerson] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_EquipmentRepair]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_EquipmentRepair](
	[RepairID] uniqueidentifier NOT NULL,
	[EquipmentID] uniqueidentifier NULL,
	[RepairDate] datetime NULL,
	[RepairReason] [nvarchar](100) NULL,
	[RepairContent] [nvarchar](100) NULL,
	[RepairPerson] [nvarchar](100) NULL,
	[RepairCost] [decimal](10, 2) NULL,
	[RepairStatus] [nvarchar](100) NULL,
	[RepairStartTime] datetime NULL,
	[RepairEndTime] datetime NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[RepairID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_InventoryManagement]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_InventoryManagement](
	[InventoryID] uniqueidentifier NOT NULL,
	[DocumentNo] [nvarchar](100) NULL,
	[MaterialName] [nvarchar](100) NULL,
	[MaterialCode] [nvarchar](100) NULL,
	[SpecificationModel] [nvarchar](100) NULL,
	[WarehouseID] uniqueidentifier NULL,
	[LocationID] uniqueidentifier NULL,
	[InventoryQuantity] [int] NOT NULL,
	[InventoryUnit] [nvarchar](100) NULL,
	[InventoryCost] [decimal](10, 2) NOT NULL,
	[InventoryStatus] [nvarchar](100) NULL,
	[InboundDate] datetime NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_LocationManagement]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_LocationManagement](
	[LocationID] uniqueidentifier NOT NULL,
	[WarehouseID] uniqueidentifier NULL,
	[LocationCode] [nvarchar](100) NOT NULL,
	[LocationName] [nvarchar](100) NOT NULL,
	[LocationType] [nvarchar](100) NULL,
	[LocationCapacity] [int] NOT NULL,
	[LocationStatus] [nvarchar](100) NULL,
	[LocationRow] [int] NOT NULL,
	[LocationColumn] [int] NOT NULL,
	[LocationFloor] [int] NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_Material]    Script Date: 2025/3/21 19:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_Material](
	[MaterialID] uniqueidentifier NOT NULL,
	[MaterialCode] [nvarchar](100) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[MaterialType] [nvarchar](100) NULL,
	[CatalogID] uniqueidentifier NULL,
	[Specification] [nvarchar](100) NULL,
	[Unit] [nvarchar](100) NULL,
	[Price] [decimal](10, 2) NULL,
	[Img] [nvarchar](2000) NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_MaterialCatalog]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_MaterialCatalog](
	[CatalogID] uniqueidentifier NOT NULL,
	[CatalogCode] [nvarchar](100) NOT NULL,
	[CatalogName] [nvarchar](100) NOT NULL,
	[CatalogType] [nvarchar](100) NULL,
	[ParentId] uniqueidentifier NULL,
	[Enable] [int] NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[CatalogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_Process]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_Process](
	[ProcessID] uniqueidentifier NOT NULL,
	[ProcessCode] [nvarchar](100) NOT NULL,
	[ProcessName] [nvarchar](100) NOT NULL,
	[ProcessType] [nvarchar](100) NULL,
	[ProcessSequence] [int] NOT NULL,
	[ProcessDescription] [nvarchar](100) NULL,
	[WorkCenter] [nvarchar](100) NULL,
	[StandardWorkingHours] [decimal](10, 2) NOT NULL,
	[ProcessStatus] [nvarchar](100) NULL,
	[ResponsibleWorker] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProcessReport]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProcessReport](
	[ReportID] uniqueidentifier NOT NULL,
	[ProcessID] uniqueidentifier NULL,
	[ReportDate] datetime NOT NULL,
	[CompletedQuantity] [int] NOT NULL,
	[DefectiveQuantity] [int] NOT NULL,
	[ReportedBy] [nvarchar](100) NULL,
	[ReportStatus] [nvarchar](100) NULL,
	[ReportRemarks] [nvarchar](100) NULL,
	[StartTime] datetime NULL,
	[EndTime] datetime NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProcessRoute]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProcessRoute](
	[RouteID] uniqueidentifier NOT NULL,
	[ProcessID] uniqueidentifier NULL,
	[ProductID] [nvarchar](100) NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[RouteSequence] [int] NOT NULL,
	[RouteDescription] [nvarchar](100) NULL,
	[PreProcessID] uniqueidentifier NULL,
	[NextProcessID] uniqueidentifier NULL,
	[RouteStatus] [nvarchar](100) NULL,
	[RouteResponsible] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductInbound]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductInbound](
	[InboundID] uniqueidentifier NOT NULL,
	[DocumentNo] [nvarchar](100) NULL,
	[MaterialName] [nvarchar](100) NULL,
	[MaterialCode] [nvarchar](100) NULL,
	[SpecificationModel] [nvarchar](100) NULL,
	[WarehouseID] uniqueidentifier NULL,
	[LocationID] uniqueidentifier NULL,
	[InboundQuantity] [int] NOT NULL,
	[InboundUnit] [nvarchar](100) NULL,
	[InboundDate] datetime NULL,
	[InboundOperator] [nvarchar](100) NULL,
	[InboundReason] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[InboundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionLine]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionLine](
	[ProductionLineID] uniqueidentifier NOT NULL,
	[LineName] [nvarchar](100) NOT NULL,
	[LineType] [nvarchar](100) NULL,
	[Capacity] [nvarchar](100) NULL,
	[Status] [nvarchar](100) NULL,
	[ResponsiblePerson] [nvarchar](100) NULL,
	[Location] [nvarchar](100) NULL,
	[StartDate] datetime NULL,
	[EndDate] datetime NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionLineDevice]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionLineDevice](
	[DeviceID] uniqueidentifier NOT NULL,
	[ProductionLineID] uniqueidentifier NULL,
	[DeviceName] [nvarchar](100) NOT NULL,
	[DeviceModel] [nvarchar](100) NULL,
	[Manufacturer] [nvarchar](100) NULL,
	[PurchaseDate] datetime NULL,
	[WarrantyDate] datetime NULL,
	[Status] [nvarchar](100) NULL,
	[LocationOnLine] [nvarchar](100) NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[DeviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionOrder]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionOrder](
	[OrderID] uniqueidentifier NOT NULL,
	[OrderNumber] [nvarchar](100) NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[OrderDate] datetime NOT NULL,
	[DeliveryDate] datetime NOT NULL,
	[OrderQty] [int] NULL,
	[OrderStatus] [nvarchar](100) NOT NULL,
	[LV] [nvarchar](255) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionPlanChangeRecord]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionPlanChangeRecord](
	[ChangeRecordID] uniqueidentifier NOT NULL,
	[PlanDetailID] uniqueidentifier NULL,
	[OrderNumber] [nvarchar](100) NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[OrderDate] datetime NULL,
	[ChangeDate] datetime NOT NULL,
	[OriginalPlanQuantity] [int] NOT NULL,
	[NewPlanQuantity] [int] NOT NULL,
	[OriginalPlannedStartTime] datetime NULL,
	[NewPlannedStartTime] datetime NULL,
	[OriginalPlannedEndTime] datetime NULL,
	[NewPlannedEndTime] datetime NULL,
	[ChangeReason] [nvarchar](100) NOT NULL,
	[ChangedBy] [nvarchar](100) NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[ChangeRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionPlanDetail]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionPlanDetail](
	[PlanDetailID] uniqueidentifier NOT NULL,
	[OrderID] uniqueidentifier NULL,
	[MaterialCode] [nvarchar](100) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[MaterialSpecification] [nvarchar](100) NULL,
	[Unit] [nvarchar](100) NULL,
	[PlanQuantity] [int] NULL,
	[PlannedStartTime] datetime NULL,
	[PlannedEndTime] datetime NULL,
	[PlanStatus] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[PlanDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionReporting]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionReporting](
	[ReportingID] uniqueidentifier NOT NULL,
	[ReportingNumber] [nvarchar](100) NULL,
	[OrderID] uniqueidentifier NULL,
	[ReportedBy] [nvarchar](100) NOT NULL,
	[ReportingTime] datetime NULL,
	[ReportHour] [decimal](2, 0) NULL,
	[Total] [int] NULL,
	[AcceptedQuantity] [int] NULL,
	[RejectedQuantity] [int] NULL,
	[AuditStatus] [int] NULL,
	[Auditor] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductionReportingDetail]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductionReportingDetail](
	[DetailID] uniqueidentifier NOT NULL,
	[ReportingID] uniqueidentifier NULL,
	[MaterialCode] [nvarchar](100) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[MaterialSpecification] [nvarchar](100) NOT NULL,
	[ReportHour] [decimal](11, 2) NULL,
	[ReportedQuantity] [int] NOT NULL,
	[AcceptedQuantity] [int] NOT NULL,
	[RejectedQuantity] [int] NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_ProductOutbound]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_ProductOutbound](
	[OutboundID] uniqueidentifier NOT NULL,
	[DocumentNo] [nvarchar](100) NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[MaterialCode] [nvarchar](100) NOT NULL,
	[SpecificationModel] [nvarchar](100) NULL,
	[WarehouseID] uniqueidentifier NULL,
	[LocationID] uniqueidentifier NOT NULL,
	[OutboundQuantity] [int] NOT NULL,
	[OutboundUnit] [nvarchar](100) NULL,
	[OutboundDate] datetime NULL,
	[OutboundOperator] [nvarchar](100) NULL,
	[OutboundReason] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[OutboundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_QualityInspectionPlan]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_QualityInspectionPlan](
	[InspectionPlanID] uniqueidentifier NOT NULL,
	[InspectionPlanNumber] [nvarchar](100) NOT NULL,
	[OrderID] uniqueidentifier NULL,
	[PlanStartTime] datetime NOT NULL,
	[PlanEndTime] datetime NOT NULL,
	[ResponsiblePerson] [nvarchar](100) NOT NULL,
	[PlanStatus] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[InspectionPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_QualityInspectionPlanDetail]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_QualityInspectionPlanDetail](
	[InspectionPlanDetailID] uniqueidentifier NOT NULL,
	[InspectionPlanID] uniqueidentifier NULL,
	[MaterialCode] [nvarchar](100) NOT NULL,
	[MaterialName] [nvarchar](100) NULL,
	[MaterialSpecification] [nvarchar](100) NOT NULL,
	[QuantityToInspect] [int] NOT NULL,
	[InspectionMethod] [nvarchar](100) NOT NULL,
	[InspectionStandard] [nvarchar](100) NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[InspectionPlanDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_QualityInspectionRecord]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_QualityInspectionRecord](
	[InspectionRecordID] uniqueidentifier NOT NULL,
	[InspectionPlanDetailID] uniqueidentifier NULL,
	[InspectionNumber] [nvarchar](100) NOT NULL,
	[Inspector] [nvarchar](100) NOT NULL,
	[InspectionTime] datetime NOT NULL,
	[InspectedQuantity] [int] NOT NULL,
	[PassedQuantity] [int] NOT NULL,
	[FailedQuantity] [int] NOT NULL,
	[InspectionResult] [nvarchar](100) NOT NULL,
	[DefectDescription] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[InspectionRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_SchedulingPlan]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_SchedulingPlan](
	[SchedulePlanID] uniqueidentifier NOT NULL,
	[PlanName] [nvarchar](100) NOT NULL,
	[ProductionLine] [nvarchar](100) NOT NULL,
	[TeamName] [nvarchar](100) NOT NULL,
	[StartDate] datetime NOT NULL,
	[EndDate] datetime NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[SchedulePlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_Supplier]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_Supplier](
	[SupplierID] uniqueidentifier NOT NULL,
	[SupplierName] [nvarchar](100) NOT NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[ContactPhone] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[SupplierType] [nvarchar](100) NULL,
	[ProductRange] [nvarchar](100) NULL,
	[QualityRating] [nvarchar](100) NULL,
	[Remarks] [nvarchar](100) NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MES_WarehouseManagement]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MES_WarehouseManagement](
	[WarehouseID] uniqueidentifier NOT NULL,
	[WarehouseCode] [nvarchar](100) NOT NULL,
	[WarehouseName] [nvarchar](100) NOT NULL,
	[WarehouseType] [nvarchar](100) NULL,
	[WarehouseArea] [decimal](10, 2) NOT NULL,
	[WarehouseAddress] [nvarchar](100) NULL,
	[WarehousePhone] [nvarchar](100) NULL,
	[WarehouseManager] [nvarchar](100) NULL,
	[WarehouseStatus] [nvarchar](100) NULL,
	[WarehouseCapacity] [int] NOT NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[ModifyID] [int] NULL,
	[Modifier] [nvarchar](100) NULL,
	[ModifyDate] datetime NULL,
PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestDb]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestDb](
	[Id] [nchar](36) NOT NULL,
	[TestDbName] [nvarchar](100) NOT NULL,
	[TestDbContent] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](30) NULL,
	[Modifier] [nvarchar](30) NULL,
	[ModifyDate] datetime NULL,
	[ModifyID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestService]    Script Date: 2025/3/21 19:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestService](
	[Id] [nchar](36) NOT NULL,
	[DbName] [nvarchar](100) NOT NULL,
	[DbContent] [nvarchar](100) NULL,
	[CreateDate] datetime NULL,
	[CreateID] [int] NULL,
	[Creator] [nvarchar](30) NULL,
	[Modifier] [nvarchar](30) NULL,
	[ModifyDate] datetime NULL,
	[ModifyID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[MES_Bom_Detail] ([DomDetailId], [BomId], [Sequence], [MaterialCode], [MaterialName], [Spec], [UsageQty], [ConsumeModel], [Warehouse], [SupplierCode], [KitScale], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'401fa70b-ef49-436e-9782-35b6d887759b', N'1dc84b0c-2cd7-4709-b488-df42ce36ab88', 1, N'BO01-0002-4', N'机壳毛坯p38x66.3', N'个', CAST(400.000 AS Decimal(24, 3)), N'推式', N'成品仓库', N'fd83f9a1-0289-11f0-92bb-52540099312c', CAST(1.000 AS Decimal(24, 3)), NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:33:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Detail] ([DomDetailId], [BomId], [Sequence], [MaterialCode], [MaterialName], [Spec], [UsageQty], [ConsumeModel], [Warehouse], [SupplierCode], [KitScale], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'531e804a-df10-499b-ab26-775f68cb35ae', N'd57095e6-ef91-4f00-87cb-82e2dbb633d6', 2, N'BO01-0001-2', N'机壳毛坯p38x66.2', NULL, CAST(200.000 AS Decimal(24, 3)), N'推式', N'成品仓库', N'fd8f3146-0289-11f0-92bb-52540099312c', CAST(1.000 AS Decimal(24, 3)), NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:32:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Detail] ([DomDetailId], [BomId], [Sequence], [MaterialCode], [MaterialName], [Spec], [UsageQty], [ConsumeModel], [Warehouse], [SupplierCode], [KitScale], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'80dc11d2-ace8-479b-b60c-18454bba5cdb', N'1dc84b0c-2cd7-4709-b488-df42ce36ab88', 2, N'BO01-0001-3', N'机壳毛坯p38x66.3', N'个', CAST(300.000 AS Decimal(24, 3)), N'推式', N'成品仓库', N'fd8f3146-0289-11f0-92bb-52540099312c', CAST(1.000 AS Decimal(24, 3)), NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:33:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Detail] ([DomDetailId], [BomId], [Sequence], [MaterialCode], [MaterialName], [Spec], [UsageQty], [ConsumeModel], [Warehouse], [SupplierCode], [KitScale], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'91ad77cf-f062-4c4f-87b2-7fe6ab942bbf', N'0b713f05-5871-471e-8f03-8c0e8654c063', 1, N'BO01-0001', N'机壳镀锌p38x66.1', N'个', CAST(100.000 AS Decimal(24, 3)), N'推式', N'成品仓库', N'fd83f9a1-0289-11f0-92bb-52540099312c', CAST(1.000 AS Decimal(24, 3)), NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:25:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Detail] ([DomDetailId], [BomId], [Sequence], [MaterialCode], [MaterialName], [Spec], [UsageQty], [ConsumeModel], [Warehouse], [SupplierCode], [KitScale], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c88c38b6-cbb5-44c4-a4ea-d9e1192e0359', N'0b713f05-5871-471e-8f03-8c0e8654c063', 2, N'BO01-0001-1', N'机壳镀锌p38x66.1', NULL, CAST(200.000 AS Decimal(24, 3)), N'推式', N'成品仓库', N'fd8f3146-0289-11f0-92bb-52540099312c', CAST(1.000 AS Decimal(24, 3)), NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Detail] ([DomDetailId], [BomId], [Sequence], [MaterialCode], [MaterialName], [Spec], [UsageQty], [ConsumeModel], [Warehouse], [SupplierCode], [KitScale], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ef77c899-95e9-48ab-9958-9ceb752788cd', N'd57095e6-ef91-4f00-87cb-82e2dbb633d6', 1, N'BO01-0002', N'机壳毛坯p38x66.2', N'个', CAST(100.000 AS Decimal(24, 3)), N'推式', N'成品仓库', N'fd83f9a1-0289-11f0-92bb-52540099312c', CAST(1.000 AS Decimal(24, 3)), NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:32:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Main] ([BomId], [Code], [MaterialCode], [MaterialName], [Spec], [Purpose], [Edition], [EffectiveDate], [InvalidDate], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0b713f05-5871-471e-8f03-8c0e8654c063', N'001-BO01-0001', N'001-BO01-0001', N'H1001机壳镀锌p38x66.1', N'个', N'机加工', N'v1.0', CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), 0, 1, N'超级管理员', CAST(N'2025-03-19T01:24:59.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:31:31.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Bom_Main] ([BomId], [Code], [MaterialCode], [MaterialName], [Spec], [Purpose], [Edition], [EffectiveDate], [InvalidDate], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1dc84b0c-2cd7-4709-b488-df42ce36ab88', N'001-BO01-0003', N'001-BO01-0003', N'H1001机壳镀锌p38x66.3', N'个', N'机加工', N'v1.0', CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), 0, 1, N'超级管理员', CAST(N'2025-03-19T01:33:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_Bom_Main] ([BomId], [Code], [MaterialCode], [MaterialName], [Spec], [Purpose], [Edition], [EffectiveDate], [InvalidDate], [Enable], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd57095e6-ef91-4f00-87cb-82e2dbb633d6', N'001-BO01-0002', N'001-BO01-0002', N'H1001机壳镀锌p38x66.1', N'个', N'机加工', N'v1.0', CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), 0, 1, N'超级管理员', CAST(N'2025-03-19T01:32:24.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_Customer] ([CustomerID], [CustomerName], [ContactPerson], [ContactPhone], [Email], [Address], [CustomerType], [CreditRating], [BusinessScope], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0aeb3835-0289-11f0-92bb-52540099312c', N'辉煌科技集团', N'李阳', N'13900139000', N'liyang@huihuang.com', N'北京市海淀区创新大道2号', N'重要客户', N'A', N'通信设备研发与生产', N'业务量大，需重点跟进', 1, N'admin', CAST(N'2023-02-01T09:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_Customer] ([CustomerID], [CustomerName], [ContactPerson], [ContactPhone], [Email], [Address], [CustomerType], [CreditRating], [BusinessScope], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0aeb39e8-0289-11f0-92bb-52540099312c', N'星辰电子公司', N'王芳', N'13600136000', N'wangfang@xingchen.com', N'深圳市南山区创业路3号', N'新客户', N'B+', N'电子零部件生产', N'潜力较大，需加强沟通', 1, N'admin', CAST(N'2023-03-01T10:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_Customer] ([CustomerID], [CustomerName], [ContactPerson], [ContactPhone], [Email], [Address], [CustomerType], [CreditRating], [BusinessScope], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0aeb3aeb-0289-11f0-92bb-52540099312c', N'阳光电子集团', N'陈静', N'13300133000', N'chenjing@yangguang.com', N'杭州市西湖区科技园区5号', N'长期合作客户', N'A', N'LED照明产品制造', N'合作良好，定期回访', 1, N'admin', CAST(N'2023-05-01T12:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_Customer] ([CustomerID], [CustomerName], [ContactPerson], [ContactPhone], [Email], [Address], [CustomerType], [CreditRating], [BusinessScope], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0aeb3b9c-0289-11f0-92bb-52540099312c', N'瑞风科技有限公司', N'赵刚', N'13700137000', N'zhaogang@ruifeng.com', N'广州市天河区软件园4号', N'普通客户', N'B', N'智能家居产品研发', N'偶尔下单，保持联系', 1, N'admin', CAST(N'2023-04-01T11:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_Customer] ([CustomerID], [CustomerName], [ContactPerson], [ContactPhone], [Email], [Address], [CustomerType], [CreditRating], [BusinessScope], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0aeb3c2c-0289-11f0-92bb-52540099312c', N'卓越电子有限公司', N'张悦', N'13800138000', N'zhangyue@zhuoyue.com', N'上海市浦东新区科技路1号', N'长期合作客户', N'A+', N'消费电子产品制造', N'合作多年，订单稳定', 1, N'admin', CAST(N'2023-01-01T08:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO

INSERT [dbo].[MES_DefectiveProductRecord] ([DefectiveID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [DefectiveQuantity], [DefectType], [DefectReason], [DisposalMethod], [DisposalStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'84348030-03e0-11f0-92bb-52540099312c', N'7e80d01e-03e0-11f0-92bb-52540099312c', N'M001', N'电阻', N'100Ω', 20, N'阻值偏差', N'生产工艺问题', N'报废', N'已处理', 1, N'admin', CAST(N'2024-06-01T15:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_DefectiveProductRecord] ([DefectiveID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [DefectiveQuantity], [DefectType], [DefectReason], [DisposalMethod], [DisposalStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'843483f9-03e0-11f0-92bb-52540099312c', N'7e80d290-03e0-11f0-92bb-52540099312c', N'M002', N'电容', N'10μF', 20, N'容量不达标', N'原材料质量问题', N'报废', N'已处理', 1, N'admin', CAST(N'2024-06-02T16:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_DefectiveProductRecord] ([DefectiveID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [DefectiveQuantity], [DefectType], [DefectReason], [DisposalMethod], [DisposalStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'84348505-03e0-11f0-92bb-52540099312c', N'7e80d2d4-03e0-11f0-92bb-52540099312c', N'M003', N'线路板', N'PCB-A100', 20, N'线路短路', N'加工过程失误', N'维修后再检验', N'已处理', 1, N'admin', CAST(N'2024-06-03T17:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_DefectiveProductRecord] ([DefectiveID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [DefectiveQuantity], [DefectType], [DefectReason], [DisposalMethod], [DisposalStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'843485ab-03e0-11f0-92bb-52540099312c', N'7e80d2fe-03e0-11f0-92bb-52540099312c', N'M004', N'塑料粒子', N'PP-500', 50, N'产品变形', N'注塑参数不当', N'报废', N'已处理', 1, N'admin', CAST(N'2024-06-04T18:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_DefectiveProductRecord] ([DefectiveID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [DefectiveQuantity], [DefectType], [DefectReason], [DisposalMethod], [DisposalStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'8434864a-03e0-11f0-92bb-52540099312c', N'7e80d322-03e0-11f0-92bb-52540099312c', N'M005', N'螺丝', N'M3x10', 50, N'螺纹损坏', N'加工精度不够', N'报废', N'已处理', 1, N'admin', CAST(N'2024-06-05T19:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_EquipmentFaultRecord] ([FaultRecordID], [EquipmentID], [FaultDate], [FaultType], [FaultDescription], [FaultImpact], [FaultReportedBy], [FaultStatus], [TroubleshootingStartTime], [TroubleshootingEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f349f43c-0290-11f0-92bb-52540099312c', N'bdbb3938-028f-11f0-92bb-52540099312c', CAST(N'2024-06-01T08:00:00.0000000' AS DateTime2), N'电气故障', N'设备突然断电', N'生产中断', N'李明', N'已解决', CAST(N'2024-06-01T08:15:00.0000000' AS DateTime2), CAST(N'2024-06-01T09:30:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-06-01T08:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:04:14.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentFaultRecord] ([FaultRecordID], [EquipmentID], [FaultDate], [FaultType], [FaultDescription], [FaultImpact], [FaultReportedBy], [FaultStatus], [TroubleshootingStartTime], [TroubleshootingEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f349f60c-0290-11f0-92bb-52540099312c', N'bdbb36ec-028f-11f0-92bb-52540099312c', CAST(N'2024-06-02T09:00:00.0000000' AS DateTime2), N'机械故障', N'模具开合异常', N'影响产品成型质量', N'张华', N'已解决', CAST(N'2024-06-02T09:10:00.0000000' AS DateTime2), CAST(N'2024-06-02T11:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-06-02T09:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:04:11.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentFaultRecord] ([FaultRecordID], [EquipmentID], [FaultDate], [FaultType], [FaultDescription], [FaultImpact], [FaultReportedBy], [FaultStatus], [TroubleshootingStartTime], [TroubleshootingEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f349f707-0290-11f0-92bb-52540099312c', N'bdbb37ef-028f-11f0-92bb-52540099312c', CAST(N'2024-06-03T10:00:00.0000000' AS DateTime2), N'软件故障', N'检测程序报错', N'无法正常检测产品', N'陈丽', N'已解决', CAST(N'2024-06-03T10:15:00.0000000' AS DateTime2), CAST(N'2024-06-03T12:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-06-03T10:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:04:05.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentFaultRecord] ([FaultRecordID], [EquipmentID], [FaultDate], [FaultType], [FaultDescription], [FaultImpact], [FaultReportedBy], [FaultStatus], [TroubleshootingStartTime], [TroubleshootingEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f349f7b4-0290-11f0-92bb-52540099312c', N'bdbb3938-028f-11f0-92bb-52540099312c', CAST(N'2024-06-04T11:00:00.0000000' AS DateTime2), N'传感器故障', N'螺丝拧紧量检测传感器失灵', N'螺丝拧紧质量不稳定', N'王强', N'已解决', CAST(N'2024-06-04T11:10:00.0000000' AS DateTime2), CAST(N'2024-06-04T13:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-06-04T11:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:04:01.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentFaultRecord] ([FaultRecordID], [EquipmentID], [FaultDate], [FaultType], [FaultDescription], [FaultImpact], [FaultReportedBy], [FaultStatus], [TroubleshootingStartTime], [TroubleshootingEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f349f849-0290-11f0-92bb-52540099312c', N'bdbb34f1-028f-11f0-92bb-52540099312c', CAST(N'2024-06-05T12:00:00.0000000' AS DateTime2), N'加热故障', N'回流焊温度达不到设定值', N'焊接效果不佳', N'李明', N'已解决', CAST(N'2024-06-05T12:15:00.0000000' AS DateTime2), CAST(N'2024-06-05T14:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-06-05T12:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:03:57.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentMaintenance] ([MaintenanceID], [EquipmentID], [MaintenanceDate], [MaintenanceType], [MaintenanceContent], [MaintenancePerson], [MaintenanceStatus], [NextMaintenanceDate], [MaintenanceCost], [MaintenanceRemarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f488d2d-0291-11f0-92bb-52540099312c', N'bdbb3938-028f-11f0-92bb-52540099312c', CAST(N'2024-02-06T09:00:00.0000000' AS DateTime2), N'日常保养', N'润滑机械部件、检查电路', N'王师傅', N'已完成', CAST(N'2024-03-06T09:00:00.0000000' AS DateTime2), CAST(600.00 AS Decimal(10, 2)), N'无异常', 1, N'admin', CAST(N'2024-02-06T09:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:06:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentMaintenance] ([MaintenanceID], [EquipmentID], [MaintenanceDate], [MaintenanceType], [MaintenanceContent], [MaintenancePerson], [MaintenanceStatus], [NextMaintenanceDate], [MaintenanceCost], [MaintenanceRemarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f488e2d-0291-11f0-92bb-52540099312c', N'bdbb36ec-028f-11f0-92bb-52540099312c', CAST(N'2024-03-07T10:00:00.0000000' AS DateTime2), N'深度保养', N'更换易损件、全面检测', N'张师傅', N'已完成', CAST(N'2024-04-07T10:00:00.0000000' AS DateTime2), CAST(1200.00 AS Decimal(10, 2)), N'设备性能稳定', 1, N'admin', CAST(N'2024-03-07T10:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:06:33.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentMaintenance] ([MaintenanceID], [EquipmentID], [MaintenanceDate], [MaintenanceType], [MaintenanceContent], [MaintenancePerson], [MaintenanceStatus], [NextMaintenanceDate], [MaintenanceCost], [MaintenanceRemarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f488eea-0291-11f0-92bb-52540099312c', N'bdbb36ec-028f-11f0-92bb-52540099312c', CAST(N'2024-04-08T11:00:00.0000000' AS DateTime2), N'定期保养', N'清洁、调试设备', N'李师傅', N'已完成', CAST(N'2024-05-08T11:00:00.0000000' AS DateTime2), CAST(900.00 AS Decimal(10, 2)), N'设备正常运行', 1, N'admin', CAST(N'2024-04-08T11:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:06:29.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentMaintenance] ([MaintenanceID], [EquipmentID], [MaintenanceDate], [MaintenanceType], [MaintenanceContent], [MaintenancePerson], [MaintenanceStatus], [NextMaintenanceDate], [MaintenanceCost], [MaintenanceRemarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f488fb2-0291-11f0-92bb-52540099312c', N'bdbb36ec-028f-11f0-92bb-52540099312c', CAST(N'2024-05-09T12:00:00.0000000' AS DateTime2), N'日常保养', N'检查焊接头、清理灰尘', N'赵师傅', N'已完成', CAST(N'2024-06-09T12:00:00.0000000' AS DateTime2), CAST(700.00 AS Decimal(10, 2)), N'无明显问题', 1, N'admin', CAST(N'2024-05-09T12:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:06:26.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentManagement] ([EquipmentID], [EquipmentCode], [EquipmentName], [EquipmentType], [Manufacturer], [PurchaseDate], [WarrantyPeriod], [InstallationLocation], [EquipmentStatus], [ResponsiblePerson], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'bdbb34f1-028f-11f0-92bb-52540099312c', N'EQ001', N'SMT贴片机', N'电子制造设备', N'三星电子', CAST(N'2023-01-01T08:00:00.0000000' AS DateTime2), 12, N'生产车间A区1号', N'运行正常', N'李明', 1, N'admin', CAST(N'2024-01-01T08:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_EquipmentManagement] ([EquipmentID], [EquipmentCode], [EquipmentName], [EquipmentType], [Manufacturer], [PurchaseDate], [WarrantyPeriod], [InstallationLocation], [EquipmentStatus], [ResponsiblePerson], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'bdbb36ec-028f-11f0-92bb-52540099312c', N'EQ002', N'注塑机', N'塑料加工设备', N'海天塑机', CAST(N'2023-02-01T09:00:00.0000000' AS DateTime2), 10, N'生产车间B区2号', N'运行中', N'张华', 1, N'admin', CAST(N'2024-02-01T09:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_EquipmentManagement] ([EquipmentID], [EquipmentCode], [EquipmentName], [EquipmentType], [Manufacturer], [PurchaseDate], [WarrantyPeriod], [InstallationLocation], [EquipmentStatus], [ResponsiblePerson], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'bdbb37ef-028f-11f0-92bb-52540099312c', N'EQ003', N'检测仪器', N'质量检测设备', N'泰瑞达科技', CAST(N'2023-03-01T10:00:00.0000000' AS DateTime2), 15, N'生产车间D区4号', N'正常使用', N'陈丽', 1, N'admin', CAST(N'2024-03-01T10:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_EquipmentManagement] ([EquipmentID], [EquipmentCode], [EquipmentName], [EquipmentType], [Manufacturer], [PurchaseDate], [WarrantyPeriod], [InstallationLocation], [EquipmentStatus], [ResponsiblePerson], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'bdbb38a2-028f-11f0-92bb-52540099312c', N'EQ004', N'自动螺丝机', N'装配设备', N'拓普机械', CAST(N'2023-04-01T11:00:00.0000000' AS DateTime2), 11, N'生产车间C区3号', N'运行平稳', N'王强', 1, N'admin', CAST(N'2024-04-01T11:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_EquipmentManagement] ([EquipmentID], [EquipmentCode], [EquipmentName], [EquipmentType], [Manufacturer], [PurchaseDate], [WarrantyPeriod], [InstallationLocation], [EquipmentStatus], [ResponsiblePerson], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'bdbb3938-028f-11f0-92bb-52540099312c', N'EQ005', N'回流焊炉', N'焊接设备', N'日东电子', CAST(N'2023-05-01T12:00:00.0000000' AS DateTime2), 13, N'生产车间A区1号', N'正常运转', N'李明', 1, N'admin', CAST(N'2024-05-01T12:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_EquipmentRepair] ([RepairID], [EquipmentID], [RepairDate], [RepairReason], [RepairContent], [RepairPerson], [RepairCost], [RepairStatus], [RepairStartTime], [RepairEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5132a230-0290-11f0-92bb-52540099312c', N'bdbb3938-028f-11f0-92bb-52540099312c', CAST(N'2024-01-10T09:00:00.0000000' AS DateTime2), N'贴装头故障', N'更换贴装头', N'张师傅', CAST(5000.00 AS Decimal(10, 2)), N'已完成', CAST(N'2024-01-10T09:30:00.0000000' AS DateTime2), CAST(N'2024-01-10T15:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-01-10T09:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:00:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentRepair] ([RepairID], [EquipmentID], [RepairDate], [RepairReason], [RepairContent], [RepairPerson], [RepairCost], [RepairStatus], [RepairStartTime], [RepairEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5132a3fb-0290-11f0-92bb-52540099312c', N'bdbb3938-028f-11f0-92bb-52540099312c', CAST(N'2024-02-15T10:00:00.0000000' AS DateTime2), N'注塑压力不稳定', N'检查液压系统并维修', N'李师傅', CAST(3500.00 AS Decimal(10, 2)), N'已完成', CAST(N'2024-02-15T10:30:00.0000000' AS DateTime2), CAST(N'2024-02-15T16:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-02-15T10:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:00:36.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentRepair] ([RepairID], [EquipmentID], [RepairDate], [RepairReason], [RepairContent], [RepairPerson], [RepairCost], [RepairStatus], [RepairStartTime], [RepairEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5132a509-0290-11f0-92bb-52540099312c', N'bdbb38a2-028f-11f0-92bb-52540099312c', CAST(N'2024-03-20T11:00:00.0000000' AS DateTime2), N'检测精度下降', N'校准检测传感器', N'赵师傅', CAST(2000.00 AS Decimal(10, 2)), N'已完成', CAST(N'2024-03-20T11:30:00.0000000' AS DateTime2), CAST(N'2024-03-20T14:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-03-20T11:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:00:56.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentRepair] ([RepairID], [EquipmentID], [RepairDate], [RepairReason], [RepairContent], [RepairPerson], [RepairCost], [RepairStatus], [RepairStartTime], [RepairEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5132a5c0-0290-11f0-92bb-52540099312c', N'bdbb34f1-028f-11f0-92bb-52540099312c', CAST(N'2024-04-25T12:00:00.0000000' AS DateTime2), N'螺丝拧紧力度不均匀', N'调整拧紧扭矩装置', N'孙师傅', CAST(1500.00 AS Decimal(10, 2)), N'已完成', CAST(N'2024-04-25T12:30:00.0000000' AS DateTime2), CAST(N'2024-04-25T15:30:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-04-25T12:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:00:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_EquipmentRepair] ([RepairID], [EquipmentID], [RepairDate], [RepairReason], [RepairContent], [RepairPerson], [RepairCost], [RepairStatus], [RepairStartTime], [RepairEndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5132a654-0290-11f0-92bb-52540099312c', N'bdbb34f1-028f-11f0-92bb-52540099312c', CAST(N'2024-05-30T13:00:00.0000000' AS DateTime2), N'温度控制异常', N'维修温度控制器', N'周师傅', CAST(2500.00 AS Decimal(10, 2)), N'已完成', CAST(N'2024-05-30T13:30:00.0000000' AS DateTime2), CAST(N'2024-05-30T17:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-05-30T13:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:00:21.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_InventoryManagement] ([InventoryID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InventoryQuantity], [InventoryUnit], [InventoryCost], [InventoryStatus], [InboundDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5e6f978c-2f87-4046-9577-29c96a95724d', N'INV001', N'螺丝', N'S001', N'M5*10', N'3a765f84-49a6-4f42-9639-2a9c58d832c5', N'1c19c214-9d78-4596-b078-789f7755896b', 500, N'个', CAST(0.50 AS Decimal(10, 2)), N'在库', CAST(N'2024-01-01T08:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:46:23.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_InventoryManagement] ([InventoryID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InventoryQuantity], [InventoryUnit], [InventoryCost], [InventoryStatus], [InboundDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5e6f978c-2f87-4046-9577-29c96a95724e', N'INV002', N'螺母', N'N001', N'M5', N'3a765f84-49a6-4f42-9639-2a9c58d832c5', N'1c19c214-9d78-4596-b078-789f7755896b', 300, N'个', CAST(0.30 AS Decimal(10, 2)), N'在库', CAST(N'2024-01-02T09:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:47:04.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_InventoryManagement] ([InventoryID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InventoryQuantity], [InventoryUnit], [InventoryCost], [InventoryStatus], [InboundDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5e6f978c-2f87-4046-9577-29c96a95724f', N'INV003', N'成品A', N'P001', N'V1.0', N'3a765f84-49a6-4f42-9639-2a9c58d832c5', N'1c19c214-9d78-4596-b078-789f7755896b', 200, N'件', CAST(100.00 AS Decimal(10, 2)), N'在库', CAST(N'2024-01-03T10:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:46:40.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_InventoryManagement] ([InventoryID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InventoryQuantity], [InventoryUnit], [InventoryCost], [InventoryStatus], [InboundDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5e6f978c-2f87-4046-9577-29c96a957250', N'INV004', N'半成品B', N'SP001', N'半加工状态', N'3a765f84-49a6-4f42-9639-2a9c58d832c6', N'1c19c214-9d78-4596-b078-789f7755896c', 150, N'件', CAST(50.00 AS Decimal(10, 2)), N'在库', CAST(N'2024-01-04T11:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:46:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_InventoryManagement] ([InventoryID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InventoryQuantity], [InventoryUnit], [InventoryCost], [InventoryStatus], [InboundDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5e6f978c-2f87-4046-9577-29c96a957251', N'INV005', N'包装纸箱', N'C001', N'50*40*30cm', N'3a765f84-49a6-4f42-9639-2a9c58d832c8', N'1c19c214-9d78-4596-b078-789f7755896e', 400, N'个', CAST(5.00 AS Decimal(10, 2)), N'在库', CAST(N'2024-01-05T12:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:46:55.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_LocationManagement] ([LocationID], [WarehouseID], [LocationCode], [LocationName], [LocationType], [LocationCapacity], [LocationStatus], [LocationRow], [LocationColumn], [LocationFloor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3a765f84-49a6-4f42-9639-2a9c58d832c4', N'1c19c214-9d78-4596-b078-789f7755896a', N'L001', N'A区001', N'普通货位', 100, N'空闲', 1, 1, 1, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:47:51.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_LocationManagement] ([LocationID], [WarehouseID], [LocationCode], [LocationName], [LocationType], [LocationCapacity], [LocationStatus], [LocationRow], [LocationColumn], [LocationFloor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3a765f84-49a6-4f42-9639-2a9c58d832c5', N'1c19c214-9d78-4596-b078-789f7755896b', N'L002', N'B区002', N'普通货位', 150, N'占用', 2, 2, 1, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:47:57.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_LocationManagement] ([LocationID], [WarehouseID], [LocationCode], [LocationName], [LocationType], [LocationCapacity], [LocationStatus], [LocationRow], [LocationColumn], [LocationFloor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3a765f84-49a6-4f42-9639-2a9c58d832c6', N'1c19c214-9d78-4596-b078-789f7755896c', N'L003', N'C区003', N'普通货位', 120, N'空闲', 3, 3, 1, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:48:03.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_LocationManagement] ([LocationID], [WarehouseID], [LocationCode], [LocationName], [LocationType], [LocationCapacity], [LocationStatus], [LocationRow], [LocationColumn], [LocationFloor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3a765f84-49a6-4f42-9639-2a9c58d832c7', N'1c19c214-9d78-4596-b078-789f7755896d', N'L004', N'D区004', N'不良品货位', 50, N'占用', 4, 4, 1, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:48:13.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_LocationManagement] ([LocationID], [WarehouseID], [LocationCode], [LocationName], [LocationType], [LocationCapacity], [LocationStatus], [LocationRow], [LocationColumn], [LocationFloor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3a765f84-49a6-4f42-9639-2a9c58d832c8', N'1c19c214-9d78-4596-b078-789f7755896e', N'L005', N'E区005', N'普通货位', 180, N'空闲', 5, 5, 1, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:48:19.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Material] ([MaterialID], [MaterialCode], [MaterialName], [MaterialType], [CatalogID], [Specification], [Unit], [Price], [Img], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'8754ed7a-e845-42a1-9b51-6735091653f4', N'AKG0000004', N'米其林轮胎', NULL, N'40f6f014-b41f-400e-ad49-ed4b109cf5f3', N'。。。。。。。', N'件', NULL, NULL, N'。。。。。。。。', 1, N'超级管理员', CAST(N'2025-03-18T14:12:26.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:13:00.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Material] ([MaterialID], [MaterialCode], [MaterialName], [MaterialType], [CatalogID], [Specification], [Unit], [Price], [Img], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9f7e972a-028b-11f0-92bb-52540099312c', N'AKG0000001', N'碳素结构钢', N'金属材料', N'40f6f014-b41f-400e-ad49-ed4b109cf5f3', N'Q235B，厚度 5mm', N'吨', CAST(4500.00 AS Decimal(10, 2)), N'Upload/Tables/MES_Material/202503170240379198/wechat.jpg', N'常用于建筑结构', 1, N'管理员', CAST(N'2025-03-17T01:25:14.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:47:53.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Material] ([MaterialID], [MaterialCode], [MaterialName], [MaterialType], [CatalogID], [Specification], [Unit], [Price], [Img], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9f7e990f-028b-11f0-92bb-52540099312c', N'AKG0000002', N'架构芯片', N'电子元器件', N'40f6f014-b41f-400e-ad49-ed4b109cf5f3', N'Cortex - M3 内核，主频 100MHz', N'片', CAST(50.00 AS Decimal(10, 2)), N'Upload/Tables/MES_Material/202503170240426945/wechat.jpg', N'适用于嵌入式系统开发', 1, N'管理员', CAST(N'2025-03-17T01:25:14.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:48:28.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Material] ([MaterialID], [MaterialCode], [MaterialName], [MaterialType], [CatalogID], [Specification], [Unit], [Price], [Img], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9f7e99fd-028b-11f0-92bb-52540099312c', N'AKG0000003', N'聚乙烯（PE）', N'化工原料', N'0b24acbf-ac77-4355-966a-71f394020c6d', N'低密度，颗粒状', N'件', CAST(10.00 AS Decimal(10, 2)), N'Upload/Tables/MES_Material/202503170240509540/wechat.jpg', N'可用于塑料制品生产', 1, N'管理员', CAST(N'2025-03-17T01:25:14.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:49:11.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Material] ([MaterialID], [MaterialCode], [MaterialName], [MaterialType], [CatalogID], [Specification], [Unit], [Price], [Img], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9f7e9a54-028b-11f0-92bb-52540099312c', N'AKG0000004', N'双层瓦楞纸箱', N'包装材料', N'43175a13-251a-4481-b515-87a9d22a547b', N'尺寸：500mm×300mm×200mm', N'件', CAST(5.00 AS Decimal(10, 2)), NULL, N'用于产品包装运输', 1, N'管理员', CAST(N'2025-03-17T01:25:14.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:49:17.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Material] ([MaterialID], [MaterialCode], [MaterialName], [MaterialType], [CatalogID], [Specification], [Unit], [Price], [Img], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9f7e9aac-028b-11f0-92bb-52540099312c', N'AKG0000005', N'A4 复印纸', N'办公用品', N'43175a13-251a-4481-b515-87a9d22a547b', N'70g，500 张/包', N'包', CAST(20.00 AS Decimal(10, 2)), NULL, N'适用于日常办公复印', 1, N'管理员', CAST(N'2025-03-17T01:25:14.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:48:52.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_MaterialCatalog] ([CatalogID], [CatalogCode], [CatalogName], [CatalogType], [ParentId], [Enable], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0b24acbf-ac77-4355-966a-71f394020c6d', N'A0008', N'助焊剂', NULL, N'40f6f014-b41f-400e-ad49-ed4b109cf5f3', 1, N'。。。', 1, N'超级管理员', CAST(N'2025-03-17T11:45:07.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:45:14.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_MaterialCatalog] ([CatalogID], [CatalogCode], [CatalogName], [CatalogType], [ParentId], [Enable], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'40f6f014-b41f-400e-ad49-ed4b109cf5f3', N'A0001', N'原材料', NULL, NULL, 1, N'。。。。', 1, N'超级管理员', CAST(N'2025-03-17T11:36:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:46:03.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_MaterialCatalog] ([CatalogID], [CatalogCode], [CatalogName], [CatalogType], [ParentId], [Enable], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'43175a13-251a-4481-b515-87a9d22a547b', N'A0005', N'引线框架', NULL, N'ef241017-fbce-42af-942a-6d2531929cc4', 1, N'。。。。。', 1, N'超级管理员', CAST(N'2025-03-17T11:43:42.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:44:36.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_MaterialCatalog] ([CatalogID], [CatalogCode], [CatalogName], [CatalogType], [ParentId], [Enable], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'8f258988-157e-4e81-9076-44a86d1946cb', N'A0006', N'覆铜板', NULL, N'ef241017-fbce-42af-942a-6d2531929cc4', 1, NULL, 1, N'超级管理员', CAST(N'2025-03-17T11:44:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:46:22.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_MaterialCatalog] ([CatalogID], [CatalogCode], [CatalogName], [CatalogType], [ParentId], [Enable], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'b8ccd002-73b9-4bb0-b40f-fbca161b3443', N'A0007', N'粘合剂', NULL, N'40f6f014-b41f-400e-ad49-ed4b109cf5f3', 1, N'。。。', 1, N'超级管理员', CAST(N'2025-03-17T11:44:52.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:46:25.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_MaterialCatalog] ([CatalogID], [CatalogCode], [CatalogName], [CatalogType], [ParentId], [Enable], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ef241017-fbce-42af-942a-6d2531929cc4', N'A0003', N'半成品', NULL, NULL, 1, N'。。。。。。', 1, N'超级管理员', CAST(N'2025-03-17T11:36:47.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T11:36:53.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Process] ([ProcessID], [ProcessCode], [ProcessName], [ProcessType], [ProcessSequence], [ProcessDescription], [WorkCenter], [StandardWorkingHours], [ProcessStatus], [ResponsibleWorker], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', N'PAK00001', N'切割工序', N'加工工序', 1, N'对原材料进行切割处理', N'WC01', CAST(2.50 AS Decimal(10, 2)), N'正常', N'张师傅', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Process] ([ProcessID], [ProcessCode], [ProcessName], [ProcessType], [ProcessSequence], [ProcessDescription], [WorkCenter], [StandardWorkingHours], [ProcessStatus], [ResponsibleWorker], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', N'PAK00002', N'焊接工序', N'加工工序', 2, N'将切割后的部件进行焊接组装', N'WC02', CAST(3.00 AS Decimal(10, 2)), N'正常', N'李师傅', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:58.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Process] ([ProcessID], [ProcessCode], [ProcessName], [ProcessType], [ProcessSequence], [ProcessDescription], [WorkCenter], [StandardWorkingHours], [ProcessStatus], [ResponsibleWorker], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', N'PAK00003', N'打磨工序', N'加工工序', 3, N'对焊接后的产品进行打磨处理', N'WC03', CAST(2.00 AS Decimal(10, 2)), N'正常', N'王师傅', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:17:40.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Process] ([ProcessID], [ProcessCode], [ProcessName], [ProcessType], [ProcessSequence], [ProcessDescription], [WorkCenter], [StandardWorkingHours], [ProcessStatus], [ResponsibleWorker], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', N'PAK00004', N'喷漆工序', N'表面处理工序', 4, N'对打磨后的产品进行喷漆操作', N'WC04', CAST(1.50 AS Decimal(10, 2)), N'正常', N'赵师傅', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:17:45.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Process] ([ProcessID], [ProcessCode], [ProcessName], [ProcessType], [ProcessSequence], [ProcessDescription], [WorkCenter], [StandardWorkingHours], [ProcessStatus], [ResponsibleWorker], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', N'PAK00005', N'质检工序', N'质量检测工序', 5, N'对产品进行质量检测', N'WC05', CAST(1.00 AS Decimal(10, 2)), N'正常', N'孙师傅', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:17:50.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessReport] ([ReportID], [ProcessID], [ReportDate], [CompletedQuantity], [DefectiveQuantity], [ReportedBy], [ReportStatus], [ReportRemarks], [StartTime], [EndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5b348b0e-0295-11f0-92bb-52540099312c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', CAST(N'2024-01-16T08:00:00.0000000' AS DateTime2), 50, 2, N'张师傅', N'已完成', N'切割过程中发现2个次品', CAST(N'2024-01-16T07:00:00.0000000' AS DateTime2), CAST(N'2024-01-16T08:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessReport] ([ReportID], [ProcessID], [ReportDate], [CompletedQuantity], [DefectiveQuantity], [ReportedBy], [ReportStatus], [ReportRemarks], [StartTime], [EndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5b348cd3-0295-11f0-92bb-52540099312c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', CAST(N'2024-01-16T09:30:00.0000000' AS DateTime2), 40, 1, N'李师傅', N'已完成', N'焊接时有1个产品焊接不牢', CAST(N'2024-01-16T08:30:00.0000000' AS DateTime2), CAST(N'2024-01-16T09:30:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessReport] ([ReportID], [ProcessID], [ReportDate], [CompletedQuantity], [DefectiveQuantity], [ReportedBy], [ReportStatus], [ReportRemarks], [StartTime], [EndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5b348dd7-0295-11f0-92bb-52540099312c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', CAST(N'2024-01-16T11:00:00.0000000' AS DateTime2), 35, 0, N'王师傅', N'已完成', N'打磨过程顺利', CAST(N'2024-01-16T10:00:00.0000000' AS DateTime2), CAST(N'2024-01-16T11:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessReport] ([ReportID], [ProcessID], [ReportDate], [CompletedQuantity], [DefectiveQuantity], [ReportedBy], [ReportStatus], [ReportRemarks], [StartTime], [EndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5b348e97-0295-11f0-92bb-52540099312c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', CAST(N'2024-01-16T12:30:00.0000000' AS DateTime2), 45, 3, N'赵师傅', N'已完成', N'喷漆颜色有偏差3个产品', CAST(N'2024-01-16T11:30:00.0000000' AS DateTime2), CAST(N'2024-01-16T12:30:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessReport] ([ReportID], [ProcessID], [ReportDate], [CompletedQuantity], [DefectiveQuantity], [ReportedBy], [ReportStatus], [ReportRemarks], [StartTime], [EndTime], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'5b348f65-0295-11f0-92bb-52540099312c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', CAST(N'2024-01-16T14:00:00.0000000' AS DateTime2), 50, 1, N'孙师傅', N'已完成', N'1个产品质检不合格', CAST(N'2024-01-16T13:00:00.0000000' AS DateTime2), CAST(N'2024-01-16T14:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'30142e89-8086-40e3-a0c4-ea8bc24ebc7d', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', NULL, N'工艺路径03', 3, N'工艺路径03', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', N'1', NULL, 1, N'超级管理员', CAST(N'2025-03-18T14:00:07.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2a', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', N'P0001', N'工艺路径01', 1, N'产品A的工艺路线第一步 - 切割', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', N'启用', N'项目经理1', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2b', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', N'P0001', N'喷漆01', 1, N'喷漆01', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', N'启用', N'项目经理1', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:58.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', N'P0001', N'产品A', 3, N'产品A的工艺路线第三步 - 打磨', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', N'启用', N'项目经理1', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:17:40.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2d', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', N'P0001', N'产品A', 4, N'产品A的工艺路线第四步 - 喷漆', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', N'启用', N'项目经理1', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:17:45.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7d4c6b8e-3f5d-486f-9c7a-5d8643e78d2e', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', N'P0001', N'产品A', 5, N'产品A的工艺路线第五步 - 质检', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', NULL, N'启用', N'项目经理1', 1, N'admin', CAST(N'2025-03-16T23:16:25.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T02:17:50.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'be7bca96-d2b1-42be-a23c-a5e75b26fc8d', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', NULL, N'工艺路径02', 2, N'工艺路径01', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2a', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2c', N'1', NULL, 1, N'超级管理员', CAST(N'2025-03-17T02:22:19.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProcessRoute] ([RouteID], [ProcessID], [ProductID], [ProductName], [RouteSequence], [RouteDescription], [PreProcessID], [NextProcessID], [RouteStatus], [RouteResponsible], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c33a1f4e-5ace-4f58-95c2-6f15f8e64950', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2b', NULL, N'喷漆02', 2, N'喷漆02', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2d', N'4f8d7a5b-2c4e-4d75-8b9a-3d6754f97e2e', N'1', NULL, 1, N'超级管理员', CAST(N'2025-03-18T14:00:58.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:00:58.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductInbound] ([InboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InboundQuantity], [InboundUnit], [InboundDate], [InboundOperator], [InboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'528599a8-a80b-4854-9184-03b998fcf75a', N'IN202503170001', N'双层瓦楞纸箱', N'AKG0000004', N'尺寸：500mm×300mm×200mm', NULL, N'1c19c214-9d78-4596-b078-789f7755896b', 200, N'个', CAST(N'2024-01-06T08:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:58:21.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:36:23.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductInbound] ([InboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InboundQuantity], [InboundUnit], [InboundDate], [InboundOperator], [InboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'687c6fe1-6849-46c6-a9d7-96f80e10e827', N'IN202503170001', N'米其林轮胎', N'AKG0000004', N'。。。。。。。', NULL, N'1c19c214-9d78-4596-b078-789f7755896d', 200, N'个', CAST(N'2024-01-06T08:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:59:01.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:35:59.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductInbound] ([InboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InboundQuantity], [InboundUnit], [InboundDate], [InboundOperator], [InboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'75013787-8e21-49c7-a488-1cff0b051f6e', N'IN202503170001', N'聚乙烯（PE）', N'AKG0000003', N'低密度，颗粒状', NULL, N'1c19c214-9d78-4596-b078-789f7755896a', 200, N'个', CAST(N'2024-01-06T08:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:58:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:36:14.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductInbound] ([InboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [InboundQuantity], [InboundUnit], [InboundDate], [InboundOperator], [InboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'e080e4f0-1fd8-4bbf-97b0-045fda9a5207', N'IN202503170001', N'碳素结构钢', N'AKG0000001', N'Q235B，厚度 5mm', NULL, N'1c19c214-9d78-4596-b078-789f7755896d', 200, N'个', CAST(N'2024-01-06T08:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:58:55.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:36:06.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLine] ([ProductionLineID], [LineName], [LineType], [Capacity], [Status], [ResponsiblePerson], [Location], [StartDate], [EndDate], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd44efa4a-028a-11f0-92bb-52540099312c', N'手机组装产线 1 号', N'电子设备组装线', N'每天 5000 部手机', N'运行中', N'张工', N'工厂 1 楼 A 区', CAST(N'2024-01-01T08:00:00.0000000' AS DateTime2), CAST(N'2025-03-17T00:00:00.0000000' AS DateTime2), N'效率较高', 1, N'管理员', CAST(N'2025-03-17T01:19:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:36:33.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLine] ([ProductionLineID], [LineName], [LineType], [Capacity], [Status], [ResponsiblePerson], [Location], [StartDate], [EndDate], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd44efc2e-028a-11f0-92bb-52540099312c', N'汽车发动机零部件加工线', N'机械加工线', N'每月 3000 套零部件', N'运行中', N'李工', N'工厂 2 楼 B 区', CAST(N'2024-03-15T09:30:00.0000000' AS DateTime2), CAST(N'2025-03-17T00:00:00.0000000' AS DateTime2), N'质量稳定', 1, N'管理员', CAST(N'2025-03-17T01:19:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:36:00.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLine] ([ProductionLineID], [LineName], [LineType], [Capacity], [Status], [ResponsiblePerson], [Location], [StartDate], [EndDate], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd44efd10-028a-11f0-92bb-52540099312c', N'饼干包装产线 2 号', N'食品包装线', N'每小时 10000 包饼干', N'运行中', N'王工', N'工厂 3 楼 C 区', CAST(N'2024-05-20T10:15:00.0000000' AS DateTime2), CAST(N'2025-03-17T00:00:00.0000000' AS DateTime2), N'包装精美', 1, N'管理员', CAST(N'2025-03-17T01:19:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:49:46.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLine] ([ProductionLineID], [LineName], [LineType], [Capacity], [Status], [ResponsiblePerson], [Location], [StartDate], [EndDate], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd44efd6c-028a-11f0-92bb-52540099312c', N'衬衫裁剪产线', N'服装裁剪线', N'每周 2000 件衬衫裁剪量', N'运行中', N'赵工', N'工厂 4 楼 D 区', CAST(N'2024-07-05T11:00:00.0000000' AS DateTime2), CAST(N'2025-03-17T00:00:00.0000000' AS DateTime2), N'裁剪精度高', 1, N'管理员', CAST(N'2025-03-17T01:19:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:21:04.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLine] ([ProductionLineID], [LineName], [LineType], [Capacity], [Status], [ResponsiblePerson], [Location], [StartDate], [EndDate], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd44efdbd-028a-11f0-92bb-52540099312c', N'平板电脑检测线', N'电子产品检测线', N'每天 2000 台平板电脑', N'运行中', N'孙工', N'工厂 5 楼 E 区', CAST(N'2024-09-10T14:45:00.0000000' AS DateTime2), CAST(N'2025-03-17T00:00:00.0000000' AS DateTime2), N'检测全面', 1, N'管理员', CAST(N'2025-03-17T01:19:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:21:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLineDevice] ([DeviceID], [ProductionLineID], [DeviceName], [DeviceModel], [Manufacturer], [PurchaseDate], [WarrantyDate], [Status], [LocationOnLine], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'000fc915-0453-4938-a964-c63c13b00b15', N'd44efd10-028a-11f0-92bb-52540099312c', N'奥利奥', N'奥利奥', N'奥利奥', CAST(N'2025-03-17T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-18T00:00:00.0000000' AS DateTime2), N'异常', NULL, N'奥利奥', 1, N'超级管理员', CAST(N'2025-03-17T01:49:46.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:49:45.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLineDevice] ([DeviceID], [ProductionLineID], [DeviceName], [DeviceModel], [Manufacturer], [PurchaseDate], [WarrantyDate], [Status], [LocationOnLine], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'164d145d-7672-4993-b994-cb0cdbe12e77', N'd44efa4a-028a-11f0-92bb-52540099312c', N'贴片机', N'TA0001', N'台积电', CAST(N'2025-03-03T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-18T00:00:00.0000000' AS DateTime2), N'正常', NULL, N'....', 1, N'超级管理员', CAST(N'2025-03-17T01:34:42.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:36:33.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLineDevice] ([DeviceID], [ProductionLineID], [DeviceName], [DeviceModel], [Manufacturer], [PurchaseDate], [WarrantyDate], [Status], [LocationOnLine], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'6b98a0c9-988b-401e-aff9-aa88440c80d7', N'd44efa4a-028a-11f0-92bb-52540099312c', N'点胶机', N'TA0002', NULL, CAST(N'2025-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-19T00:00:00.0000000' AS DateTime2), N'正常', NULL, N'...', 1, N'超级管理员', CAST(N'2025-03-17T01:36:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:36:32.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLineDevice] ([DeviceID], [ProductionLineID], [DeviceName], [DeviceModel], [Manufacturer], [PurchaseDate], [WarrantyDate], [Status], [LocationOnLine], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'8a9567b6-ab7a-4194-a152-aab255ba0c72', N'd44efd10-028a-11f0-92bb-52540099312c', N'奥利奥plus', N'奥利奥plus', N'奥利奥plus', CAST(N'2025-03-12T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-11T00:00:00.0000000' AS DateTime2), N'正常', NULL, N'奥利奥plus', 1, N'超级管理员', CAST(N'2025-03-17T01:49:46.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:49:45.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLineDevice] ([DeviceID], [ProductionLineID], [DeviceName], [DeviceModel], [Manufacturer], [PurchaseDate], [WarrantyDate], [Status], [LocationOnLine], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'a6ac613e-241a-41fa-a4cc-e5f08d0a0dce', N'd44efc2e-028a-11f0-92bb-52540099312c', N'磨床', N'CA0002', N'..。', CAST(N'2025-03-11T00:00:00.0000000' AS DateTime2), NULL, N'正常', NULL, N'12..。', 1, N'超级管理员', CAST(N'2025-03-17T01:36:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:35:59.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionLineDevice] ([DeviceID], [ProductionLineID], [DeviceName], [DeviceModel], [Manufacturer], [PurchaseDate], [WarrantyDate], [Status], [LocationOnLine], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'cd9a6f48-5d81-46c4-9189-7f7c5fc9e163', N'd44efc2e-028a-11f0-92bb-52540099312c', N'车床', N'CA0001', N'xxxx', CAST(N'2025-03-03T00:00:00.0000000' AS DateTime2), NULL, N'正常', NULL, N'11', 1, N'超级管理员', CAST(N'2025-03-17T01:36:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:35:59.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionOrder] ([OrderID], [OrderNumber], [CustomerName], [OrderDate], [DeliveryDate], [OrderQty], [OrderStatus], [LV], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'6648a795-02f5-11f0-92bb-52540099312c', N'PO00000005', N'阳光电子集团', CAST(N'2024-01-05T13:00:00.0000000' AS DateTime2), CAST(N'2024-02-05T21:00:00.0000000' AS DateTime2), 300, N'待生产', N'1', 1, N'admin', CAST(N'2024-01-05T13:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:47.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionOrder] ([OrderID], [OrderNumber], [CustomerName], [OrderDate], [DeliveryDate], [OrderQty], [OrderStatus], [LV], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'6648abb7-02f5-11f0-92bb-52540099312c', N'PO00000004', N'瑞风科技有限公司', CAST(N'2024-01-04T12:00:00.0000000' AS DateTime2), CAST(N'2024-02-04T20:00:00.0000000' AS DateTime2), 8000, N'待生产', N'1', 1, N'admin', CAST(N'2024-01-04T12:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionOrder] ([OrderID], [OrderNumber], [CustomerName], [OrderDate], [DeliveryDate], [OrderQty], [OrderStatus], [LV], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'6648aca8-02f5-11f0-92bb-52540099312c', N'PO00000003', N'星辰电子公司', CAST(N'2024-01-03T11:00:00.0000000' AS DateTime2), CAST(N'2024-02-03T19:00:00.0000000' AS DateTime2), 1700, N'生产中', N'1', 1, N'admin', CAST(N'2024-01-03T11:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:51.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanChangeRecord] ([ChangeRecordID], [PlanDetailID], [OrderNumber], [CustomerName], [OrderDate], [ChangeDate], [OriginalPlanQuantity], [NewPlanQuantity], [OriginalPlannedStartTime], [NewPlannedStartTime], [OriginalPlannedEndTime], [NewPlannedEndTime], [ChangeReason], [ChangedBy], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'92fd73c5-f999-4a17-a4f2-fb94253e62da', NULL, N'CA2025021000001', N'星星电子', CAST(N'2025-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-18T00:00:00.0000000' AS DateTime2), 12000, 8000, NULL, NULL, NULL, NULL, N'。。。。。', N'admin', 1, N'超级管理员', CAST(N'2025-03-17T19:34:06.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1012861c-89f2-4337-9718-3c79c72d3fd6', N'6648aca8-02f5-11f0-92bb-52540099312c', N'AKG0000004', N'双层瓦楞纸箱', N'尺寸：500mm×300mm×200mm', N'件', 800, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T19:08:34.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:51.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'40139c6f-6697-489d-8bee-46d888a1bb53', N'6648aca8-02f5-11f0-92bb-52540099312c', N'AKG0000005', N'A4 复印纸', N'70g，500 张/包', N'包', 900, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T19:08:34.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:51.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4d1ed687-fc78-419a-8128-29b0dc75e486', N'6648abb7-02f5-11f0-92bb-52540099312c', N'AKG0000002', N'架构芯片', N'Cortex - M3 内核，主频 100MHz', N'片', 2000, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T19:08:29.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'6a7a9c6f-61f3-4cf4-9c1c-4304f8bc2eff', N'6648abb7-02f5-11f0-92bb-52540099312c', N'AKG0000003', N'聚乙烯（PE）', N'低密度，颗粒状', N'件', 2000, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T19:08:29.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'af2d3f94-5912-412d-89a1-26a16d9d00ae', N'6648abb7-02f5-11f0-92bb-52540099312c', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', N'吨', 4000, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T19:08:29.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'afebc1a7-e112-43a4-a766-2e8987e0dbcc', N'6648a795-02f5-11f0-92bb-52540099312c', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', N'吨', 100, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T18:43:57.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:47.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionPlanDetail] ([PlanDetailID], [OrderID], [MaterialCode], [MaterialName], [MaterialSpecification], [Unit], [PlanQuantity], [PlannedStartTime], [PlannedEndTime], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c1876253-995a-4303-bc1a-15af7742515a', N'6648a795-02f5-11f0-92bb-52540099312c', N'AKG0000002', N'架构芯片', N'Cortex - M3 内核，主频 100MHz', N'片', 200, NULL, NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T18:43:57.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T14:50:47.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReporting] ([ReportingID], [ReportingNumber], [OrderID], [ReportedBy], [ReportingTime], [ReportHour], [Total], [AcceptedQuantity], [RejectedQuantity], [AuditStatus], [Auditor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', N'BG202503180007', NULL, N'3362', CAST(N'2024-06-05T19:00:00.0000000' AS DateTime2), CAST(10 AS Decimal(2, 0)), 380, 490, 60, 0, NULL, 1, N'超级管理员', CAST(N'2025-03-20T21:42:04.0000000' AS DateTime2), NULL, NULL, CAST(N'2025-03-20T21:42:04.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReporting] ([ReportingID], [ReportingNumber], [OrderID], [ReportedBy], [ReportingTime], [ReportHour], [Total], [AcceptedQuantity], [RejectedQuantity], [AuditStatus], [Auditor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'd902044f-abd1-42ab-b3d8-9e63f431b410', N'BG202503180006', NULL, N'3362', CAST(N'2024-06-05T19:00:00.0000000' AS DateTime2), CAST(4 AS Decimal(2, 0)), 300, 390, 10, 0, NULL, 1, N'超级管理员', CAST(N'2025-03-20T21:42:04.0000000' AS DateTime2), NULL, NULL, CAST(N'2025-03-20T21:42:04.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReporting] ([ReportingID], [ReportingNumber], [OrderID], [ReportedBy], [ReportingTime], [ReportHour], [Total], [AcceptedQuantity], [RejectedQuantity], [AuditStatus], [Auditor], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f8fb5b93-0b38-4892-aa8d-7d3a00b89afd', N'BG202503180004', NULL, N'3362', CAST(N'2024-06-05T19:00:00.0000000' AS DateTime2), CAST(7 AS Decimal(2, 0)), 180, 280, 30, 0, NULL, 1, N'超级管理员', CAST(N'2025-03-20T21:42:04.0000000' AS DateTime2), NULL, NULL, CAST(N'2025-03-20T21:42:04.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'017f792c-4520-43a8-a649-c5e1ed5a28c1', N'd902044f-abd1-42ab-b3d8-9e63f431b410', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', CAST(1.50 AS Decimal(11, 2)), 200, 200, 0, 1, N'超级管理员', CAST(N'2025-03-18T16:09:41.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T15:58:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'0ae90653-97a9-43a2-9ede-a38967d7b434', N'34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', CAST(1.50 AS Decimal(11, 2)), 200, 200, 0, 1, N'超级管理员', CAST(N'2025-03-18T16:09:52.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T16:09:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3f665f4b-ace1-4644-a706-d31552c84cb5', N'f8fb5b93-0b38-4892-aa8d-7d3a00b89afd', N'AKG0000004', N'米其林轮胎', N'。。。。。。。', CAST(5.00 AS Decimal(11, 2)), 80, 90, 20, 1, N'超级管理员', CAST(N'2025-03-18T16:09:20.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7d48b30b-8b7c-4403-abf8-690e52762e44', N'34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', N'AKG0000004', N'米其林轮胎', N'。。。。。。。', CAST(6.00 AS Decimal(11, 2)), 80, 100, 50, 1, N'超级管理员', CAST(N'2025-03-18T16:09:52.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T16:09:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c1cf52d2-e98a-43ba-92de-3c757d7c41f1', N'f8fb5b93-0b38-4892-aa8d-7d3a00b89afd', N'AKG0000002', N'架构芯片', N'Cortex - M3 内核，主频 100MHz', CAST(2.00 AS Decimal(11, 2)), 100, 190, 10, 1, N'超级管理员', CAST(N'2025-03-18T16:09:20.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T15:58:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c437274d-2be9-44ef-b8f0-85b8c6040c31', N'd902044f-abd1-42ab-b3d8-9e63f431b410', N'AKG0000002', N'架构芯片', N'Cortex - M3 内核，主频 100MHz', CAST(2.00 AS Decimal(11, 2)), 100, 190, 10, 1, N'超级管理员', CAST(N'2025-03-18T16:09:41.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T15:58:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductionReportingDetail] ([DetailID], [ReportingID], [MaterialCode], [MaterialName], [MaterialSpecification], [ReportHour], [ReportedQuantity], [AcceptedQuantity], [RejectedQuantity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'e13eda90-0c3e-436e-8b49-2631f916dbdc', N'34a8e0fb-1b90-4358-a1fb-004a6a9e9f93', N'AKG0000002', N'架构芯片', N'Cortex - M3 内核，主频 100MHz', CAST(2.00 AS Decimal(11, 2)), 100, 190, 10, 1, N'超级管理员', CAST(N'2025-03-18T16:09:52.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-18T16:09:24.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'087d6390-c914-4949-b397-3cf5bfe66df0', N'OB20250317006', N'聚乙烯（PE）', N'AKG0000003', N'低密度，颗粒状', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, N'件', CAST(N'2024-01-14T11:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:14.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:38:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'323adf96-5391-45a6-bd03-69ebe526a933', N'OB20250317008', N'碳素结构钢', N'AKG0000001', N'Q235B，厚度 5mm', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, N'件', CAST(N'2024-01-14T11:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:26.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:37:58.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'623a152c-d7d6-4aba-9456-092d1b5902b1', N'OB20250317010', N'双层瓦楞纸箱', N'AKG0000004', N'尺寸：500mm×300mm×200mm', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c8', 50, N'个', CAST(N'2024-01-15T12:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:34.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:37:47.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'688f2d79-c448-4c91-99ff-ca65448a38d7', N'OB20250317012', N'聚乙烯（PE）', N'AKG0000003', N'低密度，颗粒状', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c8', 12, N'箱', CAST(N'2024-01-15T12:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:47.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:37:34.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'7ac2fe76-c1a5-49af-b441-91c722e35759', N'OB20250317003', N'包装纸箱', N'C001', N'50*40*30cm', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c8', 50, N'个', CAST(N'2024-01-15T12:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:38:12.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'80f59df8-dbd6-47c8-b1ee-9700ad876902', N'OB20250317009', N'米其林轮胎', N'AKG0000004', N'。。。。。。。', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, N'件', CAST(N'2024-01-14T11:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:29.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:37:52.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'84a80744-df64-4b5e-b810-4028f57f405a', N'OB20250317005', N'A4 复印纸', N'AKG0000005', N'70g，500 张/包', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, N'件', CAST(N'2024-01-14T11:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:53:48.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:38:15.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9784e034-5ef3-4a5f-bd4e-6183c2e8ee25', N'OB20250317011', N'碳素结构钢', N'AKG0000001', N'Q235B，厚度 5mm', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c8', 12, N'箱', CAST(N'2024-01-15T12:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:39.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:37:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c1151e9d-704b-4abc-b8b9-8989eff162a7', N'OB20250317007', N'双层瓦楞纸箱', N'AKG0000004', N'尺寸：500mm×300mm×200mm', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, N'件', CAST(N'2024-01-14T11:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:54:23.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-20T17:38:02.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'de425c5f-114b-4f25-a5e2-a1e6f6fa166e', N'OB20250317004', N'包装纸箱', N'E00X', N'50*40*30cm', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c8', 12, N'箱', CAST(N'2024-01-15T12:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:53:44.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:54:06.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_ProductOutbound] ([OutboundID], [DocumentNo], [MaterialName], [MaterialCode], [SpecificationModel], [WarehouseID], [LocationID], [OutboundQuantity], [OutboundUnit], [OutboundDate], [OutboundOperator], [OutboundReason], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'e3b460f4-7caa-4017-92f7-e116b7920a57', N'OB20250317002', N'半成品B', N'SP001', N'半加工状态', NULL, N'3a765f84-49a6-4f42-9639-2a9c58d832c6', 30, N'件', CAST(N'2024-01-14T11:00:00.0000000' AS DateTime2), NULL, NULL, 1, N'超级管理员', CAST(N'2025-03-17T00:38:02.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_QualityInspectionPlan] ([InspectionPlanID], [InspectionPlanNumber], [OrderID], [PlanStartTime], [PlanEndTime], [ResponsiblePerson], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'60475294-c153-4c7c-8645-9209d9eb7be4', N'QIP202503190001', NULL, CAST(N'2024-07-01T09:00:00.0000000' AS DateTime2), CAST(N'2024-07-02T17:00:00.0000000' AS DateTime2), N'3362', NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:48:58.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:48.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlan] ([InspectionPlanID], [InspectionPlanNumber], [OrderID], [PlanStartTime], [PlanEndTime], [ResponsiblePerson], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'6e58e213-f8e9-4032-9dc7-d62d76a418d9', N'QIP202503190003', NULL, CAST(N'2024-07-01T09:00:00.0000000' AS DateTime2), CAST(N'2024-07-02T17:00:00.0000000' AS DateTime2), N'3362', NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:49:46.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlan] ([InspectionPlanID], [InspectionPlanNumber], [OrderID], [PlanStartTime], [PlanEndTime], [ResponsiblePerson], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'cc7fe857-0608-4872-8e8b-754e41c4609a', N'QIP202503190002', NULL, CAST(N'2024-07-01T09:00:00.0000000' AS DateTime2), CAST(N'2024-07-02T17:00:00.0000000' AS DateTime2), N'1', NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:49:40.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:44.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlan] ([InspectionPlanID], [InspectionPlanNumber], [OrderID], [PlanStartTime], [PlanEndTime], [ResponsiblePerson], [PlanStatus], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fc4a1634-e1e0-4455-acf8-4d097a95ca56', N'QIP202503190004', NULL, CAST(N'2024-07-01T09:00:00.0000000' AS DateTime2), CAST(N'2024-07-02T17:00:00.0000000' AS DateTime2), N'1', NULL, 1, N'超级管理员', CAST(N'2025-03-19T01:49:50.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:38.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'3151bae6-9b91-46cc-8615-11c3cb2afaa6', N'6e58e213-f8e9-4032-9dc7-d62d76a418d9', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', 100, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:49:47.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'4c946033-91ae-4f7e-a11e-c9fd20f0e373', N'cc7fe857-0608-4872-8e8b-754e41c4609a', N'AKG0000003', N'聚乙烯（PE）', N'低密度，颗粒状', 290, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:49:41.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:44.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'8270f2e3-71ba-4074-bbd5-c97c981dda3d', N'60475294-c153-4c7c-8645-9209d9eb7be4', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', 100, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:48:59.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:48.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'89d373c2-5fce-4915-a661-0f10d47112a5', N'6e58e213-f8e9-4032-9dc7-d62d76a418d9', N'AKG0000003', N'聚乙烯（PE）', N'低密度，颗粒状', 290, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:49:47.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'b7ad76cd-0c56-40da-beee-0a096148b00f', N'60475294-c153-4c7c-8645-9209d9eb7be4', N'AKG0000003', N'聚乙烯（PE）', N'低密度，颗粒状', 290, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:48:59.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:48.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'bb066d57-83ad-45c5-bb6e-3041b1ea65f6', N'fc4a1634-e1e0-4455-acf8-4d097a95ca56', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', 100, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:49:51.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:38.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'c6291518-07ca-4abd-bd9a-63f51ff4a68f', N'fc4a1634-e1e0-4455-acf8-4d097a95ca56', N'AKG0000003', N'聚乙烯（PE）', N'低密度，颗粒状', 290, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:49:51.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:38.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'e29789ce-3501-4a57-87d6-9ea292f193f8', N'cc7fe857-0608-4872-8e8b-754e41c4609a', N'AKG0000001', N'碳素结构钢', N'Q235B，厚度 5mm', 100, N'抽样检查', N'抽样检查', 1, N'超级管理员', CAST(N'2025-03-19T01:49:41.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:50:44.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ec9d80f7-041f-11f0-92bb-52540099312c', N'e92bea50-041f-11f0-92bb-52540099312c', N'M001', N'电阻', N'100Ω', 500, N'抽样检验', N'阻值偏差±5%', 1, N'admin', CAST(N'2024-07-01T08:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ec9d82a2-041f-11f0-92bb-52540099312c', N'e92becd6-041f-11f0-92bb-52540099312c', N'M002', N'电容', N'10μF', 300, N'全检', N'容量偏差±3%', 1, N'admin', CAST(N'2024-07-03T09:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ec9d83cd-041f-11f0-92bb-52540099312c', N'e92bed65-041f-11f0-92bb-52540099312c', N'M003', N'线路板', N'PCB-A100', 200, N'功能测试', N'无短路、断路', 1, N'admin', CAST(N'2024-07-05T10:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ec9d8477-041f-11f0-92bb-52540099312c', N'e92bedcf-041f-11f0-92bb-52540099312c', N'M004', N'塑料粒子', N'PP-500', 400, N'外观检验', N'无杂质、色泽均匀', 1, N'admin', CAST(N'2024-07-07T11:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_QualityInspectionPlanDetail] ([InspectionPlanDetailID], [InspectionPlanID], [MaterialCode], [MaterialName], [MaterialSpecification], [QuantityToInspect], [InspectionMethod], [InspectionStandard], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'ec9d8507-041f-11f0-92bb-52540099312c', N'e92bee39-041f-11f0-92bb-52540099312c', N'M005', N'螺丝', N'M3x10', 600, N'尺寸检验', N'直径偏差±0.1mm', 1, N'admin', CAST(N'2024-07-09T12:00:00.0000000' AS DateTime2), NULL, NULL, NULL)
GO
INSERT [dbo].[MES_QualityInspectionRecord] ([InspectionRecordID], [InspectionPlanDetailID], [InspectionNumber], [Inspector], [InspectionTime], [InspectedQuantity], [PassedQuantity], [FailedQuantity], [InspectionResult], [DefectDescription], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f769acb9-0421-11f0-92bb-52540099312c', N'ff1b025b-0421-11f0-92bb-52540099312c', N'QIR001', N'1', CAST(N'2024-07-01T10:00:00.0000000' AS DateTime2), 500, 480, 20, N'不合格', N'部分电阻阻值偏差超过±5%', 1, N'admin', CAST(N'2024-07-01T10:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:56:01.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionRecord] ([InspectionRecordID], [InspectionPlanDetailID], [InspectionNumber], [Inspector], [InspectionTime], [InspectedQuantity], [PassedQuantity], [FailedQuantity], [InspectionResult], [DefectDescription], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f769ae7c-0421-11f0-92bb-52540099312c', N'ff1b049d-0421-11f0-92bb-52540099312c', N'QIR002', N'3362', CAST(N'2024-07-03T11:00:00.0000000' AS DateTime2), 300, 290, 10, N'不合格', N'少数电容容量偏差超过±3%', 1, N'admin', CAST(N'2024-07-03T11:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:55:58.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionRecord] ([InspectionRecordID], [InspectionPlanDetailID], [InspectionNumber], [Inspector], [InspectionTime], [InspectedQuantity], [PassedQuantity], [FailedQuantity], [InspectionResult], [DefectDescription], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f769af6b-0421-11f0-92bb-52540099312c', N'ff1b0534-0421-11f0-92bb-52540099312c', N'QIR003', N'3362', CAST(N'2024-07-05T12:00:00.0000000' AS DateTime2), 200, 190, 10, N'不合格', N'几块线路板存在短路问题', 1, N'admin', CAST(N'2024-07-05T12:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:55:54.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionRecord] ([InspectionRecordID], [InspectionPlanDetailID], [InspectionNumber], [Inspector], [InspectionTime], [InspectedQuantity], [PassedQuantity], [FailedQuantity], [InspectionResult], [DefectDescription], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f769b023-0421-11f0-92bb-52540099312c', N'ff1b05a7-0421-11f0-92bb-52540099312c', N'QIR004', N'3362', CAST(N'2024-07-07T13:00:00.0000000' AS DateTime2), 400, 380, 20, N'合格', N'部分塑料粒子有杂质', 1, N'admin', CAST(N'2024-07-07T13:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:56:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_QualityInspectionRecord] ([InspectionRecordID], [InspectionPlanDetailID], [InspectionNumber], [Inspector], [InspectionTime], [InspectedQuantity], [PassedQuantity], [FailedQuantity], [InspectionResult], [DefectDescription], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'f769b22d-0421-11f0-92bb-52540099312c', N'ff1b0616-0421-11f0-92bb-52540099312c', N'QIR005', N'1', CAST(N'2024-07-09T14:00:00.0000000' AS DateTime2), 600, 570, 30, N'合格', N'部分螺丝直径偏差超过±0.1mm', 1, N'admin', CAST(N'2024-07-09T14:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T01:56:46.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_SchedulingPlan] ([SchedulePlanID], [PlanName], [ProductionLine], [TeamName], [StartDate], [EndDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9c2c24f1-0422-11f0-92bb-52540099312c', N'SMT产线1月排班计划', N'SMT贴片生产线', N'SMT一组', CAST(N'2024-01-01T08:00:00.0000000' AS DateTime2), CAST(N'2024-01-31T17:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-01-01T09:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T02:00:45.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_SchedulingPlan] ([SchedulePlanID], [PlanName], [ProductionLine], [TeamName], [StartDate], [EndDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9c2c268a-0422-11f0-92bb-52540099312c', N'注塑产线1月排班计划', N'注塑生产线', N'注塑一组', CAST(N'2024-01-01T09:00:00.0000000' AS DateTime2), CAST(N'2024-01-31T18:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-01-02T10:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T02:00:44.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_SchedulingPlan] ([SchedulePlanID], [PlanName], [ProductionLine], [TeamName], [StartDate], [EndDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9c2c279a-0422-11f0-92bb-52540099312c', N'总装产线1月排班计划', N'总装生产线', N'总装一组', CAST(N'2024-01-01T10:00:00.0000000' AS DateTime2), CAST(N'2024-01-31T19:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-01-03T11:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T02:00:42.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_SchedulingPlan] ([SchedulePlanID], [PlanName], [ProductionLine], [TeamName], [StartDate], [EndDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9c2c2835-0422-11f0-92bb-52540099312c', N'检测产线1月排班计划', N'检测生产线', N'检测一组', CAST(N'2024-01-01T11:00:00.0000000' AS DateTime2), CAST(N'2024-01-31T20:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-01-04T12:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T02:00:40.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_SchedulingPlan] ([SchedulePlanID], [PlanName], [ProductionLine], [TeamName], [StartDate], [EndDate], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'9c2c28b9-0422-11f0-92bb-52540099312c', N'包装产线1月排班计划', N'包装生产线', N'包装一组', CAST(N'2024-01-01T12:00:00.0000000' AS DateTime2), CAST(N'2024-01-31T21:00:00.0000000' AS DateTime2), 1, N'admin', CAST(N'2024-01-05T13:00:00.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-19T02:00:38.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Supplier] ([SupplierID], [SupplierName], [ContactPerson], [ContactPhone], [Email], [Address], [SupplierType], [ProductRange], [QualityRating], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fd83f9a1-0289-11f0-92bb-52540099312c', N'绿韵包装材料供应商', N'刘女士', N'13378901234', N'lvyun@example.com', N'杭州市西湖区', N'包装材料供应商', N'环保包装材料', N'A', N'。。。。。。。。。', 1, N'管理员', CAST(N'2025-03-17T01:13:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:14:36.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Supplier] ([SupplierID], [SupplierName], [ContactPerson], [ContactPhone], [Email], [Address], [SupplierType], [ProductRange], [QualityRating], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fd83fb2f-0289-11f0-92bb-52540099312c', N'宝盛包装用品供应商', N'孙先生', N'13289012345', N'baosheng@example.com', N'南京市鼓楼区', N'包装材料供应商', N'各类包装用品', N'B', N'。。。。。。', 1, N'管理员', CAST(N'2025-03-17T01:13:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:14:53.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Supplier] ([SupplierID], [SupplierName], [ContactPerson], [ContactPhone], [Email], [Address], [SupplierType], [ProductRange], [QualityRating], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fd83fb7b-0289-11f0-92bb-52540099312c', N'逸彩印刷包装供应商', N'周先生', N'13190123456', N'yicai@example.com', N'成都市武侯区', N'包装材料供应商', N'印刷包装产品', N'A', N'印刷工艺。。。。。。', 1, N'管理员', CAST(N'2025-03-17T01:13:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:14:59.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Supplier] ([SupplierID], [SupplierName], [ContactPerson], [ContactPhone], [Email], [Address], [SupplierType], [ProductRange], [QualityRating], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fd8f3146-0289-11f0-92bb-52540099312c', N'宏泰生产设备供应商', N'吴先生', N'13001234567', N'hongtai@example.com', N'武汉市武昌区', N'设备供应商', N'生产设备', N'A', N'。。。。。。', 1, N'管理员', CAST(N'2025-03-17T01:13:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:15:03.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Supplier] ([SupplierID], [SupplierName], [ContactPerson], [ContactPhone], [Email], [Address], [SupplierType], [ProductRange], [QualityRating], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fd8f32c3-0289-11f0-92bb-52540099312c', N'锐翔检测设备供应商', N'郑女士', N'18812345678', N'ruixiang@example.com', N'西安市碑林区', N'设备供应商', N'检测设备', N'B', N'检测精度较高。。。。。。', 1, N'管理员', CAST(N'2025-03-17T01:13:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:15:11.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_Supplier] ([SupplierID], [SupplierName], [ContactPerson], [ContactPhone], [Email], [Address], [SupplierType], [ProductRange], [QualityRating], [Remarks], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'fd8f3302-0289-11f0-92bb-52540099312c', N'丰能能源设备供应商', N'钱先生', N'18923456789', N'fengneng@example.com', N'沈阳市和平区', N'设备供应商', N'能源设备', N'A', N'。。。。。。', 1, N'管理员', CAST(N'2025-03-17T01:13:33.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T01:15:07.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_WarehouseManagement] ([WarehouseID], [WarehouseCode], [WarehouseName], [WarehouseType], [WarehouseArea], [WarehouseAddress], [WarehousePhone], [WarehouseManager], [WarehouseStatus], [WarehouseCapacity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1c19c214-9d78-4596-b078-789f7755896a', N'WH001', N'原材料仓库', N'原材料存储', CAST(1000.50 AS Decimal(10, 2)), N'工厂A区', N'021-12345678', N'李明', N'1', 5000, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:16:34.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_WarehouseManagement] ([WarehouseID], [WarehouseCode], [WarehouseName], [WarehouseType], [WarehouseArea], [WarehouseAddress], [WarehousePhone], [WarehouseManager], [WarehouseStatus], [WarehouseCapacity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1c19c214-9d78-4596-b078-789f7755896b', N'WH002', N'成品仓库', N'成品存储', CAST(1200.00 AS Decimal(10, 2)), N'工厂B区', N'021-23456789', N'张华', N'1', 6000, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:16:37.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_WarehouseManagement] ([WarehouseID], [WarehouseCode], [WarehouseName], [WarehouseType], [WarehouseArea], [WarehouseAddress], [WarehousePhone], [WarehouseManager], [WarehouseStatus], [WarehouseCapacity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1c19c214-9d78-4596-b078-789f7755896c', N'WH003', N'半成品仓库', N'半成品存储', CAST(800.25 AS Decimal(10, 2)), N'工厂C区', N'021-34567890', N'王强', N'0', 3500, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:16:44.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_WarehouseManagement] ([WarehouseID], [WarehouseCode], [WarehouseName], [WarehouseType], [WarehouseArea], [WarehouseAddress], [WarehousePhone], [WarehouseManager], [WarehouseStatus], [WarehouseCapacity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1c19c214-9d78-4596-b078-789f7755896d', N'WH004', N'不良品仓库', N'不良品暂存', CAST(300.75 AS Decimal(10, 2)), N'工厂D区', N'021-45678901', N'刘悦', N'1', 1000, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:16:41.0000000' AS DateTime2))
GO
INSERT [dbo].[MES_WarehouseManagement] ([WarehouseID], [WarehouseCode], [WarehouseName], [WarehouseType], [WarehouseArea], [WarehouseAddress], [WarehousePhone], [WarehouseManager], [WarehouseStatus], [WarehouseCapacity], [CreateID], [Creator], [CreateDate], [ModifyID], [Modifier], [ModifyDate]) VALUES (N'1c19c214-9d78-4596-b078-789f7755896e', N'WH005', N'包装材料仓库', N'包装材料存储', CAST(650.00 AS Decimal(10, 2)), N'工厂E区', N'021-56789012', N'陈杰', N'0', 4500, 1, N'admin', CAST(N'2025-03-16T23:16:24.0000000' AS DateTime2), 1, N'超级管理员', CAST(N'2025-03-17T00:16:47.0000000' AS DateTime2))
GO
INSERT [dbo].[TestService] ([Id], [DbName], [DbContent], [CreateDate], [CreateID], [Creator], [Modifier], [ModifyDate], [ModifyID]) VALUES (N'C0737155-AC39-4F35-87DC-22DD83896CAD', N'这是业务数据库', N'这是业务数据库。。', CAST(N'2023-05-19T11:46:34.0000000' AS DateTime2), 3362, N'测试管理员', NULL, NULL, NULL)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'DomDetailId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bom编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'BomId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'序号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'Sequence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'子件物料编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'子件物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'Spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单台用量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'UsageQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消耗方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'ConsumeModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'投料仓库' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'Warehouse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'SupplierCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'齐套比例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'KitScale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'启用状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'Enable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新人名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BOM明细' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Detail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'BomId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BOM编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'母件物料编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'母件物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用途' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Purpose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'版本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Edition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'EffectiveDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'失效日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'InvalidDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'启用状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Enable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新人名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BOM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Bom_Main'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'CustomerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'ContactPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'CustomerType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'信用评级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'CreditRating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'业务范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'BusinessScope'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Customer', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理记录ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'DisposalRecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不良品ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'DefectiveID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'DisposalPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'DisposalStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'DisposalEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'DisposalResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductDisposalRecord', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不良品ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'DefectiveID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'ReportingID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'MaterialSpecification'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不良品数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'DefectiveQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'DefectType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'DefectReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'DisposalMethod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'DisposalStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_DefectiveProductRecord', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障记录ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultRecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'EquipmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障影响' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultImpact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障报告人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultReportedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'FaultStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障排查开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'TroubleshootingStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'故障排查结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'TroubleshootingEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentFaultRecord', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'EquipmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养人员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenancePerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下次保养日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'NextMaintenanceDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养成本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'MaintenanceRemarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentMaintenance', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'EquipmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'EquipmentCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'EquipmentName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'EquipmentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'制造商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'PurchaseDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保修期（月）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'WarrantyPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安装位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'InstallationLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'EquipmentStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'责任人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'ResponsiblePerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentManagement', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'EquipmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修人员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修成本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'维修结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'RepairEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_EquipmentRepair', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'InventoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'DocumentNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'SpecificationModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'WarehouseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'InventoryQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'InventoryUnit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存成本' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'InventoryCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'InventoryStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'InboundDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_InventoryManagement', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属仓库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'WarehouseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位容量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位行号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationRow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位列号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationColumn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位层数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'LocationFloor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_LocationManagement', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'MaterialType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'CatalogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Specification'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计量单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单价信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Img'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Material', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'CatalogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'CatalogCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'CatalogName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'CatalogType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上级分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'启用状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'Enable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_MaterialCatalog', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序顺序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessSequence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作中心' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'WorkCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标准工时' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'StandardWorkingHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ProcessStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'责任人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ResponsibleWorker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Process', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'汇报ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ReportID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'汇报日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ReportDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'完成数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'CompletedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不良数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'DefectiveQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'汇报人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ReportedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'汇报状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ReportStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'汇报备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ReportRemarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'EndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessReport', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路线ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'RouteID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工序ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'ProductName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路线顺序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'RouteSequence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路线描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'RouteDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'前工序ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'PreProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'后工序ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'NextProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路线状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'RouteStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路线责任人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'RouteResponsible'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProcessRoute', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'InboundID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'DocumentNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'SpecificationModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'WarehouseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'InboundQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'InboundUnit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'InboundDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库操作员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'InboundOperator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'InboundReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductInbound', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'ProductionLineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'LineName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'LineType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产能信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'Capacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'负责人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'ResponsiblePerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'启用日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'停用日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLine', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'DeviceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'ProductionLineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'DeviceName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'DeviceModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'制造商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购买日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'PurchaseDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保修日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'WarrantyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'设备状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线上位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'LocationOnLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionLineDevice', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'OrderNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'CustomerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'OrderDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交货日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'DeliveryDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'OrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'OrderStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'优先级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'LV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionOrder', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更记录ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'ChangeRecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划明细ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'PlanDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'OrderNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'CustomerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'OrderDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'ChangeDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原计划数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'OriginalPlanQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新计划数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'NewPlanQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原计划开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'OriginalPlannedStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新计划开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'NewPlannedStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原计划结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'OriginalPlannedEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新计划结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'NewPlannedEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'ChangeReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'变更人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'ChangedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanChangeRecord', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划明细ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'PlanDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'MaterialSpecification'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'PlanQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'PlannedStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'PlannedEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'PlanStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionPlanDetail', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ReportingID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ReportingNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ReportedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ReportingTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工时(小时)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ReportHour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'Total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'AcceptedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不合格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'RejectedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审批状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'AuditStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审批人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'Auditor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReporting', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'明细ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'DetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'ReportingID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'MaterialSpecification'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工时(小时)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'ReportHour'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'报工数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'ReportedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'AcceptedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不合格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'RejectedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductionReportingDetail', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'OutboundID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单据号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'DocumentNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格型号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'SpecificationModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'WarehouseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出库数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'OutboundQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出库单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'OutboundUnit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出库日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'OutboundDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出库操作员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'OutboundOperator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出库原因' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'OutboundReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_ProductOutbound', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验计划ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'InspectionPlanID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验计划单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'InspectionPlanNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'OrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'PlanStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'PlanEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'责任人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'ResponsiblePerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'计划状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'PlanStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlan', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验计划明细ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'InspectionPlanDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验计划ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'InspectionPlanID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'MaterialCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物料规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'MaterialSpecification'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'QuantityToInspect'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验方法' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'InspectionMethod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验标准' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'InspectionStandard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionPlanDetail', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验记录ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'InspectionRecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验计划明细ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'InspectionPlanDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'InspectionNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'Inspector'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'InspectionTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实际检验数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'InspectedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'PassedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'不合格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'FailedQuantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验结果（合格、不合格）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'InspectionResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'DefectDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_QualityInspectionRecord', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排班计划ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'SchedulePlanID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排班计划名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'PlanName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'ProductionLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班组名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'TeamName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_SchedulingPlan', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'SupplierID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'SupplierName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'ContactPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'SupplierType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'ProductRange'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'质量评级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'QualityRating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'Remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_Supplier', @level2type=N'COLUMN',@level2name=N'ModifyDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库面积' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehousePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库管理员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseManager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'仓库容量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'WarehouseCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'CreateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'Creator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'ModifyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'Modifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MES_WarehouseManagement', @level2type=N'COLUMN',@level2name=N'ModifyDate'


