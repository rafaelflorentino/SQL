
-- Selecionar estados com id 25
select * from estados where id = 25;

-- Selecionar cidades 
select * from cidades;

-- Inserir cidades 
INSERT INTO cidades (nome, area, estado_id)
VALUES('Campinas', 795, 25);

INSERT INTO cidades (nome, area, estado_id)
VALUES('Niterói', 133.9, 25);

-- Inserir cidades no estado PE pega o id pelo select
INSERT INTO cidades 
    (nome, area, estado_id)
VALUES(
    'Caruaru', 920.6, 
    (select id from estados where sigla = 'PE'));

-- Inserir cidades no estado CE pega id pelo select
INSERT INTO cidades 
    (nome, area, estado_id)
VALUES(
    'Juazeiro do Norte', 248.2, 
    (select id from estados where sigla = 'CE'));

-- Deletar cidade pelo nome
delete from cidades where nome = 'Campinas';