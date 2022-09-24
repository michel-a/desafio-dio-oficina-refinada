show databases;

-- criação do banco de dados para o cenário da oficina
create database oficina;
use oficina;

-- criar tabela OS
create table os (
	numeroOS int auto_increment primary key,
    data_emissao date not null,
    valor_total float not null,
    status enum('Em avaliação', 'Em manutenção', 'Entregue') not null default 'Em avaliação',
    data_entrega date not null
);
alter table os auto_increment = 1;

-- criar tabela Peças
create table pecas (
	idPecas int auto_increment primary key,
    nome_peca varchar(45) not null,
    valor_peca float not null
);
alter table pecas auto_increment = 1;

-- criar tabela Peças OS
create table pecas_os (
	pecas_idPecas int,
    os_numeroOs int,
    primary key (pecas_idPecas, os_numeroOs),
    constraint fk_pecas_os_id_pecas foreign key (pecas_idPecas) references pecas(idPecas),
    constraint fk_pecas_os_numero_os foreign key (os_numeroOs)  references os(numeroOs)
);

-- criar tabela Cliente
create table cliente (
	idCliente int auto_increment primary key,
    nome_cliente varchar(100) not null,
    autorizacao_servico boolean not null default 0
);
alter table cliente auto_increment = 1;

-- criar tabela Veículo
create table veiculo (
	idVeiculo int auto_increment primary key,
    cliente_id_cliente int,
    nome_veiculo varchar(50) not null,
    modelo varchar(50),
    marca varchar(50),
    constraint fk_veiculo_id_cliente foreign key (cliente_id_cliente) references cliente(idCliente)
);
alter table veiculo auto_increment = 1;

-- criar tabela Mao de Obra
create table mao_de_obra (
	idMao_de_Obra int auto_increment primary key,
    valor_mao_de_obra float not null
);
alter table mao_de_obra auto_increment = 1;

-- criar tabela Serviços
create table servicos (
	idServico int auto_increment primary Key,
    nome_servico varchar(50) not null,
    descricao varchar(255),
    servico_idMao_de_obra int,
    constraint fk_servico_id_mao_de_obra foreign key (servico_idMao_de_obra) references mao_de_obra (idMao_de_Obra)
);
alter table servicos auto_increment = 1;

-- criar tabela Mecânico
create table mecanico (
	codMecanico int auto_increment primary key,
    nome varchar(50) not null,
    idade int,
    endereco varchar(100),
    especialidade varchar(50) not null
);
alter table mecanico auto_increment = 1;

-- criar tabela OS Serviços
create table servicos_com_os (
	servicos_os_numero int,
    servicos_id_servico int,
    constraint fk_servicos_os_numero foreign key (servicos_os_numero) references os (numeroOS),
    constraint fk_servicos_id_servico foreign key (servicos_id_servico) references servicos (idServico)
);

-- criar tabela Equipe Mecânica
create table equipe_mecanica (
	idEquipe_mecanica int auto_increment primary key,
    mecanico_codMecanico int,
    veiculo_idVeiculo int,
    servicos_idServicos int,
    os_numero_os int,
    constraint fk_equipe_mecanico_codMecanico foreign key (mecanico_codMecanico) references mecanico (codMecanico),
    constraint fk_equipe_veiculo_idVeiculo foreign key (veiculo_idVeiculo) references veiculo (idVeiculo),
    constraint fk_equipe_servicos_idservicos foreign key (servicos_idservicos) references servicos (idServico),
    constraint fk_equipe_os_numero_os foreign key (os_numero_os) references os (numeroOS)
);
alter table equipe_mecanica auto_increment = 1;

show tables;

desc os;
insert into os (data_emissao, valor_total, status, data_entrega)
	values ('2022-09-10', 480, 'Em manutenção', '2022-10-07'),
    ('2022-09-11', 790, 'Em manutenção', '2023-01-13'),
    ('2022-09-12', 10, 'Em avaliação', '2022-09-24'),
    ('2022-09-13', 300, 'Em manutenção', '2023-01-09'),
    ('2022-09-14', 700, 'Entregue', '2022-09-23'),
	('2022-09-10', 480, 'Em manutenção', '2022-10-07'),
    ('2022-09-11', 790, 'Em manutenção', '2023-01-13'),
    ('2022-09-14', 700, 'Entregue', '2022-09-23');
desc pecas;
insert into pecas (nome_peca, valor_peca)
	values ('Pneu', 200),
    ('Freios', 400),
    ('Jogo de lanternas', 300),
    ('Velas', 150),
    ('Óleo', 30),
    ('Pastilhas', 210);

desc cliente;
insert into cliente (nome_cliente, autorizacao_servico)
	values ('Alessandra Cavalcante', 0),
    ('Leonora da Silva', 1),
    ('Tadeu dos Santos', 0),
    ('Leandro Gonçalves', 0),
    ('Marcia Zanata', 1),
    ('Romulo Cabrini', 1);

desc pecas_os;
insert into pecas_os (pecas_idPecas, os_numeroOs)
	values (1, 6),
    (2, 7),
    (3, 8),
    (4, 10),
    (5, 9),
    (6, 7),
    (2, 8),
    (3, 9);

desc veiculo;
insert into veiculo (cliente_id_cliente, nome_veiculo, modelo, marca)
	values (1, 'Palio', 'Fire4P', 'Fiat'),
    (2, 'Gol', 'GVI', 'Volkswagen'),
    (3, 'Civic', 'LXS A', 'Honda'),
    (4, 'Corolla', 'GLI', 'Toyota'),
    (5, 'EcoSport', '1.6 SE', 'Ford'),
    (6, 'Duster', 'Dynamique', 'Renault');

desc mao_de_obra;
insert into mao_de_obra (valor_mao_de_obra)
	values (100),
    (200),
    (300),
    (400),
    (500),
    (600),
    (700),
    (800),
    (900),
    (1000);

desc servicos;
insert into servicos (nome_servico, descricao, servico_idMao_de_obra)
	values ('Troca de óleo', 'Limpeza e troca de óleo', 1),
    ('Troca de pneus', 'Troca de pneus gastos', 2),
    ('Retífica de motor', null, 9),
    ('Troca de porta', null, 7);

desc mecanico;
insert into mecanico (nome, idade, endereco, especialidade)
	values ('Francisco da Lua', 37, 'Rua Leopoldo, 211 - Centro', 'Montador'),
    ('Jorge Amado Santoro', 31, 'Rua das Acácias, 12 - Jd. Botânico', 'Reparador'),
    ('Pedro Vás da Luz', 38, 'Rua Savoiy City, 873 - Pq. Savoi City', 'Manutenção preventiva'),
    ('Monteiro Lobato Contâncio', 34, 'Rua do Candelábro, 818 - Centro', 'Reparador'),
    ('Machado de Assis Aguiar', 23, 'Rua do Asfalto Furado - São Mateus', 'Auxiliar');

desc servicos_com_os;
insert into servicos_com_os (servicos_os_numero, servicos_id_servico)
	values (6, 1),
    (7, 2),
    (8, 3),
    (9, 4),
    (10, 3);

desc equipe_mecanica;
insert into equipe_mecanica (mecanico_codMecanico, veiculo_idVeiculo, servicos_idServicos, os_numero_os)
	values (1, 1, 1, 6),
    (2, 2, 2, 7),
    (3, 3, 3, 8),
    (4, 4, 4, 9),
    (5, 5, 2, 10);

-- Recuperações simples com SELECT Statement;
select * from mecanico;

-- Filtros com WHERE Statement;
select * from os where valor_total = 480;

-- Crie expressões para gerar atributos derivados;
select idVeiculo as identificação, concat(nome_veiculo, ' - ', modelo) as carro, marca from veiculo;

-- Defina ordenações dos dados com ORDER BY;
select * from mecanico order by especialidade;

-- Condições de filtros aos grupos – HAVING Statement;
select data_entrega, count(data_entrega) as entrega_proximo_ano from os 
	group by data_entrega
    having year( data_entrega ) = 2023;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
select idVeiculo, concat(nome_veiculo, '-', modelo) as carro, marca, 
	idEquipe_mecanica, count(idEquipe_mecanica) as qtde from veiculo
		inner join equipe_mecanica
		on idVeiculo = idEquipe_mecanica
		group by idEquipe_mecanica;
