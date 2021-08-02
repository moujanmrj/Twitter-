select avacontent, count(likes.avaId) 
from likes inner join avas on likes.avaId=avas.ID 
where 'moujanmrj' not in (select blocked from blocks where username = avas.username)
group by likes.avaId order by count(likes.avaId) desc; 