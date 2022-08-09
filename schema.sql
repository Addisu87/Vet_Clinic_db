/* Database schema to keep the structure of entire database. */

-- DAY-1
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE, 
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

--DAY-2

ALTER TABLE animals
ADD species VARCHAR(50);


