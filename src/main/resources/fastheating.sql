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
