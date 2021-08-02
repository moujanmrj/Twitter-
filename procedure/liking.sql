CREATE DEFINER=`root`@`localhost` PROCEDURE `liking`(
	in theID int
)
`likingscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
	 
    if lastlogin not in (select blocked from blocks where username in (select username from avas where ID = theID)) 
    and lastlogin not in(select username from likes where avaId = avaId)
	then
		insert into likes (username, avaId) 
		values (lastlogin, theID);
        select 'liked successfully' as `status`;
	else
		select 'liking failed' as `status`;
		leave likingscope;
	end if;
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE likingscope;
	end if;
END