# 1. Залить в свою БД данные по продажам (часть таблицы Orders в csv, исходник здесь https://drive.google.com/drive/folders/1C3HqIJcABblKM2tz8vPGiXTFT7MisrML?usp=sharing )
use bda_1;

#2. Проанализировать, какой период данных выгружен
SELECT MIN(o_date),MAX(o_date) FROM main;

#3. Посчитать кол-во строк, кол-во заказов и кол-во уникальных пользователей, кот совершали заказы.
SELECT COUNT(*) FROM main;
SELECT COUNT(id_o) FROM main;
SELECT COUNT(DISTINCT user_id) from main;

#4. По годам посчитать средний чек, среднее кол-во заказов на пользователя, сделать вывод , как изменялись это показатели Год от года.
SELECT YEAR(main.o_date) AS Year,
AVG(price),
COUNT(id_o)/COUNT(DISTINCT user_id) AS Orders_per_Client
FROM main
GROUP BY YEAR(main.o_date);

#5. Найти кол-во пользователей, кот покупали в одном году и перестали покупать в следующем.

SELECT COUNT(user_id) FROM main
WHERE user_id NOT IN
(SELECT DISTINCT user_id FROM main
WHERE YEAR(main.o_date)!=(SELECT DISTINCT YEAR(main.o_date) FROM main LIMIT 1));

#6. Найти ID самого активного по кол-ву покупок пользователя.
SELECT user_id, COUNT(id_o) FROM main
GROUP BY main.user_id
ORDER BY COUNT(id_o) DESC
LIMIT 1;

