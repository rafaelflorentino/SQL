-- consultar empresas que tem sede na cidade.
select e.nome as Empresa, c.nome as 'Cidade'
from empresas e, empresas_unidades eu, cidades c
where e.id = eu.empresa_id
and c.id = eu.cidade_id
and sede = 1;


-- alterar o id da tabela campinas
update cidades 
set id = 2
where nome ='Campinas';