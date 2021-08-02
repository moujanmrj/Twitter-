CREATE DEFINER=`root`@`localhost` PROCEDURE `blocking`(
	blocked varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;

	insert into blocks (username, blocked)
	select lastlogin , blocked
		where (exists(select lastlogin from users)) and (lastlogin not in(select blocked from blocks where username = lastlogin));
END