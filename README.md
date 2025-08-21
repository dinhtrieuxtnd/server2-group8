# Cách chạy dự án
Sau khi đã clone code về tạo branch mới thì làm theo các bước sau
1. Cài đặt các gói phụ thuộc
    - ```npm i```
2. Cấu hình file môi trường
    - Sửa lại tên file .env.example thành .env là được
3. Khởi chạy CSDL bằng docker (nhớ cài docker trước khi làm)
    - ```docker-compose up -d```
4. Áp dụng các migration vào CSDL
    - ```npx prisma migrate dev```
5. Khởi chạy ứng dụng
    - ```npm run start:dev```
    - Sau đó bật trình duyệt vào localhost:3000/api để vào giao diện swagger