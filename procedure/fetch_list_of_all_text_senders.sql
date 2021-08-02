CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_list_of_all_text_senders`(
	
)
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;
    
	select sender, textcontent, sendtime
	from texts 
    where receiver = lastlogin
    order by sendtime desc;
END