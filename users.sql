-- create user for student with id 1
CREATE USER s1 WITH PASSWORD 'password';
GRANT student TO s1;

-- create user for advisor with id 1
CREATE USER a1 WITH PASSWORD 'password';
GRANT advisor TO a1;


-- use s1
SET ROLE s1;

-- use a1
SET ROLE a1;