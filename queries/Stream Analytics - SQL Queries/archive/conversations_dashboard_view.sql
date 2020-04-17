drop view Conversations_Dashboard_View
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Conversations_Dashboard_View] 
AS  
SELECT [State]
      ,[Conversations_View].[date]
      ,[Conversations_View].[hour]
      ,[Gender]
      ,[Age]
      ,[HCF]
      ,[outcome]
      ,Count(*) as [count]
  FROM [dbo].[Conversations_View]
  join [dbo].[Conversations_Outcome_View] on [dbo].[Conversations_Outcome_View].convid = [dbo].[Conversations_View].convid 
  group by [State], [Conversations_View].[date], [Conversations_View].[hour], [Gender], [Age], [HCF], [outcome]
;
GO
