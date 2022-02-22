-- Made by Denys Chorny

DROP TABLE users;
DROP TABLE role_operations;
DROP TABLE operations;
DROP TABLE roles;

--                                            Working
-- ===============================================================================================

CREATE TABLE roles
    (role_id VARCHAR2(5) CONSTRAINT roles_role_id_pk PRIMARY KEY,
    role_name VARCHAR2(20),
    CONSTRAINT roles_rol_id_name_uk UNIQUE(role_id, role_name));

--                                            Working
-- ==============================================================================================

CREATE TABLE operations
    (operation_id VARCHAR2(5) CONSTRAINT operations_oper_id_pk PRIMARY KEY,
    operation_name VARCHAR(20),
    CONSTRAINT operations_id_name_uk UNIQUE(operation_id, operation_name));

--                                            Working
-- ===============================================================================================
CREATE TABLE role_operations
    (role_id VARCHAR2(5) CONSTRAINT role_oper_role_id_fk REFERENCES roles(role_id),
    operation_id VARCHAR2(5) CONSTRAINT role_oper_oper_id_fk REFERENCES operations(operation_id));

--                                            Working
-- ===============================================================================================
CREATE TABLE users
    (user_name VARCHAR2(15) CONSTRAINT users_user_name_pk PRIMARY KEY,
    email VARCHAR(35),
    password VARCHAR2(35),
    blocked NUMBER(1) CONSTRAINT users_blocked_ck CHECK (blocked = 0 OR blocked = 1),
    role_id VARCHAR2(5) CONSTRAINT users_role_id_fk REFERENCES roles(role_id),
    backup VARCHAR2(15) CONSTRAINT users_backup_fk REFERENCES users(user_name),
    CONSTRAINT users_us_name_email_uk UNIQUE(user_name,email));


--                                            In Proces
-- ===============================================================================================

INSERT INTO roles
VALUES
  ('R0001', 'Manager');

INSERT INTO operations
VALUES
  ('P0001', 'Order');

INSERT INTO users
  (user_name, email, password, blocked, role_id, backup)
VALUES
  ('dech', 'dech@proven.cat', '1234qwer', 0, 'R0001', '');

INSERT INTO role_operations
  (role_id, operation_id)
VALUES
  ('R0001', 'P0001');