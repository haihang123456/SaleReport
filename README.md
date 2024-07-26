# Báo Cáo Tổng Quan Về Hiệu Suất Kinh Doanh

## 1. Tổng Quan Doanh Số
- **Doanh số YTD (Year-To-Date Sales):** Thẻ cung cấp thông tin về tổng doanh số bán hàng từ đầu năm đến nay. Đây là chỉ số quan trọng để đánh giá hiệu suất kinh doanh hiện tại so với các mục tiêu đã đề ra.
- **Lợi nhuận YTD (Year-To-Date Profit):** Thẻ hiển thị tổng lợi nhuận thu được từ đầu năm đến nay, giúp đo lường hiệu quả lợi nhuận so với cùng kỳ năm trước.
- **Số lượng YTD (Year-To-Date Quantity):** Thẻ cho biết tổng số lượng sản phẩm bán được từ đầu năm đến nay, cung cấp cái nhìn về khối lượng bán hàng.
- **Tỷ suất lợi nhuận YTD (Year-To-Date Profit Margin):** Thẻ hiển thị tỷ suất lợi nhuận từ đầu năm đến nay, phản ánh hiệu quả kinh doanh và khả năng sinh lời của công ty.

## 2. Doanh Số Theo Danh Mục
- **Doanh số YTD, PYTD, YOY Sales và Xu hướng (Trend):** Ma trận này cung cấp thông tin chi tiết về doanh số bán hàng theo từng danh mục sản phẩm, bao gồm doanh số hiện tại, doanh số của cùng kỳ năm trước và sự thay đổi so với năm trước. Cột xu hướng giúp xác định nhanh chóng tình trạng tăng trưởng hay giảm sút của mỗi danh mục.

## 3. Sản Phẩm Bán Chạy Nhất (Top 5 Products by YTD Sales)
- **Top 5 Sản Phẩm Bán Chạy Nhất:** Biểu đồ này liệt kê các sản phẩm có doanh số cao nhất từ đầu năm đến nay, giúp nhận diện các sản phẩm chiến lược và tiềm năng.

## 4. Sản Phẩm Bán Kém Nhất (Bottom 5 Products by YTD Sales)
- **Top 5 Sản Phẩm Bán Kém Nhất:** Biểu đồ này liệt kê các sản phẩm có doanh số thấp nhất từ đầu năm đến nay, giúp nhận diện các sản phẩm cần cải thiện hoặc loại bỏ.

## 5. Doanh Số Theo Khu Vực (YTD Sales by Region)
- **Doanh Số Theo Khu Vực:** Biểu đồ tròn này phân tích doanh số theo từng khu vực địa lý, giúp xác định vùng thị trường nào có hiệu suất tốt nhất và vùng nào cần cải thiện.

## 6. Doanh Số Theo Loại Giao Hàng (YTD Sales by Shipping Type)
- **Doanh Số Theo Loại Giao Hàng:** Biểu đồ tròn này phân tích doanh số theo từng loại hình giao hàng, cung cấp thông tin về sự ưa chuộng của khách hàng đối với các phương thức giao hàng khác nhau.

## 7. Doanh Số Theo Bang (Sales by State)
- **Doanh Số Theo Bang:** Bản đồ này hiển thị doanh số bán hàng theo từng bang và khu vực của khách hàng, giúp nhận diện các khu vực có hiệu suất tốt và vùng thị trường tiềm năng.

---

## Kết Luận
- **Tổng Quan:** Các thẻ card và biểu đồ trên dashboard cung cấp một cái nhìn tổng quan về tình hình kinh doanh hiện tại, giúp đánh giá hiệu suất bán hàng, lợi nhuận và nhận diện các xu hướng quan trọng.
- **Phân Tích:** Thông tin chi tiết theo danh mục, sản phẩm, khu vực và phương thức giao hàng giúp doanh nghiệp đưa ra các quyết định chiến lược, tối ưu hóa danh mục sản phẩm và cải thiện hiệu suất kinh doanh.
- **Hành Động:** Các số liệu này là cơ sở để xác định các biện pháp cải thiện, từ việc tối ưu hóa danh mục sản phẩm đến việc nâng cao chiến lược tiếp thị và bán hàng tại các khu vực khác nhau.

## Phần DAX cho Power BI
```DAX
1. Tính YTD
YTD Sales = TOTALYTD(SUM(ecommerce_data[sales_per_order]), 'Calendar'[Date])
YTD Quantity = TOTALYTD(SUM(ecommerce_data[order_quantity]), 'Calendar'[Date])
YTD Concate Qty = CONCATENATE("#", FORMAT([YTD Quantity]/1000, "0.0K"))
YTD Profit Margin = TOTALYTD([Profit Margin], 'Calendar'[Date])
YTD profit = TOTALYTD(SUM(ecommerce_data[profit_per_order]), 'Calendar'[Date]) 

2. Tính YOY
YOY Sales = ([YTD Sales] - [PYTD Sales]) / [PYTD Sales]
YOY Qty = ([YTD Quantity] - [PYTD Qty]) / [PYTD Qty]
YOY ProfitMargin = ([YTD Profit Margin] - [PYTD Profit Margin]) / [PYTD Profit Margin]
YOY Profit = ([YTD profit] - [PYTD Profit]) / [PYTD Profit]

3. Tính PYTD
PYTD Profit = CALCULATE(SUM(ecommerce_data[profit_per_order]), DATESYTD(SAMEPERIODLASTYEAR('Calendar'[Date])))
PYTD Profit Margin = CALCULATE([Profit Margin], DATESYTD(SAMEPERIODLASTYEAR('Calendar'[Date])))
PYTD Qty = CALCULATE(SUM(ecommerce_data[order_quantity]), DATESYTD(SAMEPERIODLASTYEAR('Calendar'[Date])))
PYTD Sales = CALCULATE(SUM(ecommerce_data[sales_per_order]), DATESYTD(SAMEPERIODLASTYEAR('Calendar'[Date])))

4. DAX khác
Profit Margin = SUM(ecommerce_data[profit_per_order]) / SUM(ecommerce_data[sales_per_order])

