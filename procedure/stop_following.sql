CREATE DEFINER=`root`@`localhost` PROCEDURE `stop_following`(
	in thefollowings varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;
    
	delete from follow 
	where username = lastlogin and followings = thefollowings;
END