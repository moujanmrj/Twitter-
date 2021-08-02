-- drop schema if exists canary;
-- create schema canary;

drop table if exists users;
create table users(
	firstname varchar(20) not null,
	lastname varchar(20) not null,
	username varchar(20) not null,
	userpassword varchar(128) not null,
	birthdate date,
	registerdate datetime not null default current_timestamp,
	biography varchar(64),
	
    primary key(username)
    );
    
    
    
    
    
    
    
    
