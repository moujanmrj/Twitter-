insert into likes(username, avaId)
select 'moujanmrj', 3
	where (select username from avas where ID = 3) not in(select username from blocks where blocked = 'moujanmrj') and 
    'moujanmrj' not in(select username from likes where avaId = 3);

insert into likes(username, avaId)
select 'dayanamov', 3
	where (select username from avas where ID = 3) not in(select username from blocks where blocked = 'dayanamov') and 
    'dayanamov' not in(select username from likes where avaId = 3);    
    
insert into likes(username, avaId)
select 'dayanamov', 6
	where (select username from avas where ID = 6) not in(select username from blocks where blocked = 'dayanamov') and 
    'dayanamov' not in(select username from likes where avaId = 6);       
    
insert into likes(username, avaId)
select 'hastimir', 6
	where (select username from avas where ID = 6) not in(select username from blocks where blocked = 'hastimir') and 
    'hastimir' not in(select username from likes where avaId = 6);      

insert into likes(username, avaId)
select 'erfanrmz', 3
	where (select username from avas where ID = 3) not in(select username from blocks where blocked = 'erfanrmz') and 
    'erfanrmz' not in(select username from likes where avaId = 3);       
    