-- Practical 6 - Q2 : Visitor Statistics using Remote Stateless EJB
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS userstat (
    dt DATETIME,
    hostname VARCHAR(100) PRIMARY KEY,
    visits INT DEFAULT 1
);
