CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_list_of_an_ava_likers`(
	in theID int
)
`fetchlistofanavalikersscope`:
BEGIN
	declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;	

	select username from (select likes.username from avas inner join likes on likes.avaId = avas.ID 
	where avas.ID = theID and avas.username not in (select username from blocks where blocked = lastlogin)) as liker
	where liker.username not in (select username from blocks where blocked = lastlogin);

	set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE fetchlistofanavalikersscope;
	end if;
END