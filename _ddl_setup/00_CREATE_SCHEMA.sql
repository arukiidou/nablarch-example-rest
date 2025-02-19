CREATE DATABASE rest_example;
USE rest_example;
CREATE USER 'rest_example'@'%'  IDENTIFIED BY 'rest_example';
GRANT ALL ON *.* TO 'rest_example';