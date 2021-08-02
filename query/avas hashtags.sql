drop table if exists avashashtags;
create table avashashtags(
	avaId int not null,
    hashtagContent char(6) check(hashtagContent like '#%') not null,
    
   foreign key (hashtagContent) references hashtags(hashtagContent),
   foreign key (avaId) references avas(ID)
);