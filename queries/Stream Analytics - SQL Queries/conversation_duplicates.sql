select count(*) as [count], convid from Messages
where dialogname like ('%/scenarios/covid19') and eventtype = 'ScenarioStart'
group by convid
having count(*) > 1
order by [count] desc