# Đặc tả API Quản lý Kho Hàng

## 1. Authentication & User Management

### Đăng ký (Register)

-   **Endpoint**: `POST /auth/register`
-   **Mô tả**: Tạo tài khoản mới
-   **Input**: `{ username, email, password }`
-   **Output**: `201 Created` + thông tin user (ẩn mật khẩu)

### Đăng nhập (Login)

-   **Endpoint**: `POST /auth/login`
-   **Mô tả**: Đăng nhập hệ thống, nhận JWT access token + refresh token
-   **Input**: `{ email, password }`
-   **Output**: `{ access_token, refresh_token }`

### Refresh Token

-   **Endpoint**: `POST /auth/refresh`
-   **Mô tả**: Cấp lại access token mới từ refresh token
-   **Input**: `{ refresh_token }`
-   **Output**: `{ access_token }`

------------------------------------------------------------------------

## 2. Quản lý Sản phẩm (Products)

### Lấy danh sách sản phẩm

-   **Endpoint**: `GET /products`
-   **Mô tả**: Trả về danh sách tất cả sản phẩm (có phân trang)
-   **Output**:
    `[ { id, sku, name, cost_price, sell_price, stock, ... } ]`

### Lấy chi tiết sản phẩm

-   **Endpoint**: `GET /products/{id}`
-   **Mô tả**: Trả về chi tiết sản phẩm theo ID
-   **Output**: `{ id, sku, name, category, brand, prices, stock }`

### Tạo sản phẩm mới

-   **Endpoint**: `POST /products`
-   **Mô tả**: Tạo sản phẩm mới
-   **Input**:
    `{ sku, name, category_id, brand_id, cost_price, sell_price, min_stock }`
-   **Output**: `201 Created` + sản phẩm mới

### Cập nhật sản phẩm

-   **Endpoint**: `PUT /products/{id}`
-   **Mô tả**: Cập nhật thông tin sản phẩm
-   **Input**: `{ name?, cost_price?, sell_price?, min_stock? }`
-   **Output**: `200 OK`

### Xóa sản phẩm

-   **Endpoint**: `DELETE /products/{id}`
-   **Mô tả**: Xóa sản phẩm theo ID
-   **Output**: `204 No Content`

------------------------------------------------------------------------

## 3. Quản lý Kho (Stock)

### Kiểm tra tồn kho

-   **Endpoint**: `GET /stock/{product_id}`
-   **Mô tả**: Xem số lượng tồn kho của sản phẩm
-   **Output**: `{ product_id, stock }`

### Nhập kho (Stock In)

-   **Endpoint**: `POST /stock/in`
-   **Mô tả**: Nhập thêm số lượng cho sản phẩm
-   **Input**: `{ product_id, quantity, note? }`
-   **Output**: `200 OK` + stock mới

### Xuất kho (Stock Out)

-   **Endpoint**: `POST /stock/out`
-   **Mô tả**: Xuất số lượng khỏi kho
-   **Input**: `{ product_id, quantity, note? }`
-   **Output**: `200 OK` + stock mới

------------------------------------------------------------------------

## 4. Quản lý Đơn hàng (Orders)

### Tạo đơn hàng mới

-   **Endpoint**: `POST /orders`
-   **Mô tả**: Tạo đơn hàng xuất/nhập
-   **Input**:
    `{ type: "import" | "export", items: [ { product_id, quantity, price } ] }`
-   **Output**: `201 Created` + thông tin đơn hàng

### Lấy danh sách đơn hàng

-   **Endpoint**: `GET /orders`
-   **Mô tả**: Trả về danh sách các đơn hàng
-   **Output**: `[ { id, type, status, created_at } ]`

### Lấy chi tiết đơn hàng

-   **Endpoint**: `GET /orders/{id}`
-   **Mô tả**: Trả về chi tiết đơn hàng
-   **Output**: `{ id, type, status, items: [...] }`

### Cập nhật trạng thái đơn hàng

-   **Endpoint**: `PUT /orders/{id}/status`
-   **Mô tả**: Cập nhật trạng thái (pending, completed, canceled)
-   **Input**: `{ status }`
-   **Output**: `200 OK`

------------------------------------------------------------------------

## 5. Báo cáo (Reports)

### Báo cáo tồn kho

-   **Endpoint**: `GET /reports/stock`
-   **Mô tả**: Trả về báo cáo tồn kho (sản phẩm nào dưới min_stock)
-   **Output**: `[ { product, stock, min_stock } ]`

### Báo cáo doanh thu

-   **Endpoint**: `GET /reports/revenue`
-   **Mô tả**: Báo cáo doanh thu theo khoảng thời gian
-   **Input (query)**: `?from=YYYY-MM-DD&to=YYYY-MM-DD`
-   **Output**: `{ total_revenue, total_orders, best_seller }`
