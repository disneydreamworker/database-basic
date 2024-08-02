USE world;
-- Q1 
SELECT CONCAT(Name, ' ', Continent, ' ', Population) FROM country;

-- Q2 
SELECT name, IFNULL(IndepYear, '데이터 없음') AS IndepYear
FROM country WHERE IndepYear IS NULL;

-- Q3 
SELECT UPPER(name), LOWER(name) FROM country;

-- Q4 
SELECT LTRIM(name), RTRIM(name), TRIM(name) FROM country;

-- Q5 
SELECT
	name, LENGTH(name)
FROM country
WHERE LENGTH(name) > 20
ORDER BY LENGTH(name) DESC;

-- Q6 
SELECT name, SurfaceArea, POSITION('.' in SurfaceArea) FROM country;

-- Q7 
SELECT name, SUBSTRING(name, 2,4) FROM country;

-- Q8 
SELECT Code, REPLACE(Code, 'A', 'Z') FROM country;

-- Q9 
SELECT Code, REPLACE(code, 'A', REPEAT('Z', 10)) FROM country;

-- Q10 
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 24 HOUR);

-- Q11 
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 24 HOUR);

-- Q12 
SELECT DAYNAME('2024-01-01');

-- Q13 
SELECT COUNT(*) FROM country;

-- Q14 
SELECT SUM(GNP), AVG(GNP), MAX(GNP), MIN(GNP) FROM country;

-- Q15 
SELECT name, LifeExpectancy, ROUND(LifeExpectancy, 0) FROM country;

-- Q16 
SELECT 
	row_number() OVER (ORDER BY LifeExpectancy DESC, Name ASC), Name, LifeExpectancy
FROM country;

-- Q17 
SELECT 
	RANK() OVER (ORDER BY LifeExpectancy DESC), Name, LifeExpectancy
FROM country;

-- Q18 
SELECT 
	DENSE_RANK() OVER (ORDER BY LifeExpectancy DESC), Name, LifeExpectancy
FROM country;