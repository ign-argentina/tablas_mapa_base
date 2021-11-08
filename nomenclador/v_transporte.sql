CREATE OR REPLACE VIEW nomenclador.v_transporte AS
SELECT 6 AS clase,
					'Transporte'::text AS clase_desc,
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
					   FROM controles
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
					   FROM infraestructura_de_transporte
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
					   FROM lineas_de_cruces_y_enlaces
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
					   FROM lineas_de_transporte_ferroviario
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
					   FROM puntos_de_cruces_y_enlaces
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
					   FROM puntos_de_transporte_aereo
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
					   FROM puntos_de_transporte_ferroviario
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
					   FROM puntos_de_transporte_fluvial_lacustre_y_maritimo
	 UNION 
	SELECT gid,
						entidad,
						objeto,
						geom,
						centroide,
						fna1::varchar as fna,
						gna1 as gna,
						nam1::varchar as nam,
						sag::varchar
					   FROM vial*
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
					   FROM areas_de_transporte_aereo
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
					   FROM areas_de_transporte_ferroviario
) as tbl;