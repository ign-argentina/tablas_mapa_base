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
