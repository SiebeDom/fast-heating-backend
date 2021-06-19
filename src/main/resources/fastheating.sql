CREATE datebase fastheating;

CREATE TABLE customer (
id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
type VARCHAR(20),
name VARCHAR(100),
street VARCHAR(100),
house_number VARCHAR(10),
box_number VARCHAR(10),
postal_code VARCHAR(10),
city VARCHAR(100),
phone VARCHAR(100),
mobile VARCHAR(100),
email VARCHAR(100),
year_number smallint,
index_number int,
number VARCHAR(100)
);

CREATE TABLE invoice (
id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
invoice_date DATETIME,
type VARCHAR(20),
description VARCHAR(255),
conditions VARCHAR(100),
customer_id BIGINT(20) NOT NULL,
subTotal DECIMAL(15,2),
vatRate DECIMAL(15,2),
vatAmount DECIMAL(15,2),
total DECIMAL(15,2),
year_number smallint,
index_number int,
number VARCHAR(100),
FOREIGN KEY (customer_id) REFERENCES customer(id)
);