USE blinkitdb;
select * from blinkit_data;

-- kpi's

SELECT 
CASE
WHEN SUM(`Total Sales`) >= 1000000
THEN CONCAT(ROUND(SUM(`Total Sales`) / 1000000, 1), 'M')

WHEN SUM(`Total Sales`) >= 1000
THEN CONCAT(ROUND(SUM(`Total Sales`) / 1000, 0), 'K')

ELSE ROUND(SUM(`Total Sales`), 0)
END AS Formatted_Total_Sales
FROM blinkit_data;


SELECT 
CASE
WHEN AVG(`Total Sales`) >= 1000000
THEN CONCAT(ROUND(AVG(`Total Sales`) / 1000000, 1), 'M')

WHEN AVG(`Total Sales`) >= 1000
THEN CONCAT(ROUND(AVG(`Total Sales`) / 1000, 1), 'K')

ELSE ROUND(AVG(`Total Sales`), 0)
END AS Avg_Sales
FROM blinkit_data;


SELECT COUNT(*) AS No_Of_Item  FROM blinkit_data;


SELECT 
CASE
WHEN SUM(`Total Sales`) >= 1000000
THEN CONCAT(ROUND(SUM(`Total Sales`) / 1000000, 1), 'M')

WHEN SUM(`Total Sales`) >= 1000
THEN CONCAT(ROUND(SUM(`Total Sales`) / 1000, 0), 'K')

ELSE ROUND(SUM(`Total Sales`), 0)
END AS Low_Fat_Count
FROM blinkit_data
WHERE Item_Fat_Content = 'Low Fat' ;

	
SELECT CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating FROM blinkit_data;



-- Granular  requirements

SELECT 
Item_Fat_Content,
CONCAT(ROUND(SUM(`Total Sales`) / 1000,1),'K') AS Total_Sales,
ROUND(AVG(`Total Sales`),1) AS Avg_Sales,

COUNT(*) AS No_Of_Items,
ROUND(AVG(Rating),2) AS Avg_Rating
FROM blinkit_data

GROUP BY Item_Fat_Content
ORDER BY SUM(`Total Sales`) DESC;


SELECT 
`Item Type`,
CONCAT(ROUND(SUM(`Total Sales`) / 1000,1),'K') AS Total_Sales,

ROUND(AVG(`Total Sales`),1) AS Avg_Sales,
COUNT(*) AS No_Of_Items,
ROUND(AVG(Rating),2) AS Avg_Rating

FROM blinkit_data
GROUP BY `Item Type`
ORDER BY SUM(`Total Sales`) DESC;


SELECT 
`Outlet Location Type`,

CONCAT(
ROUND(
SUM(
CASE
WHEN Item_Fat_Content = 'Low Fat'
THEN `Total Sales`
ELSE 0
END
)/1000,1
),'K'
) AS Low_Fat,

CONCAT(
ROUND(
SUM(
CASE
WHEN Item_Fat_Content = 'Regular'
THEN `Total Sales`
ELSE 0
END
)/1000,1
),'K'
) AS Regular

FROM blinkit_data
GROUP BY `Outlet Location Type`;


SELECT 
`Outlet Establishment Year`,

CONCAT(
ROUND(SUM(`Total Sales`) / 1000,1),
'K'
) AS Total_Sales,
ROUND(AVG(`Total Sales`),1) AS Avg_Sales,

COUNT(*) AS No_Of_Items,
ROUND(AVG(Rating),2) AS Avg_Rating
FROM blinkit_data

GROUP BY `Outlet Establishment Year`
ORDER BY `Outlet Establishment Year`;


SELECT 
`Outlet Size`,

CONCAT(
ROUND(SUM(`Total Sales`) / 1000,1),
'K'
) AS Total_Sales,

ROUND(
(SUM(`Total Sales`) * 100) / 
(SELECT SUM(`Total Sales`) FROM blinkit_data),
2
) AS Sales_Percentage

FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY SUM(`Total Sales`) DESC;


SELECT 
`Outlet Type`,
CONCAT(
ROUND(SUM(`Total Sales`) / 1000,1),
'K'
) AS Total_Sales,

ROUND(AVG(`Total Sales`),1) AS Avg_Sales,
COUNT(*) AS No_Of_Items,
ROUND(AVG(Rating),2) AS Avg_Rating,

ROUND(
(SUM(`Total Sales`) * 100) / 
(SELECT SUM(`Total Sales`) FROM blinkit_data),
2
) AS Sales_Percentage

FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY SUM(`Total Sales`) DESC;