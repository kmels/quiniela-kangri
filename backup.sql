--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ganador_predicto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ganador_predicto (
    partido_id bigint NOT NULL,
    user_id bigint NOT NULL,
    equipo_predicto character varying(254) NOT NULL
);


ALTER TABLE public.ganador_predicto OWNER TO postgres;

--
-- Name: ganadores; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ganadores (
    partido_id bigint NOT NULL,
    equipo_ganador character varying(254) NOT NULL
);


ALTER TABLE public.ganadores OWNER TO postgres;

--
-- Name: mensajes_chat; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mensajes_chat (
    id integer NOT NULL,
    autor_id bigint NOT NULL,
    texto character varying(254) NOT NULL,
    fecha bigint NOT NULL
);


ALTER TABLE public.mensajes_chat OWNER TO postgres;

--
-- Name: mensajes_chat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mensajes_chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mensajes_chat_id_seq OWNER TO postgres;

--
-- Name: mensajes_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mensajes_chat_id_seq OWNED BY mensajes_chat.id;


--
-- Name: partidos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE partidos (
    id integer NOT NULL,
    equipo1 character varying(254) NOT NULL,
    equipo2 character varying(254) NOT NULL,
    fecha bigint NOT NULL
);


ALTER TABLE public.partidos OWNER TO postgres;

--
-- Name: partidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE partidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partidos_id_seq OWNER TO postgres;

--
-- Name: partidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE partidos_id_seq OWNED BY partidos.id;


--
-- Name: predicciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE predicciones (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    partido_id bigint NOT NULL,
    goles_equipo1 integer NOT NULL,
    goles_equipo2 integer NOT NULL
);


ALTER TABLE public.predicciones OWNER TO postgres;

--
-- Name: predicciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE predicciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.predicciones_id_seq OWNER TO postgres;

--
-- Name: predicciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE predicciones_id_seq OWNED BY predicciones.id;


--
-- Name: resultados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE resultados (
    id bigint NOT NULL,
    goles_equipo1 integer NOT NULL,
    goles_equipo2 integer NOT NULL
);


ALTER TABLE public.resultados OWNER TO postgres;

--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    id integer NOT NULL,
    ident character varying(254) NOT NULL,
    pw character varying(254) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_id_seq OWNED BY usuarios.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mensajes_chat ALTER COLUMN id SET DEFAULT nextval('mensajes_chat_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY partidos ALTER COLUMN id SET DEFAULT nextval('partidos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY predicciones ALTER COLUMN id SET DEFAULT nextval('predicciones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios ALTER COLUMN id SET DEFAULT nextval('usuarios_id_seq'::regclass);


--
-- Data for Name: ganador_predicto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ganador_predicto (partido_id, user_id, equipo_predicto) FROM stdin;
49	3	
50	3	
51	3	
52	3	
53	3	
49	15	
50	15	
51	15	
52	15	
53	15	
49	1	
49	12	
50	12	
51	12	
52	12	
53	12	
53	16	
56	2	
55	9	
56	9	
53	6	
54	6	
55	6	Argentina
59	6	
51	1	
52	1	
55	15	
58	10	
49	16	
50	1	
59	10	
58	8	
55	1	
57	1	
54	15	
58	1	
49	10	
50	10	
51	10	
52	10	
53	10	
54	10	
55	10	
56	10	Bélgica
50	16	
51	16	
52	16	
49	8	
50	8	
51	8	
52	8	
57	4	
54	7	
55	7	
56	7	
54	12	
55	12	
56	12	
54	3	
49	7	
50	7	
51	7	
52	7	
53	7	
49	6	
50	6	
51	6	
52	6	
49	9	
50	9	
51	9	
52	9	
53	9	
54	9	
59	1	Argentina
57	16	
56	1	
58	16	
54	2	
56	15	
53	1	Francia
54	1	
49	17	
50	17	
49	2	
50	2	
51	2	
52	2	
53	2	
51	17	
52	17	
53	17	
53	8	
54	8	
54	17	
55	17	
49	4	
50	4	
51	4	
52	4	
53	4	
54	4	
55	4	
56	4	
59	16	
54	16	
55	16	
56	16	
56	17	
56	6	
55	3	
56	3	
60	16	
57	3	
55	8	
56	8	Estados Unidos
55	2	
59	8	
60	3	
57	6	
57	7	Francia
58	7	Colombia
60	7	
57	17	
57	15	
58	15	
59	15	
60	15	
58	3	
59	3	
57	8	
58	6	
60	6	
57	10	
60	10	
57	2	
58	2	
59	2	
60	2	
59	7	Bélgica
58	17	
59	17	
60	17	
57	9	
58	9	
59	9	
60	9	
60	1	Holanda
58	4	
59	4	
60	4	
60	8	
61	17	Brasil
62	17	Holanda
61	2	
61	3	
61	15	
62	15	Argentina
61	6	
61	8	Alemania
61	1	Alemania
61	7	
62	7	
61	16	
62	16	
61	10	
62	10	
61	9	Brasil
61	4	
62	4	
62	3	
62	8	
62	1	
62	2	
62	6	
62	9	
63	15	
64	15	
63	1	Brasil
64	1	Argentina
63	3	
64	3	
63	2	Brasil
64	2	
63	4	
64	4	
63	8	
64	8	
\.


--
-- Data for Name: ganadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ganadores (partido_id, equipo_ganador) FROM stdin;
49	Brasil
\.


--
-- Data for Name: mensajes_chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY mensajes_chat (id, autor_id, texto, fecha) FROM stdin;
1	1	DISCULPA: Sorry por el downtime. Si pierden su password contáctenme al 30359775.	1402601731847
2	1	ANUNCIO: después del partido de hoy, voy a borrar los usuarios: prueba, marioelpijudo y Marioño_el_pijudo	1402601771443
3	1	ANUNCIO: Cuando comience el partido, voy a poner las predicciones de cada quien, para que no cambien el marcador después.	1402601815996
4	1	ANUNCIO: El chat ya sirve, tienen que estar logueados para mensajear!	1402601868641
5	1	Pinto meté tu marcador cerote, sólo vos faltas	1402602191749
6	1	Muchá que opinan, debería de puntearse acertar los goles de cada equipo	1402602695817
7	1	y no sólo el marcador exacto	1402602731779
8	1	Bueno, los marcadores son:	1402602973901
9	1	Dario, Chente, kmels: 4-1	1402602984520
10	1	Chechin, polo: 3-1	1402602993305
11	1	JCRomero, Javcast89, Cotto, dani: 2-0	1402603018036
12	1	Bocha: 3-0	1402603029320
13	1	mariño_el_pijudo: 3-1	1402603037349
14	1	SALÚÚÚÚÚÚÚ	1402603051112
15	1	Efraín: 3-1	1402603584994
16	6	ya perdiiiii	1402605358043
17	1	Hiasudos!!	1402610076939
18	7	YEAAAAAAAAAAAAAAHHH	1402610378423
19	1	Ya borré los usuarios extra	1402632074506
20	1	Ya funcionan las puntuaciones...	1402633230161
21	1	Ya no se puede predecir si el partido ya empezo, muchaes	1402639840063
22	3	negro	1402670804461
23	3	negro	1402670805215
24	1	sorry kangri mans	1402674636510
25	1	metan su resultado aqui antes	1402674667269
26	1	ojala no le atinen putos. ahi arreglo la pagina mas tarde peace out	1402674712270
27	1	Ya se puede guardar mucha, también metí el 1-0 de méxico y el 1-5 (parcial) de holanda	1402692081746
28	1	también los resultados que el bocha y el pinto me mandaron para hoy! Mañana debería de estar todo en orden	1402692712671
29	8	kmel	1402704082950
30	7	La pagina ya funciona bien!! En dispositivo movil y en compu!!!	1402713310291
31	1	diawevo. Ya metí el partido de chile y los puntos tan' actualizaos	1402719083680
32	1	Ya pueden shutear las predicciones de la otra mara! Vean la tabla de puntuaciones para encontrar links. Peace out	1402723745186
33	15	A ganar puntos ps!!!!	1402760469821
34	1	Puntos actualizaos!	1402800963710
35	1	Ya metí los puntos que me dijo el checha!	1402877985931
36	7	Woooohoooo	1403124652863
37	7	Españoles hdp!!!!	1403124666968
38	9	Buena suerte a todos los knguros en los partidos de hoy!! VIVOS!!!	1403192786432
39	8	Suerte a todos	1403192941236
40	7	que dificiles estan 3 de los 4 partidos de hoy!!!	1403538980392
\.


--
-- Name: mensajes_chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mensajes_chat_id_seq', 40, true);


--
-- Data for Name: partidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY partidos (id, equipo1, equipo2, fecha) FROM stdin;
15	Colombia	Costa de Marfil	1403193600000
16	Japón	Grecia	1403215200000
17	Japón	Colombia	1403640000000
1	Brasil	Croacia	1402603200000
2	México	Camerún	1402675200000
18	Grecia	Costa de Marfil	1403643600000
19	Uruguay	Costa Rica	1402772400000
20	Inglaterra	Italia	1402783200000
21	Uruguay	Inglaterra	1403204400000
22	Italia	Costa Rica	1403280000000
23	Italia	Uruguay	1403625600000
24	Costa Rica	Inglaterra	1403625600000
25	Suiza	Ecuador	1402848000000
26	Francia	Honduras	1402858800000
27	Suiza	Francia	1403290800000
28	Honduras	Ecuador	1403301600000
29	Honduras	Suiza	1403726400000
30	Ecuador	Francia	1403726400000
31	Argentina	Bosnia-Herzegovina	1402869600000
32	Irán	Nigeria	1402945200000
33	Argentina	Irán	1403366400000
34	Nigeria	Bosnia-Herzegovina	1403388000000
35	Nigeria	Argentina	1403712000000
36	Bosnia-Herzegovina	Irán	1403712000000
37	Alemania	Portugal	1402934400000
3	Brasil	México	1403031600000
4	Camerún	Croacia	1403128800000
5	Camerún	Brasil	1403553600000
38	Ghana	Estados Unidos	1402956000000
39	Alemania	Ghana	1403377200000
40	Estados Unidos	Portugal	1403474400000
41	Estados Unidos	Alemania	1403798400000
42	Portugal	Ghana	1403798400000
43	Bélgica	Algeria	1403020800000
44	Rusia	Corea del Sur	1403042400000
45	Bélgica	Rusia	1403452800000
46	Corea del Sur	Algeria	1403463600000
47	Algeria	Rusia	1403812800000
48	Corea del Sur	Bélgica	1403812800000
49	Brasil	Chile	1403971200000
50	Colombia	Uruguay	1403985600000
51	Holanda	México	1404057600000
52	Costa Rica	Grecia	1404072000000
53	Francia	Nigeria	1404144000000
54	Alemania	Algeria	1404158400000
6	Croacia	México	1403553600000
7	España	Holanda	1402686000000
8	Chile	Australia	1402696800000
9	España	Chile	1403118000000
55	Argentina	Suiza	1404230400000
56	Bélgica	Estados Unidos	1404244800000
57	Francia	Alemania	1404489600000
58	Brasil	Colombia	1404504000000
59	Argentina	Bélgica	1404576000000
10	Australia	Holanda	1403107200000
11	Australia	España	1403539200000
12	Holanda	Chile	1403539200000
13	Colombia	Grecia	1402761600000
60	Holanda	Costa Rica	1404590400000
61	Brasil	Alemania	1404849600000
14	Costa de Marfil	Japón	1402794000000
62	Holanda	Argentina	1404936000000
63	Brasil	Holanda	1405195200000
64	Alemania	Argentina	1405195200000
\.


--
-- Name: partidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('partidos_id_seq', 64, true);


--
-- Data for Name: predicciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY predicciones (id, user_id, partido_id, goles_equipo1, goles_equipo2) FROM stdin;
40	1	40	2	0
22	1	22	2	0
28	1	28	0	2
34	1	34	0	1
2	1	2	1	1
1	1	1	4	1
13	1	13	2	0
26	1	26	2	0
97	2	1	4	1
110	2	14	3	1
252	3	12	2	1
38	1	38	1	3
58	10	10	1	5
98	2	2	1	3
23	1	23	2	2
30	1	30	0	2
7	1	7	2	2
8	1	8	2	0
45	1	45	1	0
39	1	39	2	0
46	1	46	2	0
64	10	16	1	1
83	10	35	1	2
70	10	22	2	1
61	10	13	3	2
62	10	14	1	2
69	10	21	1	2
84	10	36	2	1
76	10	28	1	2
75	10	27	1	2
67	10	19	3	1
68	10	20	2	2
90	10	42	4	1
95	10	47	1	2
81	10	33	3	0
82	10	34	0	3
73	10	25	1	2
74	10	26	3	1
96	10	48	1	4
80	10	32	2	1
41	1	41	2	4
87	10	39	5	0
25	1	25	2	0
18	1	18	0	2
107	2	11	0	2
32	1	32	0	1
12	1	12	4	2
29	1	29	1	2
251	3	11	1	2
101	2	5	0	4
37	1	37	3	2
33	1	33	4	0
59	10	11	1	2
102	2	6	2	1
242	3	2	2	1
245	3	5	0	2
35	1	35	1	2
89	10	41	2	3
100	2	4	1	2
108	2	12	2	1
11	1	11	1	2
99	2	3	4	0
65	10	17	0	3
16	1	16	3	1
10	1	10	0	3
4	1	4	1	2
21	1	21	3	0
24	1	24	1	1
27	1	27	1	2
71	10	23	1	2
243	3	3	3	1
55	10	7	3	2
79	10	31	4	0
88	10	40	1	2
36	1	36	1	4
85	10	37	3	2
86	10	38	1	3
42	1	42	1	2
93	10	45	3	0
94	10	46	1	1
91	10	43	4	1
92	10	44	2	1
258	3	18	1	2
47	1	47	3	1
53	10	5	0	4
17	1	17	1	2
51	10	3	4	1
105	2	9	1	1
52	10	4	1	4
15	1	15	3	2
72	10	24	2	1
49	10	1	4	1
19	1	19	4	2
20	1	20	0	1
5	1	5	0	3
248	3	8	2	1
103	2	7	2	2
104	2	8	2	0
250	3	10	1	3
78	10	30	1	3
106	2	10	1	3
109	2	13	3	2
50	10	2	2	1
56	10	8	2	1
257	3	17	1	3
14	1	14	1	1
54	10	6	2	1
31	1	31	5	0
57	10	9	3	2
63	10	15	3	1
3	1	3	2	0
44	1	44	3	1
60	10	12	2	1
6	1	6	3	2
66	10	18	0	2
247	3	7	1	2
255	3	15	2	1
9	1	9	1	1
256	3	16	2	1
43	1	43	3	0
253	3	13	2	1
48	1	48	0	2
77	10	29	1	1
246	3	6	1	2
249	3	9	1	2
244	3	4	1	2
178	4	34	1	2
273	3	33	3	0
137	2	41	1	3
117	2	21	2	2
279	3	39	4	0
123	2	27	0	3
124	2	28	0	3
270	3	30	1	3
172	4	28	0	2
208	7	16	2	1
205	7	13	0	2
200	7	8	2	0
199	7	7	1	1
206	7	14	2	1
118	2	22	2	0
159	4	15	3	1
196	7	4	1	2
129	2	33	2	0
130	2	34	1	2
161	4	17	0	3
115	2	19	4	1
116	2	20	1	1
136	2	40	1	3
135	2	39	4	0
121	2	25	0	3
122	2	26	5	0
192	4	48	1	3
263	3	23	1	2
141	2	45	2	0
128	2	32	0	3
127	2	31	3	1
142	2	46	2	1
114	2	18	1	2
134	2	38	2	2
119	2	23	3	1
133	2	37	1	2
180	4	36	1	0
113	2	17	0	2
139	2	43	3	0
197	7	5	1	2
140	2	44	2	1
198	7	6	1	1
148	4	4	1	2
125	2	29	0	3
176	4	32	0	2
175	4	31	3	1
262	3	22	2	1
152	4	8	3	0
162	4	18	1	2
182	4	38	1	2
181	4	37	3	1
184	4	40	2	1
171	4	27	1	2
187	4	43	3	0
202	7	10	1	3
188	4	44	-1	-1
131	2	35	1	2
168	4	24	1	0
143	2	47	2	3
173	4	29	1	2
207	7	15	3	2
269	3	29	1	2
193	7	1	3	1
194	7	2	1	2
272	3	32	1	2
265	3	25	2	1
210	7	18	1	2
186	4	42	2	2
201	7	9	1	2
111	2	15	2	1
211	7	19	3	0
144	2	48	1	2
264	3	24	2	1
274	3	34	1	2
145	4	1	3	1
151	4	7	2	1
281	3	41	1	2
150	4	6	2	1
156	4	12	2	1
282	3	42	2	1
153	4	9	2	1
275	3	35	1	3
138	2	42	1	2
158	4	14	-1	-1
157	4	13	3	1
191	4	47	2	0
132	2	36	0	2
203	7	11	1	2
164	4	20	0	2
163	4	19	3	0
170	4	26	3	1
169	4	25	2	2
276	3	36	0	1
165	4	21	1	2
155	4	11	1	3
149	4	5	0	3
177	4	33	3	0
204	7	12	1	2
190	4	46	0	1
183	4	39	4	0
120	2	24	0	0
189	4	45	2	1
209	7	17	1	2
112	2	16	2	0
271	3	31	3	1
160	4	16	2	1
261	3	21	1	3
277	3	37	2	1
278	3	38	1	2
166	4	22	2	1
280	3	40	1	2
267	3	27	1	3
126	2	30	1	1
146	4	2	2	0
185	4	41	1	2
154	4	10	0	4
268	3	28	1	2
179	4	35	1	2
167	4	23	2	1
147	4	3	3	0
174	4	30	1	3
266	3	26	2	1
259	3	19	4	1
260	3	20	1	2
195	7	3	3	1
627	1	51	2	1
322	6	34	1	0
232	7	40	1	1
359	8	23	1	2
335	6	47	0	2
233	7	41	1	3
357	8	21	2	1
336	6	48	0	2
215	7	23	1	2
319	6	31	3	0
341	8	5	0	3
296	6	8	2	0
289	6	1	2	0
290	6	2	1	1
325	6	37	1	3
342	8	6	1	1
293	6	5	0	2
216	7	24	2	1
314	6	26	2	0
355	8	19	3	1
356	8	20	1	2
338	8	2	0	1
234	7	42	2	3
333	6	45	1	1
285	3	45	2	1
294	6	6	2	1
326	6	38	0	1
316	6	28	0	3
351	8	15	1	1
239	7	47	1	2
308	6	20	1	1
309	6	21	1	3
311	6	23	1	2
343	8	7	1	2
334	6	46	2	1
349	8	13	2	1
214	7	22	2	1
350	8	14	1	2
230	7	38	2	1
312	6	24	0	2
344	8	8	3	1
299	6	11	-1	-1
226	7	34	1	1
241	3	1	2	0
300	6	12	-1	-1
360	8	24	1	0
235	7	43	2	0
213	7	21	1	2
287	3	47	1	2
254	3	14	1	2
237	7	45	1	2
310	6	22	2	0
240	7	48	1	2
238	7	46	1	0
352	8	16	2	1
303	6	15	2	1
288	3	48	1	2
327	6	39	4	0
329	6	41	1	4
227	7	35	1	4
236	7	44	3	1
229	7	37	3	1
302	6	14	1	1
295	6	7	0	2
304	6	16	1	2
297	6	9	2	0
298	6	10	0	3
330	6	42	3	0
220	7	28	0	3
231	7	39	4	0
228	7	36	1	2
353	8	17	1	3
354	8	18	1	3
358	8	22	2	1
317	6	29	1	3
347	8	11	1	1
339	8	3	3	1
318	6	30	1	2
331	6	43	3	0
332	6	44	2	-1
283	3	43	2	1
320	6	32	0	2
284	3	44	4	0
348	8	12	2	1
286	3	46	2	1
345	8	9	2	1
313	6	25	0	2
346	8	10	0	3
301	6	13	2	1
305	6	17	0	2
629	1	53	1	0
328	6	40	1	3
323	6	35	1	1
340	8	4	1	3
306	6	18	1	3
361	8	25	1	1
307	6	19	3	1
224	7	32	1	2
219	7	27	1	2
324	6	36	0	3
337	8	1	2	0
626	1	50	3	2
221	7	29	1	3
212	7	20	2	1
222	7	30	1	3
217	7	25	0	2
218	7	26	1	2
225	7	33	2	0
223	7	31	4	0
291	6	3	2	1
315	6	27	0	3
321	6	33	3	0
292	6	4	1	3
632	1	56	2	3
625	1	49	2	0
631	1	55	2	0
628	1	52	1	0
735	9	55	2	1
729	9	49	2	1
730	9	50	1	2
732	9	52	2	1
733	9	53	2	1
734	9	54	3	0
736	9	56	2	1
630	1	54	3	1
738	7	50	0	1
731	9	51	2	0
385	12	1	2	0
377	8	41	1	1
378	8	42	2	1
402	12	18	0	2
405	12	21	2	1
406	12	22	2	0
379	8	43	2	0
407	12	23	3	1
392	12	8	2	0
408	12	24	2	2
411	12	27	1	2
412	12	28	0	2
413	12	29	1	1
414	12	30	1	2
415	12	31	6	0
416	12	32	0	2
417	12	33	5	0
418	12	34	2	0
398	12	14	0	2
419	12	35	1	3
420	12	36	2	0
421	12	37	3	1
422	12	38	2	1
403	12	19	3	0
404	12	20	3	1
423	12	39	3	1
391	12	7	2	1
386	12	2	1	1
380	8	44	1	0
409	12	25	-1	-1
410	12	26	-1	-1
383	8	47	1	0
384	8	48	1	2
376	8	40	2	1
368	8	32	0	1
381	8	45	3	1
382	8	46	0	1
373	8	37	2	1
747	12	51	2	1
748	12	52	1	1
749	12	53	-1	-1
363	8	27	1	3
364	8	28	1	0
751	12	55	1	2
640	6	56	1	0
740	7	52	3	1
764	4	52	2	1
424	12	40	2	3
425	12	41	1	3
426	12	42	2	1
427	12	43	0	2
428	12	44	2	1
374	8	38	1	2
765	4	53	2	1
766	4	54	4	1
637	6	53	3	1
638	6	54	2	0
737	7	49	2	1
739	7	51	3	1
752	12	56	1	0
741	7	53	2	1
759	15	55	3	0
743	7	55	2	1
387	12	3	3	1
388	12	4	2	0
365	8	29	1	3
366	8	30	1	3
371	8	35	0	1
372	8	36	2	1
369	8	33	3	1
370	8	34	2	0
362	8	26	2	1
375	8	39	3	0
367	8	31	3	0
745	12	49	1	2
389	12	5	2	4
746	12	50	2	0
397	12	13	2	1
390	12	6	0	1
393	12	9	3	1
394	12	10	0	4
395	12	11	0	4
396	12	12	2	1
399	12	15	1	1
400	12	16	1	1
401	12	17	0	3
767	4	55	2	1
768	4	56	2	2
744	7	56	1	1
795	15	59	2	1
633	6	49	2	1
634	6	50	1	1
753	15	49	2	1
754	15	50	2	2
755	15	51	3	2
756	15	52	2	0
757	15	53	2	1
761	4	49	2	2
762	4	50	1	2
639	6	55	1	1
760	15	56	2	1
758	15	54	3	1
787	1	59	1	1
635	6	51	3	1
636	6	52	-1	-1
742	7	54	2	0
785	1	57	0	1
750	12	54	0	1
763	4	51	2	2
789	7	57	1	1
790	7	58	1	1
792	7	60	2	1
788	1	60	2	0
786	1	58	2	1
793	15	57	1	2
814	10	58	1	2
796	15	60	3	1
816	10	60	3	1
818	2	58	1	3
815	10	59	2	1
820	2	60	-1	-1
813	10	57	2	1
817	2	57	2	1
794	15	58	0	1
791	7	59	1	1
819	2	59	1	1
506	15	26	3	1
449	9	17	2	1
450	9	18	1	2
493	15	13	0	1
433	9	1	3	0
510	15	30	1	2
458	9	26	3	0
485	15	5	1	2
486	15	6	2	2
448	9	16	2	1
642	3	50	1	2
463	9	31	4	0
798	16	58	1	0
647	3	55	2	1
442	9	10	0	3
454	9	22	3	0
432	12	48	0	0
482	15	2	1	2
487	15	7	2	2
648	3	56	1	2
473	9	41	1	3
459	9	27	1	2
447	9	15	3	1
460	9	28	0	3
435	9	3	3	1
474	9	42	3	1
445	9	13	2	1
446	9	14	2	1
511	15	31	3	0
512	15	32	1	2
479	9	47	2	1
436	9	4	0	3
475	9	43	3	0
476	9	44	2	1
472	9	40	3	1
491	15	11	1	2
492	15	12	3	1
467	9	35	1	3
468	9	36	1	2
480	9	48	1	2
437	9	5	1	2
438	9	6	1	2
501	15	21	2	1
507	15	27	1	2
496	15	16	2	0
508	15	28	0	2
434	9	2	1	2
439	9	7	2	1
440	9	8	2	0
461	9	29	1	3
502	15	22	3	1
503	15	23	1	2
504	15	24	2	1
462	9	30	1	4
772	17	52	2	1
451	9	19	3	0
452	9	20	1	2
477	9	45	2	1
773	17	53	1	1
774	17	54	3	0
441	9	9	3	1
775	17	55	2	0
455	9	23	1	2
456	9	24	2	1
776	17	56	1	2
654	10	54	3	1
429	12	45	0	1
469	9	37	3	1
478	9	46	0	2
655	10	55	2	1
656	10	56	2	2
453	9	21	2	1
649	10	49	3	2
481	15	1	3	1
769	17	49	2	1
484	15	4	1	2
488	15	8	1	0
465	9	33	3	0
466	9	34	2	1
494	15	14	0	3
443	9	11	1	2
495	15	15	3	1
444	9	12	3	2
499	15	19	3	1
500	15	20	1	2
489	15	9	1	2
490	15	10	0	3
505	15	25	1	1
497	15	17	0	2
498	15	18	1	2
471	9	39	4	0
464	9	32	0	2
645	3	53	3	1
430	12	46	1	2
431	12	47	2	1
509	15	29	1	2
483	15	3	3	1
470	9	38	2	1
457	9	25	2	0
646	3	54	3	0
797	16	57	1	2
643	3	51	2	1
644	3	52	2	1
641	3	49	2	1
821	17	57	-1	-1
650	10	50	3	1
651	10	51	2	1
652	10	52	2	1
653	10	53	4	1
770	17	50	1	2
771	17	51	2	2
822	17	58	-1	-1
823	17	59	2	0
824	17	60	1	1
826	9	58	2	0
825	9	57	1	2
799	16	59	2	1
827	9	59	2	1
800	16	60	-2	-1
834	1	62	1	2
837	17	61	3	2
838	17	62	2	2
836	15	62	1	1
835	15	61	1	2
847	9	61	1	1
833	1	61	1	1
580	17	4	1	2
587	17	11	1	3
523	15	43	2	1
531	16	3	3	1
588	17	12	1	2
593	17	17	0	2
594	17	18	1	2
599	17	23	2	2
578	17	2	1	1
600	17	24	1	2
535	16	7	4	1
536	16	8	3	1
579	17	3	4	1
562	16	34	1	2
545	16	17	0	3
546	16	18	1	2
557	16	29	1	2
591	17	15	1	0
592	17	16	2	0
551	16	23	1	2
542	16	14	1	2
547	16	19	3	0
548	16	20	1	2
567	16	39	3	1
552	16	24	2	1
607	17	31	3	1
608	17	32	1	2
520	15	40	2	1
514	15	34	1	1
571	16	43	-1	-1
585	17	9	3	1
586	17	10	1	4
558	16	30	1	3
563	16	35	0	1
524	15	44	2	0
564	16	36	2	1
589	17	13	2	0
590	17	14	0	3
573	16	45	-1	-1
556	16	28	1	3
595	17	19	1	1
596	17	20	1	3
574	16	46	-1	-1
533	16	5	0	3
534	16	6	1	2
565	16	37	2	1
560	16	32	1	3
601	17	25	1	2
566	16	38	2	1
539	16	11	0	2
540	16	12	1	2
513	15	33	3	1
577	17	1	3	1
597	17	21	2	2
532	16	4	1	2
517	15	37	2	0
583	17	7	2	1
584	17	8	1	0
518	15	38	1	3
598	17	22	3	1
569	16	41	1	1
570	16	42	1	2
519	15	39	4	0
575	16	47	1	1
550	16	22	3	1
576	16	48	0	1
527	15	47	1	2
554	16	26	2	0
605	17	29	1	1
606	17	30	1	2
537	16	9	2	1
541	16	13	3	1
603	17	27	1	3
559	16	31	3	1
553	16	25	1	2
604	17	28	2	1
528	15	48	0	3
555	16	27	1	3
609	17	33	2	0
572	16	44	3	1
610	17	34	2	1
521	15	41	2	3
538	16	10	1	4
529	16	1	3	1
530	16	2	-1	-1
522	15	42	4	1
581	17	5	1	3
525	15	45	2	1
543	16	15	1	2
544	16	16	2	1
561	16	33	4	1
602	17	26	3	1
526	15	46	1	0
582	17	6	1	2
549	16	21	2	1
515	15	35	1	3
568	16	40	1	2
516	15	36	1	2
719	8	55	2	1
720	8	56	1	1
615	17	39	3	1
616	17	40	2	1
727	2	55	2	0
728	2	56	3	1
621	17	45	1	1
622	17	46	2	1
853	10	61	2	1
713	8	49	2	1
714	8	50	3	1
715	8	51	-1	-1
783	16	55	2	1
723	2	51	3	1
611	17	35	1	2
612	17	36	1	1
802	3	58	2	1
854	10	62	1	2
617	17	41	1	2
618	17	42	1	2
623	17	47	1	1
624	17	48	1	2
619	17	43	0	0
620	17	44	2	1
613	17	37	3	2
614	17	38	1	2
780	16	52	0	1
858	15	64	3	2
724	2	52	2	0
716	8	52	2	0
777	16	49	2	1
778	16	50	3	1
779	16	51	2	1
855	4	61	1	2
806	8	58	1	2
856	4	62	1	2
840	3	62	1	2
725	2	53	3	0
846	8	62	2	1
842	2	62	3	1
844	6	62	3	1
810	6	58	0	2
848	9	62	2	1
721	2	49	1	3
722	2	50	3	1
801	3	57	1	2
809	6	57	2	1
717	8	53	3	1
718	8	54	3	1
781	16	53	3	1
805	8	57	1	1
803	3	59	2	0
811	6	59	1	2
726	2	54	4	1
867	8	63	1	2
782	16	54	2	1
784	16	56	-1	-1
807	8	59	2	1
829	4	57	-1	-1
830	4	58	-1	-1
831	4	59	-1	-1
832	4	60	3	0
862	3	64	2	1
808	8	60	2	1
804	3	60	2	1
812	6	60	-2	-1
859	1	63	0	0
841	2	61	1	2
857	15	63	1	2
839	3	61	1	0
869	9	64	2	1
843	6	61	0	2
845	8	61	1	1
870	9	63	1	2
828	9	60	2	0
849	7	61	1	2
850	7	62	2	1
851	16	61	2	1
852	16	62	-1	-1
860	1	64	1	1
861	3	63	1	2
863	2	63	2	2
864	2	64	-1	-1
865	4	63	2	1
866	4	64	-1	-1
868	8	64	2	1
\.


--
-- Name: predicciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('predicciones_id_seq', 868, true);


--
-- Data for Name: resultados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resultados (id, goles_equipo1, goles_equipo2) FROM stdin;
36	3	1
30	0	0
29	0	3
7	1	5
8	3	1
42	2	1
41	0	1
47	1	1
48	0	1
13	3	0
20	1	2
14	2	1
19	1	3
25	2	1
26	3	0
31	2	1
37	4	0
49	1	1
32	0	0
38	1	2
50	2	0
43	2	1
3	0	0
44	1	1
10	2	3
9	0	2
4	0	4
21	2	1
16	0	0
22	0	1
27	2	5
28	1	2
33	1	0
34	1	0
39	2	2
45	1	0
46	2	4
40	2	2
11	0	3
12	2	0
51	2	1
5	1	4
6	1	3
24	0	0
23	0	1
17	1	4
18	2	1
35	2	3
52	1	1
53	2	0
54	2	1
55	1	0
56	2	1
57	0	1
58	2	1
59	1	0
60	0	0
15	2	1
1	3	1
2	1	0
61	1	7
62	0	0
63	0	3
64	1	0
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (id, ident, pw) FROM stdin;
2	Dario Castellanos	339F0035FF05BA58A5519D2D99F8B8B7
3	JCRomero	E66B5A0894CF8FDE97BEF11418CC4A2A
4	polo	183901BB5374CB36B422A56C588165BC
6	Javcas89	7F8B8F7DBE0D6176207ED43D0DC25EE8
7	Chechin	A8F62B5C84DFF3B464104AC989CB095D
10	chente	11ACF1EA521B4D17BE8A62EA75370BB7
8	Cotto	8FCB4EC3D7DC5D5EB9AAEE8BE82A71B4
12	dani	0AF1E153901C08A79FE4659227D969C7
9	Bocha	8FCB4EC3D7DC5D5EB9AAEE8BE82A71B4
1	kmels	4AB814F4A9171341CDB8A515B8F221F9
16	mrpinto	9482FA645007003C9DBF686AA44ECE77
17	Efrain	1F1544784839DBD4C4FEA85C6D8C7C1F
15	marinho_el_pijudo	9E6A4B0E1ED01007F6604ABD3E4D2163
\.


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_id_seq', 18, true);


--
-- Name: mensajes_chat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mensajes_chat
    ADD CONSTRAINT mensajes_chat_pkey PRIMARY KEY (id);


--
-- Name: partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id);


--
-- Name: predicciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY predicciones
    ADD CONSTRAINT predicciones_pkey PRIMARY KEY (id);


--
-- Name: usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: AUTOR_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mensajes_chat
    ADD CONSTRAINT "AUTOR_FK" FOREIGN KEY (autor_id) REFERENCES usuarios(id) ON DELETE CASCADE;


--
-- Name: PARTIDO_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY predicciones
    ADD CONSTRAINT "PARTIDO_FK" FOREIGN KEY (partido_id) REFERENCES partidos(id) ON DELETE CASCADE;


--
-- Name: PARTIDO_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resultados
    ADD CONSTRAINT "PARTIDO_FK" FOREIGN KEY (id) REFERENCES partidos(id) ON DELETE CASCADE;


--
-- Name: USER_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY predicciones
    ADD CONSTRAINT "USER_FK" FOREIGN KEY (user_id) REFERENCES usuarios(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

