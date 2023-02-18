-- Somar a populacao dos estados pelas regioes
select 
  regiao as 'Região',
  sum(populacao) as Total
from estados
group by regiao -- Agrupar por região
order by total desc; -- Oredenar do maior para menor

-- Somar toda a população (todos dados da mesma coluna)
select 
    sum(populacao) as Total
from estados;

-- Somar a média da população, dividida pelo numero de estados
select 
    avg(populacao) as Total
from estados;