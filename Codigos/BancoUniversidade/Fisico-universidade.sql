/* Modelo Físico Universidade*/
CREATE DATABASE IF NOT EXISTS db_universidade
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

SHOW DATABASES;
USE db_universidade;

DROP DATABASE db_universidade;

SHOW TABLES;

CREATE TABLE IF NOT EXISTS  tb_turma (
    codigo_turma INTEGER NOT NULL PRIMARY KEY,
    periodo  VARCHAR(255) NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    numero_alunos INTEGER NOT NULL,
    codigo_departamento INTEGER,
    CONSTRAINT fk_codigo_departamento_tb_turma FOREIGN KEY(codigo_departamento) REFERENCES tb_departamento(codigo_departamento)
);

CREATE TABLE IF NOT EXISTS tb_aluno (
    codigo_ra INTEGER NOT NULL PRIMARY KEY,
    maximo_disciplinas INTEGER NOT NULL,
    codigo_turma INTEGER NOT NULL,
    codigo_curso INTEGER NOT NULL,
    CONSTRAINT fk_codigo_turma_tb_aluno FOREIGN KEY(codigo_turma) REFERENCES tb_turma(codigo_turma),
    CONSTRAINT fk_codigo_curso_tb_aluno FOREIGN KEY(codigo_curso) REFERENCES tb_curso(codigo_curso)
);

CREATE TABLE IF NOT EXISTS tb_endereco (
    codigo_endereco INTEGER NOT NULL PRIMARY KEY,
    numero INTEGER NOT NULL,
    rua  VARCHAR(255) NOT NULL,
    cep INTEGER NOT NULL,
    bairro  VARCHAR(255) NOT NULL,
    codigo_ra INTEGER NOT NULL,
	CONSTRAINT fk_codigo_ra_tb_endereco FOREIGN KEY(codigo_ra) REFERENCES tb_aluno(codigo_ra)
);

CREATE TABLE IF NOT EXISTS tb_telefone (
    codigo_telefone INTEGER NOT NULL PRIMARY KEY,
    numero INTEGER NOT NULL,
    codigo_ra INTEGER NOT NULL,
    CONSTRAINT fk_codigo_ra_tb_telefone FOREIGN KEY(codigo_ra) REFERENCES tb_aluno(codigo_ra)
);

CREATE TABLE IF NOT EXISTS tb_curso (
    codigo_curso INTEGER NOT NULL PRIMARY KEY,
    nome_curso  VARCHAR(255) NOT NULL,
    codigo_departamento INTEGER NOT NULL,
    CONSTRAINT fk_codigo_departamento_tb_curso FOREIGN KEY(codigo_departamento) REFERENCES tb_departamento(codigo_departamento)
);

CREATE TABLE IF NOT EXISTS tb_departamento (
    codigo_departamento INTEGER NOT NULL PRIMARY KEY,
    nome_departamento  VARCHAR(255) NOT NULL,
    codigo_disciplina INTEGER NOT NULL,
    CONSTRAINT fk_codigo_disciplina_tb_departamento FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina)
);

CREATE TABLE IF NOT EXISTS tb_historico (
    codigo_historico INTEGER NOT NULL PRIMARY KEY,
    frequencia INTEGER NOT NULL,
    nota_final FLOAT NOT NULL,
    periodo  VARCHAR(255) NOT NULL,
    media FLOAT NOT NULL,
    notas FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_disciplina (
    codigo_disciplina INTEGER NOT NULL PRIMARY KEY,
    nome  VARCHAR(255) NOT NULL,
    descricao  VARCHAR(255) NOT NULL,
    quantidade_alunos INTEGER NOT NULL,
    carga_horaria INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_historico_disciplina (
    codigo_historico INTEGER NOT NULL,
    codigo_disciplina INTEGER NOT NULL,
	CONSTRAINT fk_codigo_historico_tb_historico_disciplina FOREIGN KEY(codigo_historico) REFERENCES tb_historico(codigo_historico),
	CONSTRAINT fk_codigo_disciplina_tb_historico_disciplina FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina)
);

CREATE TABLE IF NOT EXISTS tb_disciplina_curso (
    codigo_disciplina INTEGER NOT NULL,
    codigo_curso INTEGER NOT NULL,
	CONSTRAINT fk_codigo_disciplina_tb_disciplina_curso FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina),
	CONSTRAINT fk_codigo_curso_tb_disciplina_curso FOREIGN KEY(codigo_curso) REFERENCES tb_curso(codigo_curso)
);

CREATE TABLE IF NOT EXISTS tb_aluno_disciplina (
    codigo_disciplina INTEGER NOT NULL,
    codigo_ra INTEGER NOT NULL,
    CONSTRAINT fk_codigo_disciplina_tb_aluno_disciplina FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina),
    CONSTRAINT fk_codigo_ra_tb_aluno_disciplina FOREIGN KEY(codigo_ra) REFERENCES tb_aluno(codigo_ra)
);

CREATE TABLE IF NOT EXISTS tb_professor (
    codigo_professor INTEGER NOT NULL PRIMARY KEY,
    nome  VARCHAR(255) NOT NULL,
    disciplina  VARCHAR(255) NOT NULL,
    status  VARCHAR(255) NOT NULL,
    codigo_departamento INTEGER NOT NULL,
    CONSTRAINT fk_codigo_departamento_tb_professor FOREIGN KEY(codigo_departamento) REFERENCES tb_departamento(codigo_departamento)
);

CREATE TABLE IF NOT EXISTS tb_disciplina_professor (
    codigo_disciplina INTEGER NOT NULL,
    codigo_professor INTEGER NOT NULL,
	CONSTRAINT fk_codigo_disciplina_tb_disciplina_professor FOREIGN KEY(codigo_disciplina) REFERENCES tb_disciplina(codigo_disciplina),
    CONSTRAINT fk_codigo_professor_tb_disciplina_professor FOREIGN KEY(codigo_professor) REFERENCES tb_professor(codigo_professor)
);

/* Inserindo histórico */
INSERT INTO tb_historico(codigo_historico, frequencia, nota_final, periodo, media, notas) 
VALUES
	(0, 22, '9', 'matutino', 7, 10),
    (1, 33, '10', 'vespertino', 10, 10),
    (2, 10, '7', 'noturno', 6, 8);
    
SELECT * from tb_historico;

/* Inserindo disciplina */
INSERT INTO tb_disciplina(codigo_disciplina, nome, descricao, quantidade_alunos, carga_horaria) 
VALUES
	(0, 'matematica', 'realizar calculos', 35, 110),
    (1, 'portugues', 'regras da lingua portuguesa', 45, 200),
    (2, 'quimica', 'elementos quimicos e reações', 10, 240);
    
SELECT * from tb_disciplina;
 
