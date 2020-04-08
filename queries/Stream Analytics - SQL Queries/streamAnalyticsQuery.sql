WITH STEPS AS
(    
    SELECT 
       min(cast(A.internal.data.id AS NVARCHAR(MAX))) as Id,
       min(cast(GetArrayElement(A.event,0).name AS NVARCHAR(MAX))) as eventType,
       min(cast(dim.ArrayValue.conv_id AS NVARCHAR(MAX))) as convId,
       min(cast(dim.ArrayValue.tenantName AS NVARCHAR(MAX))) as tenantName,
       min(cast(dim.ArrayValue.tenantId AS NVARCHAR(MAX))) as tenantId,
       min(cast(dim.ArrayValue.speaker AS NVARCHAR(MAX))) as speaker,
       UDF.Parse(min(cast(dim.ArrayValue.step AS NVARCHAR(MAX)))) as step,
       min(cast(dim.ArrayValue.text AS NVARCHAR(MAX))) as text,
       min(cast(dim.ArrayValue.dialogOutcome as NVARCHAR(MAX))) as dialogOutcome,
       min(cast(A.context.data.eventTime AS datetime)) as eventTime
    FROM traceythealthbotinput A PARTITION BY BlobName
    CROSS APPLY GetElements(A.context.custom.dimensions) as dim
    GROUP BY System.Timestamp, A.internal.data.id
    HAVING eventType = 'StepExecuted' OR eventType = 'Message' or eventType = 'ScenarioOutcome' or eventType = 'ScenarioStart' or eventType = 'ScenarioEnded'
),
STEPS2 AS (
    SELECT
        STEPS.Id as Id,
        STEPS.convid as convId,
        STEPS.step as step,
        try_cast(STEPS.step.response as array) as multichoice
    FROM STEPS
    HAVING STEPS.step.label = 'Risk factors' or STEPS.step.label = 'COV SYM'
)

SELECT
    Id,
    eventTime,
    convId,
    tenantName,
    tenantId,
    speaker,
    step.id as stepId,
    step.label as stepLabel,
    step.text as stepText,
    step.response.[index] as stepResponseIndex,
    COALESCE(step.response.entity, step.response.state) as stepResponseEntity
INTO
    StepOutput
FROM STEPS PARTITION BY ConvId
WHERE eventType = 'StepExecuted'

SELECT
    Id,
    eventTime,
    eventType,
    convId,
    tenantName,
    tenantId,
    speaker,
    dialogOutcome,
    text
INTO
    MessageOutput
FROM STEPS PARTITION BY ConvId
WHERE eventType = 'Message' or eventType = 'ScenarioOutcome' or eventType = 'ScenarioStart' or eventType = 'ScenarioEnded'

SELECT
    STEPS2.Id,
    STEPS2.convid,
    STEPS2.step.label,
    multichoiceElements.ArrayValue.score,
    case multichoiceElements.ArrayValue.entity
        when 'chronic lung disease' then 'chronic lung disease, moderate to severe asthma, or smoking'
        when 'weakened immune system (cancer treatment' then 'weakened immune system (cancer treatment, prolonged use of steroids, transplant or HIV/AIDS)'
        when 'underlying conditions (diabetes' then 'underlying conditions (diabetes, renal failure, or liver disease)'
        when 'fever or feeling feverish (chills' then 'fever or feeling feverish (chills, sweating)'
        else multichoiceElements.ArrayValue.entity
    end as entity,
    case
        when multichoiceElements.ArrayValue.entity = 'chronic lung disease' then 0
        when multichoiceElements.ArrayValue.entity = 'weakened immune system (cancer treatment' then 2
        when multichoiceElements.ArrayValue.entity = 'underlying conditions (diabetes' then 4
        when multichoiceElements.ArrayValue.entity = 'fever or feeling feverish (chills' then 0
        else multichoiceElements.ArrayValue.[index]
    end as [index]
INTO
    MultiChoiceAnswerOutput 
FROM STEPS2
CROSS APPLY getarrayelements(STEPS2.multichoice) as multichoiceElements


