CREATE DEFINER=`root`@`localhost` PROCEDURE `count_likes`(
	in theID int
)
`countlikesscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	

	select coalesce(count(avaId),0) as likes
	from likes inner join avas on likes.avaId=avas.ID
		where lastlogin not in (select blocked from blocks where username = avas.username) and avas.ID = theID;
        
	set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE countlikesscope;
	end if;
END