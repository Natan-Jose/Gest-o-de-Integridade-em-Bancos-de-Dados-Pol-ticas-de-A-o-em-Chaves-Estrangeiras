CREATE DATABASE Controle;

USE Controle;

CREATE TABLE Departamento(
 cod_depto INT PRIMARY KEY,
 nome_depto VARCHAR(50)
);

CREATE TABLE Membro(
 id_membro INT PRIMARY KEY,
 cod_depto INT, 
 nome VARCHAR(50),
 sexo CHAR,
 papel VARCHAR(50), 
 dt_nasc DATE, 
 salario NUMERIC NOT NULL,
 CONSTRAINT fk_departamento_membro
 FOREIGN KEY (cod_depto)
 REFERENCES Departamento(cod_depto)
 );

-- Inserção de Departamento
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (1, 'Intermidia');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (2, 'Sistemas Web');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (3, 'Mobile');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (4, 'Inteligência Artificial');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (5, 'Desktop');

-- Inserção de membros
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (1, 1, 'Ana Carla Barros', 'F', 'analista', null, 3000);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (2, 2, 'Manoel Silva', 'M', 'programador', '1997-04-12', 2750);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (3, 3, 'Jéssica dos Santos', 'F', 'gerente', '1995-10-23', 7500);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (4, 4, 'Manoela Garcia', 'F', 'instrutor', '1996-07-30', 5000);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (5, 1, 'Manoela Garcia', 'F', 'programador', '1999-01-10', 2750);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (6, 2, 'Jéssica Machado', 'F', 'gerente', '1990-01-04', 10000);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (7, 3, 'Noeli Peres', 'F', 'analista', null, 3000);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (8, 4, 'Caio Manoel de Barros', 'M', 'programador', '1997-04-12', 2750);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (9, 1, 'Cláudia Freitas', 'F', 'gerente', '1995-10-23', 7500);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (10, 2, 'Emanoel Silva', 'M', 'instrutor', '1998-07-30', 4600);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (11, 3, 'Noel Natalina', 'F', 'programador', '1999-01-10', 2150);
INSERT INTO Membro (id_membro, cod_depto, nome, sexo, papel, dt_nasc, salario)
 VALUES (12, 4, 'Judith Deodora', 'F', 'gerente', '1960-01-04', 12000);

/* CONSULTA PARA VISUALIZAR AS POLÍTICAS DE AÇÃO DE UMA CHAVE ESTRANGEIRA */
SELECT
    CONSTRAINT_NAME,
    DELETE_RULE AS ON_DELETE,
    UPDATE_RULE AS ON_UPDATE
FROM
    information_schema.REFERENTIAL_CONSTRAINTS
WHERE
    CONSTRAINT_SCHEMA = 'Controle'
    AND TABLE_NAME = 'Membro'
    AND CONSTRAINT_NAME = 'fk_departamento_membro';

SELECT * FROM  information_schema.REFERENTIAL_CONSTRAINTS;

/* ALTERANDO AS POLÍTICAS DE ATUALIZAÇÃO E REMOÇÃO */

-- Método 01: Remover e Recriar a CONSTRAINT
SHOW CREATE TABLE Membro;

ALTER TABLE Membro
DROP CONSTRAINT fk_departamento_membro;

ALTER TABLE Membro
ADD CONSTRAINT fk_departamento_membro
FOREIGN KEY (cod_depto)
REFERENCES Departamento (cod_depto)
ON DELETE RESTRICT 
ON UPDATE CASCADE;

-- Método 2: Utilizando Temporariamente uma Tabela de Backup

# RECOMENDADO
SHOW CREATE TABLE Membro;

CREATE TABLE membro_backup LIKE Membro;
INSERT INTO membro_backup SELECT * FROM Membro;

ALTER TABLE Membro
DROP CONSTRAINT fk_departamento_membro;

ALTER TABLE Membro
ADD CONSTRAINT fk_departamento_membro
FOREIGN KEY (cod_depto)
REFERENCES Departamento (cod_depto)
ON DELETE RESTRICT 
ON UPDATE CASCADE;

INSERT INTO Membro SELECT * FROM orders_backup;

DROP TABLE orders_backup;
    