  /**
Esta consulta utiliza tablas del IGN necesarias para el mapa base 
(previamente importadas en la base) y crea nuevas tablas en otro esquema 
con menos campos, además transforma las geometrías a Web Mercator (EPSG:3857)
para mejorar el rendimiento del renderizado de teselas.
**/

-- Convertir ne_10m_bathymetry_a_10000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_a_10000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_a_10000
FROM
  externos.ne_10m_bathymetry_a_10000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_a_10000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_a_10000_geom ON argenmap.ne_10m_bathymetry_a_10000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_a_10000 USING gix_ne_10m_bathymetry_a_10000_geom;
ANALYZE argenmap.ne_10m_bathymetry_a_10000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_a_10000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_a_10000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_a_10000 TO readonly;

-- Fin ne_10m_bathymetry_a_10000

-- Convertir ne_10m_bathymetry_b_9000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_b_9000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_b_9000
FROM
  externos.ne_10m_bathymetry_b_9000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_b_9000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_b_9000_geom ON argenmap.ne_10m_bathymetry_b_9000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_b_9000 USING gix_ne_10m_bathymetry_b_9000_geom;
ANALYZE argenmap.ne_10m_bathymetry_b_9000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_b_9000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_b_9000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_b_9000 TO readonly;

-- Fin ne_10m_bathymetry_b_9000

-- Convertir ne_10m_bathymetry_c_8000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_c_8000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_c_8000
FROM
  externos.ne_10m_bathymetry_c_8000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_c_8000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_c_8000_geom ON argenmap.ne_10m_bathymetry_c_8000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_c_8000 USING gix_ne_10m_bathymetry_c_8000_geom;
ANALYZE argenmap.ne_10m_bathymetry_c_8000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_c_8000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_c_8000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_c_8000 TO readonly;

-- Fin ne_10m_bathymetry_c_8000

-- Convertir ne_10m_bathymetry_d_7000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_d_7000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_d_7000
FROM
  externos.ne_10m_bathymetry_d_7000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_d_7000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_d_7000_geom ON argenmap.ne_10m_bathymetry_d_7000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_d_7000 USING gix_ne_10m_bathymetry_d_7000_geom;
ANALYZE argenmap.ne_10m_bathymetry_d_7000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_d_7000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_d_7000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_d_7000 TO readonly;

-- Fin ne_10m_bathymetry_d_7000

-- Convertir ne_10m_bathymetry_e_6000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_e_6000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_e_6000
FROM
  externos.ne_10m_bathymetry_e_6000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_e_6000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_e_6000_geom ON argenmap.ne_10m_bathymetry_e_6000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_e_6000 USING gix_ne_10m_bathymetry_e_6000_geom;
ANALYZE argenmap.ne_10m_bathymetry_e_6000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_e_6000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_e_6000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_e_6000 TO readonly;

-- Fin ne_10m_bathymetry_e_6000

-- Convertir ne_10m_bathymetry_f_5000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_f_5000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        geom,
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_f_5000
FROM
  externos.ne_10m_bathymetry_f_5000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_f_5000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_f_5000_geom ON argenmap.ne_10m_bathymetry_f_5000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_f_5000 USING gix_ne_10m_bathymetry_f_5000_geom;
ANALYZE argenmap.ne_10m_bathymetry_f_5000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_f_5000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_f_5000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_f_5000 TO readonly;

-- Fin ne_10m_bathymetry_f_5000

-- Convertir ne_10m_bathymetry_g_4000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_g_4000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        geom,
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_g_4000
FROM
  externos.ne_10m_bathymetry_g_4000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_g_4000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_g_4000_geom ON argenmap.ne_10m_bathymetry_g_4000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_g_4000 USING gix_ne_10m_bathymetry_g_4000_geom;
ANALYZE argenmap.ne_10m_bathymetry_g_4000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_g_4000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_g_4000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_g_4000 TO readonly;

-- Fin ne_10m_bathymetry_g_4000

-- Convertir ne_10m_bathymetry_h_3000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_h_3000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_h_3000
FROM
  externos.ne_10m_bathymetry_h_3000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_h_3000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_h_3000_geom ON argenmap.ne_10m_bathymetry_h_3000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_h_3000 USING gix_ne_10m_bathymetry_h_3000_geom;
ANALYZE argenmap.ne_10m_bathymetry_h_3000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_h_3000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_h_3000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_h_3000 TO readonly;

-- Fin ne_10m_bathymetry_h_3000

-- Convertir ne_10m_bathymetry_i_2000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_i_2000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        geom,
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_i_2000
FROM
  externos.ne_10m_bathymetry_i_2000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_i_2000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_i_2000_geom ON argenmap.ne_10m_bathymetry_i_2000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_i_2000 USING gix_ne_10m_bathymetry_i_2000_geom;
ANALYZE argenmap.ne_10m_bathymetry_i_2000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_i_2000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_i_2000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_i_2000 TO readonly;

-- Fin ne_10m_bathymetry_i_2000

-- Convertir ne_10m_bathymetry_j_1000

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_j_1000;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_j_1000
FROM
  externos.ne_10m_bathymetry_j_1000;
ALTER TABLE
  argenmap.ne_10m_bathymetry_j_1000
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_j_1000_geom ON argenmap.ne_10m_bathymetry_j_1000 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_j_1000 USING gix_ne_10m_bathymetry_j_1000_geom;
ANALYZE argenmap.ne_10m_bathymetry_j_1000;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_j_1000' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_j_1000 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_j_1000 TO readonly;

-- Fin ne_10m_bathymetry_j_1000

-- Convertir ne_10m_bathymetry_k_200

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_k_200;
SELECT
  gid,
  featurecla,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        ST_Intersection(
          geom,
          ST_MakeEnvelope(-180, -89, 180, 90, 4326) :: geometry
        ),
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_k_200
FROM
  externos.ne_10m_bathymetry_k_200;
ALTER TABLE
  argenmap.ne_10m_bathymetry_k_200
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_k_200_geom ON argenmap.ne_10m_bathymetry_k_200 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_k_200 USING gix_ne_10m_bathymetry_k_200_geom;
ANALYZE argenmap.ne_10m_bathymetry_k_200;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_k_200' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_k_200 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_k_200 TO readonly;

-- Fin ne_10m_bathymetry_k_200

-- Convertir ne_10m_bathymetry_l_0

DROP TABLE IF EXISTS argenmap.ne_10m_bathymetry_l_0;
SELECT
  gid,
  depth,
  ST_Multi(
    ST_SetSRID(
      ST_Transform(
        geom,
        3857
      ),
      3857
    )
  ) as geom INTO TABLE argenmap.ne_10m_bathymetry_l_0
FROM
  externos.ne_10m_bathymetry_l_0;
ALTER TABLE
  argenmap.ne_10m_bathymetry_l_0
ADD
  PRIMARY KEY (gid);
CREATE INDEX gix_ne_10m_bathymetry_l_0_geom ON argenmap.ne_10m_bathymetry_l_0 USING gist(geom) TABLESPACE pg_default;
CLUSTER argenmap.ne_10m_bathymetry_l_0 USING gix_ne_10m_bathymetry_l_0_geom;
ANALYZE argenmap.ne_10m_bathymetry_l_0;
SELECT
  Populate_Geometry_Columns('argenmap.ne_10m_bathymetry_l_0' :: regclass :: oid);
ALTER TABLE
  argenmap.ne_10m_bathymetry_l_0 OWNER to admins;
GRANT
SELECT
  ON TABLE argenmap.ne_10m_bathymetry_l_0 TO readonly;

-- Fin ne_10m_bathymetry_l_0
