DROP TABLE IF EXISTS argenmap.areas_de_aguas_sin_agujeros;

CREATE TABLE argenmap.areas_de_aguas_sin_agujeros (
  gid SERIAL PRIMARY KEY,
  fna TEXT,
  entidad BIGINT,
  geom geometry(Polygon, 3857)
);

INSERT INTO argenmap.areas_de_aguas_sin_agujeros (fna, entidad, geom)
SELECT
    fna,
    entidad, 
    ST_MakePolygon(ST_ExteriorRing((ST_Dump(geom)).geom))  AS geom
FROM argenmap.areas_de_aguas_continentales
WHERE NOT ST_IsEmpty(geom)
AND fna IS NOT NULL
AND entidad > 1;

CREATE INDEX gix_areas_de_aguas_sin_agujeros_geom 
ON argenmap.areas_de_aguas_sin_agujeros 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_aguas_sin_agujeros 
USING gix_areas_de_aguas_sin_agujeros_geom;
ANALYZE argenmap.areas_de_aguas_sin_agujeros;

SELECT Populate_Geometry_Columns('argenmap.areas_de_aguas_sin_agujeros'::regclass::oid);

ALTER TABLE argenmap.areas_de_aguas_sin_agujeros OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_aguas_sin_agujeros TO readonly;

-- Fusionar

DROP TABLE IF EXISTS argenmap.areas_de_aguas_fusionadas;
CREATE TABLE argenmap.areas_de_aguas_fusionadas (
  gid SERIAL PRIMARY KEY,
  fna TEXT,
  entidad BIGINT,
  geom geometry(MultiPolygon, 3857)
);

INSERT INTO argenmap.areas_de_aguas_fusionadas (fna, entidad, geom)
SELECT 
  fna, 
  entidad, 
  ST_SetSRID(ST_Multi(ST_Union(ST_MakeValid(ST_SnapToGrid(geom, 0.0001)))), 3857) AS geom 
FROM argenmap.areas_de_aguas_sin_agujeros
GROUP BY fna, entidad;

CREATE INDEX gix_areas_de_aguas_fusionadas_geom 
ON argenmap.areas_de_aguas_fusionadas 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.areas_de_aguas_fusionadas 
USING gix_areas_de_aguas_fusionadas_geom;
ANALYZE argenmap.areas_de_aguas_fusionadas;

SELECT Populate_Geometry_Columns('argenmap.areas_de_aguas_fusionadas'::regclass::oid);

ALTER TABLE argenmap.areas_de_aguas_fusionadas OWNER TO admins;
GRANT SELECT ON TABLE argenmap.areas_de_aguas_fusionadas TO readonly;
