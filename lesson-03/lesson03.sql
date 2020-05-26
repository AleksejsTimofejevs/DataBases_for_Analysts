USE bda_1;

CREATE TABLE rfm
SELECT user_id, sum(price) as money,
(CASE 
	WHEN timestampdiff(day, MAX(o_date), (SELECT MAX(o_date) FROM main)) <= 30 THEN 1
 	WHEN timestampdiff(day, MAX(o_date), (SELECT MAX(o_date) FROM main)) BETWEEN 30 AND 61 THEN 2
   	ELSE 3 
END) as R,
(CASE 
	WHEN COUNT(id_o) = 1 THEN 3 
	WHEN COUNT(id_o) BETWEEN 2 AND 3 THEN 2 
ELSE 1 END) as F,
(CASE 
	WHEN SUM(price) < 5000 THEN 3 
	WHEN SUM(price) BETWEEN 5000 AND 15000 THEN 2 
ELSE 1 END) as M
from main
GROUP BY user_id;

SELECT user_id,
(CASE 
	WHEN R IN(2,3) AND F = 3 AND M = 3 THEN 'VIP'
	WHEN R = 1 THEN 'LOST'
   	ELSE 'Regular'
END) as Status
from rfm;

SELECT t.Status, COUNT(t.user_id) AS Num_users, SUM(t.money) As turnover, 
SUM(t.money)/(SELECT SUM(price) FROM main) AS perc_turnover FROM
(SELECT user_id, money,
(CASE 
	WHEN R IN(2,3) AND F = 3 AND M = 3 THEN 'VIP'
	WHEN R = 1 THEN 'LOST'
   	ELSE 'Regular'
END) as Status
from rfm) t
GROUP BY t.Status;

SELECT COUNT(user_id) FROM main;
SELECT SUM(price) FROM main;


