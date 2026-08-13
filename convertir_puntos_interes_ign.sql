-- Limpiar tablas existentes
DROP TABLE IF EXISTS argenmap.ayuda_a_la_navegacion;
DROP TABLE IF EXISTS argenmap.puntos_de_ciencia_y_educacion;
DROP TABLE IF EXISTS argenmap.puntos_instalacion_militar;
DROP TABLE IF EXISTS argenmap.puntos_paso_a_nivel;
DROP TABLE IF EXISTS argenmap.puntos_estructuras_operativas_y_defensivas;
DROP TABLE IF EXISTS argenmap.puntos_cultura_y_religion;
DROP TABLE IF EXISTS argenmap.puntos_de_equipamiento;
DROP TABLE IF EXISTS argenmap.areas_de_fabricacion_y_procesamiento;
DROP TABLE IF EXISTS argenmap.areas_restringidas_y_limites;
DROP TABLE IF EXISTS argenmap.economia_y_comercio;
DROP TABLE IF EXISTS argenmap.areas_de_ciencia_y_educacion;
DROP TABLE IF EXISTS argenmap.areas_de_recreacion;
DROP TABLE IF EXISTS argenmap.areas_de_transporte_aereo;
DROP TABLE IF EXISTS argenmap.areas_de_extraccion;
DROP TABLE IF EXISTS argenmap.salud;

-- Crear tablas de puntos
CREATE TABLE argenmap.ayuda_a_la_navegacion (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.puntos_de_ciencia_y_educacion (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.puntos_instalacion_militar (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.puntos_paso_a_nivel (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.puntos_estructuras_operativas_y_defensivas (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.puntos_cultura_y_religion (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.puntos_de_equipamiento (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

CREATE TABLE argenmap.areas_de_fabricacion_y_procesamiento (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.areas_restringidas_y_limites (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.economia_y_comercio (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.areas_de_ciencia_y_educacion (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.areas_de_recreacion (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.areas_de_transporte_aereo (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.areas_de_extraccion (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(MultiPolygon, 3857)
);

CREATE TABLE argenmap.salud (
  gid SERIAL PRIMARY KEY,
  objeto TEXT,
  fna TEXT,
  geom geometry(Point, 3857)
);

-- Puntos de interés
INSERT INTO argenmap.ayuda_a_la_navegacion (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.ayuda_a_la_navegacion WHERE objeto = 'Faro' AND fna IS NOT NULL;
INSERT INTO argenmap.puntos_de_ciencia_y_educacion  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.puntos_de_ciencia_y_educacion WHERE fna IS NOT NULL;

INSERT INTO argenmap.puntos_instalacion_militar  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.instalacion_militar WHERE fna IS NOT NULL;
INSERT INTO argenmap.puntos_paso_a_nivel  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.infraestructura_de_transporte WHERE objeto = 'Paso a nivel';
INSERT INTO argenmap.puntos_estructuras_operativas_y_defensivas  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.estructuras_operativas_y_defensivas WHERE fna IS NOT NULL;
INSERT INTO argenmap.puntos_cultura_y_religion  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.cultura_y_religion WHERE fna IS NOT NULL;
INSERT INTO argenmap.puntos_de_equipamiento  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom 
 FROM public.puntos_de_equipamiento WHERE fna IS NOT NULL;

-- Áreas de interés
INSERT INTO argenmap.areas_de_fabricacion_y_procesamiento  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.areas_de_fabricacion_y_procesamiento WHERE fna IS NOT NULL;
INSERT INTO argenmap.areas_restringidas_y_limites  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.areas_restringidas_y_limites WHERE fna IS NOT NULL;
INSERT INTO argenmap.economia_y_comercio  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.economia_y_comercio WHERE fna IS NOT NULL;
INSERT INTO argenmap.areas_de_ciencia_y_educacion  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.areas_de_ciencia_y_educacion WHERE fna IS NOT NULL;
INSERT INTO argenmap.areas_de_recreacion  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.areas_de_recreacion WHERE fna IS NOT NULL;
INSERT INTO argenmap.areas_de_transporte_aereo  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.areas_de_transporte_aereo WHERE fna IS NOT NULL;
INSERT INTO argenmap.areas_de_extraccion  (objeto, fna, geom)
SELECT objeto, fna, ST_Multi(
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
  ) as geom
FROM public.areas_de_extraccion WHERE fna IS NOT NULL;

INSERT INTO argenmap.salud  (objeto, fna, geom)
SELECT objeto, fna, ST_SetSRID(
    ST_Transform(
      ST_Intersection(
        geom,
        ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
      ),
      3857
    ),
    3857
  ) as geom
FROM public.salud WHERE fna IS NOT NULL;

-- Crear índices
CREATE INDEX gix_ayuda_a_la_navegacion_geom ON argenmap.ayuda_a_la_navegacion USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_puntos_de_ciencia_y_educacion_geom ON argenmap.puntos_de_ciencia_y_educacion USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_puntos_instalacion_militar_geom ON argenmap.puntos_instalacion_militar USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_puntos_paso_a_nivel_geom ON argenmap.puntos_paso_a_nivel USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_puntos_estructuras_operativas_y_defensivas_geom ON argenmap.puntos_estructuras_operativas_y_defensivas USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_puntos_cultura_y_religion_geom ON argenmap.puntos_cultura_y_religion USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_puntos_de_equipamiento_geom ON argenmap.puntos_de_equipamiento USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_areas_de_fabricacion_y_procesamiento_geom ON argenmap.areas_de_fabricacion_y_procesamiento USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_areas_restringidas_y_limites_geom ON argenmap.areas_restringidas_y_limites USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_economia_y_comercio_geom ON argenmap.economia_y_comercio USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_areas_de_ciencia_y_educacion_geom ON argenmap.areas_de_ciencia_y_educacion USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_areas_de_recreacion_geom ON argenmap.areas_de_recreacion USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_areas_de_transporte_aereo_geom ON argenmap.areas_de_transporte_aereo USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_areas_de_extraccion_geom ON argenmap.areas_de_extraccion USING gist(geom) TABLESPACE pg_default;
CREATE INDEX gix_salud_geom ON argenmap.salud USING gist(geom) TABLESPACE pg_default;

-- Cluster, analyze y agregar en vista geometry_columns
CLUSTER argenmap.ayuda_a_la_navegacion USING gix_ayuda_a_la_navegacion_geom;
ANALYZE  argenmap.ayuda_a_la_navegacion;
SELECT Populate_Geometry_Columns('argenmap.ayuda_a_la_navegacion'::regclass::oid);

CLUSTER argenmap.puntos_de_ciencia_y_educacion USING gix_puntos_de_ciencia_y_educacion_geom;
ANALYZE  argenmap.puntos_de_ciencia_y_educacion;
SELECT Populate_Geometry_Columns('argenmap.puntos_de_ciencia_y_educacion'::regclass::oid);

CLUSTER argenmap.puntos_instalacion_militar USING gix_puntos_instalacion_militar_geom;
ANALYZE  argenmap.puntos_instalacion_militar;
SELECT Populate_Geometry_Columns('argenmap.puntos_instalacion_militar'::regclass::oid);

CLUSTER argenmap.puntos_paso_a_nivel USING gix_puntos_paso_a_nivel_geom;
ANALYZE  argenmap.puntos_paso_a_nivel;
SELECT Populate_Geometry_Columns('argenmap.puntos_paso_a_nivel'::regclass::oid);

CLUSTER argenmap.puntos_estructuras_operativas_y_defensivas USING gix_puntos_estructuras_operativas_y_defensivas_geom;
ANALYZE  argenmap.puntos_estructuras_operativas_y_defensivas;
SELECT Populate_Geometry_Columns('argenmap.puntos_estructuras_operativas_y_defensivas'::regclass::oid);

CLUSTER argenmap.puntos_cultura_y_religion USING gix_puntos_cultura_y_religion_geom;
ANALYZE  argenmap.puntos_cultura_y_religion;
SELECT Populate_Geometry_Columns('argenmap.puntos_cultura_y_religion'::regclass::oid);

CLUSTER argenmap.puntos_de_equipamiento USING gix_puntos_de_equipamiento_geom;
ANALYZE  argenmap.puntos_de_equipamiento;
SELECT Populate_Geometry_Columns('argenmap.puntos_de_equipamiento'::regclass::oid);

CLUSTER argenmap.areas_de_fabricacion_y_procesamiento USING gix_areas_de_fabricacion_y_procesamiento_geom;
ANALYZE  argenmap.areas_de_fabricacion_y_procesamiento;
SELECT Populate_Geometry_Columns('argenmap.areas_de_fabricacion_y_procesamiento'::regclass::oid);

CLUSTER argenmap.areas_restringidas_y_limites USING gix_areas_restringidas_y_limites_geom;
ANALYZE  argenmap.areas_restringidas_y_limites;
SELECT Populate_Geometry_Columns('argenmap.areas_restringidas_y_limites'::regclass::oid);

CLUSTER argenmap.economia_y_comercio USING gix_economia_y_comercio_geom;
ANALYZE  argenmap.economia_y_comercio;
SELECT Populate_Geometry_Columns('argenmap.economia_y_comercio'::regclass::oid);

CLUSTER argenmap.areas_de_ciencia_y_educacion USING gix_areas_de_ciencia_y_educacion_geom;
ANALYZE  argenmap.areas_de_ciencia_y_educacion;
SELECT Populate_Geometry_Columns('argenmap.areas_de_ciencia_y_educacion'::regclass::oid);

CLUSTER argenmap.areas_de_recreacion USING gix_areas_de_recreacion_geom;
ANALYZE  argenmap.areas_de_recreacion;
SELECT Populate_Geometry_Columns('argenmap.areas_de_recreacion'::regclass::oid);

CLUSTER argenmap.areas_de_transporte_aereo USING gix_areas_de_transporte_aereo_geom;
ANALYZE  argenmap.areas_de_transporte_aereo;
SELECT Populate_Geometry_Columns('argenmap.areas_de_transporte_aereo'::regclass::oid);

CLUSTER argenmap.areas_de_extraccion USING gix_areas_de_extraccion_geom;
ANALYZE  argenmap.areas_de_extraccion;
SELECT Populate_Geometry_Columns('argenmap.areas_de_extraccion'::regclass::oid);

CLUSTER argenmap.salud USING gix_salud_geom;
ANALYZE  argenmap.salud;
SELECT Populate_Geometry_Columns('argenmap.salud'::regclass::oid);

-- Asignar permisos
ALTER TABLE argenmap.ayuda_a_la_navegacion OWNER TO admins;
GRANT SELECT ON TABLE argenmap.ayuda_a_la_navegacion TO readonly;
ALTER TABLE argenmap.puntos_de_ciencia_y_educacion OWNER TO admins;
GRANT SELECT ON TABLE argenmap.puntos_de_ciencia_y_educacion TO readonly;
ALTER TABLE argenmap.puntos_instalacion_militar OWNER TO admins;
GRANT SELECT ON TABLE argenmap.puntos_instalacion_militar TO readonly;
ALTER TABLE argenmap.puntos_paso_a_nivel OWNER TO admins;
GRANT SELECT ON TABLE argenmap.puntos_paso_a_nivel TO readonly;
ALTER TABLE argenmap.puntos_estructuras_operativas_y_defensivas OWNER TO admins;
GRANT SELECT ON TABLE argenmap.puntos_estructuras_operativas_y_defensivas TO readonly;
ALTER TABLE argenmap.puntos_cultura_y_religion OWNER TO admins;
GRANT SELECT ON TABLE argenmap.puntos_cultura_y_religion TO readonly;
ALTER TABLE argenmap.puntos_de_equipamiento OWNER TO admins;
GRANT SELECT ON TABLE argenmap.puntos_de_equipamiento TO readonly;
ALTER TABLE argenmap.areas_de_fabricacion_y_procesamiento OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_fabricacion_y_procesamiento TO readonly;
ALTER TABLE argenmap.areas_restringidas_y_limites OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_restringidas_y_limites TO readonly;
ALTER TABLE argenmap.economia_y_comercio OWNER TO admins;
GRANT SELECT ON TABLE argenmap.economia_y_comercio TO readonly;
ALTER TABLE argenmap.areas_de_ciencia_y_educacion OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_ciencia_y_educacion TO readonly;
ALTER TABLE argenmap.areas_de_recreacion OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_recreacion TO readonly;
ALTER TABLE argenmap.areas_de_transporte_aereo OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_transporte_aereo TO readonly;
ALTER TABLE argenmap.areas_de_extraccion OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_extraccion TO readonly;
ALTER TABLE argenmap.salud OWNER TO admins;
GRANT SELECT ON TABLE argenmap.salud TO readonly;