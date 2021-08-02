drop table if exists userslog;
create table userslog(
	username varchar(20) not null,
	registerdate datetime not null default current_timestamp,
	
    primary key(username)
    );
    
create trigger users_log 
after insert on users for each row
insert into userslog (username, registerdate) values ((select username from users order by registerdate desc limit 1), now());
