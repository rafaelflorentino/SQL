select * from cidades;
-- Trazer prefeitos
select * from prefeitos;

-- Insrir prefeitos
INSERT INTO prefeitos
    (nome, cidade_id)
VALUES
    ('Rodrigo Neves', 1),
    ('Raquel Lyra Neves', 3),
    ('Zenaldo Coutinho', null); -- cidade_id opcional aceita null

INSERT INTO prefeitos
    (nome, cidade_id)
VALUES
    ('Rafael Greca', null);

