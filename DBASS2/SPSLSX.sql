SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TongSoLuongSanXuat 
	-- Add the parameters for the stored procedure here
	@MSMHang varchar(20) = NULL, 
	@thang int = 0,
	@nam int =0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT Min(SoLuongSanXuat) AS SoLuongSanXuatTrongThang FROM (SELECT  tmp3.MSNVL AS MSNVL ,SUM(tmp3.SoLuongSanXuat/tmp3.Tile) AS SoLuongSanXuat  FROM (SELECT  tmp2.MSNVL , tmp2.TiLe AS Tile ,ISNULL((CASE WHEN dbo.PhieuXuatNVL.NgayXuat BETWEEN (select datefromparts(@nam, @thang, 1)) AND  (select datefromparts(@nam, @thang, 30)) THEN tmp2.SoLuong ELSE 0 END),0)
       AS SoLuongSanXuat FROM dbo.PhieuXuatNVL JOIN(SELECT MSPX,tmp.TiLe AS TiLe ,SoLuong,tmp.MSNVL AS MSNVL FROM dbo.XuatNVL INNER JOIN (SELECT MSNVL, SoLuong As TiLe FROM dbo.DinhMuc WHERE MSMH = @MSMHang) tmp 
	ON tmp.MSNVL = dbo.XuatNVL.MSNVL) tmp2 ON tmp2.MSPX = dbo.PhieuXuatNVL.MSPX ) tmp3 GROUP BY tmp3.MSNVL) tmp4;
END
GO
EXEC TongSoLuongSanXuat @MSMHang = 'NCH01234', @thang = 03, @nam =2022;
