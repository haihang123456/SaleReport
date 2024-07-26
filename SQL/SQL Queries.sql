SELECT * from [dbo].[ecommerce_data]

-- 1.tổng doanh thu và lợi nhuận theo năm
SELECT YEAR(order_date) as Year,
ROUND(SUM(sales_per_order),2) as total_sales,
ROUND(SUM(profit_per_order),2) as total_profit
FROM [dbo].[ecommerce_data]
GROUP BY YEAR(order_date)
ORDER BY YEAR ASC

-- 2.tổng doanh thu và lợi nhuận theo từng quý
SELECT 
  YEAR(order_date) AS year, 
  CASE 
    WHEN MONTH(order_date) IN (1, 2, 3) THEN 'Q1'
    WHEN MONTH(order_date) IN (4, 5, 6) THEN 'Q2'
    WHEN MONTH(order_date) IN (7, 8, 9) THEN 'Q3'
    ELSE 'Q4'
  END AS quarter,
  Round(SUM(sales_per_order),2) AS total_sales,
  Round(SUM(profit_per_order),2) AS total_sales
FROM ecommerce_data
GROUP BY YEAR(order_date), 
         CASE 
           WHEN MONTH(order_date) IN (1, 2, 3) THEN 'Q1'
           WHEN MONTH(order_date) IN (4, 5, 6) THEN 'Q2'
           WHEN MONTH(order_date) IN (7, 8, 9) THEN 'Q3'
           ELSE 'Q4'
         END
ORDER BY YEAR(order_date), 
         CASE 
           WHEN MONTH(order_date) IN (1, 2, 3) THEN 'Q1'
           WHEN MONTH(order_date) IN (4, 5, 6) THEN 'Q2'
           WHEN MONTH(order_date) IN (7, 8, 9) THEN 'Q3'
           ELSE 'Q4'
         END;

--3.tổng doanh thu theo khu vực
SELECT customer_region, 
       SUM(sales_per_order) AS total_sales, 
       SUM(profit_per_order) AS total_profits
FROM ecommerce_data
GROUP BY customer_region
ORDER BY total_profits DESC;

-- 4.tổng doanh thu và lợi nhuận mỗi bang, lấy 10 bang cao nhất
SELECT customer_state, 
       SUM(sales_per_order) AS Total_Sales, 
       SUM(profit_per_order) AS Total_Profits, 
       ROUND((SUM(profit_per_order) / SUM(sales_per_order)) * 100, 2) AS profit_margin
FROM ecommerce_data
GROUP BY customer_state
ORDER BY Total_Profits DESC 
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


--5.Tổng doanh thu và lợi nhuận theo thành phố
SELECT customer_city, 
       SUM(sales_per_order) AS Total_Sales, 
       SUM(profit_per_order) AS Total_Profits, 
       ROUND((SUM(profit_per_order) / SUM(sales_per_order)) * 100, 2) AS profit_margin
FROM ecommerce_data
GROUP BY customer_city
ORDER BY Total_Profits DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--6.Tổng doanh thu và lợi nhuận theo loại sản phẩm
SELECT category_name, 
       SUM(sales_per_order) AS total_sales, 
       SUM(profit_per_order) AS total_profit,
       ROUND((SUM(profit_per_order) / SUM(sales_per_order)) * 100, 2) AS profit_margin
FROM ecommerce_data
GROUP BY category_name
ORDER BY total_profit DESC;

--7.Tổng doanh thu và lợi nhuận theo sản phẩm
SELECT product_name, 
       SUM(sales_per_order) AS total_sales, 
       SUM(profit_per_order) AS total_profit, 
       ROUND((SUM(profit_per_order) / SUM(sales_per_order)) * 100, 2) AS profit_margin
FROM ecommerce_data
GROUP BY product_name
ORDER BY total_profit DESC;

-- 8.Sản phẩm sinh lời nhiều nhất và ít nhất
SELECT product_name, 
       ROUND(SUM(sales_per_order),2) AS total_sales, 
       ROUND(SUM(profit_per_order),2) AS total_profit
FROM ecommerce_data
GROUP BY product_name
ORDER BY total_profit DESC
OFFSET 0 ROWS FETCH NEXT 15 ROWS ONLY;

--9.Phân khúc khách hàng mang lại nhiều lợi nhuận và doanh thu nhất
SELECT customer_segment, 
       SUM(sales_per_order) AS total_sales, 
       SUM(profit_per_order) AS total_profit
FROM ecommerce_data
GROUP BY customer_segment
ORDER BY total_profit DESC;

--10. Tổng số lượng khách hàng
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM ecommerce_data;

-- 11.Số lượng khách hàng tổng cộng
SELECT customer_region, 
       COUNT(DISTINCT customer_id) AS total_customers
FROM ecommerce_data
GROUP BY customer_region
ORDER BY total_customers DESC;

-- 12.Top khách hàng có doanh thu cao nhất
SELECT customer_id, 
       ROUND(SUM(sales_per_order),2) AS total_sales,
       ROUND(SUM(profit_per_order),2) AS total_profit
FROM ecommerce_data
GROUP BY customer_id
ORDER BY total_sales DESC
OFFSET 0 ROWS FETCH NEXT 15 ROWS ONLY;

-- 13.Thời gian giao hàng trung bình
SELECT ROUND(AVG(DATEDIFF(day, order_date, ship_date)), 1) AS avg_shipping_time
FROM ecommerce_data;

-- 14. Thời gian giao hàng trung bình theo từng loại
SELECT shipping_type, 
       ROUND(AVG(DATEDIFF(day, order_date, ship_date)), 1) AS avg_shipping_time
FROM ecommerce_data
GROUP BY shipping_type
ORDER BY avg_shipping_time DESC;

-- 15. Phân khúc khách hàng với loại sản phẩm
WITH RankedData AS (
    SELECT 
        category_name,
        customer_segment,
        ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY (SUM(profit_per_order + sales_per_order))) AS rn
    FROM ecommerce_data
    GROUP BY category_name, customer_segment
)
SELECT 
    category_name,
    STRING_AGG(customer_segment, ', ') AS protoc
FROM RankedData
GROUP BY category_name
ORDER BY category_name ASC;


-- 16.Phân khúc khách hàng cho từng loại sản phẩm, sắp xếp theo tên loại sản phẩm
SELECT category_name, 
       STRING_AGG(customer_segment, ', ') AS protoc,
       ROUND(SUM(total_traffic),2) AS total_traffic
FROM (
    SELECT category_name, 
           customer_segment,
           SUM(profit_per_order + sales_per_order) AS total_traffic
    FROM ecommerce_data
    GROUP BY category_name, customer_segment
) AS X
GROUP BY category_name
ORDER BY category_name ASC;



-- 17.Tổng doanh thu và lợi nhuận cho từng phân khúc khách hàng
SELECT customer_segment, 
       SUM(profit_per_order + sales_per_order) AS total_tr
FROM ecommerce_data
GROUP BY customer_segment
ORDER BY total_tr DESC;

-- 18.tổng doanh thu và lợi nhuận theo phân khúc khách hàng, sau đó sắp xếp theo tổng doanh thu và lợi nhuận giảm dần
SELECT customer_segment, 
       SUM(total_tr) AS c 
FROM (    
    SELECT customer_segment, 
           (profit_per_order + sales_per_order) AS total_tr
    FROM ecommerce_data
) AS X
GROUP BY customer_segment
ORDER BY c DESC;

-- lượng đơn hàng cho từng phân khúc khách hàng và sắp xếp theo tổng doanh thu và lợi nhuận giảm dần
SELECT customer_segment, 
       COUNT(*) AS total_count
FROM ecommerce_data
GROUP BY customer_segment
ORDER BY SUM(profit_per_order + sales_per_order) DESC;










