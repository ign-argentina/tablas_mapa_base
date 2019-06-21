CREATE OR REPLACE VIEW nomenclador.v_relieve_suelo AS
SELECT 5 AS clase,
					'Relieve y suelo'::text AS clase_desc,
					*
FROM 
(
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM lineas_de_geomorfologia
	 UNION 
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM lineas_de_glaciologia
	 UNION 
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM puntos_de_geomorfologia
	 UNION 
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM puntos_de_glaciologia
	 UNION 
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM areas_de_geomorfologia
	 UNION 
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM areas_de_glaciologia
) as tbl;