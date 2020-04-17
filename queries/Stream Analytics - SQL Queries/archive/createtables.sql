drop table Steps
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Steps](
	[id] [varchar](100) NOT NULL,
	[eventtime] [datetime] NOT NULL,
	[eventtype] [varchar](100) NULL,
	[convid] [varchar](80) NOT NULL,
	[tenantname] [varchar](100) NULL,
	[tenantid] [varchar](100) NULL,
	[dialogname] [varchar](100) NULL,
	[speaker] [varchar](100) NULL,
	[stepid] [varchar](100) NULL,
	[steplabel] [varchar](200) NULL,
	[stepresponse] [varchar](1000) NULL,
	[steptext] [varchar](1000) NULL,
	[stepresponseindex] [int] NULL,
	[stepresponseentity] [varchar](1000) NULL,
	[dialogoutcome] [varchar](100) NULL
) ON [PRIMARY]
GO


drop table Messages
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[id] [varchar](100) NOT NULL,
	[eventtime] [datetime] NOT NULL,
	[eventtype] [varchar](100) NULL,
	[convid] [varchar](80) NOT NULL,
	[tenantname] [varchar](100) NULL,
	[tenantid] [varchar](100) NULL,
	[dialogname] [varchar](100) NULL,
	[speaker] [varchar](100) NULL,
	[text] [varchar](5000) NULL,
	[dialogoutcome] [varchar](100) NULL
) ON [PRIMARY]
GO

drop table MultiChoiceAnswers
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MultiChoiceAnswers](
	[id] [varchar](100) NOT NULL,
	[eventtime] [datetime] NOT NULL,
	[eventtype] [varchar](100) NULL,
	[convid] [varchar](80) NOT NULL,
	[tenantname] [varchar](100) NULL,
	[tenantid] [varchar](100) NULL,
	[dialogname] [varchar](100) NULL,
	[label] [varchar](100) NULL,
	[score] [int] NULL,
	[entity] [varchar](200) NULL,
	[index] [int] NULL
) ON [PRIMARY]
GO

