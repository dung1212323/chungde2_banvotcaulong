# chuyengde2_banvotcaulong
<h1 align="center">🏸 BadmintonShop</h1>

<p align="center">
  Hệ Thống Quản Lý Bán Vợt Cầu Lông
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Frontend-blue?logo=flutter">
  <img src="https://img.shields.io/badge/Laravel-Backend-red?logo=laravel">
  <img src="https://img.shields.io/badge/MySQL-Database-orange?logo=mysql">
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen">
</p>

---

## 📋 Giới Thiệu

**LI NING** là hệ thống phần mềm giúp quản lý và bán vợt cầu lông trực tuyến.  
Người dùng có thể dễ dàng tìm kiếm, xem thông tin và đặt mua sản phẩm nhanh chóng.

Hệ thống được xây dựng nhằm phục vụ mục đích học tập và phát triển kỹ năng lập trình fullstack.

---

## 🚀 Demo Giao Diện

<p align="center">
  <img src="https://via.placeholder.com/800x400.png?text=App+UI+Preview">
</p>

---

## 👥 Thành Viên Nhóm

| 👤 Họ và Tên | 🎯 Vai Trò |
|-------------|-----------|
| Nguyễn Quốc Bảo | Trưởng Nhóm |
| Nguyễn Đức Dũng | Thành Viên |
| Đặng Thị Kim Anh | Thành Viên |
| Doãn Ngọc Ánh | Thành Viên |
| Hoàng Đức Giáp | Thành Viên |

---

## 🎯 Mục Tiêu

- 🏸 Xây dựng hệ thống bán vợt cầu lông online
- ⚡ Tối ưu trải nghiệm người dùng
- 📦 Quản lý sản phẩm & đơn hàng hiệu quả
- 📱 Hỗ trợ đa nền tảng

---

## ✨ Tính Năng

### 👤 Người dùng
- 🔐 Đăng ký / Đăng nhập
- 🔍 Tìm kiếm sản phẩm
- 🏸 Xem chi tiết vợt cầu lông
- 🛒 Thêm vào giỏ hàng
- 💳 Thanh toán (giả lập)
- ⭐ Đánh giá sản phẩm

### 🛠️ Quản trị viên
- 📊 Quản lý sản phẩm
- 📦 Quản lý đơn hàng
- 👥 Quản lý người dùng

---

## 🛠️ Công Nghệ

| Thành Phần | Công Nghệ |
|-----------|----------|
| Frontend | Flutter |
| Backend | Laravel |
| Database | MySQL / PostgreSQL |
| API | RESTful API |
| Auth | JWT / Sanctum |

---

## 📦 Cài Đặt

### 🔧 Backend

```bash
git clone https://github.com/your-repo/badminton-shop.git
cd badminton-shop/backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
