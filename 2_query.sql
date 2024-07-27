select m.id, m.title, count(*) as actors_count from movies m
right join actors_participations ap on ap.movie_id=m.id
right join persons p on ap.person_id = p.id
where EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM RELEASE_DATE) BETWEEN 0 AND 5
group by(m.id)