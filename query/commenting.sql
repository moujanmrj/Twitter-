-- insert into avas(avacontent, username, postagedate) values (':))', 'moujanmrj',now());

-- insert into avas(avacontent, username, postagedate)
-- select ':))', 'moujanmrj',now() where ('moujanmrj' not in(select blocked from blocks where username = 'erfanrmz'));

-- insert into comments(avaId, commentcontent, commenter)
-- select avaId,':))','moujanmrj'
-- 	from ava
--     where avaIdand ('moujanmrj' not in(select blocked from blocks where username = 'erfanrmz'));
--     
insert into avas (avacontent, username, postagedate, iscomment)
select 'good', 'moujanmrj', now(), 3 
where ('moujanmrj' not in(select blocked from blocks where username = 'hastimir'));
    
insert into avas (avacontent, username, postagedate, iscomment)
select 'ish', 'moujanmrj', now(), 4 
where ('moujanmrj' not in(select blocked from blocks where username = 'erfanrmz'));

insert into avas (avacontent, username, postagedate, iscomment)
select ':))', 'dayanamov', now(), 4 
where ('dayanamov' not in(select blocked from blocks where username = 'hastimir'));
    
