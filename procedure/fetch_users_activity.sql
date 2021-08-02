CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_users_activity`(
	in theusername varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;
    
	select username, avacontent, postagedate 
	from avas
	where 
		(username = theusername and username not in(select username from blocks where blocks.blocked = lastlogin))
	order by 
		postagedate desc;
END