CREATE DEFINER=`root`@`localhost` PROCEDURE `followings`(
    in followings varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
    select username into lastlogin from logins order by logindate desc limit 1;
	
    insert into follow (username, followings)
	select lastlogin, followings
		where (exists(select lastlogin from users))and (lastlogin not in(select followings from follow where username = lastlogin));
END