-- select likes.username from likes inner join avas on likes.avaId = avas.ID
-- 	where likes.avaId= 3 and 'erfanrmz' not in (select blocked from blocks where username = 'hastimir' ) and
-- 	likes.username not in (select username from blocks inner join likes on blocks.username = likes.username where blocked= 'erfanrmz' );
--   
--  select username
-- 	from likes inner join avas on likes.avaId=avas.ID
-- 		where 'moujanmrj' not in (select blocked from blocks where username = avas.username) and 
-- 		avas.ID = 3 and'moujanmrj' not in (select blocked from blocks where username = 'hastimir' );

select username from (select likes.username from avas inner join likes on likes.avaId = avas.ID 
where avas.ID = 3 and avas.username not in (select username from blocks where blocked = 'moujanmrj')) as liker
where liker.username not in (select username from blocks where blocked = 'moujanmrj');

