drop table if exists hashtags;
create table hashtags(
    hashtagContent char(6) check(hashtagContent like '#%') not null,
	
    primary key(hashtagContent)
);