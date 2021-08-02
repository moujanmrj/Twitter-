insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
select 'moujanmrj', 'hastimir', 1, now(), 0, (select avacontent from avas where ID = 1) from avas as tmp 
where  tmp.ID = 1 and 'hastimir' not in(select blk.blocked from blocks as blk where tmp.username = blk.username)
and not exists(select * from blocks as blk where (blk.username = 'moujanmrj' and blk.blocked = 'hastimir') or (blk.username = 'hastimir' and blk.blocked = 'moujanmrj'));

insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
select 'moujanmrj', 'hastimir', null, now(), 1, 'hii'
where not exists(select * from blocks as blk where (blk.username = 'moujanmrj' and blk.blocked = 'hastimir') or (blk.username = 'hastimir' and blk.blocked = 'moujanmrj'));

insert into texts (	sender, receiver, avaId, sendtime, contenttype, textcontent)
select 'dayanamov', 'hastimir', null, now(), 1, 'hastiii'
where not exists(select * from blocks as blk where (blk.username = 'dayanamov' and blk.blocked = 'hastimir') or (blk.username = 'hastimir' and blk.blocked = 'dayanamov'));