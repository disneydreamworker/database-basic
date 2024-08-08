-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;

-- Create the main table if it does not exist
CREATE TABLE IF NOT EXISTS testtbl (
    id INT,
    txt VARCHAR(10)
);

-- Create the log table if it does not exist
CREATE TABLE IF NOT EXISTS logTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS testTrg;

-- Define the trigger
DELIMITER $$
CREATE TRIGGER testTrg
AFTER DELETE ON testtbl
FOR EACH ROW
BEGIN
    -- Insert a record into the log table to simulate logging
    INSERT INTO logTable (message) VALUES ('가수 그룹이 삭제됨');
END$$
DELIMITER ;

-- Insert initial data into the main table
INSERT INTO testtbl (id, txt) VALUES (1, '레드벨벳');
INSERT INTO testtbl (id, txt) VALUES (2, '잇지');
INSERT INTO testtbl (id, txt) VALUES (3, '블랙핑크');

-- Insert a new record into testtbl
INSERT INTO testtbl (id, txt) VALUES (4, 'BTS');

-- Delete a record to activate the trigger
DELETE FROM testtbl WHERE id = 1;

-- Select data from the main table to verify the deletion
SELECT * FROM testtbl;

-- Check the log table to see the trigger's effect
SELECT * FROM logTable;
