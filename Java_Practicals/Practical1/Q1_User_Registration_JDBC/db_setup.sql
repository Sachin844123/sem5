-- Practical 1 - Q1 : User Registration using JDBC
CREATE DATABASE IF NOT EXISTS userdb;
USE userdb;

CREATE TABLE IF NOT EXISTS users (
    username VARCHAR(50),
    password VARCHAR(50),
    email VARCHAR(100),
    country VARCHAR(50)
);
