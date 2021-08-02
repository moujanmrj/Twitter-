drop table if exists comments;
create table comments(
	avaId int not null,
    commentcontent varchar(256) not null,
    commenter varchar(20) not null,
    commentId int not null auto_increment,
    
    primary key(commentId),
    foreign key(commenter) references users(username),
    foreign key(avaId) references avas(ID)
);