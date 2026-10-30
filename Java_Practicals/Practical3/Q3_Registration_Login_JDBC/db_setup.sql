-- Practical 3 - Q3 : Registration + Login using JSP + JDBC
CREATE DATABASE IF NOT EXISTS jspdb;
USE jspdb;

CREATE TABLE IF NOT EXISTS register (
    name VARCHAR(50),
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);
