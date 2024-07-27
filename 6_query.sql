select m.id, m.title, m.release_date, m.duration, m.description, json_agg(f) as poster, array_agg(g.name) as genres,
json_build_object('id', p.id, 'first_name', p.first_name, 'last_name', p.last_name, 'photo', p.primary_image) as director
from movies m
left join files f on f.id=m.poster_id
left join persons p on p.id=m.director_id
left join movies_genres mg on mg.movie_id=m.id
left join genres g on g.id=mg.genre_id
group by m.id, p.id