-- Temporary table to unify data tables for analysis

with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

-- Joins to link foreign keys

select * from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal

-- Further analysis was performed using data transformation within Power Query



-- Total hotel revenue, per hotel type, by year. Group by and order by in Power BI as individual data may be relevant for graphical representation.
WITH hotels AS (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$']
) 

SELECT 
arrival_date_year,
hotel,
--Have to use the aggregation function SUM in order to be able to group by year at the end of the query.
ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) AS revenue
-- This only expresses the total revenue, not taking into account discounts, or meal cost. This will be addressed in Power BI using Power Query to calculate a field.

FROM hotels
GROUP BY arrival_date_year,hotel