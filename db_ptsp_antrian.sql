--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10
-- Dumped by pg_dump version 10.10

-- Started on 2021-06-05 23:33:16

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
-- TOC entry 2848 (class 1262 OID 26321)
-- Name: db_nano; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE db_nano WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE db_nano OWNER TO postgres;

\connect db_nano

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
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2850 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 26324)
-- Name: mst_detail_pelayanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_detail_pelayanan (
    id integer NOT NULL,
    value_detail text,
    id_pelayanan integer
);


ALTER TABLE public.mst_detail_pelayanan OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 26322)
-- Name: mst_detail_pelayanan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mst_detail_pelayanan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mst_detail_pelayanan_id_seq OWNER TO postgres;

--
-- TOC entry 2851 (class 0 OID 0)
-- Dependencies: 196
-- Name: mst_detail_pelayanan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mst_detail_pelayanan_id_seq OWNED BY public.mst_detail_pelayanan.id;


--
-- TOC entry 199 (class 1259 OID 26335)
-- Name: mst_pelayanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_pelayanan (
    id integer NOT NULL,
    nama character varying(255)
);


ALTER TABLE public.mst_pelayanan OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 26333)
-- Name: mst_pelayanan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mst_pelayanan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mst_pelayanan_id_seq OWNER TO postgres;

--
-- TOC entry 2852 (class 0 OID 0)
-- Dependencies: 198
-- Name: mst_pelayanan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mst_pelayanan_id_seq OWNED BY public.mst_pelayanan.id;


--
-- TOC entry 201 (class 1259 OID 26343)
-- Name: mst_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_users (
    id integer NOT NULL,
    username character varying(155),
    password text,
    nama character varying(155),
    loketid integer,
    onlineid character varying(20),
    offlineid character varying(20),
    namalayanan character varying(155)
);


ALTER TABLE public.mst_users OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 26341)
-- Name: mst_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mst_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mst_users_id_seq OWNER TO postgres;

--
-- TOC entry 2853 (class 0 OID 0)
-- Dependencies: 200
-- Name: mst_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mst_users_id_seq OWNED BY public.mst_users.id;


--
-- TOC entry 203 (class 1259 OID 26354)
-- Name: ref_jam_kedatangan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ref_jam_kedatangan (
    id integer NOT NULL,
    jam integer,
    keterangan character varying(155)
);


ALTER TABLE public.ref_jam_kedatangan OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 26352)
-- Name: ref_jam_kedatangan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ref_jam_kedatangan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ref_jam_kedatangan_id_seq OWNER TO postgres;

--
-- TOC entry 2854 (class 0 OID 0)
-- Dependencies: 202
-- Name: ref_jam_kedatangan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ref_jam_kedatangan_id_seq OWNED BY public.ref_jam_kedatangan.id;


--
-- TOC entry 205 (class 1259 OID 26362)
-- Name: tran_form_isian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tran_form_isian (
    id integer NOT NULL,
    nama_lengkap character varying(255),
    no_identitas integer,
    jenis_kelamin character varying(155),
    alamat character varying(255),
    email character varying(255),
    no_hp character varying(155),
    tanggal_kedatangan date,
    id_pelayanan integer,
    jam_kedatangan integer,
    no_antrian character varying(155),
    status character varying(155),
    lama_menunggu numeric,
    lama_pelayanan numeric
);


ALTER TABLE public.tran_form_isian OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 26360)
-- Name: tran_form_isian_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tran_form_isian_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tran_form_isian_id_seq OWNER TO postgres;

--
-- TOC entry 2855 (class 0 OID 0)
-- Dependencies: 204
-- Name: tran_form_isian_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tran_form_isian_id_seq OWNED BY public.tran_form_isian.id;


--
-- TOC entry 2697 (class 2604 OID 26327)
-- Name: mst_detail_pelayanan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_detail_pelayanan ALTER COLUMN id SET DEFAULT nextval('public.mst_detail_pelayanan_id_seq'::regclass);


--
-- TOC entry 2698 (class 2604 OID 26338)
-- Name: mst_pelayanan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_pelayanan ALTER COLUMN id SET DEFAULT nextval('public.mst_pelayanan_id_seq'::regclass);


--
-- TOC entry 2699 (class 2604 OID 26346)
-- Name: mst_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_users ALTER COLUMN id SET DEFAULT nextval('public.mst_users_id_seq'::regclass);


--
-- TOC entry 2700 (class 2604 OID 26357)
-- Name: ref_jam_kedatangan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ref_jam_kedatangan ALTER COLUMN id SET DEFAULT nextval('public.ref_jam_kedatangan_id_seq'::regclass);


--
-- TOC entry 2701 (class 2604 OID 26365)
-- Name: tran_form_isian id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tran_form_isian ALTER COLUMN id SET DEFAULT nextval('public.tran_form_isian_id_seq'::regclass);


--
-- TOC entry 2834 (class 0 OID 26324)
-- Dependencies: 197
-- Data for Name: mst_detail_pelayanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mst_detail_pelayanan (id, value_detail, id_pelayanan) VALUES (1, 'Pendaftaran Perkara Gugatan', 1);
INSERT INTO public.mst_detail_pelayanan (id, value_detail, id_pelayanan) VALUES (2, 'Pendaftaraan Perkara Gugatan Sederhana', 1);
INSERT INTO public.mst_detail_pelayanan (id, value_detail, id_pelayanan) VALUES (3, 'Pendaftaran Perkara Perlawanan atau Bantahan', 1);
INSERT INTO public.mst_detail_pelayanan (id, value_detail, id_pelayanan) VALUES (4, 'Pendaftaran Perkara Permohonan', 1);
INSERT INTO public.mst_detail_pelayanan (id, value_detail, id_pelayanan) VALUES (5, 'Pendaftaran Perkara Verzet atas Putusan Verstek', 1);


--
-- TOC entry 2836 (class 0 OID 26335)
-- Dependencies: 199
-- Data for Name: mst_pelayanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mst_pelayanan (id, nama) VALUES (1, 'E-Court');
INSERT INTO public.mst_pelayanan (id, nama) VALUES (2, 'Pengaduan & Infromasi');
INSERT INTO public.mst_pelayanan (id, nama) VALUES (3, 'Kepaniteraan Hukum');
INSERT INTO public.mst_pelayanan (id, nama) VALUES (4, 'Kepaniteraan Pidana');
INSERT INTO public.mst_pelayanan (id, nama) VALUES (6, 'Salinan Putusan Perdata /Eksekusi');
INSERT INTO public.mst_pelayanan (id, nama) VALUES (7, 'Umum & Surat Masuk');
INSERT INTO public.mst_pelayanan (id, nama) VALUES (5, 'Upaya Hukum Perdata');


--
-- TOC entry 2838 (class 0 OID 26343)
-- Dependencies: 201
-- Data for Name: mst_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mst_users (id, username, password, nama, loketid, onlineid, offlineid, namalayanan) VALUES (1, 'loket1', '$1$WoyrJY7w$8hqwzJPtQkag1rjoWFqNO1', 'loket 1', 1, 'A', 'I', 'E-Cort');
INSERT INTO public.mst_users (id, username, password, nama, loketid, onlineid, offlineid, namalayanan) VALUES (2, 'loket2', '$2a$06$eE7dxJ8Yi26WyJtHOW0JZuqhLhw3gJEtAE/cl9cI59Y37UtiAhAbK', 'loket 2', 1, 'A', 'I', 'E-Cort');


--
-- TOC entry 2840 (class 0 OID 26354)
-- Dependencies: 203
-- Data for Name: ref_jam_kedatangan; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2842 (class 0 OID 26362)
-- Dependencies: 205
-- Data for Name: tran_form_isian; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (269, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 2, 'A6', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (270, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 2, 'A7', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (271, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 3, 'A11', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (272, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 3, 'A12', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (273, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 4, 'A16', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (274, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 4, 'A17', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (278, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 2, 1, 'B1', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (279, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 2, 1, 'B2', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (280, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 2, 2, 'B8', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (281, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 3, 1, 'C1', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (282, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 3, 1, 'C2', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (283, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 3, 2, 'C6', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (284, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 6, 2, 'F6', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (285, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 6, 1, 'F1', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (286, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 1, 'G1', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (288, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G12', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (289, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G13', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (290, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G14', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (291, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G15', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (292, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G16', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (293, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G17', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (294, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G18', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (295, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G19', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (296, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G20', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (297, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G21', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (298, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G22', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (299, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G23', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (300, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G24', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (301, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G25', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (302, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G26', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (303, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G27', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (304, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G28', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (305, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G29', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (306, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G30', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (307, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 3, 'A13', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (287, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 7, 3, 'G11', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (267, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 1, 'A1', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (275, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 1, 'A3', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (268, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 1, 'A2', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (276, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 1, 'A4', 'Done', NULL, NULL);
INSERT INTO public.tran_form_isian (id, nama_lengkap, no_identitas, jenis_kelamin, alamat, email, no_hp, tanggal_kedatangan, id_pelayanan, jam_kedatangan, no_antrian, status, lama_menunggu, lama_pelayanan) VALUES (277, 'Septiansah', 1099923, 'laki-laki', 'jl.merdeka raya', 'septiansahnuraziz@gmail.com', '+62 092093 12313', '2021-04-25', 1, 1, 'A5', 'Done', NULL, NULL);


--
-- TOC entry 2856 (class 0 OID 0)
-- Dependencies: 196
-- Name: mst_detail_pelayanan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mst_detail_pelayanan_id_seq', 1, false);


--
-- TOC entry 2857 (class 0 OID 0)
-- Dependencies: 198
-- Name: mst_pelayanan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mst_pelayanan_id_seq', 1, false);


--
-- TOC entry 2858 (class 0 OID 0)
-- Dependencies: 200
-- Name: mst_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mst_users_id_seq', 1, false);


--
-- TOC entry 2859 (class 0 OID 0)
-- Dependencies: 202
-- Name: ref_jam_kedatangan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ref_jam_kedatangan_id_seq', 1, false);


--
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 204
-- Name: tran_form_isian_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tran_form_isian_id_seq', 1, false);


--
-- TOC entry 2703 (class 2606 OID 26332)
-- Name: mst_detail_pelayanan mst_detail_pelayanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_detail_pelayanan
    ADD CONSTRAINT mst_detail_pelayanan_pkey PRIMARY KEY (id);


--
-- TOC entry 2705 (class 2606 OID 26340)
-- Name: mst_pelayanan mst_pelayanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_pelayanan
    ADD CONSTRAINT mst_pelayanan_pkey PRIMARY KEY (id);


--
-- TOC entry 2707 (class 2606 OID 26351)
-- Name: mst_users mst_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_users
    ADD CONSTRAINT mst_users_pkey PRIMARY KEY (id);


--
-- TOC entry 2709 (class 2606 OID 26359)
-- Name: ref_jam_kedatangan ref_jam_kedatangan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ref_jam_kedatangan
    ADD CONSTRAINT ref_jam_kedatangan_pkey PRIMARY KEY (id);


--
-- TOC entry 2711 (class 2606 OID 26370)
-- Name: tran_form_isian tran_form_isian_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tran_form_isian
    ADD CONSTRAINT tran_form_isian_pkey PRIMARY KEY (id);


-- Completed on 2021-06-05 23:33:18

--
-- PostgreSQL database dump complete
--

