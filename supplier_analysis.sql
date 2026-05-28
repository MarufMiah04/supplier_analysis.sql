-- Supplier Performance Analysis
-- Baker Hughes Placement Prep | Maruf Miah
-- Tools: SQL (SQLite)

-- Query 1: Total spend by category
SELECT category, 
       SUM(po_value) AS total_spend,
       COUNT(*) AS supplier_count
FROM suppliers
GROUP BY category
ORDER BY total_spend DESC;

-- Query 2: High risk suppliers flagged for review
SELECT supplier_name, 
       category,
       quality_score,
       on_time_percent,
       po_value
FROM suppliers
WHERE risk_level = 'High'
ORDER BY quality_score ASC;

-- Query 3: Average performance by risk level
SELECT risk_level,
       ROUND(AVG(quality_score), 2) AS avg_quality,
       ROUND(AVG(on_time_percent), 2) AS avg_on_time,
       SUM(po_value) AS total_po_value
FROM suppliers
GROUP BY risk_level
ORDER BY avg_quality DESC;

-- Query 4: Best value suppliers
SELECT supplier_name,
       category,
       quality_score,
       delivery_days,
       po_value,
       risk_level
FROM suppliers
WHERE quality_score > 8.0 
AND delivery_days < 5
AND risk_level = 'Low'
ORDER BY quality_score DESC;

-- Query 5: Contracts flagged for renegotiation
SELECT supplier_name,
       quality_score,
       on_time_percent,
       po_value,
       risk_level
FROM suppliers
WHERE on_time_percent < 0.80
OR quality_score < 7.0
ORDER BY on_time_percent ASC;
