select u.id, u.username, movies from users u
left join favorite_movies on favorite_movies.user_id=u.id