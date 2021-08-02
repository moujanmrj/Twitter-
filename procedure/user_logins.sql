CREATE DEFINER=`root`@`localhost` PROCEDURE `user_logins`(
	in username varchar(20),
    in userpassword varchar(128)
)
BEGIN
	insert into logins (username, logindate)
	select username, now() from users where users.userpassword = sha2(userpassword, 256);
END