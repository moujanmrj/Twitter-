CREATE DEFINER=`root`@`localhost` PROCEDURE `hashtagsprocedure`(
	in content varchar(256),
    in avaId int
)
BEGIN
	declare thelist text default null;
    declare thenext text default null;
    declare thenextlen text default null;
    declare thevalue text default null;
    
    set thelist = substr(content, locate('#', content));
    iterator:
    loop
		if char_length(trim(thelist)) = 0 or thelist is null then
			leave iterator;
        end if;
		set thenext = substring_index(thelist, '#', 1);
		set thenextlen = char_length(thenext);
        set thenext = substring_index(thenext, ' ',1);
		set thevalue = trim(thenext);
		if char_length(thevalue) = 5
        then
			insert into hashtags (hashtagContent) values (thevalue);
			insert into avahashtags (avaId, hashtagContent) values (avaId, thevalue);
		end if;
        set thelist = insert(thelist, 1, thenextlen+1, '');
	end loop;
END