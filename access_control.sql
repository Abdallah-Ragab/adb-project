-- Create a role without login privileges (for grouping purposes)
CREATE ROLE role_name;

-- Create a role with login privileges (acts as a user)
CREATE ROLE user_name LOGIN PASSWORD 'your_password';

-- Grant a role the ability to create databases
ALTER ROLE user_name CREATEDB;

-- Remove the ability to create databases
ALTER ROLE user_name NOCREATEDB;

-- Grant superuser privileges
ALTER ROLE user_name SUPERUSER;

-- Change a role's password
ALTER ROLE user_name PASSWORD 'new_password';

-- drop role
DROP ROLE role_name;

-- Grant a role to a user
GRANT role_name TO user_name;

-- Grant with administrative privileges (allows the user to manage the role)
GRANT role_name TO user_name WITH ADMIN OPTION;

-- Grant privileges on a database
GRANT CONNECT ON DATABASE database_name TO user_name;

-- Grant all privileges on a database
GRANT ALL PRIVILEGES ON DATABASE database_name TO user_name;

-- Grant privileges on a table
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE table_name TO user_name;

-- Grant privileges on specific columns
GRANT SELECT (column_name1, column_name2) ON TABLE table_name TO user_name;

-- Grant usage on a schema (allows access to objects in the schema)
GRANT USAGE ON SCHEMA schema_name TO user_name;

-- Grant execute privilege on a function
GRANT EXECUTE ON FUNCTION function_name(args) TO user_name;



-- Revoke privileges on a database
REVOKE CONNECT ON DATABASE database_name FROM user_name;

-- Revoke privileges on a table
REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE table_name FROM user_name;

-- Revoke usage on a schema
REVOKE USAGE ON SCHEMA schema_name FROM user_name;

-- Revoke execute privilege on a function
REVOKE EXECUTE ON FUNCTION function_name(args) FROM user_name;



-- Change ownership of a table
ALTER TABLE table_name OWNER TO user_name;

-- Change ownership of a database
ALTER DATABASE database_name OWNER TO user_name;

-- Change ownership of a schema
ALTER SCHEMA schema_name OWNER TO user_name;


-- create role
CREATE ROLE "staff" WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1
	PASSWORD '123456789';


-- give role to  user
GRANT "staff" TO "user";