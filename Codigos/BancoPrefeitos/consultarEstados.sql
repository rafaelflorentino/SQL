-- Selecionar todos os estados.
select * from estados;

-- Selecionar todas as siglas e os estados.
select sigla,
    nome
from estados;

-- Selecionar siglas da regiao Sul.
select sigla, nome as 'Nome do Estado' from estados
where regiao = 'Sul';

-- Selecionar estados e regiões que a população seja >= 10 milhoes.
select nome, regiao, populacao from estados
where populacao >= 10
order by populacao desc; -- Ordena de forma decrescente. 