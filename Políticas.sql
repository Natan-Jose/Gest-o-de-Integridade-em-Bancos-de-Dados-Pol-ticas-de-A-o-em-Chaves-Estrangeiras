CREATE DATABASE Teste;

USE Teste;

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
 FOREIGN KEY (cod_depto)
 REFERENCES Departamento(cod_depto)
 );

INSERT INTO Departamento (cod_depto, nome_depto) VALUES (1, 'Intermidia');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (2, 'Sistemas Web');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (3, 'Mobile');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (4, 'Inteligência Artificial');
INSERT INTO Departamento (cod_depto, nome_depto) VALUES (5, 'Desktop');

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

# PASSOS PARA TROCAR A POLÍTICA

-- 1. Identificar a Constraint,
-- 2. Remover a Constraint Existente,
-- 3. Recriar a Constraint com a política desejada.

/* Listar as constraints da FK de uma tabela */

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM 
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
	CONSTRAINT_SCHEMA = 'Controle'
	AND TABLE_NAME = 'Membro'
    AND CONSTRAINT_TYPE = 'FOREIGN KEY';

/* Visualizar as políticas da chave FK */

SELECT
    CONSTRAINT_NAME,
    DELETE_RULE AS ON_DELETE,
    UPDATE_RULE AS ON_UPDATE
FROM
     INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
WHERE
    CONSTRAINT_SCHEMA = 'Controle'
    AND TABLE_NAME = 'Membro'
    AND CONSTRAINT_NAME = 'fk_departamento_membro';

SELECT * FROM  information_schema.REFERENTIAL_CONSTRAINTS;

/* Filtra as chaves estrangeiras da tabela 'Membro' e suas referências */

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME, 
    kcu.REFERENCED_TABLE_NAME, 
    kcu.REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE 
    tc.TABLE_NAME = 'Membro' 
    AND tc.CONSTRAINT_TYPE = 'FOREIGN KEY';


/* ALTERANDO POLÍTICAS */

# Método 01: Remover e Recriar a CONSTRAINT
SHOW CREATE TABLE Membro;

ALTER TABLE Membro
DROP CONSTRAINT fk_departamento_membro;

ALTER TABLE Membro
ADD CONSTRAINT fk_departamento_membro
FOREIGN KEY (cod_depto)
REFERENCES Departamento (cod_depto)
ON DELETE RESTRICT 
ON UPDATE CASCADE;

# Método 2: Utilizando Temporariamente uma Tabela de Backup 
# (RECOMENDADO)
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

INSERT INTO Membro SELECT * FROM membro_backup;

DROP TABLE membro_backup;