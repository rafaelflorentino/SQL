-- Alterar tipo do cnpj de int para varchar
ALTER TABLE empresas MODIFY cnpj VARCHAR(14);

-- inserir empresas
INSERT INTO empresas
    (nome, cnpj)
VALUES
    ('Bradesco', 47059174000193),
    ('Vale', 86263215000110),
    ('Cielo', 51496680000117);

-- Descreveer tabela
desc empresas;
desc prefeitos;

select * from empresas;
select * from cidades;

-- inserir empresas
INSERT INTO empresas_unidades
    (empresa_id, cidade_id, sede)
VALUES
    (1, 1, 1), -- 1 é sede
    (1, 2, 0), -- 0 não é sede
    (2, 1, 0), -- 0 não é sede
    (2, 2, 1); -- 1 é sede

desc empresas_unidades;

select * FROM empresas_unidades;


    