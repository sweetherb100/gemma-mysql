/*
Red라는 회사(com_name)에 판매하지 못한 영업 사원(sales_name)을 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE sales_person;
CREATE TABLE sales_person
(
    sales_id        INT,
    sales_name      VARCHAR(255),
    salary          INT,
    commission_rate INT,
    hire_date       DATE,
    PRIMARY KEY (sales_id)
);
INSERT INTO sales_person
    (sales_id, sales_name, salary, commission_rate, hire_date)
VALUES (1, 'Jim', 100000, 6, '2006-04-01'),
    (2, 'Dwight', 120000, 5, '2010-05-01'),
    (3, 'Michael', 65000, 12, '2008-12-24'),
    (4, 'Pam', 25000, 25, '2005-01-01'),
    (5, 'Creed', 50000, 10, '2007-02-03');
SELECT *
FROM sales_person; 

# [SETTING]
USE practice;
DROP TABLE company;
CREATE TABLE company
(
    com_id 	   INT,
    com_name   VARCHAR(255),
    city       VARCHAR(255),
    PRIMARY KEY (com_id)
);
INSERT INTO company
    (com_id, com_name, city)
VALUES (1, 'Red', 'Boston'),
    (2, 'Orange', 'New York'),
    (3, 'Yellow', 'Boston'),
    (4, 'Green', 'Austin');
SELECT *
FROM company; 

# [SETTING]
USE practice;
DROP TABLE orders;
CREATE TABLE orders
(
    order_id INT,
    dates    DATE,
    com_id   INT,
    sales_id INT,
    amount   INT,
    PRIMARY KEY (order_id)
);
INSERT INTO orders
    (order_id, dates, com_id, sales_id, amount)
VALUES (1, '2024-01-01', 3, 4, 100000),
    (2, '2024-02-01', 4, 5, 5000),
    (3, '2024-03-01', 1, 1, 50000),
    (4, '2024-04-01', 1, 4, 25000);
SELECT *
FROM orders; 

# [코드 12-8] NOT IN 문제 2 중간 코드
SELECT *
FROM company
WHERE com_name = 'Red';

# [코드 12-9] NOT IN 문제 2 중간 코드
SELECT *
FROM orders
WHERE com_id IN (
	SELECT
		com_id
	FROM company
	WHERE com_name = 'Red'
);

# [코드 12-10] NOT IN 문제 2 최종 코드
SELECT
    sales_name
FROM sales_person
WHERE sales_id NOT IN (
	SELECT
		sales_id
	FROM orders
	WHERE com_id IN (
		SELECT
			com_id
		FROM company
		WHERE com_name = 'Red'
	)
);