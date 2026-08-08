create database fraud_detection_db;
use fraud_detection_db;

CREATE TABLE fraud_transactions (
    trans_date_trans_time VARCHAR(30),
    cc_num VARCHAR(25),
    merchant VARCHAR(100),
    category VARCHAR(50),
    amt DECIMAL(10,2),
    first VARCHAR(50),
    last VARCHAR(50),
    gender VARCHAR(5),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(5),
    zip VARCHAR(10),
    lat DECIMAL(9,6),
    `long` DECIMAL(9,6),
    city_pop INT,
    job VARCHAR(100),
    dob VARCHAR(20),
    trans_num VARCHAR(50) PRIMARY KEY,
    unix_time BIGINT,
    merch_lat DECIMAL(9,6),
    merch_long DECIMAL(9,6),
    is_fraud TINYINT,
    hour TINYINT,
    day_of_week VARCHAR(10),
    month TINYINT,
    year SMALLINT,
    age TINYINT,
    age_band VARCHAR(10)
);



SET GLOBAL local_infile = 1;



LOAD DATA LOCAL INFILE 'E:/Credit_Card_Transactions_Fraud_Detection_Project/Phase 1/fraud_cleaned.csv'
INTO TABLE fraud_transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(trans_date_trans_time, cc_num, merchant, category, amt, first, last, gender, street, city, state, zip, lat, `long`, city_pop, job, dob, trans_num, 
unix_time, merch_lat, merch_long, is_fraud, hour, day_of_week, month, year, age, age_band);




SELECT COUNT(*) FROM fraud_transactions;  -- expect 1852394
SELECT cc_num FROM fraud_transactions LIMIT 5;  -- confirm full numbers, no truncation
SELECT gender FROM fraud_transactions LIMIT 5;  -- confirm M/F showing correctly



ALTER TABLE fraud_transactions MODIFY COLUMN trans_date_trans_time DATETIME;

ALTER TABLE fraud_transactions MODIFY COLUMN dob DATE;

describe fraud_transactions;




ALTER TABLE fraud_transactions DROP COLUMN trans_datetime;
ALTER TABLE fraud_transactions DROP COLUMN dob_date;

