insert into blocks (username,blocked)
select 'erfanrmz' , 'moujanmrj'
		where (exists(select username from users))and ('moujanmrj' not in(select blocked from blocks where username = 'erfanrmz'));
        
insert into blocks (username,blocked)
select 'erfanrmz' , 'moujanmrj'
		where (exists(select username from users))and ('moujanmrj' not in(select blocked from blocks where username = 'erfanrmz'));        
        
insert into blocks (username,blocked)
select 'moujanmrj' , 'erfanrmz'
		where (exists(select username from users))and ('erfanrmz' not in(select blocked from blocks where username = 'moujanmrj'));          