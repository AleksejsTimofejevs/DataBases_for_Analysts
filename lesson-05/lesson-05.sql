use bda_1;

DROP TABLE IF EXISTS last_month;

CREATE TABLE last_month
SELECT user_id,
timestampdiff(day, MIN(o_date), '2017-12-01') AS lifetime, SUM(price) AS LTV FROM main
WHERE o_date < '2017-12-01'
GROUP BY user_id;

SELECT t.user_id, t.lifetime, t.LTV, r.R, r.F
FROM  last_month t
LEFT JOIN rfm r
ON t.user_id = r.user_id;

DROP TABLE IF EXISTS pred;

CREATE TABLE predict
SELECT t.user_id, t.lifetime, t.LTV, r.R, r.F, 
(CASE 
	WHEN t.lifetime <= 30 THEN t.LTV/30
   	ELSE t.LTV/t.lifetime
END) AS spending
FROM  last_month t
LEFT JOIN rfm r
ON t.user_id = r.user_id;