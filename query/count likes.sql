select coalesce(count(avaId),0) as likes
	from likes inner join avas on likes.avaId=avas.ID
		where 'moujanmrj' not in (select blocked from blocks where username = avas.username) and avas.ID = 3;