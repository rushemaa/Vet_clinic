/* Database schema to keep the structure of entire database. */
 CREATE DATABASE  vet_clinic;

CREATE TABLE animals (
   id INT,
   name VARCHAR (50),
   date_of_birth DATE,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg DECIMAL(4,2)
);

ALTER TABLE animals  ADD COLUMN species VARCHAR(255);

CREATE TABLE owners(
   id  SERIAL PRIMARY KEY,
   full_name          VARCHAR (255),
   age                 INT
);

CREATE TABLE species(
   id  SERIAL PRIMARY KEY,
   name          VARCHAR (255)
);

ALTER TABLE animals 
ADD PRIMARY KEY (id);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals  ADD COLUMN species_id INT;
ALTER TABLE animals  ADD COLUMN owner_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_species 
FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE animals 
ADD CONSTRAINT fk_owners 
FOREIGN KEY (owner_id) 
REFERENCES owners (id);
