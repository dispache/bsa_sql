select persons.id, first_name, last_name, sum(movies.budget) as totalBudget from persons
left join actors_participations ON actors_participations.person_id = persons.id
left join movies on actors_participations.movie_id = movies.id
group by persons.id;