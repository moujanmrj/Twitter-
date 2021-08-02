CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_followings_activity`(
		
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;

	select username, avacontent, postagedate 
	from avas
	where 
		(username in(select followings from follow where follow.username = lastlogin) and username not in(select username from blocks where blocks.blocked = lastlogin))
	order by 
		postagedate desc;
END