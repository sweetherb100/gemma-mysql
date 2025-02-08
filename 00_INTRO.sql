/* 01. INNER JOIN */
SELECT
    p.person,
    p.preparation,
    o.opportunity,
    'success' AS result
FROM preparations AS p
INNER JOIN opportunities AS o
ON p.person = o.person;

/* 02. LEFT OUTER JOIN */
SELECT *
FROM goals AS a
LEFT OUTER JOIN failures AS b
ON a.id = b.goal_id;

/* 03. CROSS JOIN */
SELECT 
    a.idea AS idea_from_a,
    b.idea AS idea_from_b,
    CONCAT(a.idea, ' + ', b.idea) AS combined_idea
FROM ideas_a AS a
CROSS JOIN ideas_b AS b;

/* 04. FULL OUTER JOIN */
SELECT 
    COALESCE(a.person, b.person) AS person,
    a.skill AS skill_from_a,
    b.skill AS skill_from_b
FROM team_a AS a
FULL OUTER JOIN team_b AS b
ON a.person = b.person;

/* 05. GROUP BY */
SELECT 
    status,
    COUNT(*) AS task_count
FROM tasks
GROUP BY status;
    
/* 06. HAVING */
SELECT 
    person,
    SUM(effort) AS total_effort
FROM efforts
GROUP BY person
HAVING SUM(effort) >= 100;
    
/* 07. MIN, MAX*/
SELECT 
    person,
    MIN(wealth) AS min_wealth,
    MAX(contentment) AS max_contentment
FROM life_quality
GROUP BY person;

/* 08. SUM, COUNT */
SELECT 
    COUNT(small_task) AS total_tasks,
    SUM(small_task_value) AS total_value
FROM tasks;

/* 09. CASE WHEN */
SELECT 
    event,
    CASE 
        WHEN event = 'positive' THEN 'positive_response'
        WHEN event = 'negative' THEN 'positive_response'
        ELSE 'neutral_response'
    END AS reaction
FROM life_events;

/* 10. IFNULL */
SELECT 
    strategy,
    IFNULL(risk_taken, 'no_risk') AS risk_status,
    IFNULL(outcome, 'guaranteed_to_fail') AS final_outcome
FROM strategies;
