select p.id, concat_ws(' ', p.first_name, p.last_name) as name, AVG(budget)::numeric(10) as average_budget from persons p
right join movies m on m.director_id=p.id
group by p.id