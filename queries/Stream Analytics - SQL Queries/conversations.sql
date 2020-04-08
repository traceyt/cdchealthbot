SELECT *
From 
( 
    select  [dbo].[Steps].convid, 
            [dbo].[Steps].steplabel,
            [dbo].[Steps].stepresponseentity,
            [dbo].[Messages].dialogoutcome
    FROM [dbo].[Steps]
    join [dbo].[Messages] on [dbo].[Messages].convid = [dbo].[Steps].convid 
    where [dbo].[Messages].eventtype = 'ScenarioOutcome'
) as Source PIVOT(Min([stepresponseentity]) for [steplabel] in ([State], [Gender], [Age], [Ill], [LTCF], [HCF], [ED SYM], [911 SYM] )) as PivotTable
