USE [ASS2]
GO
SELECT dbo.CungCap.MSNCC,dbo.CungCap.MSNVL,dbo.CungCap.GiaCa From dbo.CungCap, (SELECT MSNVL, Min(GiaCa) AS GiaCa FROM dbo.CungCap
	Group By MSNVL) tmp 
	WHERE tmp.MSNVL = dbo.CungCap.MSNVL and tmp.GiaCa = dbo.CungCap.GiaCa

USE [ASS2]
GO

SELECT TenNVL FROM dbo.NguyenVatLieu
INNER JOIN (SELECT MSNVL AS Targ  FROM dbo.XuatNVL
WHERE dbo.XuatNVL.MSPX IN (SELECT MSPX FROM dbo.PhieuXuatNVL WHERE NgayXuat BETWEEN '2022-03-01 00:00:00' and '2022-03-31 00:00:00')
GROUP BY MSNVL) tmp
ON MSNVL = Targ

Select TenNVL FROM dbo.NguyenVatLieu 
INNER JOIN (SELECT MSNVL From dbo.DinhMuc 
WHERE MSMH in (SELECT MSMH FROM dbo.MatHang WHERE TenMH = 'Tuong ot')) tmp
ON dbo.NguyenVatLieu.MSNVL = tmp.MSNVL

SELECT TenNVL FROM dbo.NguyenVatLieu
INNER JOIN (SELECT MSNVL  FROM dbo.XuatNVL
INNER JOIN
 (SELECT MSPX FROM dbo.PhieuXuatNVL WHERE MSPXUONG IN (SELECT MSPX AS MSPXG FROM dbo.PhanXuong WHERE TenPX ='Khu A')) tmp
ON 
	dbo.XuatNVL.MSPX = tmp.MSPX
GROUP BY MSNVL) tmp
ON tmp.MSNVL = dbo.NguyenVatLieu.MSNVL
