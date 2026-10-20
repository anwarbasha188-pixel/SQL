-- DDL Commands:

-- Table Creation (CREATE): 

create database employee;
use employee;

Create table departments (
department_id int Primary key auto_increment,
department_name varchar(150) not null
);

create table location (
location_id int primary key auto_increment,
city varchar(150),
state varchar(150),
country varchar(150)
);

create table employees (
employee_id int primary key auto_increment,
name varchar(80) not null,
designation varchar(100),
age int,
email varchar(150),
hire_date Date,
Department_id int,
location_id int,
  foreign key (department_id)
      references Departments (department_id),
  foreign key (location_id)
    references location(location_id)
);
-- The Employees table used foreign keys to link each employee to a department and a location.

Alter table employees
modify column designation varchar(100);

Alter table employees
drop column age;

alter table employees
add column age int;

Alter table employees
Rename column hire_date to joining_of_joining;

Rename table departments to Departments_info;

truncate table employees;

Drop table employees;

-- Constraints : 
 -- Database Recreation: 
  
-- 1. Drop and recreate a databse
  Drop database if exists employee;
  Create database employee;
  
  use employee;
  
-- 2. Create the Department table

  Create table Departments (
  department_id int primary key,
  department_name varchar(150) Not null unique
  );
  
-- 3. Create the location table 

Create table Location (
location_id int primary key,
location_name varchar(150) not null unique
);

-- 4. Create the employees table

Create table Employees (
 employee_id int primary key,
 employee_name VARCHAR(150) NOT NULL,
    gender CHAR(1) NOT NULL,
    age INT NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE),
    department_id INT,
    location_id INT,
    
    CONSTRAINT chk_gender
        CHECK (gender IN ('M', 'F')),

    CONSTRAINT chk_age
        CHECK (age >= 18),

    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),

    CONSTRAINT fk_location
        FOREIGN KEY (location_id)
        REFERENCES Location(location_id)
        );

-- Show tables by Verifying it

Show tables;

Describe departments;
describe employees;
describe location;

  










