-- Junção de tabelas

-- Consultar duas tabelas id do estado e igual estado_id da cidade
select * from estados e, cidades c
where e.id = c.estado_id;

-- Consultar nomes das cidades e das regiôes
select e.nome, c.nome, regiao from estados e, cidades c
where e.id = c.estado_id; 

-- Junção de tabelas, Consultar nomes das cidades e das regiôes
select 
    e.nome as Estado,
    c.nome as Cidade,
    regiao as Região
from estados e, cidades c 
where e.id =  c.estado_id;

-- Junção de tabelas Usando inner join
select 
    c.nome as Cidade,
    e.nome as Estado,
    regiao as Região
from estados e
inner join cidades c on e.id = c.estado_id