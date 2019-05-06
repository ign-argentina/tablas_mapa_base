DROP TABLE IF EXISTS argenmap.osm_vial CASCADE;
CREATE TABLE argenmap.osm_vial AS
SELECT
  osm_id,
  name,
  highway,
  other_tags -> 'alt_name' AS alt_name,
  other_tags -> 'short_name' AS short_name,
  other_tags -> 'ref' AS ref,
  (
    CASE
      WHEN other_tags :: hstore -> 'ref' IS NULL THEN NULL
      WHEN other_tags :: hstore -> 'ref' LIKE '%;%' THEN NULL
      WHEN other_tags :: hstore -> 'ref' LIKE '%-%' THEN NULLIF(
        regexp_replace(
          LEFT(
            other_tags :: hstore -> 'ref',
            STRPOS(other_tags :: hstore -> 'ref', '-') - 1
          ),
          '\D',
          '',
          'g'
        ),
        ''
      )
      ELSE NULLIF(
        regexp_replace(other_tags :: hstore -> 'ref', '\D', '', 'g'),
        ''
      )
    END
  ) :: numeric AS num_ref,
  other_tags -> 'access' AS access,
  other_tags -> 'bridge' AS bridge,
  other_tags -> 'tunnel' AS tunnel,
  other_tags -> 'layer' AS layer,
  other_tags -> 'maxspeed' AS maxspeed,
  -- other_tags -> 'lanes' AS lanes,
  -- other_tags -> 'surface' AS surface,
  -- other_tags -> 'smoothness' AS smoothness,
  ST_SetSRID(ST_Transform(wkb_geometry, 3857),3857) AS geom
FROM
  osm.lines
WHERE
  highway IN (
    'unclassified',
    'motorway',
    'raceway',
    'tertiary_link',
    'motorway_link',
    'pedestrian',
    'secondary_link',
    'primary_link',
    'service',
    'trunk_link',
    'living_street',
    'residential',
    'construction',
    'secondary',
    'primary',
    'track',
    'tertiary',
    'trunk'
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
