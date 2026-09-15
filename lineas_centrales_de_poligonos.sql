-- Funciona?
DROP TABLE IF EXISTS argenmap.etiquetas_areas_de_aguas;

SELECT 
    gid, 
    fna, 
    try_st_centralaxis(ST_MakeValid(geom), 100) AS geom 
INTO argenmap.etiquetas_areas_de_aguas
FROM argenmap.areas_de_aguas_fusionadas;

CREATE INDEX gix_etiquetas_areas_de_aguas_geom 
ON argenmap.etiquetas_areas_de_aguas 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.etiquetas_areas_de_aguas 
USING gix_etiquetas_areas_de_aguas_geom;
ANALYZE argenmap.etiquetas_areas_de_aguas;

SELECT Populate_Geometry_Columns('argenmap.etiquetas_areas_de_aguas'::regclass::oid);

ALTER TABLE argenmap.etiquetas_areas_de_aguas OWNER TO admins;
GRANT SELECT ON TABLE argenmap.etiquetas_areas_de_aguas TO readonly;

SELECT * FROM argenmap.etiquetas_areas_de_aguas;

-- Generar líneas internas

DROP TABLE IF EXISTS argenmap.lineas_internas_areas_de_aguas;

SELECT 
    gid, 
    fna, 
    --ST_Simplify(ST_StraightSkeleton(ST_MakeValid(geom)), 10) AS geom -- genera muchas más líneas
    ST_ApproximateMedialAxis(ST_MakeValid(geom))  AS geom -- puede tardar más pero el resultado final es más simple
INTO argenmap.lineas_internas_areas_de_aguas
FROM argenmap.areas_de_aguas_fusionadas
WHERE fna = 'Lago Traful';

CREATE INDEX gix_lineas_internas_areas_de_aguas_geom 
ON argenmap.lineas_internas_areas_de_aguas 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.lineas_internas_areas_de_aguas 
USING gix_lineas_internas_areas_de_aguas_geom;
ANALYZE argenmap.lineas_internas_areas_de_aguas;

SELECT Populate_Geometry_Columns('argenmap.lineas_internas_areas_de_aguas'::regclass::oid);

ALTER TABLE argenmap.lineas_internas_areas_de_aguas OWNER TO admins;
GRANT SELECT ON TABLE argenmap.lineas_internas_areas_de_aguas TO readonly;

--SELECT * FROM argenmap.lineas_internas_areas_de_aguas;

-- Centroides de lagos

SELECT gid, ST_PointOnSurface(geom) as geom
INTO argenmap.centroides_etiquetas_areas_de_aguas
FROM argenmap.areas_de_aguas_fusionadas;



-- Dejar sólo línea central
DROP TABLE IF EXISTS argenmap.etiquetas_areas_de_aguas;
SELECT 
    gid, 
    fna, 
    geom
INTO argenmap.etiquetas_areas_de_aguas
FROM argenmap.lineas_internas_areas_de_aguas 
WHERE ST_Intersects(geom, (
    SELECT ST_PointOnSurface(geom) 
    FROM argenmap.areas_de_aguas_fusionadas 
    WHERE gid = argenmap.lineas_internas_areas_de_aguas.gid
    --AND fna = 'Lago Traful'
));

CREATE INDEX gix_etiquetas_areas_de_aguas_geom 
ON argenmap.etiquetas_areas_de_aguas 
USING gist(geom) TABLESPACE pg_default;

CLUSTER argenmap.etiquetas_areas_de_aguas 
USING gix_etiquetas_areas_de_aguas_geom;
ANALYZE argenmap.etiquetas_areas_de_aguas;

SELECT Populate_Geometry_Columns('argenmap.etiquetas_areas_de_aguas'::regclass::oid);

ALTER TABLE argenmap.etiquetas_areas_de_aguas OWNER TO admins;
GRANT SELECT ON TABLE argenmap.etiquetas_areas_de_aguas TO readonly;

SELECT * FROM argenmap.etiquetas_areas_de_aguas;