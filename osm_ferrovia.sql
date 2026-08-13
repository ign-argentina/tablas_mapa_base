-- Vías de ferrocarril, subte y otros
DROP TABLE IF EXISTS argenmap.osm_ferrovia CASCADE;
CREATE TABLE argenmap.osm_ferrovia AS
SELECT
  osm_id,
  name,
  railway,
  other_tags -> 'alt_name' AS alt_name,
  other_tags -> 'short_name' AS short_name,
  other_tags -> 'ref' AS ref,
  other_tags -> 'access' AS access,
  other_tags -> 'bridge' AS bridge,
  other_tags -> 'tunnel' AS tunnel,
  other_tags -> 'service' AS service,
  CASE 
    WHEN other_tags -> 'layer' IS NOT NULL THEN (
      SELECT 
        CASE 
          WHEN MIN(CAST(val AS INT)) < 0 THEN 
            MIN(CAST(val AS INT)) -- Mayor absoluto en negativos
          ELSE 
            MAX(CAST(val AS INT)) -- Mayor en positivos
        END
      FROM unnest(string_to_array(other_tags -> 'layer', ';')) AS val
    )
  END AS layer,
  ST_SetSRID(ST_Transform(wkb_geometry, 3857),3857) AS geom
FROM
  osm.lines
WHERE
  railway IS NOT NULL;

ALTER TABLE argenmap.osm_ferrovia
ADD PRIMARY KEY (osm_id);

CREATE INDEX gix_osm_ferrovia_geom 
ON argenmap.osm_ferrovia 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.osm_ferrovia 
USING gix_osm_ferrovia_geom;
ANALYZE argenmap.osm_ferrovia;

SELECT Populate_Geometry_Columns('argenmap.osm_ferrovia'::regclass::oid);

ALTER TABLE argenmap.osm_ferrovia
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.osm_ferrovia TO readonly;

-- Estaciones

DROP TABLE IF EXISTS argenmap.osm_estaciones CASCADE;
CREATE TABLE argenmap.osm_estaciones AS
SELECT
  osm_id,
  name,
  other_tags -> 'railway' AS railway,
  other_tags -> 'alt_name' AS alt_name,
  other_tags -> 'short_name' AS short_name,
  other_tags -> 'station' AS station,
  other_tags -> 'ref' AS ref,
  ST_SetSRID(ST_Transform(wkb_geometry, 3857),3857) AS geom
FROM
  osm.points
WHERE
  other_tags -> 'railway' IS NOT NULL;

ALTER TABLE argenmap.osm_estaciones
ADD PRIMARY KEY (osm_id);

CREATE INDEX gix_osm_estaciones_geom 
ON argenmap.osm_estaciones 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.osm_estaciones 
USING gix_osm_estaciones_geom;
ANALYZE argenmap.osm_estaciones;

SELECT Populate_Geometry_Columns('argenmap.osm_estaciones'::regclass::oid);

ALTER TABLE argenmap.osm_estaciones
    OWNER to admins;

GRANT SELECT ON TABLE argenmap.osm_estaciones TO readonly;
