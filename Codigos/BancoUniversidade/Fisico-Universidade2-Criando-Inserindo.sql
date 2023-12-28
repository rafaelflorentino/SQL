/* Modelo Físico Universidade Criando e inserindo dados */

CREATE DATABASE IF NOT EXISTS db_universidade
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_universidade;

CREATE TABLE tb_departamento (
    codigo_departamento INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_departamento  VARCHAR(255) NOT NULL
);

CREATE TABLE tb_depende (
    codigo_disciplina INTEGER NOT NULL,
    possui_codigo_disciplina INTEGER 
);

CREATE TABLE tb_tipo_telefone (
    codigo_tipo_telefone INTEGER PRIMARY KEY AUTO_INCREMENT,
    tipo_telefone  VARCHAR(255) 
);

CREATE TABLE tb_tipo_logradouro (
    codigo_tipo_logradouro INTEGER PRIMARY KEY AUTO_INCREMENT,
    tipo_logradouro  VARCHAR(255) NOT NULL
);

CREATE TABLE tb_professor (
    codigo_professor INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_professor  VARCHAR(255) NOT NULL,
    sobrenome_professor  VARCHAR(255) NOT NULL,
    status Boolean  NOT NULL,
    codigo_departamento INTEGER NOT NULL,
    CONSTRAINT fk_codigo_departamento_tb_professor FOREIGN KEY(codigo_departamento) REFERENCES tb_departamento(codigo_departamento)
);

CREATE TABLE tb_curso (
    codigo_curso INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_curso  VARCHAR(255) NOT NULL,
    codigo_departamento INTEGER NOT NULL,
	CONSTRAINT fk_codigo_departamento_tb_curso FOREIGN KEY(codigo_departamento) REFERENCES tb_departamento(codigo_departamento)
);

CREATE TABLE tb_turma (
    codigo_turma INTEGER PRIMARY KEY AUTO_INCREMENT,
    periodo  VARCHAR(255) NOT NULL,
    numero_alunos INTEGER NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    codigo_curso INTEGER NOT NULL,
	CONSTRAINT fk_codigo_curso_tb_turma FOREIGN KEY(codigo_curso) REFERENCES tb_curso(codigo_curso)
);

CREATE TABLE tb_disciplina (
    codigo_disciplina INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina  VARCHAR(255) NOT NULL,
    descricao  VARCHAR(255) NOT NULL,
    quantidade_alunos INTEGER NOT NULL,
    carga_horaria INTEGER NOT NULL,
    numero_alunos INTEGER NOT NULL,
	codigo_departamento INTEGER NOT NULL,
    CONSTRAINT fk_codigo_departamento_tb_disciplina FOREIGN KEY(codigo_departamento) REFERENCES tb_departamento(codigo_departamento)
);

CREATE TABLE tb_professor_disciplina (
    codigo_professor INTEGER NOT NULL,
    codigo_disciplina INTEGER NOT NULL,
	CONSTRAINT fk_codigo_professor_tb_professor_disciplina FOREIGN KEY(codigo_professor) REFERENCES tb_professor(codigo_professor),
	CONSTRAINT fk_codigo_disciplina_tb_professor_disciplina FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina)
);

CREATE TABLE tb_curso_disciplina (
    codigo_curso INTEGER NOT NULL,
    codigo_disciplina INTEGER NOT NULL,
	CONSTRAINT fk_codigo_curso_tb_curso_disciplina FOREIGN KEY(codigo_curso) REFERENCES tb_curso(codigo_curso),
	CONSTRAINT fk_codigo_disciplina_tb_curso_disciplina FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina)
);

CREATE TABLE tb_aluno (
    ra INTEGER PRIMARY KEY AUTO_INCREMENT,
    maximo_disciplinas INTEGER NOT NULL,
    nome_aluno  VARCHAR(255) NOT NULL,
    sobrenome_aluno  VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL,
    status Boolean NOT NULL,
    sexo CHAR(1) NOT NULL,
    nome_pai  VARCHAR(255) ,
    nome_mae  VARCHAR(255) NOT NULL,
    email  VARCHAR(255) NOT NULL,
    Whatsapp INTEGER,
    codigo_turma INTEGER NOT NULL,
    codigo_curso INTEGER NOT NULL,
	CONSTRAINT fk_codigo_turma_tb_aluno FOREIGN KEY(codigo_turma) REFERENCES tb_turma(codigo_turma),
	CONSTRAINT fk_codigo_curso_tb_aluno FOREIGN KEY(codigo_curso) REFERENCES tb_curso(codigo_curso),
    CONSTRAINT uq_cpf_tb_aluno UNIQUE(cpf) 
);

CREATE TABLE tb_telefone_aluno (
    codigo_telefone INTEGER PRIMARY KEY AUTO_INCREMENT,
    numero INTEGER NOT NULL,
    ra INTEGER NOT NULL,
    codigo_tipo_telefone INTEGER NOT NULL,
	CONSTRAINT fk_ra_tb_telefone_aluno FOREIGN KEY(ra) REFERENCES tb_aluno(ra),
	CONSTRAINT fk_codigo_tipo_telefone_tb_telefone_aluno FOREIGN KEY(codigo_tipo_telefone) REFERENCES tb_tipo_telefone(codigo_tipo_telefone)
);

CREATE TABLE tb_endereco_aluno (
    codigo_endereco_aluno INTEGER PRIMARY KEY AUTO_INCREMENT,
    rua  VARCHAR(255) NOT NULL,
    numero INTEGER NOT NULL,
    complemento  VARCHAR(255) NOT NULL,
    CEP INTEGER NOT NULL,
    ra INTEGER NOT NULL,
    codigo_tipo_logradouro INTEGER NOT NULL,
    CONSTRAINT fk_ra_tb_endereco_aluno FOREIGN KEY(ra) REFERENCES tb_aluno(ra),
    CONSTRAINT fk_codigo_tipo_logradouro_tb_endereco_aluno FOREIGN KEY(codigo_tipo_logradouro) REFERENCES tb_tipo_logradouro(codigo_tipo_logradouro)
);

CREATE TABLE tb_aluno_disciplina (
    ra INTEGER NOT NULL,
    codigo_disciplina INTEGER NOT NULL,
    CONSTRAINT fk_ra_tb_aluno_disciplina FOREIGN KEY(ra) REFERENCES tb_aluno(ra),
    CONSTRAINT fk_codigo_disciplina_tb_aluno_disciplina FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina)
);

CREATE TABLE tb_historico (
    codigo_historico INTEGER PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    ra INTEGER NOT NULL,
	CONSTRAINT fk_ra_tb_historico FOREIGN KEY(ra) REFERENCES tb_aluno(ra)
);

ALTER TABLE tb_historico CHANGE data_fim data_fim date;
 
CREATE TABLE tb_disciplina_historico (
    nota FLOAT NOT NULL,
    frequencia INTEGER NOT NULL,
	codigo_historico INTEGER NOT NULL,
    codigo_disciplina INTEGER NOT NULL,
	situacao VARCHAR(255) NOT NULL,
	CONSTRAINT fk_codigo_historico_tb_disciplina_historico FOREIGN KEY(codigo_historico) REFERENCES tb_historico(codigo_historico),
    CONSTRAINT fk_codigo_disciplina_tb_disciplina_historico FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina)
);

/* Inserindo departamento */
INSERT INTO tb_departamento(codigo_departamento, nome_departamento) 
VALUES
	(DEFAULT, 'Exatas'),
    (DEFAULT, 'Linguas'),
    (DEFAULT, 'Ciências Humanas'),
    (DEFAULT, 'Biológicas'),
    (DEFAULT, 'Robótica'),
    (DEFAULT, 'Artes'),
    (DEFAULT, 'Música'),
    (DEFAULT, 'Contaveis'),
    (DEFAULT, 'Esportes'),
    (DEFAULT, 'Estágio');
    
/* Inserindo Professores */
INSERT INTO tb_professor(codigo_professor, nome_professor, sobrenome_professor, status, codigo_departamento) 
VALUES
	(DEFAULT, 'Paulo', 'Ricardo', 0, 1),
	(DEFAULT, 'Carla', 'Santos', 1, 1),
	(DEFAULT, 'Pedro', 'Souza', 1, 2),
	(DEFAULT, 'Marta', 'Fontinele', 0, 2),
    (DEFAULT, 'Vinícius', 'Palacio', 0, 3),
    (DEFAULT, 'Sandra', 'de Sá', 1, 3),
    (DEFAULT, 'Carlos', 'Magno', 1, 4),
    (DEFAULT, 'Judite', 'da Silva', 0, 4),
    (DEFAULT, 'Marcos', 'Maia', 0, 5),
	(DEFAULT, 'Elias', 'Ribeiro', 1, 6);
    
/* Inserindo Curso */
INSERT INTO tb_curso(codigo_curso, nome_curso, codigo_departamento) 
VALUES
	(DEFAULT, 'Ciencia da Computação Bacharelado', 1),
    (DEFAULT, 'Física Licenciatura', 1),
	(DEFAULT, 'Letras em Lingua Portugues Licenciatura', 2),
	(DEFAULT, 'Filosofia Licenciatura', 3),
    (DEFAULT, 'Microbiologia Bacharelado', 4),
	(DEFAULT, 'Engenharia Mecatrônica Bacharelado', 5),
    (DEFAULT, 'Cinema Bacharelado', 6),
    (DEFAULT, 'Música Conteporanea Licenciatura', 7),
    (DEFAULT, 'Contabilidade Bacharelado', 8),
    (DEFAULT, 'Educação Física Licenciatura', 9),
    (DEFAULT, 'Administração de Empresas Bacharelado', 10);
    
/* Inserindo Turma */
INSERT INTO tb_turma(codigo_turma, periodo, numero_alunos, data_inicio, data_fim, codigo_curso) 
VALUES
	(DEFAULT, 'Matutino', 20, '2020-02-01','2023-12-30', 2),
	(DEFAULT, 'Vespertino', 10, '2020-02-01','2023-12-30', 1),
	(DEFAULT, 'Noturno', 15, '2020-0-01','2023-12-30',3),
    (DEFAULT, 'Matutino', 22, '2020-06-01','2024-06-30', 4),
	(DEFAULT, 'Vespertino', 11, '2020-06-01','2024-6-30', 5),
	(DEFAULT, 'Noturno', 15, '2020-0-01','2023-12-30',3),
    (DEFAULT, 'Matutino', 22, '2020-06-01','2024-06-30', 7),
	(DEFAULT, 'Vespertino', 11, '2020-06-01','2024-6-30', 8),
	(DEFAULT, 'Noturno', 15, '2020-0-01','2023-12-30',9),
    (DEFAULT, 'Matutino', 22, '2020-06-01','2024-06-30', 10),
	(DEFAULT, 'Vespertino', 11, '2020-06-01','2024-6-30', 11);
    
INSERT INTO tb_turma(codigo_turma, periodo, numero_alunos, data_inicio, data_fim, codigo_curso) 
VALUES
    (DEFAULT, 'EAD', 22, '2021-06-01','2026-06-30', 1),
	(DEFAULT, 'EAD', 11, '2019-06-01','2025-6-30', 2),
    (DEFAULT, 'A1', 22, '2021-06-01','2026-06-30', 3),
	(DEFAULT, 'A2', 11, '2019-06-01','2025-6-30', 4),
    (DEFAULT, 'A3', 15, '2021-06-01','2026-06-30', 5),
	(DEFAULT, 'B1', 14, '2019-06-01','2025-6-30', 5),
    (DEFAULT, 'B2', 23, '2021-06-01','2026-06-30', 6),
	(DEFAULT, 'B3', 17, '2019-06-01','2025-6-30', 6),
	(DEFAULT, 'C1', 19, '2019-06-01','2025-6-30', 7),
    (DEFAULT, 'C2', 32, '2021-06-01','2026-06-30', 8),
    (DEFAULT, 'D1', 28, '2021-06-01','2026-06-30', 9),
	(DEFAULT, 'D2', 22, '2019-06-01','2025-6-30', 10);

/* Inserindo Disciplina */
INSERT INTO tb_disciplina(codigo_disciplina, nome_disciplina, descricao, quantidade_alunos, carga_horaria, numero_alunos, codigo_departamento) 
VALUES
	(DEFAULT, 'Matemática', 'Calculos Básicos',20, 1200, 50, 1),
    (DEFAULT, 'Matemática Avançada', 'Calculos Avançados',15, 300, 30, 1),
    (DEFAULT, 'Contabilidade', 'Calculos Contábeis',11, 200, 20, 8),
	(DEFAULT, 'Lógica', 'Raciocínio lógico', 30, 1000, 40, 5),
	(DEFAULT, 'Português', 'Regras da Lingua', 15, 900, 30, 2),
    (DEFAULT, 'Biologia', 'Estudo dos Seres Vivos', 22, 600, 35, 4),
	(DEFAULT, 'Inglês Técnico', 'Idioma Estrangeiro', 30, 1000, 37, 2),
	(DEFAULT, 'Atletismo', 'Exercícios Físicos', 15, 400, 34, 9),
    (DEFAULT, 'Filosofia Antiga', 'Estudo dos Seres Vivos', 12, 200, 28, 3),
	(DEFAULT, 'Cinema Moderno', 'Tecnicas de filmagem Avançadas', 11, 400, 21, 6),
	(DEFAULT, 'Violão Eletrico', 'Tecnicas, Acordes e Melodias', 18, 200, 25, 7),
    (DEFAULT, 'Estágio Obrigatório', 'Estagiar em Empresas', 19, 150, 34, 10),
	(DEFAULT, 'Estatística', 'Calculos Estatísticos e Probabilísticos', 28, 500, 30, 1);
    
/* Inserindo Aluno */
INSERT INTO tb_aluno(ra, maximo_disciplinas, nome_aluno, sobrenome_aluno,  cpf, status, sexo, nome_pai, nome_mae, email, Whatsapp, codigo_turma, codigo_curso) 
VALUES
	(DEFAULT, 7,'João', 'da silva ', 01457123611, true, 'M', 'José da silva', 'Maria ferraz da silva', 'aluno1@teste.com.br', 984471236, 1, 2),
	(DEFAULT, 6,'maria', 'de souza ', 01457123612, true, 'F', 'José da souza', 'Maria ferraz da souza', 'aluno2@teste.com.br', 985671236, 2, 1),
	(DEFAULT, 7,'Mario', 'Guedes ', 01457123613, true, 'M', 'Pedro Guedes', 'Joana dos santos guedes', 'aluno3@teste.com.br', 988771936, 1, 2),
    (DEFAULT, 6,'Pamela', 'Sampaio ', 01457123614, true, 'F', 'Antonio Sampaio', 'Claudia Ferreira Sampaio', 'aluno4@teste.com.br', 985684136, 2, 1),
	(DEFAULT, 7,'Thiago', 'Maia ', 01458903155, false, 'M', 'Arnaldo souza', 'Francisca souza santna', 'aluno5@teste.com.br', 98799856, 1, 2),
	(DEFAULT, 7,'Angelo', 'Lucas ', 01457433611, true, 'M', 'Lucas da silva', 'Sergina ferraz da silva', 'aluno6@teste.com.br', 984665236, 1, 3),
	(DEFAULT, 6,'Cecília', 'Rodrigues ', 01457165712, true, 'F', 'Lucas da silva', 'Sergina ferraz da silva', 'aluno7@teste.com.br', 985677736, 7, 4),
	(DEFAULT, 7,'Jéssica', 'Caixeta ', 01457122313, true, 'F', 'Jorge Maranhão', 'Olga REgina', 'aluno8@teste.com.br', 988788736, 14, 5),
    (DEFAULT, 6,'Gisélia', 'da Costa ', 01457111614, true, 'F', 'Frascisco da Costa', 'Maria Antonieta', 'aluno9@teste.com.br', 915684136, 2, 6),
	(DEFAULT, 7,'Gabriel', 'Alvin ', 01457123155, false, 'M', 'Fernando Alvin', 'Nilda Santana', 'aluno10@teste.com.br', 98766856, 8, 7),
	(DEFAULT, 6,'Fedrerick', 'Nitzie ', 5478459632, true, 'F', 'chocadeira', 'chocadeira', 'aluno6@teste.com.br', 98147136, 2, 4),
	(DEFAULT, 7,'Bethoven', 'Ludivic ', 2148254983, false, 'M', 'chocadeira', 'chocadeira', 'aluno7@teste.com.br', 9873666, 1, 5);

/* Inserindo Curso_disciplina  */
INSERT INTO tb_curso_disciplina(codigo_curso, codigo_disciplina) 
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(1, 1),
	(2, 2),
	(5, 2),
	(6, 3),
	(7, 4),
	(10, 5),
	(1, 2),
	(2, 3),
	(3, 4),
	(1, 5),
	(2, 6);
    
/* Inserindo professor_disciplina  */
INSERT INTO tb_professor_disciplina(codigo_professor, codigo_disciplina) 
VALUES
	(2, 1),
	(1, 2),
	(3, 3),
	(2, 4),
	(2, 1),
	(3, 13),
	(4, 11),
	(5, 4),
	(6, 1),
	(1, 2),
	(2, 6),
	(3, 7),
	(4, 2);
    
/* Inserindo tb_tipo_logradouro */
INSERT INTO tb_tipo_logradouro(codigo_tipo_logradouro, tipo_logradouro) 
VALUES
	(DEFAULT, 'Rua'),
    (DEFAULT, 'Travessa'),
    (DEFAULT, 'Alameda'),
    (DEFAULT, 'Avenida');

/* Inserindo tb_tipo_telefone */
INSERT INTO tb_tipo_telefone(codigo_tipo_telefone, tipo_telefone) 
VALUES
	(DEFAULT, 'Fixo'),
    (DEFAULT, 'Celular'),
    (DEFAULT, 'Comercial'),
    (DEFAULT, 'Fixo'),
	(DEFAULT, 'Celular'),
    (DEFAULT, 'Comercial'),
    (DEFAULT, 'Fixo'),
	(DEFAULT, 'Comercial'),
    (DEFAULT, 'Fixo'),
    (DEFAULT, 'Celular');
    
/* Inserindo materias com pre requisitos depende de outra*/
INSERT INTO tb_depende(codigo_disciplina, possui_codigo_disciplina) 
VALUES
	(1, NULL),
    (2, NULL),
    (3, NULL),
    (4, NULL),
    (5, NULL),
	(6, NULL),
    (7, NULL),
    (8, 3),
    (9, 2),
    (10, 1);
    

/* Inserindo Aluno_disciplina */
INSERT INTO tb_aluno_disciplina(ra, codigo_disciplina) 
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 1),
    (6, 1),
	(7, 2),
	(8, 3),
	(9, 4),
	(10, 1),
	(1, 2),
	(2, 3),
	(3, 5),
	(4, 5),
	(5, 6),
    (6, 4),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 2);

/* Inserindo Histórico */
INSERT INTO tb_historico(codigo_historico, data_inicio, data_fim, ra) 
VALUES
	(DEFAULT, '2020-02-01','2023-12-28',1),
    (DEFAULT, '2020-02-01','2023-12-29',2),
    (DEFAULT, '2020-06-01','2023-01-28',3),
    (DEFAULT, '2020-02-01','2023-12-29',4),
    (DEFAULT, '2020-06-01','2023-12-26',5),
	(DEFAULT, '2020-06-01','2023-11-29',7),
    (DEFAULT, '2020-06-01','2023-11-28',8),
    (DEFAULT, '2020-01-01','2023-06-27',9),
    (DEFAULT, '2020-01-01','2023-07-29',10),
    (DEFAULT, '2020-01-01','2023-07-28',11);
    
/* Inserindo tb_endereco_aluno */
INSERT INTO tb_endereco_aluno(codigo_endereco_aluno, rua, numero, complemento, CEP, ra, codigo_tipo_logradouro) 
VALUES
	(DEFAULT, 'das Giestas', 245, 'casa 02', 0255415, 1, 1),
    (DEFAULT, 'das palmeiras', 255, 'APT 06', 0255416, 2, 1),
    (DEFAULT, 'do Carmo', 249, 'casa 05', 0255411, 3, 2),
	(DEFAULT, 'das Giestas', 245, 'casa 02', 0255415, 4, 3),
    (DEFAULT, 'dos Cocais', 255, 'APT 06', 0255416, 5, 1),
    (DEFAULT, 'dos Anjos', 249, 'casa 05', 0255411, 6, 2),
	(DEFAULT, 'das Giestas', 245, 'casa 02', 0255415, 7, 3),
    (DEFAULT, 'das Emas', 255, 'APT 06', 0255416, 8, 3),
    (DEFAULT, 'da Salvação', 249, 'casa 05', 0255411, 9, 2),
	(DEFAULT, 'Dom Pedro II', 299, 'APT 15', 0255417, 10, 2);
    
/* Inserindo Disciplina Histórico*/
INSERT INTO tb_disciplina_historico(codigo_historico, codigo_disciplina, nota, frequencia, situacao) 
VALUES
	(1, 2, 9, 30,'Cursando'),
    (2, 1, 8, 25, 'Arpovado'),
    (3, 4, 7, 29, 'Reprovado'),
    (4, 3, 6, 15, 'Cursando'),
	(5, 3, 5, 12,'Cursando'),
    (6, 4, 10, 32,'Cursando'),
    (7, 6, 0, 0,'Reprovado'),
    (8, 7, 8, 29,'Arpovado'),
    (9, 8, 5, 19,'Arpovado');
    

