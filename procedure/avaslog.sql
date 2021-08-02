drop table if exists avaslog;
create table avaslog(
	username varchar(20) not null,
	postagedate datetime not null default current_timestamp,
    ID int not null,
	
	primary key(ID),
    foreign key(username) references users(username)
    );
    
create trigger avas_log 
after insert on avas for each row
insert into avaslog (username, postagedate, ID) values ((select username from avas order by postagedate desc limit 1), now(), (select ID from avas order by postagedate desc limit 1));
