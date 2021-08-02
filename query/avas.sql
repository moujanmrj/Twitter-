drop table if exists avas;
create table avas(
	avacontent varchar(256) not null,
    username varchar(20) not null,
    postagedate datetime not null default current_timestamp,
    ID int not null auto_increment,
    iscomment int,
    
	primary key(ID),
    foreign key(username) references users(username)
);

