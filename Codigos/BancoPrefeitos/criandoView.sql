-- Criando uma view e usando ela

   CREATE VIEW vw_info_nomes_cnpj as
   SELECT c.nome, e.cnpj
   FROM cidades c , empresas e
   WHERE c.area > 140;

-- Chamando View Criada
SELECT * FROM vw_info_nomes_cnpj; 

-- Deletando view
drop view vw_info_nomes_cnpj;