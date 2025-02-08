/*
각 날짜(sell_date)에 대해 판매된 제품 수(sold_count)와 제품 이름(products)을 조회하는 SQL 쿼리를 작성합니다.
각 날짜에 판매된 제품 이름(products)은 사전순으로 정렬되어야 하며, sell_date를 기준으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE activities;
CREATE TABLE activities
(
    sell_date DATE,
    product   VARCHAR(20)
);
INSERT INTO activities
    (sell_date, product)
VALUES ('2024-05-30', 'Headphone'),
    ('2024-06-01', 'Pencil'),
    ('2024-06-02', 'Mask'),
    ('2024-05-30', 'Basketball'),
    ('2024-06-01', 'Bible'),
    ('2024-06-02', 'Mask'),
    ('2024-05-30', 'T-Shirt');
SELECT *
FROM activities;

# [코드 18-8] CONCAT 문제 2 중간 코드
SELECT
    sell_date,
    COUNT(DISTINCT product) AS sold_count
FROM activities
GROUP BY sell_date
ORDER BY sell_date; 

# [코드 18-9] CONCAT 문제 2 최종 코드
SELECT
    sell_date,
    COUNT(DISTINCT product) AS sold_count,
    GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS products
FROM activities
GROUP BY sell_date
ORDER BY sell_date; 