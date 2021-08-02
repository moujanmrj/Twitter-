insert into users (firstname, lastname, username, userpassword, birthdate, registerdate, biography)
	values 
    ('moujan', 'mirjalili', 'moujanmrj', sha2('12345', 256), '2000-11-16', now(), 'MOUJAN'),
    ('dayana', 'movaseghi', 'dayanamov', sha2('abcde', 256), '2002-08-31', now(), 'DAYANA'),
    ('hasti', 'mirshams', 'hastimir', sha2('hey123', 256), '2000-12-09', now(), 'HASTI'),
    ('erfan', 'ramezani', 'erfanrmz', sha2('games123', 256), '2000-06-15', now(), 'ERFAN');