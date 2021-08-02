CREATE DEFINER=`root`@`localhost` PROCEDURE `list_user_logins`(
	in theusername varchar(20)
)
BEGIN
	select 
		username, logindate
	from
		logins
	where 
		username = theusername
	order by 
		logindate desc;
END