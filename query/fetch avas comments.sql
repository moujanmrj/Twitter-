select username, avacontent, postagedate from avas
where iscomment = 3 and username not in (select blocked from blocks where username = 'hastimir');
