UPDATE osm.multipolygons
SET name = NULL
WHERE
	name IS NOT NULL
AND
    ST_Intersects(
      ST_MakeEnvelope(-55.569620, -50.408518, -63.156454,-53.416080, 4326), 
      wkb_geometry
    );

DROP TABLE IF EXISTS argenmap.osm_plazas CASCADE;
CREATE TABLE argenmap.osm_plazas AS
SELECT
  name,
  leisure,
  landuse,
  other_tags -> 'alt_name' AS alt_name,
  other_tags -> 'short_name' AS short_name,
  ST_SetSRID(ST_Transform(wkb_geometry, 3857),3857) AS geom
FROM
  osm.multipolygons
WHERE
  leisure IN ('park', 'pitch', 'garden', 'sports_centre', 'track', 'nature_reserve', 'stadium', 'golf_course')
OR 
  landuse IN ('grass', 'cemetery', 'recreation_ground', 'forest', 'meadow', 'orchard', 'farmyard');
GRANT
SELECT
  ON TABLE argenmap.osm_plazas TO readonly;

ALTER TABLE argenmap.osm_plazas
OWNER to admins;
--GRANT ALL ON TABLE argenmap.osm_plazas TO admins;

ALTER TABLE argenmap.osm_plazas 
ADD COLUMN gid SERIAL;

ALTER TABLE argenmap.osm_plazas 
ADD PRIMARY KEY(gid);

CREATE INDEX gix_osm_plazas_geom 
ON argenmap.osm_plazas 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.osm_plazas 
USING gix_osm_plazas_geom;
ANALYZE argenmap.osm_plazas;

SELECT Populate_Geometry_Columns('argenmap.osm_plazas'::regclass::oid);
