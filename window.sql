-- Накопительная выручка по месяцам
SELECT substr(sold_at,1,7) AS month,
       SUM(qty*price) AS revenue,
       SUM(SUM(qty*price)) OVER (ORDER BY substr(sold_at,1,7)) AS running
FROM sales GROUP BY month;

-- Ранг клиентов по выручке
SELECT customer, SUM(qty*price) AS total,
       RANK() OVER (ORDER BY SUM(qty*price) DESC) AS rk
FROM sales GROUP BY customer;

-- LAG: сравнение с прошлым месяцем
WITH m AS (
    SELECT substr(sold_at,1,7) AS month, SUM(qty*price) AS rev
    FROM sales GROUP BY month
)
SELECT month, rev,
       LAG(rev) OVER (ORDER BY month) AS prev,
       rev - LAG(rev) OVER (ORDER BY month) AS diff
FROM m;
