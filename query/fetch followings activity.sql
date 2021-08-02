select username, avacontent, postagedate 
from avas
where 
	(username in(select followings from follow where follow.username = 'moujanmrj') and username not in(select username from blocks where blocks.blocked = 'moujanmrj'))
order by 
	postagedate desc;