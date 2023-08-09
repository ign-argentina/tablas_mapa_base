UPDATE osm.lines
SET name = NULL
WHERE
	highway IS NOT NULL
AND
	name IS NOT NULL
AND
    ST_Intersects(
      ST_MakeEnvelope(-55.569620, -50.408518, -63.156454,-53.416080, 4326), 
      wkb_geometry
    );

DROP TABLE IF EXISTS argenmap.osm_vial CASCADE;
CREATE TABLE argenmap.osm_vial AS
SELECT
  osm_id,
  name,
  highway,
  other_tags -> 'alt_name' AS alt_name,
  other_tags -> 'short_name' AS short_name,
  other_tags -> 'ref' AS ref,
  CASE 
		WHEN other_tags :: hstore -> 'ref' NOT LIKE '%;%' 
		THEN replace(TRIM(regexp_replace((other_tags :: hstore -> 'ref'), '(RP)|(RN)', '', 'g')), ' ', '-')
  END AS num_ref,
  other_tags -> 'oneway' AS oneway,
  other_tags -> 'access' AS access,
  other_tags -> 'bridge' AS bridge,
  other_tags -> 'tunnel' AS tunnel,
  CAST(other_tags -> 'layer' AS INT) AS layer,
  other_tags -> 'maxspeed' AS maxspeed,
  --CAST(other_tags -> 'maxspeed' AS INT) AS maxspeed,
  CAST(other_tags -> 'lanes' AS INT) AS lanes,
  other_tags -> 'surface' AS surface,
  other_tags -> 'embankment' AS embankment,
  other_tags -> 'smoothness' AS smoothness,
  ST_SetSRID(ST_Transform(wkb_geometry, 3857),3857) AS geom
FROM
  osm.lines
WHERE
  highway IN (
    'motorway',
    'trunk',
    'primary',
    'secondary',
    'tertiary',
    'unclassified',
    'residential',
    'road',
    'pedestrian',
    'track',
    'living_street',
    'motorway_link',
    'trunk_link',
    'primary_link',
    'secondary_link',
    'tertiary_link',
    'service',
    'construction',
    'raceway',
    'path',
    'footway',
    'steps'
  );

ALTER TABLE argenmap.osm_vial
ADD PRIMARY KEY (osm_id);

CREATE INDEX gix_osm_vial_geom 
ON argenmap.osm_vial 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.osm_vial 
USING gix_osm_vial_geom;
ANALYZE argenmap.osm_vial;

SELECT Populate_Geometry_Columns('argenmap.osm_vial'::regclass::oid);

ALTER TABLE argenmap.osm_vial
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.osm_vial TO readonly;
