select avacontent, username, postagedate
	from avas inner join avashashtags on avas.ID=avashashtags.avaId
    where hashtagContent = '#hihih' and username not in (select username from blocks where blocked = 'dayanamov')
	order by postagedate desc;