CREATE DATABASE quan_ly_khoa_hoc_online;
USE quan_ly_khoa_hoc_online;

CREATE TABLE KhoaHoc (
    ma_khoa_hoc VARCHAR(10) PRIMARY KEY,
    ten_khoa_hoc VARCHAR(100) NOT NULL,
    nhom_chu_de VARCHAR(100),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    hoc_phi DECIMAL(10 , 2 ) CHECK (hoc_phi >= 0)
);

CREATE TABLE HocVien (
    ma_hoc_vien VARCHAR(10) PRIMARY KEY,
    ho_ten VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    sdt VARCHAR(15) UNIQUE NOT NULL,
    ngay_sinh DATE,
    gioi_tinh ENUM('Nam','Nữ','Khác') NOT NULL
);

CREATE TABLE DangKy (
    ma_dang_ky INT AUTO_INCREMENT PRIMARY KEY,
    ma_hoc_vien VARCHAR(10) NOT NULL,
    ma_khoa_hoc VARCHAR(10) NOT NULL,
    ngay_dang_ky DATE,
    trang_thai_dk ENUM('Confirmed','Cancelled','Pending') NOT NULL,
    so_luong_slot INT NOT NULL DEFAULT 1,
    FOREIGN KEY (ma_hoc_vien) REFERENCES HocVien(ma_hoc_vien),
    FOREIGN KEY (ma_khoa_hoc) REFERENCES KhoaHoc(ma_khoa_hoc)
);

CREATE TABLE ThanhToan (
    ma_thanh_toan INT AUTO_INCREMENT PRIMARY KEY,
    ma_dang_ky INT NOT NULL,
    phuong_thuc ENUM('Credit Card','Bank Transfer','Cash') NOT NULL,
    so_tien DECIMAL(10,2) NOT NULL CHECK (so_tien > 0),
    ngay_thanh_toan DATE,
    trang_thai_tt ENUM('Success','Failed','Pending'),
    FOREIGN KEY (ma_dang_ky) REFERENCES DangKy(ma_dang_ky)
);

INSERT INTO HocVien
VALUES
('S0001','Lê Hoàng Nam','nam.le@example.com','0901001001','1995-01-01','Nam'),
('S0002','Nguyễn Minh Châu','chau.nguyen@example.com','0902002002','1996-02-02','Nữ'),
('S0003','Phạm Bảo Anh','bao.pham@example.com','0903003003','1997-03-03','Nam'),
('S0004','Trần Kim Liên','lien.tran@example.com','0904004004','1998-04-04','Nữ'),
('S0005','Hoàng Tiến Đạt','dat.hoang@example.com','0905005005','1999-05-05','Nam'),
('S0006','Võ Thị Mai','mai.vo@example.com','0906006006','2000-06-06','Nữ'),
('S0007','Đoàn Minh Trí','tri.doan@example.com','0907007007','2001-07-07','Nam'),
('S0008','Nguyễn Thanh Hà','ha.nguyen@example.com','0908008008','2002-08-08','Nữ'),
('S0009','Trịnh Bảo Vy','vy.trinh@example.com','0909009009','2003-09-09','Nữ'),
('S0010','Bùi Hoàng Nam','nam.bui@example.com','0910001010','2004-10-10','Nam');

INSERT INTO KhoaHoc
VALUES
('C001','Web Development','Programming','2025-07-01','2025-08-01',120.0),
('C002','Data Analysis','Data Science','2025-07-10','2025-08-15',150.0),
('C003','Basic Photoshop','Design','2025-07-05','2025-07-30',90.0),
('C004','Intro to Marketing','Marketing','2025-07-12','2025-08-20',110.0);

INSERT INTO DangKy (ma_dang_ky, ma_hoc_vien, ma_khoa_hoc, ngay_dang_ky, trang_thai_dk, so_luong_slot)
VALUES
(1,'S0001','C001','2025-06-01','Confirmed',1),
(2,'S0002','C002','2025-06-02','Pending',2),
(3,'S0003','C003','2025-06-03','Cancelled',3),
(4,'S0004','C004','2025-06-04','Confirmed',1),
(5,'S0005','C001','2025-06-05','Pending',2),
(6,'S0006','C002','2025-06-06','Cancelled',3),
(7,'S0007','C003','2025-06-07','Confirmed',1),
(8,'S0008','C004','2025-06-08','Pending',2),
(9,'S0009','C001','2025-06-09','Cancelled',3),
(10,'S0010','C002','2025-06-10','Confirmed',1),
(11,'S0001','C003','2025-06-11','Pending',2),
(12,'S0002','C004','2025-06-12','Cancelled',3),
(13,'S0003','C001','2025-06-13','Confirmed',1),
(14,'S0004','C002','2025-06-14','Pending',2),
(15,'S0005','C003','2025-06-15','Cancelled',3),
(16,'S0006','C004','2025-06-16','Confirmed',1),
(17,'S0007','C001','2025-06-17','Pending',2),
(18,'S0008','C002','2025-06-18','Cancelled',3),
(19,'S0009','C003','2025-06-19','Confirmed',1),
(20,'S0010','C004','2025-06-20','Pending',2);

INSERT INTO ThanhToan
VALUES
(1,1,'Credit Card',120.0,'2025-06-01','Success'),
(2,2,'Bank Transfer',150.0,'2025-06-02','Failed'),
(3,3,'Cash',90.0,'2025-06-03','Pending'),
(4,4,'Credit Card',110.0,'2025-06-04','Success'),
(5,5,'Cash',120.0,'2025-06-05','Pending'),
(6,6,'Cash',150.0,'2025-06-06','Success'),
(7,7,'Credit Card',90.0,'2025-06-07','Failed'),
(8,8,'Bank Transfer',110.0,'2025-06-08','Pending'),
(9,9,'Cash',120.0,'2025-06-09','Success'),
(10,10,'Credit Card',150.0,'2025-06-10','Pending');

UPDATE ThanhToan
SET trang_thai_tt = 'Success'
WHERE so_tien > 0
  AND phuong_thuc = 'Credit Card'
  AND ngay_thanh_toan < CURRENT_DATE;

UPDATE ThanhToan
SET trang_thai_tt = 'Pending'
WHERE phuong_thuc = 'Bank Transfer'
  AND so_tien < 100
  AND ngay_thanh_toan < CURRENT_DATE;

DELETE FROM ThanhToan
WHERE trang_thai_tt = 'Pending'
  AND phuong_thuc = 'Cash';

SELECT ma_hoc_vien, ho_ten, email, ngay_sinh, gioi_tinh
FROM HocVien
ORDER BY ho_ten ASC
LIMIT 5;

SELECT ma_khoa_hoc, ten_khoa_hoc, danh_muc, hoc_phi
FROM KhoaHoc
ORDER BY hoc_phi DESC;

SELECT h.ma_hoc_vien, h.ho_ten, dk.ma_khoa_hoc, dk.trang_thai_dk
FROM HocVien h
JOIN DangKy dk ON h.ma_hoc_vien = dk.ma_hoc_vien
WHERE dk.trang_thai_dk = 'Cancelled';

SELECT ma_khoa_hoc, ma_hoc_vien, ngay_dang_ky, so_luong_slot
FROM DangKy
WHERE trang_thai_dk = 'Confirmed'
ORDER BY so_luong_slot DESC;

SELECT dk.ma_hoc_vien, h.ho_ten, dk.ma_khoa_hoc, dk.so_luong_slot
FROM DangKy dk
JOIN HocVien h ON dk.ma_hoc_vien = h.ma_hoc_vien
WHERE so_luong_slot BETWEEN 2 AND 3
ORDER BY h.ho_ten;

SELECT h.ma_hoc_vien, h.ho_ten, dk.so_luong_slot, tt.trang_thai_tt
FROM DangKy dk
JOIN ThanhToan tt ON dk.ma_dang_ky = tt.ma_dang_ky
JOIN HocVien h ON dk.ma_hoc_vien = h.ma_hoc_vien
WHERE dk.so_luong_slot >= 2 AND tt.trang_thai_tt = 'Pending';

SELECT h.ho_ten, tt.so_tien
FROM ThanhToan tt
JOIN DangKy dk ON tt.ma_dang_ky = dk.ma_dang_ky
JOIN HocVien h ON dk.ma_hoc_vien = h.ma_hoc_vien
WHERE tt.trang_thai_tt = 'Success';

SELECT dk.ma_hoc_vien, h.ho_ten, dk.so_luong_slot, dk.trang_thai_dk
FROM DangKy dk
JOIN HocVien h ON dk.ma_hoc_vien = h.ma_hoc_vien
WHERE dk.so_luong_slot > 1
ORDER BY dk.so_luong_slot DESC
LIMIT 5;

SELECT ma_khoa_hoc, COUNT(*) AS so_luong
FROM DangKy
GROUP BY ma_khoa_hoc
ORDER BY so_luong DESC
LIMIT 1;

SELECT h.ma_hoc_vien, h.ho_ten, h.ngay_sinh  -- h and dk ở đây là bí danh ;))
FROM HocVien h
JOIN DangKy dk ON h.ma_hoc_vien = dk.ma_hoc_vien
JOIN ThanhToan tt ON dk.ma_dang_ky = tt.ma_dang_ky
WHERE h.ngay_sinh < '2000-01-01'
  AND tt.trang_thai_tt = 'Success';
