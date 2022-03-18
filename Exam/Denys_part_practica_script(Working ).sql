-- Denys Chorny, 11/03/2022

-- ==============================================================================================
--                                        create tables
-- ==============================================================================================


--                                            drops
-- ==============================================================================================


DROP TABLE employeesprojects_exam;
DROP TABLE projects_exam;
DROP TABLE employees_exam;
DROP TABLE cities_exam;

DROP SEQUENCE emp_id_seq;
DROP SEQUENCE project_id_seq;

--                                            cities
-- ==============================================================================================

CREATE TABLE cities_exam
    (zip_code VARCHAR2(6),
     city_name VARCHAR2(40) UNIQUE,
     inhabitants NUMBER(12),
     area NUMBER,
     CONSTRAINT cities_zcode_id_pk PRIMARY KEY (zip_code)
    );


--                                            projects
-- ==============================================================================================

CREATE TABLE projects_exam
    (project_id NUMBER,
     project_dec VARCHAR2(40) NOT NULL,
     budget NUMBER(7,2) NOT NULL,
     CONSTRAINT projects_project_id_pk PRIMARY KEY (project_id)
    );


--                                            employees
-- ==============================================================================================

CREATE TABLE employees_exam
    (emp_id NUMBER,
     firstname VARCHAR2(20) NOT NULL,
     lastname VARCHAR2(40) NOT NULL,
     zip_code VARCHAR2(6),
     age NUMBER(2) CONSTRAINT employees_age_ck CHECK (age > 18 and age <= 67),
     hired_date DATE DEFAULT SYSDATE,
     fee NUMBER,
     manager NUMBER,
     CONSTRAINT employees_emp_id_pk PRIMARY KEY (emp_id),
     CONSTRAINT employees_manager_fk FOREIGN KEY (manager) REFERENCES employees_exam(emp_id),
     CONSTRAINT employees_zip_code_fk FOREIGN KEY (zip_code) REFERENCES cities_exam(zip_code)
    );


--                                       employeesprojects
-- ==============================================================================================

CREATE TABLE employeesprojects_exam
    (emp_id NUMBER,
     project_id NUMBER,
     assig_date DATE DEFAULT SYSDATE,
     unassig_date DATE,
     CONSTRAINT emplproj_emp_id_pk PRIMARY KEY (emp_id, project_id),
     CONSTRAINT emp_project_emp_id_fk FOREIGN KEY (emp_id) REFERENCES employees_exam(emp_id),
     CONSTRAINT emp_project_proj_id_fk FOREIGN KEY (project_id) REFERENCES projects_exam(project_id)
    );


-- ==============================================================================================
--                                         6. Sequences
-- ==============================================================================================

CREATE SEQUENCE emp_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE project_id_seq
    INCREMENT BY 10
    START WITH 100
    MAXVALUE 200
    NOCACHE
    NOCYCLE;

-- ==============================================================================================
--                                           Exercici 7
-- ==============================================================================================

INSERT INTO cities_exam (zip_code, city_name, inhabitants, area) VALUES ('08080', 'BARCELONA', 1600000.00, 101.9);
INSERT INTO cities_exam (zip_code, city_name, inhabitants, area) VALUES ('08901', 'LHospitalet de Llobregat', 210000.00, 12.4);
INSERT INTO cities_exam (zip_code, city_name, inhabitants, area) VALUES ('08635', 'Sant Esteve Sesrovires', 5000.00, 18.6);


INSERT INTO projects_exam (project_id, project_dec, budget) VALUES (project_id_seq.NEXTVAL,'Upgrade Data Base version', 12000.00);
INSERT INTO projects_exam (project_id, project_dec, budget) VALUES (project_id_seq.NEXTVAL,'Server migration', 8000.00);
INSERT INTO projects_exam (project_id, project_dec, budget) VALUES (project_id_seq.NEXTVAL,'Proven Marketplace', 50000.00);
INSERT INTO projects_exam (project_id, project_dec, budget) VALUES (project_id_seq.NEXTVAL,'New Mobile app', 45000.00);

INSERT INTO employees_exam (emp_id, firstname, lastname, zip_code, age, fee) VALUES (emp_id_seq.NEXTVAL, 'Name1', 'Lastname1', '08080', 20, 10);
INSERT INTO employees_exam (emp_id, firstname, lastname, zip_code, age, fee) VALUES (emp_id_seq.NEXTVAL, 'Name2', 'Lastname2', '08901', 24, 25);
INSERT INTO employees_exam (emp_id, firstname, lastname, zip_code, age, fee) VALUES (emp_id_seq.NEXTVAL, 'Name3', 'Lastname2', '08635', 56, 40);
INSERT INTO employees_exam (emp_id, firstname, lastname, zip_code, age, fee) VALUES (emp_id_seq.NEXTVAL, 'Name4', 'Lastname2', '08901', 35, 60);

UPDATE employees_exam SET manager = 4 WHERE firstname = 'Name3';
UPDATE employees_exam SET manager = 1 WHERE firstname = 'Name2';
UPDATE employees_exam SET manager = 1 WHERE firstname = 'Name4';

-- ==============================================================================================
--                                           Exercici 8
-- ==============================================================================================


UPDATE employees_exam
SET fee = fee + (5/100)*fee
WHERE manager = 4;