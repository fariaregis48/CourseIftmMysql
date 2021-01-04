delimiter // 
create procedure pri_taxa_con (referencia int) 
begin 
declare @id int;
declare @taxa decimal(9, 2);
declare cur_taxa_con cursor for
select
select
  c.id,
  cv.valor_taxa
from
  condominio c
  inner join categoria_valor cv on cv.id = c.id_categoria_valor
  left join mensalidade m on m.condominio_id = c.id;
open cur_taxa_con;
read_loop :loop fetch cur_taxa_con into @id,
  @taxa;
if (@taxa > 0) then
insert into
  mensalidade (condominio_id, valor_taxa, mes_referencia)
values
  (@id, @taxa, @referencia)
where
  c.id = @id;
end if;
end loop;
close cur_taxa_con;
end // 
delimiter;

#cursor para inserir taxas mensais 
create procedure pri_taxa_con(var_referencia int) 
  begin 
  declare var_id int;
  declare var_taxa decimal(9, 2);
  declare cur_taxa_con cursor for
  select  
    c.id,
    cv.valor_taxa
  from
    condominio c
    inner join categoria_valor cv on cv.id = c.id_categoria_valor
    left join mensalidade m on m.condominio_id = c.id;
  open cur_taxa_con;
  read_loop: loop 
  fetch cur_taxa_con into var_id, var_taxa;
  if (var_referencia >0 && var_taxa > 0) then
  insert into
    mensalidade (condominio_id, valor_taxa, mes_referencia)
  values
    (var_id, var_taxa, var_referencia);
  end if;
  end loop;
  close cur_taxa_con;
end ; 

#listando condominios com taxas ja inseridas 
create procedure prc_lista_condominio () 
begin 
  select c.id, c.nome,cv.valor_taxa,m.data_lancamento from mensalidade m 
  inner join condominio c on m.condominio_id = c.id 
  inner join categoria_valor cv on cv.id = c.id_categoria_valor;
end 

call prc_lista_condominio ();