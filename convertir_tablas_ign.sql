/**
Esta consulta toma tablas de datos del IGN y crea en otro esquema nuevas tablas con menos campos
y transforma las geometrías a Web Mercator para mejorar el rendimiento del renderizado de teselas 
**/
DROP INDEX IF EXISTS gix_pais_geom;
DROP TABLE IF EXISTS argenmap.pais;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  nam,
  fna INTO TABLE argenmap.pais
FROM
  public.pais;
CREATE INDEX gix_pais_geom 
ON argenmap.pais 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.pais USING gix_pais_geom;
ANALYZE argenmap.pais;

ALTER TABLE argenmap.pais
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.pais TO readonly;

DROP INDEX IF EXISTS gix_areas_de_asentamientos_y_edificios_geom;
DROP TABLE IF EXISTS argenmap.areas_de_asentamientos_y_edificios;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad INTO TABLE argenmap.areas_de_asentamientos_y_edificios
FROM
  public.areas_de_asentamientos_y_edificios;
CREATE INDEX gix_areas_de_asentamientos_y_edificios_geom 
ON argenmap.areas_de_asentamientos_y_edificios 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_asentamientos_y_edificios 
USING gix_areas_de_asentamientos_y_edificios_geom;
ANALYZE argenmap.areas_de_asentamientos_y_edificios;

ALTER TABLE argenmap.areas_de_asentamientos_y_edificios
    OWNER to admins;

-- TEST

DROP INDEX IF EXISTS gix_areas_de_aguas_continentales_geom;
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

SELECT Populate_Geometry_Columns(argenmap.areas_de_aguas_continentales::regclass::oid);

ALTER TABLE argenmap.areas_de_asentamientos_y_edificios
    OWNER to admins;

-- FIN TEST

DROP TABLE IF EXISTS argenmap.lineas_de_aguas_continentales;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  fna INTO TABLE argenmap.lineas_de_aguas_continentales
FROM
  public.lineas_de_aguas_continentales;
CREATE INDEX gix_lineas_de_aguas_continentales_geom 
ON argenmap.lineas_de_aguas_continentales 
USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.areas_de_zona_costera;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  nam,
  fna INTO TABLE argenmap.areas_de_zona_costera
FROM
  public.areas_de_zona_costera;
CREATE INDEX gix_areas_de_zona_costera_geom ON argenmap.areas_de_zona_costera USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.area_protegida;
SELECT
  gid,
  ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom,
  entidad,
  nam,
  fna INTO TABLE argenmap.area_protegida
FROM
  public.area_protegida;
CREATE INDEX gix_area_protegida_geom ON argenmap.area_protegida USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.area_de_limites;
SELECT
  * INTO TABLE argenmap.area_de_limites
FROM
  public.area_de_limites;
CREATE INDEX gix_area_de_limites_geom ON argenmap.area_de_limites USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.areas_de_glaciologia;
SELECT
  * INTO TABLE argenmap.areas_de_glaciologia
FROM
  public.areas_de_glaciologia;
CREATE INDEX gix_areas_de_glaciologia_geom ON argenmap.areas_de_glaciologia USING gist(geom) TABLESPACE pg_default;
DROP TABLE IF EXISTS argenmap.lineas_de_glaciologia;
SELECT
  * INTO TABLE argenmap.lineas_de_glaciologia
FROM
  public.lineas_de_glaciologia;
CREATE INDEX gix_lineas_de_glaciologia_geom ON argenmap.lineas_de_glaciologia USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.vial;
SELECT
  * INTO TABLE argenmap.vial
FROM
  public.vial;
CREATE INDEX gix_vial_geom ON argenmap.vial USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.red_vial_nacional_dnv_2018;
SELECT
  * INTO TABLE argenmap.red_vial_nacional_dnv_2018
FROM
  public.red_vial_nacional_dnv_2018;
CREATE INDEX gix_red_vial_nacional_dnv_2018_geom ON argenmap.red_vial_nacional_dnv_2018 USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.lineas_de_transporte_ferroviario;
SELECT
  * INTO TABLE argenmap.lineas_de_transporte_ferroviario
FROM
  public.lineas_de_transporte_ferroviario;
CREATE INDEX gix_lineas_de_transporte_ferroviario_geom ON argenmap.lineas_de_transporte_ferroviario USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.lineas_de_geomorfologia;
SELECT
  * INTO TABLE argenmap.lineas_de_geomorfologia
FROM
  public.lineas_de_geomorfologia;
CREATE INDEX gix_lineas_de_geomorfologia_geom ON argenmap.lineas_de_geomorfologia USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.puntos_de_geomorfologia;
SELECT
  * INTO TABLE argenmap.puntos_de_geomorfologia
FROM
  public.puntos_de_geomorfologia;
CREATE INDEX gix_puntos_de_geomorfologia_geom ON argenmap.puntos_de_geomorfologia USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.toponimos_oceano;
SELECT
  * INTO TABLE argenmap.toponimos_oceano
FROM
  public.toponimos_oceano;
CREATE INDEX gix_toponimos_oceano_geom ON argenmap.toponimos_oceano USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.toponimia_maritima;
SELECT
  * INTO TABLE argenmap.toponimia_maritima
FROM
  public.toponimia_maritima;
CREATE INDEX gix_toponimia_maritima_geom ON argenmap.toponimia_maritima USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.linea_de_limite;
SELECT
  * INTO TABLE argenmap.linea_de_limite
FROM
  public.linea_de_limite;
CREATE INDEX gix_linea_de_limite_geom ON argenmap.linea_de_limite USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.puntos_de_asentamientos_y_edificios;
SELECT
  * INTO TABLE argenmap.puntos_de_asentamientos_y_edificios
FROM
  public.puntos_de_asentamientos_y_edificios;
CREATE INDEX gix_puntos_de_asentamientos_y_edificios_geom ON argenmap.puntos_de_asentamientos_y_edificios USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.departamento;
SELECT
  * INTO TABLE argenmap.departamento
FROM
  public.departamento;
CREATE INDEX gix_departamento_geom ON argenmap.departamento USING gist(geom) TABLESPACE pg_default;

DROP TABLE IF EXISTS argenmap.provincia;
SELECT
  * INTO TABLE argenmap.provincia
FROM
  public.provincia;
CREATE INDEX gix_provincia_geom ON argenmap.provincia USING gist(geom) TABLESPACE pg_default;