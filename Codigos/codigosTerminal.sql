/* Logar terminal */
mysql -u root
mysql -u -root -p
mysql -u root -p -h localhost

/* Criar Schema */
crate schema vm;

/* Entrar no banco */
use wm;

/* Mostrar Bancos */
show databases;

/* Mostrar Tabelas */
show tables;

/* Descrever Tabela */
describe tables;
des tables;

/* Sair do terminal */
quit;

/* Criar novo usuário */
CREATE USER 'novousuario'@'localhost' IDENTIFIED BY '123456';

/* Dando acessos */
GRANT ALL PRIVILEGES ON * . * TO 'novousuario'@'localhost';
/* Pondo em vigor os acessos */
FLUSH PRIVILEGES;

/* Apagar Usuário*/
DROP USER 'novousuario'@'localhost';
/* Alterar senha */
ALTER USER 'novousuario'@'localhost' IDENTIFIED BY 'NovaSenha';

/* Acessar com novo usuário */
mysql -u novousuario -p

/* Arrumar erro*/
ALTER USER 'root'@'localhost' IDENTIFIED BY ''; 
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''
