create trigger hashtagstrigger
after insert on avas for each row
call hashtagsprocedure (
(select avaContent from avas order by postagedate desc limit 1),
(select ID from avas order by postagedate desc limit 1)) 