--Total Revenue

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

--Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value 
FROM pizza_sales

--Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

--Total Orders


SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

--Average Pizza per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales;


--Daily Trend

SELECT DATENAME (DW, order_date) AS Order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME (DW, order_date)

--Hourly Trend

SELECT DATEPART(HOUR, order_time) AS Hourly_Orders, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART (HOUR, order_time)
ORDER BY DATEPART (HOUR, order_time)

% of Sales by Category

SELECT pizza_category, CAST (SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price) *100 /
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PercentageCategorySales
FROM pizza_sales
GROUP BY pizza_category


--Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) *100 /
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PercentageSizeSales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PercentageSizeSales DESC

--Total Pizza Sold by Category
SELECT pizza_category, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_category

--Top 5 Best Sellers

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sum(quantity) DESC


--Bottom 5 Worst Sellers
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sum(quantity) ASC