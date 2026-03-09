--
-- PostgreSQL database dump
--

\restrict oE6lQrQlWyGZ4ZHYpMnSIvQGT5Q7ovuFeWfjgILnC8NUgULKadehkXUV9wCavEr

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-03-09 13:36:13

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

--
-- TOC entry 5 (class 2615 OID 16388)
-- Name: CensusBureau; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "CensusBureau";


ALTER SCHEMA "CensusBureau" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16410)
-- Name: dim_agegroup; Type: TABLE; Schema: CensusBureau; Owner: postgres
--

CREATE TABLE "CensusBureau".dim_agegroup (
    agegroup_id integer CONSTRAINT "dim_Agegroup_agegroup_id_not_null" NOT NULL,
    range_start integer,
    range_end integer,
    generation character varying DEFAULT 20,
    dependency_status character varying(20)
);


ALTER TABLE "CensusBureau".dim_agegroup OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16439)
-- Name: dim_Agegroup_agegroup_id_seq; Type: SEQUENCE; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE "CensusBureau".dim_agegroup ALTER COLUMN agegroup_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "CensusBureau"."dim_Agegroup_agegroup_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16413)
-- Name: dim_education; Type: TABLE; Schema: CensusBureau; Owner: postgres
--

CREATE TABLE "CensusBureau".dim_education (
    education_id integer CONSTRAINT "dim_Education_education_id_not_null" NOT NULL,
    education_level character varying(30),
    field_of_study character varying(50),
    literacy_status boolean,
    institution_type character varying(20)
);


ALTER TABLE "CensusBureau".dim_education OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16434)
-- Name: dim_Education_education_id_seq; Type: SEQUENCE; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE "CensusBureau".dim_education ALTER COLUMN education_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "CensusBureau"."dim_Education_education_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16407)
-- Name: dim_employment; Type: TABLE; Schema: CensusBureau; Owner: postgres
--

CREATE TABLE "CensusBureau".dim_employment (
    employment_status boolean,
    employment_id integer CONSTRAINT "dim_Employment_employment_id_not_null" NOT NULL,
    industry_sector character varying(50),
    job_type character varying(20),
    income_level character varying(20)
);


ALTER TABLE "CensusBureau".dim_employment OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16429)
-- Name: dim_Employment_employment_id_seq; Type: SEQUENCE; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE "CensusBureau".dim_employment ALTER COLUMN employment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "CensusBureau"."dim_Employment_employment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: dim_location; Type: TABLE; Schema: CensusBureau; Owner: postgres
--

CREATE TABLE "CensusBureau".dim_location (
    city character varying(50),
    region character varying(50),
    area_type character varying(10),
    location_id integer CONSTRAINT "dim_Location_location_id_not_null" NOT NULL,
    area character varying(50)
);


ALTER TABLE "CensusBureau".dim_location OWNER TO postgres;

--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN dim_location.area_type; Type: COMMENT; Schema: CensusBureau; Owner: postgres
--

COMMENT ON COLUMN "CensusBureau".dim_location.area_type IS 'Urban or Rural area';


--
-- TOC entry 226 (class 1259 OID 16424)
-- Name: dim_Location_location_id_seq; Type: SEQUENCE; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE "CensusBureau".dim_location ALTER COLUMN location_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "CensusBureau"."dim_Location_location_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16395)
-- Name: dim_time; Type: TABLE; Schema: CensusBureau; Owner: postgres
--

CREATE TABLE "CensusBureau".dim_time (
    time_id integer CONSTRAINT "dim_Time_time_id_not_null" NOT NULL,
    year integer,
    quarter integer,
    month integer,
    date date
);


ALTER TABLE "CensusBureau".dim_time OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16419)
-- Name: dim_Time_time_id_seq; Type: SEQUENCE; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE "CensusBureau".dim_time ALTER COLUMN time_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "CensusBureau"."dim_Time_time_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: fact_table; Type: TABLE; Schema: CensusBureau; Owner: postgres
--

CREATE TABLE "CensusBureau".fact_table (
    time_id integer,
    location_id integer,
    employment_id integer,
    education_id integer,
    agegroup_id integer,
    population_count integer,
    avg_income numeric,
    unemployment_rate numeric
);


ALTER TABLE "CensusBureau".fact_table OWNER TO postgres;

--
-- TOC entry 5052 (class 0 OID 16410)
-- Dependencies: 223
-- Data for Name: dim_agegroup; Type: TABLE DATA; Schema: CensusBureau; Owner: postgres
--

COPY "CensusBureau".dim_agegroup (agegroup_id, range_start, range_end, generation, dependency_status) FROM stdin;
1	0	14	Gen Alpha	Dependent
2	15	19	Gen Z	Dependent
3	20	24	Gen Z	Independent
4	25	34	Millennials	Independent
5	35	44	Millennials	Independent
6	45	54	Gen X	Independent
7	55	64	Gen X	Independent
8	65	74	Boomers	Dependent
9	75	84	Boomers	Dependent
10	85	100	Silent	Dependent
\.


--
-- TOC entry 5053 (class 0 OID 16413)
-- Dependencies: 224
-- Data for Name: dim_education; Type: TABLE DATA; Schema: CensusBureau; Owner: postgres
--

COPY "CensusBureau".dim_education (education_id, education_level, field_of_study, literacy_status, institution_type) FROM stdin;
1	Primary	General	t	Public
2	Secondary	General	t	Public
3	High School	Science	t	Public
4	High School	Arts	t	Private
5	Bachelor	Computer Science	t	University
6	Bachelor	Business	t	University
7	Master	Engineering	t	University
8	Master	Economics	t	University
9	PhD	Physics	t	University
10	None	None	f	None
\.


--
-- TOC entry 5051 (class 0 OID 16407)
-- Dependencies: 222
-- Data for Name: dim_employment; Type: TABLE DATA; Schema: CensusBureau; Owner: postgres
--

COPY "CensusBureau".dim_employment (employment_status, employment_id, industry_sector, job_type, income_level) FROM stdin;
t	1	Technology	Full-time	High
t	2	Healthcare	Full-time	Medium
t	3	Education	Part-time	Medium
t	4	Retail	Part-time	Low
t	5	Manufacturing	Full-time	Medium
f	6	None	Unemployed	None
t	7	Finance	Full-time	High
t	8	Construction	Contract	Medium
t	9	Agriculture	Seasonal	Low
f	10	None	Student	None
\.


--
-- TOC entry 5050 (class 0 OID 16401)
-- Dependencies: 221
-- Data for Name: dim_location; Type: TABLE DATA; Schema: CensusBureau; Owner: postgres
--

COPY "CensusBureau".dim_location (city, region, area_type, location_id, area) FROM stdin;
Stockholm	Svealand	Urban	1	North
Gothenburg	Götaland	Urban	2	West
Malmö	Götaland	Urban	3	South
Uppsala	Svealand	Urban	4	Central
Västerås	Svealand	Urban	5	Central
Örebro	Svealand	Urban	6	Central
Linköping	Götaland	Urban	7	East
Helsingborg	Götaland	Urban	8	South
Lund	Götaland	Urban	9	South
Kiruna	Norrland	Rural	10	North
\.


--
-- TOC entry 5049 (class 0 OID 16395)
-- Dependencies: 220
-- Data for Name: dim_time; Type: TABLE DATA; Schema: CensusBureau; Owner: postgres
--

COPY "CensusBureau".dim_time (time_id, year, quarter, month, date) FROM stdin;
1	2024	1	1	2024-01-01
2	2024	1	2	2024-02-01
3	2024	1	3	2024-03-01
4	2024	2	4	2024-04-01
5	2024	2	5	2024-05-01
\.


--
-- TOC entry 5048 (class 0 OID 16389)
-- Dependencies: 219
-- Data for Name: fact_table; Type: TABLE DATA; Schema: CensusBureau; Owner: postgres
--

COPY "CensusBureau".fact_table (time_id, location_id, employment_id, education_id, agegroup_id, population_count, avg_income, unemployment_rate) FROM stdin;
1	1	1	5	4	12000	42000	4.2
1	2	2	6	5	9000	38000	5.1
2	3	4	3	3	7000	25000	8.3
2	4	7	5	4	6000	46000	3.8
3	5	1	5	4	8500	41000	4.5
3	6	3	2	2	5000	27000	6.7
4	7	8	4	5	7200	35000	5.9
4	8	9	1	1	6500	22000	7.4
5	9	1	6	4	9800	43000	4.0
5	10	6	10	8	3000	0	12.5
\.


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 229
-- Name: dim_Agegroup_agegroup_id_seq; Type: SEQUENCE SET; Schema: CensusBureau; Owner: postgres
--

SELECT pg_catalog.setval('"CensusBureau"."dim_Agegroup_agegroup_id_seq"', 10, true);


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 228
-- Name: dim_Education_education_id_seq; Type: SEQUENCE SET; Schema: CensusBureau; Owner: postgres
--

SELECT pg_catalog.setval('"CensusBureau"."dim_Education_education_id_seq"', 10, true);


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 227
-- Name: dim_Employment_employment_id_seq; Type: SEQUENCE SET; Schema: CensusBureau; Owner: postgres
--

SELECT pg_catalog.setval('"CensusBureau"."dim_Employment_employment_id_seq"', 10, true);


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 226
-- Name: dim_Location_location_id_seq; Type: SEQUENCE SET; Schema: CensusBureau; Owner: postgres
--

SELECT pg_catalog.setval('"CensusBureau"."dim_Location_location_id_seq"', 10, true);


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 225
-- Name: dim_Time_time_id_seq; Type: SEQUENCE SET; Schema: CensusBureau; Owner: postgres
--

SELECT pg_catalog.setval('"CensusBureau"."dim_Time_time_id_seq"', 5, true);


--
-- TOC entry 4893 (class 2606 OID 16461)
-- Name: dim_agegroup PK_agegroup_id; Type: CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".dim_agegroup
    ADD CONSTRAINT "PK_agegroup_id" PRIMARY KEY (agegroup_id) INCLUDE (agegroup_id);


--
-- TOC entry 4895 (class 2606 OID 16459)
-- Name: dim_education PK_education_id; Type: CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".dim_education
    ADD CONSTRAINT "PK_education_id" PRIMARY KEY (education_id) INCLUDE (education_id);


--
-- TOC entry 4891 (class 2606 OID 16457)
-- Name: dim_employment PK_employment_id; Type: CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".dim_employment
    ADD CONSTRAINT "PK_employment_id" PRIMARY KEY (employment_id) INCLUDE (employment_id);


--
-- TOC entry 4889 (class 2606 OID 16455)
-- Name: dim_location PK_location_id; Type: CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".dim_location
    ADD CONSTRAINT "PK_location_id" PRIMARY KEY (location_id) INCLUDE (location_id);


--
-- TOC entry 4887 (class 2606 OID 16453)
-- Name: dim_time PK_time_id; Type: CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".dim_time
    ADD CONSTRAINT "PK_time_id" PRIMARY KEY (time_id) INCLUDE (time_id);


--
-- TOC entry 4881 (class 1259 OID 16496)
-- Name: fki_agegroup; Type: INDEX; Schema: CensusBureau; Owner: postgres
--

CREATE INDEX fki_agegroup ON "CensusBureau".fact_table USING btree (agegroup_id);


--
-- TOC entry 4882 (class 1259 OID 16490)
-- Name: fki_education; Type: INDEX; Schema: CensusBureau; Owner: postgres
--

CREATE INDEX fki_education ON "CensusBureau".fact_table USING btree (education_id);


--
-- TOC entry 4883 (class 1259 OID 16484)
-- Name: fki_employment; Type: INDEX; Schema: CensusBureau; Owner: postgres
--

CREATE INDEX fki_employment ON "CensusBureau".fact_table USING btree (employment_id);


--
-- TOC entry 4884 (class 1259 OID 16478)
-- Name: fki_location; Type: INDEX; Schema: CensusBureau; Owner: postgres
--

CREATE INDEX fki_location ON "CensusBureau".fact_table USING btree (location_id);


--
-- TOC entry 4885 (class 1259 OID 16467)
-- Name: fki_time; Type: INDEX; Schema: CensusBureau; Owner: postgres
--

CREATE INDEX fki_time ON "CensusBureau".fact_table USING btree (time_id);


--
-- TOC entry 4896 (class 2606 OID 16491)
-- Name: fact_table agegroup; Type: FK CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".fact_table
    ADD CONSTRAINT agegroup FOREIGN KEY (agegroup_id) REFERENCES "CensusBureau".dim_agegroup(agegroup_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4897 (class 2606 OID 16485)
-- Name: fact_table education; Type: FK CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".fact_table
    ADD CONSTRAINT education FOREIGN KEY (education_id) REFERENCES "CensusBureau".dim_education(education_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4898 (class 2606 OID 16479)
-- Name: fact_table employment; Type: FK CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".fact_table
    ADD CONSTRAINT employment FOREIGN KEY (employment_id) REFERENCES "CensusBureau".dim_employment(employment_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4899 (class 2606 OID 16473)
-- Name: fact_table location; Type: FK CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".fact_table
    ADD CONSTRAINT location FOREIGN KEY (location_id) REFERENCES "CensusBureau".dim_location(location_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 4900 (class 2606 OID 16468)
-- Name: fact_table time; Type: FK CONSTRAINT; Schema: CensusBureau; Owner: postgres
--

ALTER TABLE ONLY "CensusBureau".fact_table
    ADD CONSTRAINT "time" FOREIGN KEY (time_id) REFERENCES "CensusBureau".dim_time(time_id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


-- Completed on 2026-03-09 13:36:14

--
-- PostgreSQL database dump complete
--

\unrestrict oE6lQrQlWyGZ4ZHYpMnSIvQGT5Q7ovuFeWfjgILnC8NUgULKadehkXUV9wCavEr

