CREATE VIEW public.v_asentamientos_humanos AS
-- Solo localidades simples que no sean compuestas ni entidades ni cabecera
select *
from public.puntos_de_asentamientos_y_edificios
where ba1 not in ('-1', '-2') and ahb in (1) and
substring(ba1 for 8) NOT IN (
select substring(ba1 for 8)
from public.puntos_de_asentamientos_y_edificios
where (ca1 in (1,2,3) and entidad in (3,8,9,10)) OR (ba1 not in ('-1', '-2') and ahb in (3,4))
)

UNION

-- Solo localidades compuestas que no sean entidades ni cabecera
select *
from public.puntos_de_asentamientos_y_edificios
where ba1 not in ('-1', '-2') and ahb in (3) and
substring(ba1 for 8) NOT IN (
select substring(ba1 for 8)
from public.puntos_de_asentamientos_y_edificios
where (ca1 in (1,2,3) and entidad in (3,8,9,10)) OR (ba1 not in ('-1', '-2') and ahb in (4))
)

UNION

-- Solo entidades que no son cabecera
select *
from public.puntos_de_asentamientos_y_edificios
where ba1 not in ('-1', '-2') and ahb in (4) and
CONCAT(substring(ba1 for 8),fna) NOT IN (
select CONCAT(substring(ba1 for 8),fna) 
from public.puntos_de_asentamientos_y_edificios
where ca1 in (1,2,3) and entidad in (3,8,9,10)
)

UNION

-- Solo cabeceras
select *
from public.puntos_de_asentamientos_y_edificios
where ca1 in (1,2,3) and entidad in (3,8,9,10)


UNION

-- Solo parajes y bases antarticas
select *
from public.puntos_de_asentamientos_y_edificios
where ahb in (5,6)
