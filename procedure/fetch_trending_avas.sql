CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_trending_avas`()
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
	
    select avacontent, count(likes.avaId) 
	from likes inner join avas on likes.avaId=avas.ID 
	where lastlogin not in (select blocked from blocks where username = avas.username)
	group by likes.avaId order by count(likes.avaId) desc; 
END