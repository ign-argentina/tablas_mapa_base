CREATE VIEW public.v_asentamientos_humanos_ign AS
select * from public.v_asentamientos_humanos
UNION
select * from public.puntos_de_asentamientos_y_edificios where gid not in (select gid from aplicaciones.v_asentamientos_humanos) and ba1 in ('-1', '-2')
