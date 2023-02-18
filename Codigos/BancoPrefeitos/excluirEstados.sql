-- Deletar um arquivo pela sigla
delete from estados
where sigla ='MN';

select * from estados;

-- Deletar um arquivo pelo Id
delete from estados
where id >= 1000;