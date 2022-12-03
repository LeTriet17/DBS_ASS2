USE [ASS2]
GO

INSERT INTO [dbo].[MatHang]
           ([MSMH]
           ,[TenMH]
           ,[Mota]
           ,[DVT]
           ,[MSLoai])
     VALUES
           ('NCH01234','tuong ot','khong','hop','1'),
		   ('NCH01235','tuong ca','khong','hop','1'),
		   ('NCH01236','cha gio','khong','cai','2'),
		   ('NCH01237','tra kho qua','khong','hop','2');
INSERT INTO [dbo].[NhaCungCap]
           ([MSNCC]
           ,[TenNCC]
           ,[DiaChi])
     VALUES
           ('NCC1','Thanh Cong','Viet Nam'),
           ('NCC2','Thanh Thai','Viet Nam'),
           ('NCC3','Viet Nam','Viet Nam'),
           ('NCC4','Viet Nam','Viet Nam');
INSERT INTO [dbo].[NguoiDaiDien]
           ([MSNCC]
           ,[TenNDD]
           ,[SoDT])
     VALUES
           ('NCC1','Nguyen Van A','0987654321'),
           ('NCC2','Nguyen Van B','0997654321'),
           ('NCC3','Nguyen Van C','0988654321'),
           ('NCC4','Nguyen Van D','0987754321');
INSERT INTO [dbo].[NguyenVatLieu]
           ([MSNVL]
           ,[TenNVL]
           ,[Mota]
           ,[DVT]
           ,[SLTon])
     VALUES
          ('NVL1','Tao','Khong','kg',100),
           ('NVL2','Ot','Khong','kg',250),
           ('NVL3','Gao','Khong','kg',1000),
           ('NVL4','Ga','Khong','kg',500),
           ('NVL5','Nuoc Dung','Khong','lit',100);

INSERT INTO [dbo].[CungCap]
           ([MSNCC]
           ,[MSNVL]
           ,[GiaCa])
     VALUES
           ('NCC1','NVL1',100),
           ('NCC1','NVL2',100),
           ('NCC2','NVL1',100),
           ('NCC3','NVL3',100),
           ('NCC1','NVL4',100),
           ('NCC4','NVL2',100);




INSERT INTO [dbo].[PhanXuong]
           ([MSPX]
           ,[TenPX])
     VALUES
           ('PX1','Khu A'),
           ('PX2','Khu B'),
           ('PX3','Khu C'),
           ('PX4','Khu D');
INSERT INTO [dbo].[LenhSanXuat]
           ([MSLenh]
           ,[NgayLSX]
           ,[TenPX])
     VALUES
           ('MSL1','2022/03/05','Khu A'),
           ('MSL2','2022/10/05','Khu B'),
           ('MSL3','2022/03/20','Khu C'),
           ('MSL4','2021/09/07','Khu D');
INSERT INTO [dbo].[PhieuTraNVL]
           ([MSPT]
           ,[NgayTra]
           ,[MSLenh]
           ,[MSPX])
     VALUES
            ('PT12345678','2022/10/09','MSL1','PX1'),
           ('PT18845678','2022/05/12','MSL2','PX2'),
           ('PT12354678','2022/12/12','MSL3','PX3'),
           ('PT12378678','2022/03/20','MSL4','PX4');



          
INSERT INTO [dbo].[PhieuXuatNVL]
           ([MSPX]
           ,[NgayXuat]
           ,[MSLenh]
           ,[MSPXUONG])
     VALUES
          ('PX12345688','2022/03/06','MSL1','PX1'),
         ('PX12345988','2022/10/10','MSL2','PX2'),
           ('PX12342688','2021/03/20','MSL3','PX3'),
           ('PX12345683','2022/09/07','MSL4','PX4');
INSERT INTO [dbo].[PhieuNhapTP]
           ([MSPN]
           ,[NgayNhap]
           ,[MSLenh]
           ,[MSPX])
     VALUES
			('PN12345688','2022/03/05','MSL1','PX1'),
           ('PN12345988','2022/10/10','MSL2','PX2'),
           ('PN12342688','2021/03/20','MSL3','PX3'),
           ('PN12345683','2022/09/07','MSL4','PX4');
INSERT INTO [dbo].[TraNVL]
           ([MSPT]
           ,[MSNVL]
           ,[SoLuong])
     VALUES
           ('PT12345678','NVL2',100),
           ('PT12354678','NVL1',100),
           ('PT12378678','NVL3',100),
           ('PT18845678','NVL4',100);
INSERT INTO [dbo].[XuatNVL]
           ([MSPX]
           ,[MSNVL]
           ,[SoLuong])
     VALUES
           ('PX12342688','NVL1',50),
		   ('PX12345683','NVL2',50),
          ('PX12345688','NVL1',500),
		   ('PX12345988','NVL3',100);

INSERT INTO [dbo].[NhapNVL]
           ([MSPN]
           ,[MSNVL]
           ,[SoLuong])
     VALUES
           ('PN12342688','NVL1',250),
           ('PN12345683','NVL2',95),
           ('PN12345688','NVL1',70),
		   ('PN12345988','NVL3',20);

INSERT INTO [dbo].[DinhMuc]
           ([MSMH]
           ,[MSNVL]
           ,[NgayAD]
           ,[SoLuong])
     VALUES
           ('NCH01234','NVL1','2022/10/10',1),
           ('NCH01234','NVL2','2022/10/10',1),
           ('NCH01235','NVL2','2022/10/10',1),
           ('NCH01236','NVL3','2022/10/10',1),
           ('NCH01236','NVL4','2022/10/10',1),
           ('NCH01237','NVL4','2022/10/10',1);


GO



