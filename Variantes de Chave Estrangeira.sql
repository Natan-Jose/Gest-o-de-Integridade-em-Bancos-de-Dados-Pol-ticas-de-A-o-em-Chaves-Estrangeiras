# Chave Estrangeira Implícita

/* Fornecido pelo desenvolvedor ao criar a CONSTRAINT. */

ALTER TABLE Membro
ADD FOREIGN KEY (cod_depto) 
REFERENCES Departamento(cod_depto);

# Chave Estrangeira Explícita

/* Gerado automaticamente pelo (SGBD) quando não 
se forneçe um nome específico para a CONSTRAINT. */

ALTER TABLE Membro
ADD CONSTRAINT fk_departamento_membro
FOREIGN KEY (cod_depto) 
REFERENCES Departamento(cod_depto);