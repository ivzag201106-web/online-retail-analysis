-- ============================================================
-- Online Retail Sales Analysis
-- Автор: Ivan Zagainov
-- Датасет: https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset
-- ============================================================


-- ============================================================
-- 1. Создание вычисляемой колонки "Выручка"
--    Выручка = Цена за единицу × Количество
-- ============================================================

ALTER TABLE `Data`
ADD COLUMN TotalCost
GENERATED ALWAYS AS (ROUND(UnitPrice * Quantity, 1));


-- ============================================================
-- 2. Совокупная выручка и объём продаж по странам
-- ============================================================

SELECT
    Country      AS Страна,
    SUM(Quantity)  AS Количество,
    SUM(TotalCost) AS Выручка
FROM `Data`
GROUP BY Country
ORDER BY SUM(TotalCost) DESC;


-- ============================================================
-- 3. Топ-10 товаров по выручке
-- ============================================================

SELECT
    Description  AS Наименование,
    SUM(Quantity)  AS Количество,
    SUM(TotalCost) AS Выручка
FROM `Data`
WHERE Description IS NOT NULL
GROUP BY Description
ORDER BY SUM(TotalCost) DESC
LIMIT 10;


-- ============================================================
-- 4. Динамика выручки по месяцам
-- ============================================================

SELECT
    strftime('%Y-%m', InvoiceDate) AS Месяц,
    SUM(TotalCost)                 AS Выручка
FROM `Data`
GROUP BY strftime('%Y-%m', InvoiceDate)
ORDER BY Месяц ASC;
