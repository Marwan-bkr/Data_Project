-- Database: Base_for_Music_Assessment
CREATE DATABASE "Base_for_Music_Assessment"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'French_France.1252'
    LC_CTYPE = 'French_France.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Table: public.artist
CREATE TABLE IF NOT EXISTS public.artist
(
    id integer NOT NULL DEFAULT nextval('artist_id_seq'::regclass),
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT artist_pkey PRIMARY KEY (id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.artist
    OWNER to postgres;

-- Table: public.evolution
CREATE TABLE IF NOT EXISTS public.evolution
(
    statistic_id character(255) COLLATE pg_catalog."default" NOT NULL,
    period character(255) COLLATE pg_catalog."default" NOT NULL,
    evolution integer NOT NULL,
    compared_date date NOT NULL,
    compared_value integer NOT NULL,
    percent_evolution numeric(255,0) NOT NULL
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.evolution
    OWNER to postgres;

-- Table: public.platform
CREATE TABLE IF NOT EXISTS public.platform
(
    id character(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT platform_pkey PRIMARY KEY (id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.platform
    OWNER to postgres;

-- Table: public.score
CREATE TABLE IF NOT EXISTS public.score
(
    song_id character(255) COLLATE pg_catalog."default" NOT NULL,
    platform_id character(255) COLLATE pg_catalog."default" NOT NULL,
    date date NOT NULL,
    stream integer NOT NULL,
    popularity integer NOT NULL,
    CONSTRAINT cst_platform FOREIGN KEY (platform_id)
        REFERENCES public.platform (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT cst_song1 FOREIGN KEY (song_id)
        REFERENCES public.song (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.score
    OWNER to postgres;

-- Table: public.song
CREATE TABLE IF NOT EXISTS public.song
(
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    release date NOT NULL,
    image character(1) COLLATE pg_catalog."default",
    id character(1) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT song_pkey PRIMARY KEY (id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.song
    OWNER to postgres;

-- Table: public.song_actor
CREATE TABLE IF NOT EXISTS public.song_actor
(
    song_id character(255) COLLATE pg_catalog."default" NOT NULL,
    actor_id integer NOT NULL,
    CONSTRAINT cst_actor FOREIGN KEY (actor_id)
        REFERENCES public.artist (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT cst_song FOREIGN KEY (song_id)
        REFERENCES public.song (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.song_actor
    OWNER to postgres;

-- Table: public.statistic
CREATE TABLE IF NOT EXISTS public.statistic
(
    song_id character(255) COLLATE pg_catalog."default" NOT NULL,
    platform_id character(255) COLLATE pg_catalog."default" NOT NULL,
    metric character(255) COLLATE pg_catalog."default" NOT NULL,
    value integer NOT NULL,
    last_data_point_date date NOT NULL,
    first_data_point_date date NOT NULL,
    CONSTRAINT cst_platform1 FOREIGN KEY (platform_id)
        REFERENCES public.platform (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT cst_song2 FOREIGN KEY (song_id)
        REFERENCES public.song (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.statistic
    OWNER to postgres;