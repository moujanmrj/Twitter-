CREATE DEFINER=`root`@`localhost` PROCEDURE `stop_blocking`(
	theblocked varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;

	delete from blocks 
	where username = lastlogin and blocked = theblocked;
END