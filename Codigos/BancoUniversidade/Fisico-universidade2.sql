SHOW DATABASES;
USE db_universidade;
DESCRIBE db_universidade;
DESCRIBE tb_historico;
SHOW TABLES;
/*DROP TABLE tb_historico;*/
/*DROP TABLE;*/
/*DROP DATABASE db_universidade;*/

SELECT * from tb_aluno;
SELECT * from tb_turma;
SELECT * from tb_disciplina;
SELECT * from tb_professor;
SELECT * from tb_professor_disciplina;
SELECT * from tb_departamento;
SELECT * from tb_historico;
SELECT * from tb_curso;
SELECT * from tb_curso_disciplina;
SELECT * from tb_disciplina_historico;
SELECT * from tb_aluno_disciplina;
SELECT * from tb_telefone_aluno;
SELECT * from tb_tipo_telefone;
SELECT * from tb_endereco_aluno;
SELECT * from tb_tipo_logradouro;
SELECT * from tb_depende;

/* 1) Buscar RAs, Nomes e Sobrenomes dos Alunos, Nomes dos Cursos e Períodos das Turmas, ordenados pelo primeiro nome de aluno */
	SELECT a.ra, a.nome_aluno, a.sobrenome_aluno, t.periodo, c.nome_curso
	FROM tb_aluno a
	INNER JOIN tb_curso c
	ON c.codigo_curso = a.codigo_curso
	INNER JOIN tb_turma t
	ON a.codigo_turma = t.codigo_turma
	ORDER BY a.nome_aluno;

/* 2) Todas as disciplinas cursadas por um aluno, com suas respectivas notas:*/
	SELECT a.nome_aluno, a.sobrenome_aluno, d.nome_disciplina, dh.nota
	FROM tb_aluno a
	INNER JOIN tb_aluno_disciplina ad
	ON a.ra = ad.ra
	INNER JOIN tb_disciplina d
	ON d.codigo_disciplina = ad.codigo_disciplina
	INNER JOIN tb_historico h
	ON a.ra = h.ra
	INNER JOIN tb_disciplina_historico dh
	ON h.codigo_historico = dh.codigo_historico
	WHERE a.ra = 1;
    
/* 3) Nomes e sobrenomes dos professores, e disciplinas que ministram com suas cargas horárias: */
	SELECT CONCAT(p.nome_professor, ' ', p.sobrenome_professor) AS docente,
	d.nome_disciplina, d.carga_horaria
	FROM tb_professor p
	INNER JOIN tb_professor_disciplina pd
	ON p.codigo_professor = pd.codigo_professor
	INNER JOIN tb_disciplina d
	ON d.codigo_disciplina = pd.codigo_disciplina
	ORDER BY d.nome_disciplina;
    
/* 4. Gerar "relatório" com nomes, sobrenomes, CPF dos alunos, tipos e números de telefones e endereços completos.*/
	SELECT CONCAT(a.nome_aluno, ' ', a.sobrenome_aluno) AS aluno, a.cpf, t.numero, CONCAT(tl.tipo_logradouro, ' ', e.rua, ', ', e.numero) AS logradouro, e.complemento, e.cep
	FROM tb_aluno a
	INNER JOIN tb_telefone_aluno t
	ON a.ra = t.ra
	INNER JOIN tb_endereco_aluno e
	ON a.ra = e.ra
	INNER JOIN tb_tipo_logradouro tl
	ON tl.codigo_tipo_logradouro = e.codigo_tipo_logradouro;

/* 5. Listar as disciplinas, indicando seus departamentos, cursos e professores */
	SELECT di.nome_disciplina, c.nome_curso,
	CONCAT(p.nome_professor, ' ', p.sobrenome_professor) AS docente, de.nome_departamento
	FROM tb_disciplina di
	INNER JOIN tb_departamento de
	ON di.codigo_departamento = de.Codigo_departamento
	INNER JOIN tb_professor_disciplina pd
	ON di.codigo_disciplina = pd.codigo_disciplina
	INNER JOIN tb_professor p
	ON p.codigo_professor = pd.codigo_professor
	INNER JOIN tb_curso_disciplina cd
	ON di.codigo_disciplina = cd.codigo_disciplina
	INNER JOIN tb_curso c
	ON c.codigo_curso = cd.codigo_Curso
	ORDER BY di.nome_disciplina;


/*
// Testes e Consultas

// teste 0
SELECT * FROM tb_turma WHERE data_inicio > '2020-01-01'; /* Todas as turmas iniciaram a partir de 2020 

SELECT * FROM tb_turma WHERE data_inicio BETWEEN '2019-06-01' AND '2020-02-01' ORDER BY data_inicio ASC; /* Todas as turmas com data de inicio entre 2019-06-01 e 2020-02-01 
SELECT * FROM tb_turma WHERE data_inicio BETWEEN '2020-01-01' AND '2020-12-31' ORDER BY data_inicio ASC; /* Todas as turmas com data de inicio entre 2019-06-01 e 2020-02-01 

SELECT nome_aluno FROM tb_aluno;

SELECT a.nome_aluno
	FROM tb_aluno as a
INNER JOIN tb_turma as b
	ON a.codigo_turma = b.codigo_turma
WHERE b.data_inicio >= '2020-01-01';

// teste 1
SELECT
 tb_aluno.nome_aluno,
 tb_turma.data_inicio,
 tb_curso.nome_curso
WHERE tb_turma.data_inicio >= '2020';

// teste 2
SELECT
 nome_aluno, data_inicio, nome_curso
FROM
 tb_aluno, tb_turma, tb_curso
 
WHERE data_inicio >= '2020';

// teste 3
SELECT
 tb_aluno.nome_aluno,
 tb_turma.data_inicio,
 tb_curso.nome_curso
FROM
    tb_aluno, tb_turma,  tb_curso
INNER JOIN
    tb_aluno.codigo_turma ON tb_turma.codigo_turma = tb_aluno.codigo_turma
WHERE tb_turma.data_inicio >= '2020';

// Teste 4

// Pego o nome do aluno da tabela aluno com nome do curso que elee faz da tabela curso 
SELECT a.nome_aluno, b.nome_curso
FROM tb_aluno as a
INNER JOIN tb_curso as b
	on a.codigo_curso = b.codigo_curso;
    
// Pego o nome do aluno da tabela aluno com a data de inicio da turma na tabela turma    
SELECT a.nome_aluno, b.data_inicio
FROM tb_aluno as a
INNER JOIN tb_turma as b
	on a.codigo_turma = b.codigo_turma;

//teste 5

SELECT a.nome_aluno, b.nome_curso, c.data_inicio
FROM tb_aluno as a
INNER JOIN tb_curso as b
	on a.codigo_curso = b.codigo_curso
INNER JOIN tb_turma as c
   on a.codigo_turma = c.codigo_turma
WHERE data_inicio >= '2020';


// Teste 6

SELECT a.nome_aluno, b.nome_curso, c.data_inicio
FROM tb_aluno a, tb_curso b, tb_turma c
WHERE a.codigo_curso = b.codigo_curso 
AND a.codigo_turma = c.codigo_turma
AND c.data_inicio BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY  b.nome_curso ASC;

// 7 .Organize de Forma crescente alfabética o nome dos disciplinas selecionados acima.
SELECT d.nome_disciplina, c.nome_curso, de.nome_departamento
FROM tb_disciplina d, tb_curso c, tb_departamento de
WHERE c.codigo_departamento = de.codigo_departamento
ORDER BY d.nome_disciplina ASC;

// 8. Selecione todos as matrículas feitas entre setembro de 2020 e 08 de outubro de 2023 com a data de forma crescente. 
SELECT t.codigo_turma, c.nome_curso
FROM tb_turma t, tb_curso c 
WHERE t.data_inicio BETWEEN '2020-9-08' AND '2023-09-08' 
AND t.codigo_curso = c.codigo_curso
ORDER BY data_inicio ASC;

// 10 .Selecione todos os historicos que foram pedidos em um determinado pedido. 
SELECT * FROM tb_historico WHERE data_inicio BETWEEN '2000-9-08' AND '2025-09-08';

// 11. Mostre os alunos que possuem diciplinas reprovadas. 
SELECT a.nome_aluno, d.nome_disciplina, n.nota, h.data_fim
FROM tb_aluno a, tb_disciplina d, tb_disciplina_historico n, tb_historico h
WHERE n.nota < 7 
AND a.ra = h.ra 
AND h.codigo_historico = n.codigo_historico;

// 12. Selecione todos os alunos calouros com os nomes, matrícula, endereço. 
SELECT a.nome_aluno, a.ra, e.rua, e.numero, t.codigo_turma
FROM tb_aluno a, tb_endereco_aluno e, tb_turma t
WHERE t.data_inicio > 2023-06-01;	

SELECT
 a.nome_aluno, t.data_inicio
FROM
 tb_aluno a, tb_turma t
WHERE t.data_inicio >= '2020';

*/








 


