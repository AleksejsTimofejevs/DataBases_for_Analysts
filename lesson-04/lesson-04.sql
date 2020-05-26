USE bda_1;

DROP TABLE IF EXISTS user_cog;

CREATE TABLE user_cog
SELECT user_id, DATE_FORMAT(MIN(o_date), '%y%m') as cog
FROM main
GROUP BY user_id;

SELECT t.cog, DATE_FORMAT(t.o_date, '%y%m') as YearMonth, SUM(t.price) as sales
FROM
(SELECT o.*, t.cog
FROM main o
JOIN user_cog t
ON o.user_id = t.user_id) t
GROUP BY t.cog, DATE_FORMAT(t.o_date, '%y%m');

SELECT t.cog, DATE_FORMAT(t.o_date, '%y%m') as YearMonth, SUM(t.price) as sales
FROM
(SELECT o.*, t.cog
FROM main o
JOIN user_cog t
ON o.user_id = t.user_id) t
GROUP BY t.cog, DATE_FORMAT(t.o_date, '%y%m')
HAVING cog=YearMonth;


