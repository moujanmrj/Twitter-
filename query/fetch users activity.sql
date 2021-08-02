select username, avacontent, postagedate 
from avas
where 
	(username = 'hastimir' and username not in(select username from blocks where blocks.blocked = 'moujanmrj'))
order by 
	postagedate desc;