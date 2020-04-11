drop VIEW MultiChoiceAnswersView
go
CREATE VIEW MultiChoiceAnswersView
as
select 
    [State],
    label,
    entity,
    count(*) as [total]
from multichoiceanswers
join Conversations on conversations.convid = multichoiceanswers.convid
where entity != 'None of the above'
group by [State], label, entity;