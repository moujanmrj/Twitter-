drop table if exists logins;
create table logins(
    username varchar(20) not null,
	logindate datetime not null default current_timestamp,
    
    foreign key(username) references users(username)
);