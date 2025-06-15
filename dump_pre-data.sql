--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-15 13:13:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 24581)
-- Name: artist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.artist (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 24580)
-- Name: artist_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.artist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 217
-- Name: artist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.artist_id_seq OWNED BY public.artist.id;


--
-- TOC entry 224 (class 1259 OID 24663)
-- Name: evolution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evolution (
    period character varying(255) NOT NULL,
    evolution integer NOT NULL,
    compared_date date NOT NULL,
    compared_value integer,
    percent_evolution numeric(255,0) NOT NULL,
    statistic_id integer NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 24628)
-- Name: platform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.platform (
    id character varying(255) NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 24633)
-- Name: score; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.score (
    song_id character varying(255) NOT NULL,
    platform_id character varying(255) NOT NULL,
    date date NOT NULL,
    stream bigint,
    popularity integer
);


--
-- TOC entry 219 (class 1259 OID 24592)
-- Name: song; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.song (
    name character varying(255) NOT NULL,
    release date,
    image character varying(255),
    id character varying(255) NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 24615)
-- Name: song_actor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.song_actor (
    song_id character varying(255) NOT NULL,
    actor_id integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 24648)
-- Name: statistic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statistic (
    song_id character varying(255) NOT NULL,
    platform_id character varying(255) NOT NULL,
    metric character varying(255) NOT NULL,
    value integer NOT NULL,
    last_data_point_date date NOT NULL,
    first_data_point_date date NOT NULL,
    id integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 32860)
-- Name: statistic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statistic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 225
-- Name: statistic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statistic_id_seq OWNED BY public.statistic.id;


--
-- TOC entry 4767 (class 2604 OID 24584)
-- Name: artist id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artist ALTER COLUMN id SET DEFAULT nextval('public.artist_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 32861)
-- Name: statistic id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statistic ALTER COLUMN id SET DEFAULT nextval('public.statistic_id_seq'::regclass);


--
-- TOC entry 4770 (class 2606 OID 24586)
-- Name: artist artist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (id);


--
-- TOC entry 4774 (class 2606 OID 32977)
-- Name: platform platform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (id);


--
-- TOC entry 4772 (class 2606 OID 32933)
-- Name: song song_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT song_pkey PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 32868)
-- Name: statistic statistic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statistic
    ADD CONSTRAINT statistic_pkey PRIMARY KEY (id);


--
-- TOC entry 4777 (class 2606 OID 24623)
-- Name: song_actor cst_actor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.song_actor
    ADD CONSTRAINT cst_actor FOREIGN KEY (actor_id) REFERENCES public.artist(id);


--
-- TOC entry 4783 (class 2606 OID 33171)
-- Name: evolution cst_evolution; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evolution
    ADD CONSTRAINT cst_evolution FOREIGN KEY (statistic_id) REFERENCES public.statistic(id) NOT VALID;


--
-- TOC entry 4779 (class 2606 OID 32983)
-- Name: score cst_platform; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT cst_platform FOREIGN KEY (platform_id) REFERENCES public.platform(id);


--
-- TOC entry 4781 (class 2606 OID 32978)
-- Name: statistic cst_platform1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statistic
    ADD CONSTRAINT cst_platform1 FOREIGN KEY (platform_id) REFERENCES public.platform(id);


--
-- TOC entry 4778 (class 2606 OID 32944)
-- Name: song_actor cst_song; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.song_actor
    ADD CONSTRAINT cst_song FOREIGN KEY (song_id) REFERENCES public.song(id);


--
-- TOC entry 4780 (class 2606 OID 32955)
-- Name: score cst_song1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.score
    ADD CONSTRAINT cst_song1 FOREIGN KEY (song_id) REFERENCES public.song(id);


--
-- TOC entry 4782 (class 2606 OID 32939)
-- Name: statistic cst_song2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statistic
    ADD CONSTRAINT cst_song2 FOREIGN KEY (song_id) REFERENCES public.song(id);


-- Completed on 2025-06-15 13:13:32

--
-- PostgreSQL database dump complete
--

