/*
전송자(from_user), 전송한 이메일의 총 개수(total_email_cnt), 순위(unique_rank)를 조회하는 SQL 쿼리를 작성합니다.
여러 전송자가 동일한 수의 이메일을 보낸 경우에도 고유한 순위를 반환합니다.
unique_rank 기준으로 정렬합니다.
*/

# [SETTING]
USE practice;
DROP TABLE emails;
CREATE TABLE emails
(
    email_id INT,
    from_user VARCHAR(255),
    to_user VARCHAR(255),
    PRIMARY KEY(email_id)
);
INSERT INTO emails
	(email_id, from_user, to_user)
VALUES (0, 'Frodo', 'Sam'),
	(1, 'Frodo', 'Pippin'),
	(2, 'Frodo', 'Merry'),
	(3, 'Frodo', 'Gimli'),
	(4, 'Pippin', 'Legolas'),
	(5, 'Pippin', 'Saruman'),
	(6, 'Pippin', 'Arwen'),
	(7, 'Pippin', 'Boromir'),
	(8, 'Aragorn', 'Gollum'),
	(9, 'Aragorn', 'Galadriel'),
	(10, 'Gandalf', 'Bilbo');
SELECT *
FROM emails; 

# [코드 15-5] ROW_NUMBER 문제 2 중간 코드
SELECT
	from_user,
	COUNT(*) AS total_email_cnt
FROM emails
GROUP BY from_user;

# [코드 15-6] ROW_NUMBER 문제 2 최종 코드
SELECT
	from_user,
	COUNT(*) AS total_email_cnt,
	ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS unique_rank
FROM emails
GROUP BY from_user
ORDER BY unique_rank;

# [코드 15-7] ROW_NUMBER 문제 2 오답 코드
SELECT
	from_user,
	COUNT(*) AS total_email_cnt,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rk,
	DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS drk,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rn
FROM emails
GROUP BY from_user;