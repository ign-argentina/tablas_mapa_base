DROP TABLE IF EXISTS argenmap.osm_plazas CASCADE;
CREATE TABLE argenmap.osm_plazas AS
SELECT
  --nextval('osm.multipolygons_ogc_fid_seq'::regclass) as ogc_fid PRIMARY,
  --osm_id,
  name,
  leisure,
  other_tags -> 'alt_name' AS alt_name,
  other_tags -> 'short_name' AS short_name,
  wkb_geometry AS geom
FROM
  osm.multipolygons
WHERE
  leisure = 'park';
GRANT
SELECT
  ON TABLE argenmap.osm_plazas TO readonly;
GRANT ALL ON TABLE argenmap.osm_plazas TO admins;

-- Consulta de conversión a Web Mercator

-- DROP TABLE IF EXISTS argenmap.osm_plazas;
-- SELECT
--   gid,
--   ST_SetSRID(ST_Transform(geom, 3857),3857) AS geom, 
--   name INTO TABLE argenmap.osm_plazas
-- FROM
--   public.osm_plazas;

-- ALTER TABLE argenmap.osm_plazas 
-- ADD PRIMARY KEY (gid);

-- CREATE INDEX gix_osm_plazas_geom 
-- ON argenmap.osm_plazas 
-- USING gist(geom) TABLESPACE pg_default;

-- CLUSTER argenmap.osm_plazas 
-- USING gix_osm_plazas_geom;
-- ANALYZE argenmap.osm_plazas;

-- SELECT Populate_Geometry_Columns('argenmap.osm_plazas'::regclass::oid);

-- ALTER TABLE argenmap.osm_plazas
--     OWNER to admins;

-- GRANT SELECT ON TABLE argenmap.osm_plazas TO readonly;