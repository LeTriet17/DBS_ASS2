USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'ASS2'
)
CREATE DATABASE [ASS2]
GO
USE [ASS2]
-- Create a new table called 'Customers' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.MatHang', 'U') IS NOT NULL
DROP TABLE dbo.MatHang
-- Create the table in the specified schema
CREATE TABLE dbo.MatHang
(
	MSMH varchar(20)
	CHECK(MSMH like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9]') NOT NULL    PRIMARY KEY, 	    -- primary key column
	TenMH	varchar(20) NOT NULL,
	Mota	varchar(100),
	DVT varchar(10) 
	CHECK(DVT IN ('Cai', 'Hop','Goi','Chai')) 
	DEFAULT 'Cai',
	MSLoai int,
);
CREATE TABLE dbo.NhaCungCap
(
	MSNCC	varchar(20) NOT NULL   PRIMARY KEY, 	    -- primary key column
	TenNCC	varchar(20) NOT NULL,
	DiaChi varchar(100)
	NOT NULL 

);
CREATE TABLE dbo.NguoiDaiDien
(
	SoDT varchar(10)
	CHECK(SoDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL   PRIMARY KEY, 	    -- primary key column
	MSNCC	varchar(20) NOT NULL UNIQUE,
	TenNDD varchar(20) NOT NULL,
	FOREIGN KEY (MSNCC) REFERENCES dbo.NhaCungCap(MSNCC)

);

CREATE TABLE dbo.NguyenVatLieu
(	
	MSNVL varchar(10) NOT NULL PRIMARY KEY,
	TenNVL varchar(10) NOT NULL,
	Mota	varchar(100),
	DVT varchar(10) 
	CHECK(DVT IN ('kg', 'g', 'mg', 'm', 'mm', 'lit', 'ml')),
	SLTon int
	CHECK(SLTon >=0),
	
);
CREATE TABLE dbo.CungCap
(
	MSNCC	varchar(20) NOT NULL, 	  
	MSNVL varchar(10) NOT NULL,
	GiaCa float
	CHECK(GiaCa >=0),
	CONSTRAINT MaCungCap PRIMARY KEY (MSNCC,MSNVL),  -- primary key column
	FOREIGN KEY (MSNCC) REFERENCES dbo.NhaCungCap(MSNCC),
	FOREIGN KEY (MSNVL) REFERENCES dbo.NguyenVatLieu(MSNVL)
);
CREATE TABLE dbo.PhanXuong
(	
	MSPX varchar(20) NOT NULL PRIMARY KEY,
	TenPX varchar(20) NOT NULL UNIQUE,
);
CREATE TABLE dbo.LenhSanXuat
(	
	MSLenh varchar(20) NOT NULL PRIMARY KEY,
	NgayLSX datetime NOT NULL DEFAULT getdate(),
	TenPX varchar(20) NOT NULL,
	FOREIGN KEY (TenPX) REFERENCES dbo.PhanXuong(TenPX)
);
CREATE TABLE dbo.PhieuXuatNVL
(	
	MSPX varchar(20)
	CHECK(MSPX like 'PX[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL   PRIMARY KEY,
	NgayXuat datetime NOT NULL DEFAULT getdate(),
	MSLenh	varchar(20) NOT NULL UNIQUE,
	MSPXUONG varchar(20) NOT NULL,
	FOREIGN KEY (MSLenh) REFERENCES dbo.LenhSanXuat(MSLenh),
	FOREIGN KEY (MSPXUONG) REFERENCES dbo.PhanXuong(MSPX)

);
CREATE TABLE dbo.PhieuTraNVL
(	
	MSPT varchar(20)
	CHECK(MSPT like 'PT[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL   PRIMARY KEY,
	NgayTra datetime NOT NULL DEFAULT getdate(),
	MSLenh	varchar(20) NOT NULL UNIQUE,
	MSPX varchar(20) NOT NULL,
	FOREIGN KEY (MSLenh) REFERENCES dbo.LenhSanXuat(MSLenh),
	FOREIGN KEY (MSPX) REFERENCES dbo.PhanXuong(MSPX)
);
CREATE TABLE dbo.PhieuNhapTP
(	
	MSPN varchar(20)
	CHECK(MSPN like 'PN[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL   PRIMARY KEY,
	NgayNhap datetime NOT NULL DEFAULT getdate(),
	MSLenh	varchar(20) NOT NULL UNIQUE,
	MSPX varchar(20) NOT NULL,
	FOREIGN KEY (MSLenh) REFERENCES dbo.LenhSanXuat(MSLenh),
	FOREIGN KEY (MSPX) REFERENCES dbo.PhanXuong(MSPX)
);
CREATE TABLE dbo.DinhMuc
(	
	MSMH varchar(20)
	CHECK(MSMH like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9]') NOT NULL, 	    -- primary key column
	MSNVL varchar(10) NOT NULL,
	NgayAD datetime NOT NULL DEFAULT getdate(),
	SoLuong	int
	CHECK(SoLuong >=0),
	CONSTRAINT MaDinhMuc PRIMARY KEY (MSMH,MSNVL),
	FOREIGN KEY (MSMH) REFERENCES dbo.MatHang(MSMH),
	FOREIGN KEY (MSNVL) REFERENCES dbo.NguyenVatLieu(MSNVL)

);
CREATE TABLE dbo.XuatNVL
(	
	MSPX varchar(20)
	CHECK(MSPX like 'PX[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL, 	   
	MSNVL varchar(10) NOT NULL,
	SoLuong	int
	CHECK(SoLuong >=0),
	CONSTRAINT MaXuatNVL PRIMARY KEY (MSPX,MSNVL),  -- primary key column
	FOREIGN KEY (MSPX) REFERENCES dbo.PhieuXuatNVL(MSPX),
	FOREIGN KEY (MSNVL) REFERENCES dbo.NguyenVatLieu(MSNVL)
);
CREATE TABLE dbo.NhapNVL
(	
	MSPN varchar(20)
	CHECK(MSPN like 'PN[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL, 	   
	MSNVL varchar(10) NOT NULL,
	SoLuong	int
	CHECK(SoLuong >=0),
	CONSTRAINT MaNhapNVL PRIMARY KEY (MSPN,MSNVL),  -- primary key column
	FOREIGN KEY (MSPN) REFERENCES dbo.PhieuNhapTP(MSPN),
	FOREIGN KEY (MSNVL) REFERENCES dbo.NguyenVatLieu(MSNVL)
);
CREATE TABLE dbo.TraNVL
(	
	MSPT varchar(20)
	CHECK(MSPT like 'PT[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL  UNIQUE, 	   
	MSNVL varchar(10) NOT NULL,
	SoLuong	int
	CHECK(SoLuong >=0),
	CONSTRAINT MaTraNVL PRIMARY KEY (MSPT,MSNVL),  -- primary key column
	FOREIGN KEY (MSPT) REFERENCES dbo.PhieuTraNVL(MSPT),
	FOREIGN KEY (MSNVL) REFERENCES dbo.NguyenVatLieu(MSNVL)
);
CREATE INDEX idx_tenmonhang ON dbo.MatHang (TenMH); -- index ten Mon Hang
CREATE INDEX idx_thongtintonkho ON dbo.NguyenVatLieu (MSNVL,MoTa,SLTon); -- index Thong Tin Ton Kho
CREATE INDEX idx_thongtinlsx ON dbo.LenhSanXuat (MSLenh,NgayLSX); -- index Thong Lenh san xuat

GO