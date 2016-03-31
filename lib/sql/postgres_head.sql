DROP DATABASE s{db_name};
CREATE DATABASE s{db_name};
CREATE USER s{user_name} WITH PASSWORD 'password';
ALTER USER s{user_name} with createdb;
GRANT ALL PRIVILEGES ON DATABASE s{db_name} TO s{user_name};
ALTER DATABASE "s{db_name}" OWNER TO "s{user_name}";

\c {db_name};
ALTER SCHEMA public OWNER TO "s{user_name}";

