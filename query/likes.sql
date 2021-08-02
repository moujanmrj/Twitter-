drop table if exists likes;
create table likes(
	username varchar(20) not null,
	avaId int not null,

	foreign key(username) references users(username),
	foreign key(avaId) references avas(ID)
);