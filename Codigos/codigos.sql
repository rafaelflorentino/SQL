/* Operadores Relacionais */
/* Igual = */ 
select * from produto where codigo = 10 /* O caracter '*'  traz todas as colunas da tabela e linhas*/
/* Menor que < */ 
select * from produto where qtde < 5
/* Menor ou igual a <= */ 
select * from produto where preco <= 50
/* Maior que > */
select * from produto where preco > 500
/* Maior ou igual a */
select * from produto where preco >= 500
/* Diferente */
select * from produto where codigo <> 2


/* Operadores Lógicos */
/* AND */
select * from produto where marca = 'LG' and preco > 1500
/* OR */
select * from produto where qtde < 5 or qtde > 100
/* NOT */
select * from produto where preco is not null


/* Operadores Especiais */
/*IS NULL ou IS NOT NULL*/
select * from produto where preco is null
/*BETWEEN*/
select * from produto where preco between 10 and 100
/*LIKE*/
select * from produto where nome like '_A%' /* '%' Qualquer sequencia, '-' único caractere*/
/*IN*/
Select * from produto Where codigo in (2, 5, 15, 29)
/* DISTINCT */
Select distinct categoria from produto

/*Trazer apenas nome e preço*/
select nome,preco from produto where categoria='Bebida'


/* Order By */
/* Ordem Crescente */
select * produto order by nome asc /* Por padrão order by já traz de forma ascendente*/
/* Ordem Decrescente */
select * produto order by nome desc /*des poem em Ordem Decrescente */
/* Remove os repedidos, redundantes */
select distinct categoria from produto

/*IN subconsulta, traz os nomes é os preços só dos produtos das categorias limpeza e bebida*/
SELECT nome_prod, preco_prod FROM Produto
WHERE id_categoria IN (SELECT id_categoria FROM categoria
                              WHERE nome_categoria = 'BEBIDA'
                              OR nome_categoria = 'LIMPEZA');/*sub select para descobrir os id de bebida e limpeza*/

/*IN sem sub consulta, já tem os codigos de bebida e limpeza*/
SELECT nome_prod, preco_prod FROM Produto 
WHERE id_categoria IN (20, 30)


/* Funções de Agregação */
/* count(*) conta a quantidade de produtos, linhas*/
select count(*) as Total from Produto /* 'as' cria o nome da coluna de retorno como Total */

/*AVG(Média); SUM(soma), MAX(Maior valor), MIN(Menor valor), AS(nomeia a tabela retornada)*/
SELECT categoria, AVG(PRECO) as Média, SUM(PRECO) AS Soma,
MAX(Preco) as Maior, MIN(Preco) as Menor
FROM produto
GROUP BY categoria;/*Agrupa por categoria*/

/* HAVING */
SELECT categoria, AVG(PRECO) as Média
FROM produto
WHERE categoria(10 ,30)/* WHERE filtra as categorias*/
GROUP BY categoria /* GROUP BY agrupa */
HAVING AVG(PRECO) < 10; /* HAVING Filtrar em cima do que foi grupado, Pegar só as média com valor menor que 10 */


/* INSERT */
/* Caso 1*/
INSERT INTO nome_tabela
VALUES (1,'TV', 3.500, 'Eletrônicos') /* Ordem dos atributos mantidos */

/* Caso 2*/
INSERT INTO nome_tabela (id, categoria, nome)/* Ordem dos atributos não precisa ser mantidos */
VALUES (1,'Eletronicos', 'TV LCD 50')

/* Caso 3*/
INSERT INTO nome_tabela1
SELECT * FROM nome_tabela2 /* Copiar de uma tabela para outra*/
WHERE CATEG="HIGIENE";

/* DELETE */
/* Caso 1*/
DELETE FROM PRODUTO WHERE PRECO IS NULL; /* Exclui todos os produtos sem preço, preco === nul*/

/* Caso 2*/
DELETE FROM PRODUTO /* Exclui todos os produtos, se não por o where apga tudo*/

/* UPDATE */
/* Caso 1*/
UPDATE PRODUTO
SET PRECO = PRECO * 1.1; /* Reajuste de 10% no preço de todos os produtos*/
 
/* Caso 2*/
UPDATE PRODUTO
SET PRECO = PRECO * 1.1 /* Reajuste de 10% no preço de todos os produtos de limpeza*/
WHERE CATEGORIA = 'LIMPEZA';

/*OBS: delete(apagar linha (DML)) != drop table (remover tabela (DDL))*/


/* INNER JOIN*/
SELECT p.nome_prod as produto,
c.nome_categoria as categoria
FROM produto as p INNER JOIN categoria as /* Compara 2 tabelas e tras o que bate, iterceção, some com os sem categoria*/
c ON (p.id_categoria = c.id_categoria);

/* LEFT OUTER JOIN*/
SELECT p.nome_prod as produto,
c.nome_categoria as categoria
FROM produto as p LEFT OUTER JOIN categoria as c /* pega todos os elementos da coluna da esquerda, mesmo se na direita tiver null*/
ON (p.id_categoria = c.id_categoria);

/* RIGHT OUTER JOIN*/
SELECT p.nome_prod as produto,
c.nome_categoria as categoria
FROM produto as p RIGHT OUTER JOIN categoria as c /* pega todos os elementos da coluna da direita mesmo se na esquerda tiver null*/
ON (p.id_categoria = c.id_categoria);

/* FULL OUTER JOIN*/
SELECT p.nome_prod as produto,
    c.nome_categoria as categoria
FROM produto as p RIGHT OUTER JOIN
    categoria as c ON (p.id_categoria = c.id_categoria); /*pega todos mesmo os nulos das colunas da direita e da esquerda*/


/* INNER JOIN Na mesma tabela, auto relacionamento*/
SELECT E.nome as Empregado, C.nome as Chefe
FROM Empregado as E INNER JOIN Empregado as C ON
(E.id_chefe = c.id_emp);

/* Processamento de Transações */
INSERT INTO UNIDADE (ID_UNIDADE, NOME_UNIDADE, ID_UNIDADE_SUPERIOR) VALUES
(10, 'DIRETORIA DE TECNOLOGIA DA INFORMAÇÃO', 5);

INSERT INTO UNIDADE (ID_UNIDADE, NOME_UNIDADE, ID_UNIDADE_SUPERIOR) VALUES
(11, 'COORDENAÇÃO DE SISTEMAS', 10);

SAVEPOINT ponto1; /* DTL */  /* Salva alterações do Banco até aqui */ 

DELETE FROM EMPREGADO WHERE SALARIO < 1000; /* será desfeita pelo roolback */ 

ROLLBACK TO SAVEPOINT ponto1; /* DTL */ /* Desfaz alterações, volta ate onde foi salvo SAVEPOINT = ponto1 */ 

UPDATE EMPREGADO SET SALARIO = SALARIO * 1.05 WHERE ID_UNIDADE = 11;

COMMIT; /* DTL */ /* Salva as alteraçoes feitas  */

-- Comando DCL de controle de acesso e privilegios (Acesso Discricionário)

    -- Criador do objeto tem todos os privilégios do objeto que criou.
    -- Banco tem um tabela onde contém os usuários e os seus privilégios.

/* Inserir privilegios Grant(conceder)*/
GRANT privilégios ON objeto TO usuários [WITH GRANT OPTION] -- privilégios (deletar, iserir, alterar etc)

GRANT insert, delete ON funcionario, departamento TO joao; -- Dá permições de inserir e deletar nas tabelas funcionário e deparrtamento para joao, mas joao não pode propagar privilegios
GRANT select ON funcionario, departamento TO joana WITH GRANT OPTION; -- Da permição de selecionar, na tabela funcionario e departamento para joana e pode propagar privilégios dela -- GRANT OPTION pode propagar privilegios
GRANT select funcionario TO MARCOS; -- marcos agora pode propagar seus privilegios

/* Propagação de Privilégios */
GRANT insert, delete ON funcionario TO manoel; maoel vai poder iserir e deletar na tabela funcionarios, mas não pode propagar as permissoes
GRANT delete ON departamento TO antonio WITH GRANT OPTION; -- Antonio pode deletar em departamento e pode propagar privilegios com GRANT OPTION
GRANT update (salario) ON funcionario TO renata;


/* Remover privilegios Revoke(retirar)*/
--REVOKE [WITH GRANT OPTION] privilégios ON objeto FROM usuários [RESTRICT/CASCADE]

REVOKE select ON funcionario FROM maria CASCADE ; -- cascade retira o privilegio da pessoa e de todo mundo que ela ja passou privilegios


/* Views */ -- atalho as consultas ja estão prontas retornando uma tabela vitual, basta chamar a visão.
-- Criar uma view
CREATE VIEW v AS <expressão de consulta>

CREATE VIEW vw_estoque_zerado as
SELECT nome_prod,
       nome_categ,
       nível_estoque,
       unid
FROM produto
WHERE nível_estoque=0

-- View com nome dos campos alterados
CREATE VIEW vw_estoque_zerado (produto,categoria, estoque, unidade) as  SELECT 
   nome_prod,
   nome_categ,
   nível_estoque,
   unid
   FROM produto
   WHERE nível_estoque=0
   WITH CHECK OPTION; -- caso tenha alguma inserção na view, analiza a clausula where pra nao aceitar vazio, null.
   -- WITH CHECK OPTION só da em views simples, em view complexas com 2 tabelas ou mais não funciona

-- Posso fazer uma view usando o resultado de outra view
CREATE VIEW vw_estoque_zerado_limpeza as
   SELECT nome_prod,
   nome_categ,
   nível_estoque,
   unid
   FROM vw_estoque_zerado -- usa o resultado de outro view para consultar
   WHERE nome_categ ='LIMPEZA';

-- Criando a view que buca dados de 2 tabelas diferentes e usando
CREATE VIEW vw_info_emprestimo as
   SELECT nome_cliente, valor
   FROM emprestimo , tomador
   WHERE tomador.num_emp = emprestimo.num_emp;

SELECT * FROM vw_info_emprestimo -- Maneira de chamar a view e passar mais um filtro
   WHERE valor > 5000;

-- Não usar insert em view pois da problemas de dados null entre outros erros
INSERT INTO vw_produto_bebida -- não usar insert em view
   VALUES ('SUCO DE UVA', 'BEBIDAS', '1L');

-- Dropar uma view
DROP VIEW <nome da view>

-- Gatilhos trigger sintaxe PL/SQL
CREATE OR REPLACE TRIGGER nome_gatilho
   BEFORE | AFTER
   DELETE OR INSERT OR UPDATE OF coluna1, coluna2, ...
   ON nome_da_tabela
   REFERENCING OLD AS nome NEW AS nome
   FOR EACH ROW WHEN condição
   DECLARE
      área de declaração
      BEGIN
      área de comandos
   END ; 

CREATE OR REPLACE TRIGGER trg_estoque
   BEFORE INSERT OR DELETE OF qtde ON Item_Venda
   REFERENCING OLD AS antigo NEW AS novo
   FOR EACH ROW
   BEGIN
      IF inserting THEN
         UDPATE PRODUTO SET estoque=estoque - :novo.qtde
      ELSEIF deleting THEN
      UDPATE PRODUTO SET estoque=estoque + :old.qtde
      END-IF
   END ; 

 ALTER TRIGGER <nome do gatilho> ENABLE | DISABLE;
 //EXEMPLO:
 ALTER TRIGGER trg_estoque ENABLE;
 ALTER TRIGGER trg_estoque DISABLE;
 //EXEMPLO:
 DROP TRIGGER <nome do gatilho>;
 DROP TRIGGER trg_estoque;

 -- Stored Procedure SQL coleção de comandos para otmizar o banco, programas dentro do banco
DELIMITER $$ -- Delemitador $$ no lugar de dentro da procedure
CREATE PROCEDURE selecionarTodosProdutos()
BEGIN
   SELECT * FROM PRODUTO;
END
DELIMITER;

--CALL <nome do procedimento> (parâmetros);
CALL selecionarTodosProdutos();

-- OUT saida
DELIMITER $$
CREATE PROCEDURE sp_total_produtos (OUT total INT)
BEGIN
   SELECT count(*) INTO total FROM produtos;
END
DELIMITER;
CALL sp_total_produtos (@total); -- salva na vaiavel select
SELECT @total
 
 --IN OUT
 DELIMITER $$
CREATE PROCEDURE quadrado(INOUT num INT)
BEGIN
   SET num = num * num;
END $$
DELIMITER;
SET @valor = 5;
CALL quadrado (@valor);
SELECT @valor


/*
DDL = create, alter, drop;
DML = select, delet, update, insert  ou DQL = delet, update, insert // sem select
DCL =
DTL = Grant, Revoke, commit, savepoint, rollback
*/
/*Create Table*/
CREATE TABLE Empregado
( Nome VARCHAR(15) NOT NULL,
CodEmpregado CHAR(9) NOT NULL,
DataNascimento DATE,
Endereco VARCHAR(30),
Sexo CHAR,
Salario DECIMAL(10,2),
CodSupervisor CHAR(9),
CodDepto INT NOT NULL DEFAULT 0,
CONSTRAINT PK_Emp PRIMARY KEY (CodEmpregado),
CONSTRAINT FK_NumSup FOREIGN KEY (CodSupervisor)
REFERENCES Empregado (CodEmpregado),
CONSTRAINT FK_EmpDep FOREIGN KEY (CodDepto)
REFERENCES Departamento (NumDepto) ON DELETE CASCADE
);

/*Alter Table*/
 ALTER TABLE Produto ADD Marca VARCHAR(30);
 ALTER TABLE Produto ALTER Preco SET DEFAULT 0;

 /* Drop Table*/
 
 DROP TABLE Produto;



/* Any, Selecione Qualquer que encontrar*/

SELECT * FROM Empregado
 WHERE idade > ANY (SELECT idade FROM Empregado
 WHERE depto = ‘ENG’);

 /* All, Seleciona todos */ 
 SELECT * FROM Empregado
 WHERE idade > ALL (SELECT idade FROM Empregado
 WHERE depto = 'ENG');

 /* Exists, Verifica se existe ou nao existe */ 
 SELECT * FROM Empregado E
 WHERE NOT EXISTS (SELECT * FROM Dependente D
 WHERE E.CPF = D.CPF);

/* Union, une e não tem repetido */ 
 SELECT Nome, Depto FROM Servidor UNION
 SELECT Nome, Depto FROM Terceirizado;

/* Union All, une e não pode ter repetido, aceita */ 
 SELECT Nome, Depto FROM Servidor UNION ALL
 SELECT Nome, Depto FROM Terceirizado;

/* Intersection tem nos dois conjuntos */ 
 SELECT Nome FROM Conta INTERSECT
 SELECT Nome FROM Emprestimo;
