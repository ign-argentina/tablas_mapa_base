  /**
Esta consulta utiliza tablas del IGN necesarias para el mapa base 
(previamente importadas en la base) y crea nuevas tablas en otro esquema 
con menos campos, además transforma las geometrías a Web Mercator (EPSG:3857)
para mejorar el rendimiento del renderizado de teselas.
**/

-- Convertir pais

DROP TABLE IF EXISTS argenmap.pais;
SELECT
  gid,
  nam,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.pais
FROM
  public.pais;
ALTER TABLE
  argenmap.pais
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_pais_geom ON argenmap.pais USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.pais USING gix_pais_geom;
ANALYZE argenmap.pais;
SELECT
  Populate_Geometry_Columns('argenmap.pais' :: regclass :: oid);
ALTER TABLE
  argenmap.pais OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.pais TO readonly;

-- Fin pais

-- Convertir asentamientos_y_edificios

DROP TABLE IF EXISTS argenmap.areas_de_asentamientos_y_edificios;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad INTO TABLE argenmap.areas_de_asentamientos_y_edificios
FROM
  public.areas_de_asentamientos_y_edificios;

ALTER TABLE argenmap.areas_de_asentamientos_y_edificios 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_areas_de_asentamientos_y_edificios_geom 
ON argenmap.areas_de_asentamientos_y_edificios 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_asentamientos_y_edificios 
USING gix_areas_de_asentamientos_y_edificios_geom;
ANALYZE argenmap.areas_de_asentamientos_y_edificios;

SELECT Populate_Geometry_Columns('argenmap.areas_de_asentamientos_y_edificios'::regclass::oid);

ALTER TABLE argenmap.areas_de_asentamientos_y_edificios
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.areas_de_asentamientos_y_edificios TO readonly;

-- Fin asentamientos_y_edificios

-- Convertir areas_de_aguas_continentales

DROP TABLE IF EXISTS argenmap.areas_de_aguas_continentales;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  fna INTO TABLE argenmap.areas_de_aguas_continentales
FROM
  public.areas_de_aguas_continentales;

ALTER TABLE argenmap.areas_de_aguas_continentales 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_areas_de_aguas_continentales_geom 
ON argenmap.areas_de_aguas_continentales 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_aguas_continentales 
USING gix_areas_de_aguas_continentales_geom;
ANALYZE argenmap.areas_de_aguas_continentales;

SELECT Populate_Geometry_Columns('argenmap.areas_de_aguas_continentales'::regclass::oid);

ALTER TABLE argenmap.areas_de_aguas_continentales
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.areas_de_aguas_continentales TO readonly;

-- Fin areas_de_aguas_continentales

-- Convertir lineas_de_aguas_continentales

DROP TABLE IF EXISTS argenmap.lineas_de_aguas_continentales;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  fna INTO TABLE argenmap.lineas_de_aguas_continentales
FROM
  public.lineas_de_aguas_continentales;

ALTER TABLE argenmap.lineas_de_aguas_continentales 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_lineas_de_aguas_continentales_geom 
ON argenmap.lineas_de_aguas_continentales 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.lineas_de_aguas_continentales 
USING gix_lineas_de_aguas_continentales_geom;
ANALYZE argenmap.lineas_de_aguas_continentales;

SELECT Populate_Geometry_Columns('argenmap.lineas_de_aguas_continentales'::regclass::oid);

ALTER TABLE argenmap.lineas_de_aguas_continentales
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.lineas_de_aguas_continentales TO readonly;

-- Fin lineas_de_aguas_continentales

-- Convertir areas_de_zona_costera

DROP TABLE IF EXISTS argenmap.areas_de_zona_costera;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  fna INTO TABLE argenmap.areas_de_zona_costera
FROM
  public.areas_de_zona_costera;

ALTER TABLE argenmap.areas_de_zona_costera 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_areas_de_zona_costera_geom 
ON argenmap.areas_de_zona_costera 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_zona_costera 
USING gix_areas_de_zona_costera_geom;
ANALYZE argenmap.areas_de_zona_costera;

SELECT Populate_Geometry_Columns('argenmap.areas_de_zona_costera'::regclass::oid);

ALTER TABLE argenmap.areas_de_zona_costera
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.areas_de_zona_costera TO readonly;

-- Fin areas_de_zona_costera

-- Convertir area_protegida

DROP TABLE IF EXISTS argenmap.area_protegida;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  fna INTO TABLE argenmap.area_protegida
FROM
  public.area_protegida;

ALTER TABLE argenmap.area_protegida 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_area_protegida_geom 
ON argenmap.area_protegida 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.area_protegida 
USING gix_area_protegida_geom;
ANALYZE argenmap.area_protegida;

SELECT Populate_Geometry_Columns('argenmap.area_protegida'::regclass::oid);

ALTER TABLE argenmap.area_protegida
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.area_protegida TO readonly;

-- Fin area_protegida

-- Convertir areas_de_glaciologia

DROP TABLE IF EXISTS argenmap.areas_de_glaciologia;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad INTO TABLE argenmap.areas_de_glaciologia
FROM
  public.areas_de_glaciologia;

ALTER TABLE argenmap.areas_de_glaciologia 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_areas_de_glaciologia_geom 
ON argenmap.areas_de_glaciologia 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_glaciologia 
USING gix_areas_de_glaciologia_geom;
ANALYZE argenmap.areas_de_glaciologia;

SELECT Populate_Geometry_Columns('argenmap.areas_de_glaciologia'::regclass::oid);

ALTER TABLE argenmap.areas_de_glaciologia
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.areas_de_glaciologia TO readonly;

-- Fin areas_de_glaciologia

-- Convertir lineas_de_glaciologia

DROP TABLE IF EXISTS argenmap.lineas_de_glaciologia;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
  entidad INTO TABLE argenmap.lineas_de_glaciologia
FROM
  public.lineas_de_glaciologia;

ALTER TABLE argenmap.lineas_de_glaciologia 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_lineas_de_glaciologia_geom 
ON argenmap.lineas_de_glaciologia 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.lineas_de_glaciologia 
USING gix_lineas_de_glaciologia_geom;
ANALYZE argenmap.lineas_de_glaciologia;

SELECT Populate_Geometry_Columns('argenmap.lineas_de_glaciologia'::regclass::oid);

ALTER TABLE argenmap.lineas_de_glaciologia
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.lineas_de_glaciologia TO readonly;

-- Fin lineas_de_glaciologia

-- Convertir vial

DROP TABLE IF EXISTS argenmap.vial;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
  rst, 
  entidad, 
  typ, 
  hct, 
  nr INTO TABLE argenmap.vial
FROM
  public.vial;

ALTER TABLE argenmap.vial 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_vial_geom 
ON argenmap.vial 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.vial 
USING gix_vial_geom;
ANALYZE argenmap.vial;

SELECT Populate_Geometry_Columns('argenmap.vial'::regclass::oid);

ALTER TABLE argenmap.vial
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.vial TO readonly;

-- Fin vial

-- Convertir red_vial_nacional_dnv

DROP TABLE IF EXISTS argenmap.red_vial_nacional_dnv;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  hct, 
  cod_rn INTO TABLE argenmap.red_vial_nacional_dnv
FROM
  public.red_vial_nacional_dnv_2018;

ALTER TABLE argenmap.red_vial_nacional_dnv 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_red_vial_nacional_dnv_geom 
ON argenmap.red_vial_nacional_dnv 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.red_vial_nacional_dnv 
USING gix_red_vial_nacional_dnv_geom;
ANALYZE argenmap.red_vial_nacional_dnv;

SELECT Populate_Geometry_Columns('argenmap.red_vial_nacional_dnv'::regclass::oid);

ALTER TABLE argenmap.red_vial_nacional_dnv
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.red_vial_nacional_dnv TO readonly;

-- Fin red_vial_nacional_dnv

-- Convertir lineas_de_transporte_ferroviario

DROP TABLE IF EXISTS argenmap.lineas_de_transporte_ferroviario;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  fna INTO TABLE argenmap.lineas_de_transporte_ferroviario
FROM
  public.lineas_de_transporte_ferroviario;

ALTER TABLE argenmap.lineas_de_transporte_ferroviario 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_lineas_de_transporte_ferroviario_geom 
ON argenmap.lineas_de_transporte_ferroviario 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.lineas_de_transporte_ferroviario 
USING gix_lineas_de_transporte_ferroviario_geom;
ANALYZE argenmap.lineas_de_transporte_ferroviario;

SELECT Populate_Geometry_Columns('argenmap.lineas_de_transporte_ferroviario'::regclass::oid);

ALTER TABLE argenmap.lineas_de_transporte_ferroviario
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.lineas_de_transporte_ferroviario TO readonly;

-- Fin lineas_de_transporte_ferroviario

-- Convertir lineas_de_geomorfologia

DROP TABLE IF EXISTS argenmap.lineas_de_geomorfologia;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
  entidad,
  fna INTO TABLE argenmap.lineas_de_geomorfologia
FROM
  public.lineas_de_geomorfologia
WHERE entidad IN (0, 3, 4, 5);

ALTER TABLE argenmap.lineas_de_geomorfologia 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_lineas_de_geomorfologia_geom 
ON argenmap.lineas_de_geomorfologia 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.lineas_de_geomorfologia 
USING gix_lineas_de_geomorfologia_geom;
ANALYZE argenmap.lineas_de_geomorfologia;

SELECT Populate_Geometry_Columns('argenmap.lineas_de_geomorfologia'::regclass::oid);

ALTER TABLE argenmap.lineas_de_geomorfologia
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.lineas_de_geomorfologia TO readonly;

-- Fin lineas_de_geomorfologia

-- Convertir puntos_de_geomorfologia
-- REVISAR ERROR:  transform: couldn't project point (-1.79769e+308 -1.79769e+308 -1.79769e+308): latitude or longitude exceeded limits (-14)
DROP TABLE IF EXISTS argenmap.puntos_de_geomorfologia;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
  entidad, 
  fna INTO TABLE argenmap.puntos_de_geomorfologia
FROM
  public.puntos_de_geomorfologia
WHERE gid NOT IN ('17636', '64937');

ALTER TABLE argenmap.puntos_de_geomorfologia 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_puntos_de_geomorfologia_geom 
ON argenmap.puntos_de_geomorfologia 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.puntos_de_geomorfologia 
USING gix_puntos_de_geomorfologia_geom;
ANALYZE argenmap.puntos_de_geomorfologia;

SELECT Populate_Geometry_Columns('argenmap.puntos_de_geomorfologia'::regclass::oid);

ALTER TABLE argenmap.puntos_de_geomorfologia
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.puntos_de_geomorfologia TO readonly;

-- Fin puntos_de_geomorfologia

-- Convertir toponimos_oceano

DROP TABLE IF EXISTS argenmap.toponimos_oceano;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
  nombre INTO TABLE argenmap.toponimos_oceano
FROM
  public.toponimos_oceano;

ALTER TABLE argenmap.toponimos_oceano 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_toponimos_oceano_geom 
ON argenmap.toponimos_oceano 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.toponimos_oceano 
USING gix_toponimos_oceano_geom;
ANALYZE argenmap.toponimos_oceano;

SELECT Populate_Geometry_Columns('argenmap.toponimos_oceano'::regclass::oid);

ALTER TABLE argenmap.toponimos_oceano
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.toponimos_oceano TO readonly;

-- Fin toponimos_oceano

-- Convertir toponimia_maritima

DROP TABLE IF EXISTS argenmap.toponimia_maritima;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
  nombre  INTO TABLE argenmap.toponimia_maritima
FROM
  public.toponimia_maritima;

ALTER TABLE argenmap.toponimia_maritima 
ADD PRIMARY KEY (gid);

CREATE INDEX gix_toponimia_maritima_geom 
ON argenmap.toponimia_maritima 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.toponimia_maritima 
USING gix_toponimia_maritima_geom;
ANALYZE argenmap.toponimia_maritima;

SELECT Populate_Geometry_Columns('argenmap.toponimia_maritima'::regclass::oid);

ALTER TABLE argenmap.toponimia_maritima
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.toponimia_maritima TO readonly;

-- Fin toponimia_maritima

-- Convertir linea_de_limite

DROP TABLE IF EXISTS argenmap.linea_de_limite;
SELECT
  gid,
  --ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  vlj,
  objeto,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.linea_de_limite
FROM
  public.linea_de_limite;
  -- WHERE
  --   gid NOT IN ('79', '6465')
  --   OR geom IS NOT NULL;
ALTER TABLE
  argenmap.linea_de_limite
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_linea_de_limite_geom ON argenmap.linea_de_limite USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.linea_de_limite USING gix_linea_de_limite_geom;
ANALYZE argenmap.linea_de_limite;
SELECT
  Populate_Geometry_Columns('argenmap.linea_de_limite' :: regclass :: oid);
ALTER TABLE
  argenmap.linea_de_limite OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.linea_de_limite TO readonly;

-- Fin linea_de_limite

-- Convertir puntos_de_asentamientos_y_edificios

DROP TABLE IF EXISTS argenmap.puntos_de_asentamientos_y_edificios;
SELECT
  gid,
  --ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  objeto,
  fna,
  ca1,
  ahb,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.puntos_de_asentamientos_y_edificios
FROM
  public.puntos_de_asentamientos_y_edificios;
ALTER TABLE
  argenmap.puntos_de_asentamientos_y_edificios
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_puntos_de_asentamientos_y_edificios_geom ON argenmap.puntos_de_asentamientos_y_edificios USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.puntos_de_asentamientos_y_edificios USING gix_puntos_de_asentamientos_y_edificios_geom;
ANALYZE argenmap.puntos_de_asentamientos_y_edificios;
SELECT
  Populate_Geometry_Columns(
    'argenmap.puntos_de_asentamientos_y_edificios' :: regclass :: oid
  );
ALTER TABLE
  argenmap.puntos_de_asentamientos_y_edificios OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.puntos_de_asentamientos_y_edificios TO readonly;

-- Fin puntos_de_asentamientos_y_edificios

-- Convertir departamento

DROP TABLE IF EXISTS argenmap.departamento;
SELECT
  gid,
  --ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  fna,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.departamento
FROM
  public.departamento;
ALTER TABLE
  argenmap.departamento
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_departamento_geom ON argenmap.departamento USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.departamento USING gix_departamento_geom;
ANALYZE argenmap.departamento;
SELECT
  Populate_Geometry_Columns('argenmap.departamento' :: regclass :: oid);
ALTER TABLE
  argenmap.departamento OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.departamento TO readonly;

-- Fin departamento

-- Convertir provincia

DROP TABLE IF EXISTS argenmap.provincia;
SELECT
  gid,
  --ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  fna,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.provincia
FROM
  public.provincia;
ALTER TABLE
  argenmap.provincia
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_provincia_geom ON argenmap.provincia USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.provincia USING gix_provincia_geom;
ANALYZE argenmap.provincia;
SELECT
  Populate_Geometry_Columns('argenmap.provincia' :: regclass :: oid);
ALTER TABLE
  argenmap.provincia OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.provincia TO readonly;

-- Fin provincia