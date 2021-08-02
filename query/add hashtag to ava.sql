insert into hashtags(hashtagContent) values('#hihih');

insert into avashashtags(hashtagContent, avaId)
select '#hihih', 1  where  ('#hihih' not in(select hashtagContent from avashashtags where avaId = 1));