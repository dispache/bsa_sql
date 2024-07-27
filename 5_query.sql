select m.id, m.title, m.release_date, m.duration, m.description, 
json_agg(f) as poster, json_build_object('id', p.id, 'first_name', p.first_name,
'last_name', p.last_name) as director, array_agg(g.name) as genres
from movies m
left join files f on f.id=m.poster_id
left join persons p on p.id=m.director_id
left join movies_genres mg on mg.movie_id=m.id
left join genres g on g.id=mg.genre_id
where m.country_id=1 AND EXTRACT(YEAR FROM m.release_date) > 2021 AND m.duration >= 8100000
group by m.id, p.id