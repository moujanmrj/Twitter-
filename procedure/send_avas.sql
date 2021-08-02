CREATE DEFINER=`root`@`localhost` PROCEDURE `send_avas`(
	in avacontent varchar(256)
)
BEGIN
	insert into avas(username, avacontent, postagedate, iscomment)
    values ((select username from logins order by logindate desc limit 1), avacontent , now(), null);  
END