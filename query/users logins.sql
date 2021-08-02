insert into logins (username, logindate)
select 'moujanmrj', now() from users where users.userpassword = sha2('12345', 256);

insert into logins (username, logindate)
select 'dayanamov', now() from users where users.userpassword = sha2('abcdef', 256);

insert into logins (username, logindate)
select username, now() from users where users.userpassword = sha2('12345', 256) and users.username = 'moujanmrj';

insert into logins (username, logindate)
select 'hastimir', now() from users where users.userpassword = sha2('hey123', 256);

insert into logins (username, logindate)
select 'hastimir', now() from users where users.userpassword = sha2('hey1234', 256);

insert into logins (username, logindate)
select 'hastimir', now() from users where users.userpassword = sha2('hey123', 256);

