insert into follow (username,followings)
select 'moujanmrj' , 'dayanamov'
		where (exists(select username from users))and ('dayanamov' not in(select followings from follow where username = 'moujanmrj'));

insert into follow (username,followings)
select 'moujanmrj' , 'dayanamov'
		where (exists(select username from users))and ('dayanamov' not in(select followings from follow where username = 'moujanmrj'));
        
insert into follow (username,followings)
select 'moujanmrj' , 'hastimir'
		where (exists(select username from users))and ('hastimir' not in(select followings from follow where username = 'moujanmrj'));
        
insert into follow (username,followings)
select 'moujanmrj' , 'erfanrmz'
		where (exists(select username from users))and ('erfanrmz' not in(select followings from follow where username = 'moujanmrj'));
        
insert into follow (username,followings)
select 'hastimir' , 'moujanmrj'
		where (exists(select username from users))and ('moujanmrj' not in(select followings from follow where username = 'hastimir'));