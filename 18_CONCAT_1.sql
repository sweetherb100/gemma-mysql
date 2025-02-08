/*
각 사용자(user_id)에 대해서 첫 번째 문자만 대문자이고 나머지는 소문자로 표시되도록 이름(name)을 수정하는 SQL 쿼리를 작성합니다.
user_id를 기준으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE users;
CREATE TABLE users
(
    user_id INT,
    name    VARCHAR(40),
    PRIMARY KEY(user_id)
);
INSERT INTO users
    (user_id, name)
VALUES (1, 'aLice'),
    (2, 'bOB');
SELECT *
FROM users; 

# [코드 18-1] UPPER 코드
SELECT UPPER('hello world') AS upper_string;

# [코드 18-2] LOWER 코드
SELECT LOWER('HELLO WORLD') AS lower_string;

# [코드 18-3] CONCAT 코드
SELECT CONCAT('Hello', ' ', 'World', '!') AS concat_string;

# [코드 18-4] CONCAT NULL 코드
SELECT CONCAT('Hello', NULL, 'World', '!') AS concat_null_string;

# [코드 18-5] CONCAT_WS 코드
SELECT CONCAT_WS(' ', 'Hello', 'World', '!') AS concat_ws_string;

# [코드 18-6] CONCAT_WS NULL 코드
SELECT CONCAT_WS(' ', 'Hello', NULL, 'World', '!') AS concat_ws_null_string;

# [코드 18-7] CONCAT 문제 1 최종 코드
SELECT
    user_id,
    CONCAT(UPPER(SUBSTR(name, 1, 1)), LOWER(SUBSTR(name, 2))) AS name
FROM users
ORDER BY user_id; 