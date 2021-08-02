CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_list_of_received_texts_from_a_user`(
	in theusername varchar(20)
)
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;
	
    select textcontent, sendtime
	from texts where(sender = theusername and receiver = lastlogin)
    order by sendtime desc;
END