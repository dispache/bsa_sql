--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: gender_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender_enum AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.gender_enum OWNER TO postgres;

--
-- Name: person_position; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.person_position AS ENUM (
    'actor',
    'director'
);


ALTER TYPE public.person_position OWNER TO postgres;

--
-- Name: role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role_enum AS ENUM (
    'leading',
    'supporting',
    'background',
    'crowd'
);


ALTER TYPE public.role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actors_participations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actors_participations (
    id integer NOT NULL,
    person_id bigint NOT NULL,
    movie_id bigint NOT NULL,
    role public.role_enum NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.actors_participations OWNER TO postgres;

--
-- Name: actors_participations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actors_participations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actors_participations_id_seq OWNER TO postgres;

--
-- Name: actors_participations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actors_participations_id_seq OWNED BY public.actors_participations.id;


--
-- Name: characters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    name character varying(55) NOT NULL,
    description text,
    role public.role_enum NOT NULL,
    movie_id bigint NOT NULL,
    person_id bigint,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.characters OWNER TO postgres;

--
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.characters_id_seq OWNER TO postgres;

--
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_id_seq OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: favorite_movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorite_movies (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    movies bigint[] NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.favorite_movies OWNER TO postgres;

--
-- Name: favorite_movies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favorite_movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorite_movies_id_seq OWNER TO postgres;

--
-- Name: favorite_movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favorite_movies_id_seq OWNED BY public.favorite_movies.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    mime_type character varying(255) NOT NULL,
    key text NOT NULL,
    url text,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.files OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_id_seq OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    budget bigint,
    release_date date,
    duration bigint NOT NULL,
    poster_id bigint,
    created_at date DEFAULT now() NOT NULL,
    updated_at date,
    director_id bigint DEFAULT 1 NOT NULL,
    country_id bigint
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: movies_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_genres (
    id integer NOT NULL,
    movie_id bigint NOT NULL,
    genre_id bigint NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.movies_genres OWNER TO postgres;

--
-- Name: movies_genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_genres_id_seq OWNER TO postgres;

--
-- Name: movies_genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_genres_id_seq OWNED BY public.movies_genres.id;


--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_id_seq OWNER TO postgres;

--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persons (
    id integer NOT NULL,
    first_name character varying(55) NOT NULL,
    last_name character varying(55) NOT NULL,
    biography text,
    date_of_birth date,
    gender public.gender_enum NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date,
    country character varying(255),
    primary_image bigint,
    "position" public.person_position
);


ALTER TABLE public.persons OWNER TO postgres;

--
-- Name: persons_additional_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persons_additional_photos (
    id integer NOT NULL,
    person_id bigint NOT NULL,
    file_id bigint NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.persons_additional_photos OWNER TO postgres;

--
-- Name: persons_additional_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.persons_additional_photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.persons_additional_photos_id_seq OWNER TO postgres;

--
-- Name: persons_additional_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.persons_additional_photos_id_seq OWNED BY public.persons_additional_photos.id;


--
-- Name: persons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.persons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.persons_id_seq OWNER TO postgres;

--
-- Name: persons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.persons_id_seq OWNED BY public.persons.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(55) NOT NULL,
    first_name character varying(55) NOT NULL,
    last_name character varying(55) NOT NULL,
    email character varying(55) NOT NULL,
    password text NOT NULL,
    avatar bigint,
    created_at date DEFAULT now() NOT NULL,
    updated_at date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: actors_participations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors_participations ALTER COLUMN id SET DEFAULT nextval('public.actors_participations_id_seq'::regclass);


--
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: favorite_movies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_movies ALTER COLUMN id SET DEFAULT nextval('public.favorite_movies_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: movies_genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres ALTER COLUMN id SET DEFAULT nextval('public.movies_genres_id_seq'::regclass);


--
-- Name: persons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons ALTER COLUMN id SET DEFAULT nextval('public.persons_id_seq'::regclass);


--
-- Name: persons_additional_photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons_additional_photos ALTER COLUMN id SET DEFAULT nextval('public.persons_additional_photos_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: actors_participations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actors_participations (id, person_id, movie_id, role, created_at, updated_at) FROM stdin;
7	1	5	leading	2024-07-26	\N
8	1	1	supporting	2024-07-26	\N
9	1	10	leading	2024-07-26	\N
10	2	6	leading	2024-07-26	\N
11	2	7	leading	2024-07-26	\N
12	3	4	supporting	2024-07-26	\N
13	4	10	leading	2024-07-27	\N
\.


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characters (id, name, description, role, movie_id, person_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, name, created_at, updated_at) FROM stdin;
1	USA	2024-07-27	\N
2	Canada	2024-07-27	\N
3	Great Britain	2024-07-27	\N
4	Ukraine	2024-07-27	\N
5	Spain	2024-07-27	\N
6	Italy	2024-07-27	\N
7	Portugal	2024-07-27	\N
8	Germany	2024-07-27	\N
9	Denmark	2024-07-27	\N
10	France	2024-07-27	\N
11	Ireland	2024-07-27	\N
12	Sweden	2024-07-27	\N
13	Netherlands	2024-07-27	\N
\.


--
-- Data for Name: favorite_movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorite_movies (id, user_id, movies, created_at, updated_at) FROM stdin;
1	1	{1,10,11}	2024-07-27	\N
2	2	{5,6}	2024-07-27	\N
3	3	{12}	2024-07-27	\N
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files (id, file_name, mime_type, key, url, created_at, updated_at) FROM stdin;
1	first_poster	image/png	first_key	first_url	2024-07-27	\N
2	second_poster	image/png	second_key	second_url	2024-07-27	\N
3	third_poster	image/png	third_key	third_url	2024-07-27	\N
4	fourth_poster	image/png	fourth_key	fourth_url	2024-07-27	\N
5	just_file	image/png	1key2	1url2	2024-07-27	\N
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (id, name, created_at, updated_at) FROM stdin;
1	Action	2024-07-27	\N
2	Drama	2024-07-27	\N
3	Comedy	2024-07-27	\N
4	Horror	2024-07-27	\N
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (id, title, description, budget, release_date, duration, poster_id, created_at, updated_at, director_id, country_id) FROM stdin;
9	Furiosa: A Mad Max Saga	As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.	4000000	2024-05-22	9999999999	3	2024-07-26	\N	8	1
15	Black Noise	Members of an elite security team deployed to rescue a VIP on an exclusive island.The rescue mission becomes a desperate attempt to survive, escape the island and elude the sinister presence that seeks to harm them.	7000000	2023-11-03	9999999999	4	2024-07-26	\N	8	1
4	Despicable Me 4	Gru and Lucy and their girls — Margo, Edith and Agnes — welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Meanwhile, Gru faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, forcing the family to go on the run.	1500000	2024-06-20	9999999999	\N	2024-07-26	\N	7	2
1	Bad Boys: Ride or Die	After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.	1000000	2024-06-05	9999999999	1	2024-07-26	\N	7	1
5	Deadpool & Wolverine	A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.	2000000	2024-07-24	9999999999	\N	2024-07-26	\N	8	\N
10	The Strangers: Chapter 1	After their car breaks down in an eerie small town, a young couple are forced to spend the night in a remote cabin. Panic ensues as they are terrorized by three masked strangers who strike with no mercy and seemingly no motives.	4500000	2024-05-15	9999999999	\N	2024-07-26	\N	7	5
6	The Garfield Movie	Garfield, the world-famous, Monday-hating, lasagna-loving indoor cat, is about to have a wild outdoor adventure! After an unexpected reunion with his long-lost father – scruffy street cat Vic – Garfield and his canine friend Odie are forced from their perfectly pampered life into joining Vic in a hilarious, high-stakes heist.	2500000	2024-04-30	9999999999	\N	2024-07-26	\N	8	\N
11	Beverly Hills Cop: Axel F	Forty years after his unforgettable first case in Beverly Hills, Detroit cop Axel Foley returns to do what he does best: solve crimes and cause chaos.	5000000	2024-06-20	9999999999	\N	2024-07-26	\N	5	\N
12	Monkey Man	Kid is an anonymous young man who ekes out a meager living in an underground fight club where, night after night, wearing a gorilla mask, he is beaten bloody by more popular fighters for cash. After years of suppressed rage, Kid discovers a way to infiltrate the enclave of the city’s sinister elite. As his childhood trauma boils over, his mysteriously scarred hands unleash an explosive campaign of retribution to settle the score with the men who took everything from him.	5500000	2024-04-03	9999999999	\N	2024-07-26	\N	8	\N
13	My Spy The Eternal City	JJ, a veteran CIA agent, reunites with his protégé Sophie, in order to prevent a catastrophic nuclear plot targeting the Vatican.	6000000	2024-07-18	9999999999	\N	2024-07-26	\N	6	\N
14	Under Paris	In order to save Paris from an international bloodbath, a grieving scientist is forced to face her tragic past when a giant shark appears in the Seine.	6500000	2024-06-04	9999999999	\N	2024-07-26	\N	6	\N
16	Godzilla x Kong: The New Empire	Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.	7500000	2024-03-27	9999999999	\N	2024-07-26	\N	8	\N
17	Boneyard	After Police Chief Carter discovers the remains of eleven women, FBI Special Agent Petrovick is recruited to profile the serial killer responsible for the infamous "boneyard" killings. As the police force, narcotics agency, and FBI lock horns, a tangled web of intrigue turns everyone into a suspect.	8000000	2024-07-05	9999999999	\N	2024-07-26	\N	7	\N
19	Despicable Me 4	Gru and Lucy and their girls — Margo, Edith and Agnes — welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Meanwhile, Gru faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, forcing the family to go on the run.	1000000	2024-06-20	9999999999	\N	2024-07-26	\N	7	\N
20	Deadpool & Wolverine	A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.	1000000	2024-07-24	9999999999	\N	2024-07-26	\N	7	\N
21	The Garfield Movie	Garfield, the world-famous, Monday-hating, lasagna-loving indoor cat, is about to have a wild outdoor adventure! After an unexpected reunion with his long-lost father – scruffy street cat Vic – Garfield and his canine friend Odie are forced from their perfectly pampered life into joining Vic in a hilarious, high-stakes heist.	1000000	2024-04-30	9999999999	\N	2024-07-26	\N	7	\N
22	Justice League: Crisis on Infinite Earths Part Three	Now fully revealed as the ultimate threat to existence, the Anti-Monitor wages an unrelenting attack on the surviving Earths that struggle for survival in a pocket universe. One by one, these worlds and all their inhabitants are vaporized! On the planets that remain, even time itself is shattered, and heroes from the past join the Justice League and their rag-tag allies against the epitome of evil. But as they make their last stand, will the sacrifice of the superheroes be enough to save us all?	1000000	2024-07-16	9999999999	\N	2024-07-26	\N	7	\N
8	Out of Exile	Recently paroled thief Gabriel Russell tries to balance his life and mend a troubled family as an FBI agent hunts him down, along with his crew after a botched armored car robbery.	3500000	2023-01-20	9999999999	2	2024-07-26	\N	6	1
23	Movie 111	just a description	20	2000-05-05	999999	\N	2024-07-26	\N	5	\N
7	Justice League: Crisis on Infinite Earths Part Three	Now fully revealed as the ultimate threat to existence, the Anti-Monitor wages an unrelenting attack on the surviving Earths that struggle for survival in a pocket universe. One by one, these worlds and all their inhabitants are vaporized! On the planets that remain, even time itself is shattered, and heroes from the past join the Justice League and their rag-tag allies against the epitome of evil. But as they make their last stand, will the sacrifice of the superheroes be enough to save us all?	3000000	2024-07-16	9999999999	\N	2024-07-26	\N	6	\N
24	Movie privet	description :]	1000	2005-06-06	1000000	\N	2024-07-26	\N	6	\N
25	Test title	Test description	1	2021-06-01	9999999999999999	\N	2024-07-27	\N	8	1
\.


--
-- Data for Name: movies_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies_genres (id, movie_id, genre_id, created_at, updated_at) FROM stdin;
1	1	3	2024-07-27	\N
2	8	1	2024-07-27	\N
3	9	2	2024-07-27	\N
4	15	4	2024-07-27	\N
5	1	2	2024-07-27	\N
6	8	3	2024-07-27	\N
7	9	1	2024-07-27	\N
8	15	2	2024-07-27	\N
\.


--
-- Data for Name: persons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persons (id, first_name, last_name, biography, date_of_birth, gender, created_at, updated_at, country, primary_image, "position") FROM stdin;
1	James	Wright	\N	1985-05-06	male	2024-07-26	\N	Great Britain	\N	actor
2	Ostin	Richards	\N	1973-06-15	male	2024-07-26	\N	Canada	\N	actor
3	Cristina	Lucas	\N	1991-04-20	female	2024-07-26	\N	Portugal	\N	actor
4	Paul	Brandon	\N	1990-08-08	male	2024-07-27	\N	Great Britain	\N	actor
5	Tony	DeRossi	\N	1985-03-10	male	2024-07-27	\N	Italy	\N	director
6	Anna	McRobinson	\N	1995-07-14	female	2024-07-27	\N	Scotland	\N	director
7	Jennifer	Tea	\N	1991-01-24	female	2024-07-27	\N	Japan	\N	director
8	Polina	Shevchenko	\N	1990-06-08	female	2024-07-27	\N	Ukraine	5	director
\.


--
-- Data for Name: persons_additional_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persons_additional_photos (id, person_id, file_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, first_name, last_name, email, password, avatar, created_at, updated_at) FROM stdin;
1	johnjohnson	John	Johnson	jjohnson@gmail.com	ahahahahahahahah123	\N	2024-07-26	\N
2	mikewalker	Mike	Walker	mwalker@gmail.com	iloveapples	\N	2024-07-26	\N
3	jimmywhite	Jimmy	White	jwhite@gmail.com	qwerty	\N	2024-07-26	\N
4	asdf	Hello	World	helloworld@gmail.com	helloworldpass	\N	2024-07-27	\N
\.


--
-- Name: actors_participations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actors_participations_id_seq', 13, true);


--
-- Name: characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characters_id_seq', 1, false);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_seq', 13, true);


--
-- Name: favorite_movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorite_movies_id_seq', 3, true);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.files_id_seq', 5, true);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_seq', 4, true);


--
-- Name: movies_genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_genres_id_seq', 8, true);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_id_seq', 25, true);


--
-- Name: persons_additional_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.persons_additional_photos_id_seq', 1, false);


--
-- Name: persons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.persons_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: actors_participations actors_participations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors_participations
    ADD CONSTRAINT actors_participations_pkey PRIMARY KEY (id);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: favorite_movies favorite_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT favorite_movies_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: movies_genres movies_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: persons_additional_photos persons_additional_photos_file_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons_additional_photos
    ADD CONSTRAINT persons_additional_photos_file_id_key UNIQUE (file_id);


--
-- Name: persons_additional_photos persons_additional_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons_additional_photos
    ADD CONSTRAINT persons_additional_photos_pkey PRIMARY KEY (id);


--
-- Name: persons persons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_pkey PRIMARY KEY (id);


--
-- Name: persons persons_primary_image_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_primary_image_key UNIQUE (primary_image);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: users fk_avatar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_avatar FOREIGN KEY (avatar) REFERENCES public.files(id);


--
-- Name: movies fk_country_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: movies fk_director_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_director_id FOREIGN KEY (director_id) REFERENCES public.persons(id);


--
-- Name: persons_additional_photos fk_file_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons_additional_photos
    ADD CONSTRAINT fk_file_id FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: movies_genres fk_genre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES public.genres(id);


--
-- Name: movies_genres fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: characters fk_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT fk_movie_id FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: actors_participations fk_movie_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors_participations
    ADD CONSTRAINT fk_movie_id FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: characters fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- Name: persons_additional_photos fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons_additional_photos
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- Name: actors_participations fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors_participations
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES public.persons(id);


--
-- Name: movies fk_poster; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_poster FOREIGN KEY (poster_id) REFERENCES public.files(id);


--
-- Name: persons fk_primary_image; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT fk_primary_image FOREIGN KEY (primary_image) REFERENCES public.files(id);


--
-- Name: favorite_movies fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite_movies
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

