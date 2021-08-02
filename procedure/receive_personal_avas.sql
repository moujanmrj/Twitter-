CREATE DEFINER=`root`@`localhost` PROCEDURE `receive_personal_avas`(
	in theusername varchar(20)
)
BEGIN
	select username, avacontent
	from avas
	where username = theusername;
END