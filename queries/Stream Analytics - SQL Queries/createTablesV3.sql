/* this create table query is paired with the streamAnalyticsQueryV2 */
drop table Messages
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[id] [varchar](100) NOT NULL,
	[eventtime] [datetime] NOT NULL,
	[eventtype] [varchar](100) NULL,
	[convid] [varchar](80) NOT NULL,
	[version] [varchar](80) NULL,
	[tenantname] [varchar](100) NULL,
	[tenantid] [varchar](100) NULL,
	[dialogname] [varchar](100) NULL,
	[speaker] [varchar](100) NULL,
	[text] [nvarchar](max) NULL,
	[dialogoutcome] [nvarchar](max) NULL,
  [step] [nvarchar] (max) NULL,
	[payload] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
