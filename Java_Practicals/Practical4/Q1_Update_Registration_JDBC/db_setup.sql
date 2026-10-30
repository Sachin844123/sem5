-- Practical 4 - Q1 : Update Registration using JSP + JDBC
CREATE DATABASE IF NOT EXISTS jspdb;
USE jspdb;

CREATE TABLE IF NOT EXISTS registration (
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO registration (firstname, lastname, username, password, city, country)
VALUES ('Ayush', 'Singh', 'admin', '1234', 'Mumbai', 'India')
ON DUPLICATE KEY UPDATE firstname='Ayush';
