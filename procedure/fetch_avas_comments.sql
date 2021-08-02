CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_avas_comments`(
	in theID int
)
`fetchavascommentsscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
	
	select username, avacontent, postagedate 
    from avas
	where (iscomment =  theID and lastlogin not in (select blocked from blocks where username in (select username from avas where ID = theID)));
    
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE fetchavascommentsscope;
	end if;
END