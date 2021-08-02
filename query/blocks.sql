drop table if exists blocks;
create table blocks(
    username varchar(20) not null,
	blocked varchar(20) not null,
    
    foreign key(username) references users(username),
    foreign key(blocked) references users(username)
);