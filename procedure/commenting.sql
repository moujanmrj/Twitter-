CREATE DEFINER=`root`@`localhost` PROCEDURE `commenting`(
	in avacontent varchar(256),
    in theID int
)
`commentingscope`:
BEGIN
    -- set @lastlogin = (select username from logins order by logindate desc limit 1);
    declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	
    
    if lastlogin not in (select blocked from blocks where username in (select username from avas where ID = theID))
	then
		insert into avas (avacontent, username, postagedate, iscomment) 
		values (avacontent, lastlogin, now(), theID);
        select 'commented successfully' as `status`;
	else
		select 'Ava sender of this ava has blocked you' as `status`;
		leave commentingscope;
	end if;
    
	set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE commentingscope;
	end if;
END