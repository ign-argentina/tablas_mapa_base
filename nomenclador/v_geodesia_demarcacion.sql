CREATE OR REPLACE VIEW nomenclador.v_geodesia_demarcacion AS
SELECT 1 AS clase,
					'Geodesia y demarcación'::text AS clase_desc,
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
					   FROM linea_de_limite
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
					   FROM municipio
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
					   FROM provincia
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
					   FROM pais
) as tbl;