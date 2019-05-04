DROP TABLE IF EXISTS public.osm_vial CASCADE;
CREATE TABLE public.osm_vial AS
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
  wkb_geometry AS geom
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
GRANT
SELECT
  ON TABLE public.osm_vial TO readonly;
GRANT ALL ON TABLE public.osm_vial TO admins;
ALTER TABLE
  public.osm_vial
ADD
  CONSTRAINT osm_vial_osm_id_pk PRIMARY KEY (osm_id);