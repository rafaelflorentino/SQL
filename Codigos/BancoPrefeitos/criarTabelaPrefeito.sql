-- Criar tabela prefeito

CREATE TABLE IF NOT EXISTS prefeitos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cidade_id int unsigned,
    PRIMARY KEY (id),
    UNIQUE KEY (cidade_id), -- Relação 1 X 1
    FOREIGN KEY (cidade_id) REFERENCES cidades (id)
);
