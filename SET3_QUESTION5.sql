/*
[질문]
오늘 기준으로 발간 날짜(published_date)가 1개월 미만인 도서를 제외하고,
작년에 10권 미만으로 판매된 도서 ID(book_id)와 이름(name)을 조회하는 SQL 쿼리를 작성합니다.
오늘은 2025-06-23이라고 가정합니다.
*/

# [SETTING]
USE practice;
DROP TABLE books;
CREATE TABLE books (
  book_id INT,
  name VARCHAR(255),
  published_date DATE,
  PRIMARY KEY (book_id)
);
INSERT INTO
  books (book_id, name, published_date)
VALUES (1, 'Kalila And Demna', '2024-01-01'),
  (2, '28 Letters', '2024-05-12'),
  (3, 'The Hobbit', '2025-06-10'),
  (4, '13 Reasons Why', '2025-06-01'),
  (5, 'The Hunger Games', '2024-09-21');
SELECT *
FROM books;

# [SETTING]
USE practice;
DROP TABLE orders;
CREATE TABLE orders (
  order_id INT,
  book_id INT,
  quantity INT,
  delivery_date DATE,
  PRIMARY KEY (order_id)
);
INSERT INTO
  orders (order_id, book_id, quantity, delivery_date)
VALUES (1, 1, 100, '2024-07-26'),
  (2, 1, 1, '2024-11-05'),
  (3, 3, 8, '2025-06-11'),
  (4, 4, 6, '2025-06-05'),
  (5, 4, 5, '2025-06-20'),
  (6, 5, 9, '2023-02-02'),
  (7, 5, 8, '2023-04-13');
SELECT *
FROM orders;

# [코드 SET 3-10] 중간 코드
SELECT book_id
FROM orders
WHERE DATE_FORMAT(delivery_date, '%Y') = DATE_FORMAT(DATE_SUB('2025-06-23', INTERVAL 1 YEAR), '%Y')
GROUP BY book_id
HAVING SUM(quantity) < 10;

# [코드 SET 3-11] 중간 코드
SELECT book_id
FROM orders
WHERE DATE_FORMAT(delivery_date, '%Y') = DATE_FORMAT(DATE_SUB('2025-06-23', INTERVAL 1 YEAR), '%Y')
GROUP BY book_id
HAVING SUM(quantity) >= 10

UNION

SELECT book_id
FROM books
WHERE DATE_SUB('2025-06-23', INTERVAL 1 MONTH) < published_date
  AND published_date <= '2025-06-23';
    
# [코드 SET 3-12] 최종 코드
SELECT
  book_id,
  name
FROM books
WHERE book_id NOT IN (
    SELECT book_id
    FROM orders
    WHERE DATE_FORMAT(delivery_date, '%Y') = DATE_FORMAT(DATE_SUB('2025-06-23', INTERVAL 1 YEAR), '%Y')
    GROUP BY book_id
    HAVING SUM(quantity) >= 10
    
    UNION
    
    SELECT book_id
    FROM books
    WHERE DATE_SUB('2025-06-23', INTERVAL 1 MONTH) < published_date
      AND published_date <= '2025-06-23'
);