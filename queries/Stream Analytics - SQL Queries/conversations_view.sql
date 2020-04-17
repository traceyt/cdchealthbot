drop view Conversations_View
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Conversations_View] as 
(
SELECT TOP (1000) Core.[id]
      ,Wrapper.[eventtime] as starttime
      ,Core.[eventtime] as endtime
      ,Core.[eventtype]
      ,Core.[convid]
      ,Core.[version]
      ,Core.[tenantname]
      ,Core.[tenantid]
      ,JSON_VALUE(Wrapper.[payload], '$.wrapper_scenario_data.country.entity') as country
      ,JSON_VALUE(Wrapper.[payload], '$.wrapper_scenario_data.country.index') as country_index
      ,JSON_VALUE(Wrapper.[payload], '$.wrapper_scenario_data.user_state.state') as state
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.gender.entity') as gender
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.gender.index') as gender_index
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.age.entity') as age
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.age.index') as age_index        
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.is_ill.entity') as ill
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.is_ill.index') as ill_index
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.not_child_symptoms.entity') as [911_sym]
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.not_child_symptoms.index') as [911_sym_index] 
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.adult_symptoms.entity') as ED_sym
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.adult_symptoms.index') as ED_sym_index       
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.cov19_contact.entity') as cov19_contact
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.cov19_contact.index') as cov19_contact_index        
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.healthcare_facility.entity') as hcf
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.healthcare_facility.index') as hcf_index
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.nursing_home.entity') as ltcf
      ,JSON_VALUE(Core.[payload], '$.core_scenario_data.nursing_home.index') as ltcf_index
      ,JSON_QUERY(Core.[payload], '$.core_scenario_outcomes') as core_scenario_outcomes
      ,JSON_VALUE(Core.[payload], '$.core_scenario_outome') as core_scenario_outcome
      ,JSON_VALUE(Core.[payload], '$.core_scenario_test_outcome') as core_scenario_test_outcome
  FROM [dbo].[Messages] as Core
  LEFT JOIN [dbo].[Messages] as Wrapper on Wrapper.convid = Core.convid and Wrapper.eventtype = 'CDC_WRAPPER_OUTCOME'
Where Core.eventtype = 'CDC_CORE_OUTCOME'
)
GO
