/*
[질문]
같은 날짜(view_date)에 두 개 이상의 기사(article_id)를 본 독자(viewer_id)를 조회하는 SQL 쿼리를 작성합니다.
*/

# [SETTING]
USE practice;
DROP TABLE views;
CREATE TABLE views
(
    viewer_id  INT,
    article_id INT,
    view_date  DATE
);
INSERT INTO views
    (viewer_id, article_id, view_date)
VALUES (1, 4, '2025-07-22'),
	(4, 3, '2025-07-21'),
    (4, 3, '2025-07-21'),
    (4, 7, '2025-07-21'),
	(5, 1, '2025-08-01'),
    (5, 3, '2025-08-01'),
    (5, 4, '2025-08-01'),
    (6, 1, '2025-08-02'),
    (6, 2, '2025-08-02'),
    (7, 2, '2025-08-01');
SELECT *
FROM views;

# [코드 세트 2-3] 중간 코드
SELECT
    viewer_id,
    view_date,
    article_id,
	DENSE_RANK() OVER (PARTITION BY viewer_id, view_date ORDER BY article_id) AS drk
FROM views
ORDER BY viewer_id, view_date; 
    
# [코드 세트 2-4] 최종 코드
SELECT DISTINCT viewer_id
FROM (
	SELECT
		article_id,
		viewer_id,
		view_date,
		DENSE_RANK() OVER (PARTITION BY viewer_id, view_date ORDER BY article_id) AS drk
	FROM views
	ORDER BY viewer_id
) AS a
WHERE drk > 1;