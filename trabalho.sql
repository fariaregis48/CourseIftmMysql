create database procedimentos;
use procedimentos;

 create table categoria_valor 
 (
    id int primary key AUTO_INCREMENT,
    valor_taxa decimal(9,2),
    ultima_atualizacao date default(curDate())
  );
  
  insert into categoria_valor (valor_taxa) values (190);
  insert into categoria_valor (valor_taxa) values (260);
  insert into categoria_valor (valor_taxa) values (750);
  insert into categoria_valor (valor_taxa) values (1200);
  insert into categoria_valor (valor_taxa) values (1450);
  insert into categoria_valor (valor_taxa) values (1980);
  


create table condominio (
 id int primary key AUTO_INCREMENT,
 nome varchar(100) not null ,
 id_categoria_valor int default 0, 
 cadastro date default (curDate()),
 contatos json 

);
   

insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Rossi',
   
   '{"sindico":"Carlos","Subsindico":"Vanessa","contador":"cleimar"}',3) ;
   
insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Uptwon',
   
   '{"sindico":"kaud","Subsindico":"valeria","contador":"cleimar"}',1) ;
   
insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Alfavile',
   
   '{"sindico":"Jose","Subsindico":"Renato","contador":"cleimar"}',2) ;
   
insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Barcelona',
   
   '{"sindico":"Paulo","Subsindico":"Vanusa","contador":"cleimar"}',4) ;
   
insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Ipe',
   
   '{"sindico":"Antonio","Subsindico":"Cleuber","contador":"cleimar"}',3) ;

insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Uba',
   
   '{"sindico":"Jessica","Subsindico":"Karla","contador":"cleimar"}',2) ;
   
insert into condominio (nome, contatos,id_categoria_valor) values 
  ('Madri',
   
   '{"sindico":"Augusto","Subsindico":"Ricardo","contador":"cleimar"}',2) ;
   
  
Create table  mensalidade (
  protocolo int primary key AUTO_INCREMENT,
  condominio_id int , 
  valor_taxa decimal(9,2) default 0, 
  mes_refencia int ,
  data_lancamento date default(curDate())
                          );
  
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

