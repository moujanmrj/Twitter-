CREATE DEFINER=`root`@`localhost` PROCEDURE `send_text`(
	in textcontent varchar(256),
    in receiver varchar(20),
    in contenttype int,
    in theID int
)
`sendtextscope`:
BEGIN
    declare lastlogin varchar(20);
	select username into lastlogin from logins order by logindate desc limit 1;
    
    if (contenttype = 0)
    then
		insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
		select lastlogin, receiver, theID, now(), 0, (select avacontent from avas where ID = theID) from avas as tmp 
		where  tmp.ID = theID and receiver not in(select blk.blocked from blocks as blk where tmp.username = blk.username)
		and not exists(select * from blocks as blk where (blk.username = lastlogin and blk.blocked = receiver) 
        or (blk.username = receiver and blk.blocked = lastlogin));
	else
		insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
		select lastlogin, receiver, null, now(), 1, textcontent
		where not exists(select * from blocks as blk where (blk.username = lastlogin and blk.blocked = receiver) 
        or (blk.username = receiver and blk.blocked = lastlogin));
    end if;
    
    set @maxavaid = (select max(ID) from avas);
    if (theID > @maxavaid or theID < 0)
    then
        select 'Wrong ava id' as `status`;
        LEAVE sendtextscope;
	end if;
END