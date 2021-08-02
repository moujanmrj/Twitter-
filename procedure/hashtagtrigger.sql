DELIMITER //
drop trigger if exists hashtagtrigger;
create trigger hashtagtrigger
after insert on avas for each row
BEGIN
	declare tags varchar(6);
	set @startloc := 1;
	set @startpos := -1;
	set @endpos := -1;
	set @totallen =  LENGTH(NEW.avacontent);
	while @startloc < @totallen
	do
		set @startpos := LOCATE('#', NEW.avacontent, @startloc);
		set @endpos := @startpos + 5 ;
		set @s := SUBSTRING(NEW.avacontent, @endpos+1 , 1);
		if @startpos >= 1 AND @endpos > 0 
        then
			set @len = 6;
			set tags := SUBSTRING(NEW.avacontent, @startpos, @len);
			if @s = ' ' OR @endpos = @totallen then
				insert into hashtags(hashtagContent) values (tags);
				insert into avahashtags(avaId, hashtagContent) values (new.ID, tags);
			end if;
			set @startloc = @endpos+1;
		else
			set @startloc := @totallen+1;
		end if;
	end while;
END //