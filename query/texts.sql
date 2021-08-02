drop table if exists texts;
create table texts(
	textcontent varchar(256),
    sender varchar(20) not null,
    receiver varchar(20) not null,
    sendtime datetime not null default current_timestamp,
    contenttype int not null,
    avaId int,
	ID int not null auto_increment,
    
    primary key(ID),
    foreign key(avaID) references avas(ID),
    foreign key(sender) references users(username),
    foreign key(receiver) references users(username)
);