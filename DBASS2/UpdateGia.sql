USE [ASS2]
GO

UPDATE [dbo].[CungCap]
   SET GiaCa = GiaCa + GiaCa*0.1
 WHERE MSNVL IN (SELECT MSNVL FROM dbo.NhaCungCap
	INNER JOIN dbo.CungCap
		On dbo.NhaCungCap.MSNCC = dbo.CungCap.MSNCC
			Where TenNCC = 'Thanh Cong') AND (MSNCC =  
			(SELECT dbo.NhaCungCap.MSNCC AS MSNCC FROM dbo.NhaCungCap
			Where TenNCC = 'Thanh Cong'))
GO

			