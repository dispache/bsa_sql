create type role_enum as enum ('leading', 'supporting', 'background', 'crowd');
create type gender_enum as enum ('male', 'female');
create type person_position as enum ('actor', 'director');

create table genres (
	id serial primary key,
	name varchar(25) not null,
	created_at date default now() not null,
	updated_at date
);

create table countries (
	id serial primary key,
	name varchar(255) not null,
	created_at date default now() not null,
	updated_at date
);

create table files (
	id serial primary key,
	file_name varchar(255) not null,
	mime_type varchar(255) not null,
	key text not null,
	url text,
	created_at date default now() not null,
	updated_at date
);

create table users (
	id serial primary key,
	username varchar(55) not null unique,
	first_name varchar(55) not null,
	last_name varchar(55) not null,
	email varchar(55) not null unique,
	password text not null,
	avatar bigint,
	created_at date default now() not null,
	updated_at date,
	constraint fk_avatar
		foreign key(avatar)
			references files(id)
);

create table movies (
	id serial primary key,
	title varchar(255) not null,
	description text,
	budget bigint,
	release_date date,
	duration bigint not null,
	director_id bigint not null,
	country_id bigint,
	poster_id bigint,
	created_at date default now() not null,
	updated_at date,
	constraint fk_poster_id
		foreign key(poster_id)
			references files(id),
	constraint fk_director_id
		foreign key(director_id)
			references persons(id),
	constraint fk_country_id
		foreign key(country_id)
			references countries(id)
);

create table movies_genres (
	id serial primary key,
	movie_id bigint not null,
	genre_id bigint not null,
	created_at date default now() not null,
	updated_at date,
	constraint fk_movie
		foreign key(movie_id)
			references movies(id),
	constraint fk_genre
		foreign key (genre_id)
			references genres(id)
);

create table persons (
	id serial primary key,
	first_name varchar(55) not null,
	last_name varchar(55) not null,
	biography text,
	date_of_birth date,
	position person_position not null,
	gender gender_enum not null,
	created_at date default now() not null,
	updated_at date,
	country_id bigint,
	primary_image bigint unique,
	constraint fk_primary_image
		foreign key(primary_image)
			references files(id),
	constraint fk_country_id
		foreign key(country_id)
			references countries(id)
);

create table characters (
	id serial primary key,
	name varchar(55) not null,
	description text,
	role role_enum not null,
	movie_id bigint not null,
	person_id bigint,
	created_at date default now() not null,
	updated_at date,
	constraint fk_movie_id
		foreign key(movie_id)
			references movies(id),
	constraint fk_person_id
		foreign key(person_id)
			references persons(id)
);

create table persons_additional_photos (
	id serial primary key,
	person_id bigint not null,
	file_id bigint not null unique,
	created_at date default now() not null,
	updated_at date,
	constraint fk_person_id
		foreign key(person_id)
			references persons(id),
	constraint fk_file_id
		foreign key(file_id)
			references files(id)
);

create table actors_participations (
	id serial primary key,
	person_id bigint not null,
	movie_id bigint not null,
	role role_enum not null,
	created_at date default now() not null,
	updated_at date,
	constraint fk_person_id
		foreign key(person_id)
			references persons(id),
	constraint fk_movie_id
		foreign key(movie_id)
			references movies(id)
);

create table favorite_movies (
	id serial primary key,
	user_id bigint not null,
	movies bigint[] not null,
	created_at date default now() not null,
	updated_at date,
	constraint fk_user_id
		foreign key(user_id)
			references users(id)
);