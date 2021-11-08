CREATE OR REPLACE VIEW nomenclador.v_habitat_infraestructura AS
SELECT 2 AS clase,
					'Hábitat e infraestructura social'::text AS clase_desc,
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
					   FROM cultura_y_religion
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
					   FROM economia_y_comercio
	 UNION 
	SELECT 				gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna::varchar,
						gna,
						nam::varchar,
						sag::varchar
					   FROM v_asentamientos_humanos_ign
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
					   FROM puntos_de_ciencia_y_educacion
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
					   FROM puntos_de_equipamiento
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
					   FROM puntos_de_recreacion
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
					   FROM salud
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
					   FROM areas_de_asentamientos_y_edificios
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
					   FROM areas_de_ciencia_y_educacion
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
					   FROM areas_de_equipamiento
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
					   FROM areas_de_recreacion
) as tbl
WHERE ST_Within(geom, ST_MakeEnvelope(-180, -90, 180, 90, 4326)::geometry) = true;