drop view Conversations_View
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Conversations_View] 
AS  
SELECT *
From 
(
select  [dbo].[Steps].convid, 
            FORMAT ([Messages].[eventtime], 'yyyy-MM-dd') as [date],
            FORMAT ([Messages].[eventtime], 'HH') as [hour],
            [dbo].[Steps].steplabel,
            [dbo].[Steps].stepresponseentity
    FROM [dbo].[Steps]
    inner join [dbo].[Messages] on [dbo].[Messages].convid = [dbo].[Steps].convid 
    inner join [dbo].[Messages] Messages2 on Messages2.convid = [dbo].[Steps].convid 
    where [dbo].[Messages].eventtype = 'ScenarioStart' and [Messages].dialogname like ('%/scenarios/covid19') and 
    Messages2.eventtype = 'ScenarioEnded' and [Messages2].dialogname like ('%/scenarios/covid19_core') and
    not exists (
                        select count(*) as [count], convid from Messages
                        where dialogname like ('%/scenarios/covid19') and eventtype = 'ScenarioStart' and [Messages].convid = [Steps].convid
                        group by convid
                        having count(*) > 1
    )
) as Source PIVOT(Min(stepResponseEntity) for [steplabel] in ([State], [Gender], [Age], [Ill], [LTCF], [HCF], [ED SYM], [911 SYM])) as PivotTable
;
GO
