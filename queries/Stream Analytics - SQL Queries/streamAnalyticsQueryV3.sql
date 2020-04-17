/*  this query will keep the full contents of the step and payload json objects
    this ensures that if fields are added that they will be stored in SQL
    this is paired with createTablesV3
*/
WITH MESSAGES AS
(    
    SELECT 
       min(cast(A.internal.data.id AS NVARCHAR(MAX))) as Id,
       min(cast(GetArrayElement(A.event,0).name AS NVARCHAR(MAX))) as eventType,
       min(cast(dim.ArrayValue.conv_id AS NVARCHAR(MAX))) as convId,
       min(cast(dim.ArrayValue.tenantName AS NVARCHAR(MAX))) as tenantName,
       min(cast(dim.ArrayValue.tenantId AS NVARCHAR(MAX))) as tenantId,
       min(cast(dim.ArrayValue.speaker AS NVARCHAR(MAX))) as speaker,
       UDF.Parse(min(cast(dim.ArrayValue.step AS NVARCHAR(MAX)))) as step,
       UDF.Parse(min(cast(dim.ArrayValue.payload AS NVARCHAR(MAX)))) as payload,       
       min(cast(dim.ArrayValue.text AS NVARCHAR(MAX))) as text,
       min(cast(dim.ArrayValue.dialogOutcome as NVARCHAR(MAX))) as dialogOutcome,
       min(cast(A.context.data.eventTime AS datetime)) as eventTime
    FROM traceythealthbotinputdev A PARTITION BY BlobName
    CROSS APPLY GetElements(A.context.custom.dimensions) as dim
    GROUP BY System.Timestamp, A.internal.data.id
    HAVING eventType = 'CDC_CORE_OUTCOME' or eventType = 'StepExecuted' OR eventType = 'Message' 
                or eventType = 'ScenarioOutcome' or eventType = 'ScenarioStart' or eventType = 'ScenarioEnded'
)

SELECT
    Id,
    eventTime,
    eventType,
    payload.version as version,
    convId,
    tenantName,
    tenantId,
    speaker,
    dialogOutcome,
    text,
    udf.JSONToString(step) as step,
    udf.JSONToString(payload) as payload
INTO
    MessageOutput
FROM MESSAGES PARTITION BY ConvId


