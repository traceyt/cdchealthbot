drop view Conversations_Outcome_View
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Conversations_Outcome_View] 
AS  
select  [dbo].[Steps].convid, 
            FORMAT ([Messages].[eventtime], 'yyyy-MM-dd') as [date],
            FORMAT ([Messages].[eventtime], 'HH') as [hour],
        [dbo].[Steps].steplabel as outcome
FROM [dbo].[Steps]
join [dbo].[Messages] on [dbo].[Messages].convid = [dbo].[Steps].convid 
where [dbo].[Steps].steplabel in ('MSG 1', 'MSG 2', 'MSG 3', 'MSG 4', 'MSG 5', 
                                        -- 'MSG 6' exclude MSG 6 as it is captured by the HCF flag
                                            'MSG 7', 'MSG 8', 'MSG 9', 'MSG 10', 'MSG 11', 'MSG 12', 'MSG 13') and 
    [dbo].[Messages].eventtype = 'ScenarioStart' and [Messages].dialogname like ('%/scenarios/covid19') and 
    not exists (
                        select count(*) as [count], convid from Messages
                        where dialogname like ('%/scenarios/covid19') and eventtype = 'ScenarioStart' and [Messages].convid = [Steps].convid
                        group by convid
                        having count(*) > 1
    )
;
GO
