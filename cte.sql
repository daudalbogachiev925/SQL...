-- CTE: топ товаров
WITH totals AS (
    SELECT product, SUM(qty*price) AS revenue
    FROM sales GROUP BY product
)
SELECT * FROM totals ORDER BY revenue DESC;

-- Цепочка CTE
WITH
  by_cat AS (SELECT category, SUM(qty*price) AS rev FROM sales GROUP BY category),
  total  AS (SELECT SUM(rev) AS t FROM by_cat)
SELECT category, rev, ROUND(100.0*rev/t,1) AS pct
FROM by_cat, total ORDER BY rev DESC;
