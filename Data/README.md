# Mô tả File Dữ liệu

## Giới thiệu
File `Sales_data.csv` chứa thông tin chi tiết về các giao dịch bán hàng, bao gồm các thông tin liên quan đến sản phẩm, khách hàng, khu vực, và thời gian giao hàng. File `long_lat.csv` chứa thông tin về tọa độ địa lý của các bang, bao gồm tên bang, vĩ độ và kinh độ.

## Cấu trúc dữ liệu

### File `Sales_data.csv`
Dữ liệu trong file `Sales_data.csv` được tổ chức theo các cột như sau:

1. **order_id**: Mã định danh duy nhất cho mỗi đơn hàng.
2. **order_date**: Ngày đặt hàng (định dạng YYYY-MM-DD).
3. **ship_date**: Ngày giao hàng (định dạng YYYY-MM-DD).
4. **customer_id**: Mã định danh duy nhất cho mỗi khách hàng.
5. **customer_name**: Tên của khách hàng.
6. **customer_segment**: Phân khúc khách hàng (ví dụ: Consumer, Corporate, Home Office).
7. **customer_city**: Thành phố của khách hàng.
8. **customer_state**: Bang của khách hàng.
9. **customer_region**: Khu vực của khách hàng (ví dụ: Central, East, South, West).
10. **product_id**: Mã định danh duy nhất cho mỗi sản phẩm.
11. **category_name**: Tên loại sản phẩm (ví dụ: Furniture, Office Supplies, Technology).
12. **product_name**: Tên sản phẩm.
13. **sales_per_order**: Doanh thu từ mỗi đơn hàng.
14. **profit_per_order**: Lợi nhuận từ mỗi đơn hàng.
15. **order_quantity**: Số lượng sản phẩm đặt hàng.
16. **shipping_type**: Loại hình giao hàng (ví dụ: Standard Class, Second Class, First Class, Same Day).

### File `long_lat.csv`
Dữ liệu trong file `long_lat.csv` được tổ chức theo các cột như sau:

1. **state**: Bang.
2. **latitude**: Vĩ độ của bang.
3. **longitude**: Kinh độ của bang.
4. **name**: Tên của bang.



