
CREATE OR REPLACE VIEW nomenclador.v_geodesia_demarcacion AS
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					fna::varchar,
					gna,
					nam::varchar,
					sag::varchar
				   FROM linea_de_limite
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					fna::varchar,
					gna,
					nam::varchar,
					sag::varchar
				   FROM pais
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					fna::varchar,
					gna,
					nam::varchar,
					sag::varchar
				   FROM provincia
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					fna::varchar,
					gna,
					nam::varchar,
					sag::varchar
				   FROM departamento
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					fna::varchar,
					gna,
					nam::varchar,
					sag::varchar
				   FROM municipio
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					fna::varchar,
					gna,
					nam::varchar,
					sag::varchar
				   FROM mar_territorial_argentino
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					'Plataforma Continental' as fna,
					'' as gna,
					'' as nam,
					sag::varchar
				   FROM plataforma_continental
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					'Zona Contigua Argentina' as fna,
					'' as gna,
					'' as nam,
					sag::varchar
				   FROM zona_contigua_argentina
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					'Zona de Frontera' as fna,
					'' as gna,
					'' as nam,
					sag::varchar
				   FROM zona_de_frontera
				         INNER JOIN nomenclador.clase ON (clase.id = 1)
 UNION 
SELECT 1 AS clase,
					clase.nombre AS clase_desc,
					gid,
					entidad,
					objeto,
					geom,
					centroide,
					'Zona Económica Exclusiva Argentina' as fna,
					'' as gna,
					'' as nam,
					sag::varchar
				   FROM zona_economica_exclusiva_argentina
				         INNER JOIN nomenclador.clase ON (clase.id = 1);
GRANT ALL ON TABLE nomenclador.v_geodesia_demarcacion TO admins;
GRANT ALL ON TABLE nomenclador.v_geodesia_demarcacion TO readonly;
