drop table if exists follow;
create table follow(
    username varchar(20) not null,
	followings varchar(20) not null,
    
    foreign key(username) references users(username),
    foreign key(followings) references users(username)
);