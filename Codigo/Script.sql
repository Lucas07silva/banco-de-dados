create database supermercado;
create table client (
id int not null,
nome varchar(50) not null,
cpf varchar(11) not null,
constraint pk_id_cliente primary key (id)
);

create table produto(
id int not null,
descricao varchar(100) not null,
cod_barras varchar(10),
valor decimal(16,2)
);

alter table produto add constraint pk_id_produto primary key (id);

alter table produto add column situacao boolean not null;;

alter table produto alter column  descricao type varchar(200);

insert into produto (id, descricao, cod_barras, valor, situacao)
values (3, 'cafe', '12345678', 10.20, true );


insert into client  (id, nome, cpf)
values (1, 'luquinhas', '12345678901' );


update produto set descricao = 'nescal' where id = 2;


delete from produto;

insert into produto (id, descricao, cod_barras, valor, situacao)
values (1, 'arroz', '12345678', 10.20, true );

insert into produto (id, descricao, cod_barras, valor, situacao)
values (2, 'cafe', '12345678', 10.20, true );

insert into produto (id, descricao, cod_barras, valor, situacao)
values (3, 'macarrao', '12345678', 10.20, true );

select * from produto;

select prod.id, prod.descricao from produto as prod order by id desc;