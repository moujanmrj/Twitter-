CREATE DEFINER=`root`@`localhost` PROCEDURE `create_users`(
	in firstname varchar(20),
    in lastname varchar(20),
    in username varchar(20),
    in userpassword varchar(128),
	in birthdate date,
    in biography varchar(64)
)
BEGIN
	insert into users(firstname, lastname, username, userpassword, birthdate, registerdate, biography)
	value(firstname, lastname, username, sha2(userpassword,256), birthdate, now(), biography);
END