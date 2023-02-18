-- Atualizar o nome do estado com a sigla MA, para o nome Maranhão
update estados
set nome = 'Maranhão'
where sigla ='MA';

select nome, sigla, populacao from estados where sigla = 'MA';
select estados.`nome` from estados where sigla = 'MA';
select est.`nome` from estados as est where sigla = 'MA';

-- Atualizar nome e populacao do estado
update estados
set nome = 'Paraná', populacao = 11.32
where sigla = 'PR';

select nome, sigla, populacao from estados where sigla = 'PR';