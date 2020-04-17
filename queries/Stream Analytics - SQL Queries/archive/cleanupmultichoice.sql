/*

scenario.risk_factor_list = [
    'Chronic lung disease, moderate to severe asthma, or smoking',
    'Serious heart conditions',
    'Weakened immune system (cancer treatment, prolonged use of steroids, transplant or HIV/AIDS)',
    'Severe obesity (Body Mass Index [BMI] greater than or equal to 40)',
    'Underlying conditions (diabetes, renal failure, or liver disease)',
    'Pregnancy',
    'None of the above'
];

    COV_symptoms: [
        'Fever or feeling feverish (chills, sweating)', 
        'Shortness of breath (not severe)',
        'Cough',
        'Other'
    ],

*/
update multichoiceanswers
set entity = (
case
    when entity = 'Chronic lung disease' then 'Chronic lung disease, moderate to severe asthma, or smoking'
    when entity = 'Weakened immune system (cancer treatment' then 'Weakened immune system (cancer treatment, prolonged use of steroids, transplant or HIV/AIDS)'
    when entity = 'Underlying conditions (diabetes' then 'Underlying conditions (diabetes, renal failure, or liver disease)'
    when entity = 'Fever or feeling feverish (chills' then 'Fever or feeling feverish (chills, sweating)'
    else entity
end )

update multichoiceanswers
set multichoiceanswers.[index] = (
case
    when entity = 'Chronic lung disease, moderate to severe asthma, or smoking' then 0
    when entity = 'Weakened immune system (cancer treatment, prolonged use of steroids, transplant or HIV/AIDS)' then 2
    when entity = 'Underlying conditions (diabetes, renal failure, or liver disease)' then 4
    when entity = 'Fever or feeling feverish (chills, sweating)' then 0
    else multichoiceanswers.[index]
end )

delete from multichoiceanswers
where [index] = -1

delete from multichoiceanswers
where entity = ' sweating)' or 
entity = ' moderate to severe asthma' or 
entity = ' or smoking' or 
entity = ' prolonged use of steroids' or 
entity = ' transplant or hiv/aids)' or 
entity = ' renal failure' or 
entity = ' or liver disease)'

delete
  FROM [dbo].[Steps]
  where dialogname like ('%/scenarios/covid19_partner%')

delete 
  FROM [dbo].[Steps]
  where dialogoutcome is not null and steplabel is null

delete
  FROM [dbo].[Messages]
  where dialogoutcome like ('%f724d6c1627e-af3b53043780cb5b-ac2f')
  or dialogoutcome like ('%Return to Wrapper')
  or dialogoutcome like ('%9cd0b8238414-6a4ea50ab40e5aa9-65f5')
  or dialogoutcome like ('%6a93493d9d85-4be7fb388e4daea8-c076')
  or dialogoutcome like ('%cfc705fbc23d-5f53362c813af842-6ac9')
  or dialogoutcome like ('%[caa9393de524-2ace853c4db43f03-c1c5')
  or dialogoutcome like ('%78157d36cf5b-e4583b5c6d2f33a7-6b6b')
  or dialogoutcome like ('%c66ad17da809-fb3e59962a538903-451a')
  or dialogoutcome like ('%ea69956b1e21-ccaa9c68a34ac63f-1c81')
  or dialogoutcome like ('%caa9393de524-2ace853c4db43f03-c1c5')
  or dialogoutcome like ('%18d40c0f9e44-495b5ad0190d53a6-57b7')
  or dialogoutcome like ('%c66ad17da809-fb3e59962a538903-451a')
  or dialogoutcome like ('%85473ce790b9-7569b54fd87065d3-61e4')
  or dialogoutcome like ('%0c79da9d23c5-38087583479cc069-146c')