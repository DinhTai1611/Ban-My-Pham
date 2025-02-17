USE [QLSkincare]
GO
/****** Object:  Table [dbo].[skincare]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skincare](
	[maskincare] [bigint] IDENTITY(1,1) NOT NULL,
	[tenskincare] [nvarchar](50) NULL,
	[soluong] [bigint] NULL,
	[gia] [bigint] NULL,
	[maloai] [bigint] NULL,
	[anh] [nvarchar](50) NULL,
 CONSTRAINT [PK_skincare] PRIMARY KEY CLUSTERED 
(
	[maskincare] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[khachhang]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[khachhang](
	[makh] [bigint] IDENTITY(1,1) NOT NULL,
	[tenkh] [nvarchar](50) NULL,
	[diachi] [nvarchar](50) NULL,
	[sodt] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[tendn] [nvarchar](50) NULL,
	[pass] [nvarchar](50) NULL,
 CONSTRAINT [PK_khachhang] PRIMARY KEY CLUSTERED 
(
	[makh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hoadon]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hoadon](
	[mahoadon] [bigint] IDENTITY(1,1) NOT NULL,
	[makh] [bigint] NULL,
	[ngaymua] [datetime] NULL,
	[damua] [bit] NULL,
 CONSTRAINT [PK_hoadon] PRIMARY KEY CLUSTERED 
(
	[mahoadon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chitiethoadon]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chitiethoadon](
	[machitiethd] [bigint] IDENTITY(1,1) NOT NULL,
	[maskincare] [bigint] NULL,
	[soluongmua] [int] NULL,
	[mahoadon] [bigint] NULL,
	[hddamua] [bit] NULL,
 CONSTRAINT [PK_chitiethoadon] PRIMARY KEY CLUSTERED 
(
	[machitiethd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vlichsu]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vlichsu]
AS
SELECT dbo.skincare.maskincare, dbo.skincare.tenskincare, dbo.chitiethoadon.soluongmua, dbo.skincare.gia, dbo.khachhang.makh, dbo.skincare.gia * dbo.chitiethoadon.soluongmua AS thanhtien, dbo.chitiethoadon.hddamua, 
                  dbo.hoadon.ngaymua
FROM     dbo.hoadon INNER JOIN
                  dbo.khachhang ON dbo.hoadon.makh = dbo.khachhang.makh INNER JOIN
                  dbo.chitiethoadon ON dbo.hoadon.mahoadon = dbo.chitiethoadon.mahoadon INNER JOIN
                  dbo.skincare ON dbo.chitiethoadon.maskincare = dbo.skincare.maskincare
GO
/****** Object:  View [dbo].[Vhoadon]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vhoadon]
AS
SELECT dbo.skincare.maskincare, dbo.skincare.tenskincare, dbo.skincare.gia, dbo.chitiethoadon.soluongmua
FROM     dbo.chitiethoadon INNER JOIN
                  dbo.skincare ON dbo.chitiethoadon.maskincare = dbo.skincare.maskincare INNER JOIN
                  dbo.hoadon ON dbo.chitiethoadon.mahoadon = dbo.hoadon.mahoadon
GO
/****** Object:  View [dbo].[Vadminxn]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vadminxn]
AS
SELECT dbo.chitiethoadon.machitiethd, dbo.khachhang.tenkh, dbo.skincare.tenskincare, dbo.skincare.gia, dbo.chitiethoadon.soluongmua, dbo.chitiethoadon.soluongmua * dbo.skincare.gia AS thanhtien, dbo.chitiethoadon.hddamua
FROM     dbo.hoadon INNER JOIN
                  dbo.khachhang ON dbo.hoadon.makh = dbo.khachhang.makh INNER JOIN
                  dbo.chitiethoadon ON dbo.hoadon.mahoadon = dbo.chitiethoadon.mahoadon INNER JOIN
                  dbo.skincare ON dbo.chitiethoadon.maskincare = dbo.skincare.maskincare
GO
/****** Object:  Table [dbo].[dangnhap]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dangnhap](
	[tendangnhap] [nvarchar](50) NOT NULL,
	[matkhau] [nvarchar](50) NULL,
	[quyen] [bit] NULL,
 CONSTRAINT [PK_dangnhap] PRIMARY KEY CLUSTERED 
(
	[tendangnhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loai]    Script Date: 07/12/2023 8:53:24 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loai](
	[maloai] [bigint] NOT NULL,
	[tenloai] [nvarchar](50) NULL,
 CONSTRAINT [PK_loai] PRIMARY KEY CLUSTERED 
(
	[maloai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[chitiethoadon] ON 

INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (1, 1, 1, 1, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (9, 1, 1, 2, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (10, 1, 1, 5, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (11, 1, 2, 6, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (12, 48, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (13, 14, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (14, 18, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (15, 22, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (16, 27, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (17, 31, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (18, 35, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (19, 39, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (20, 47, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (21, 51, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (22, 55, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (23, 59, 1, 6, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (24, 1, 2, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (25, 48, 2, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (26, 14, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (27, 18, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (28, 22, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (29, 27, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (30, 31, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (31, 35, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (32, 39, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (33, 47, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (34, 51, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (35, 55, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (36, 59, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (37, 11, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (38, 15, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (39, 19, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (40, 28, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (41, 32, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (42, 36, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (43, 40, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (44, 44, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (45, 52, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (46, 56, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (47, 60, 1, 7, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (48, 30, 4, 9, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (49, 12, 1, 10, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (50, 16, 1, 10, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (51, 20, 1, 10, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (52, 24, 1, 10, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (53, 29, 1, 10, 1)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (54, 33, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (55, 37, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (56, 41, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (57, 45, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (58, 49, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (59, 53, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (60, 57, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (61, 61, 1, 10, 0)
INSERT [dbo].[chitiethoadon] ([machitiethd], [maskincare], [soluongmua], [mahoadon], [hddamua]) VALUES (62, 32, 1, 11, 1)
SET IDENTITY_INSERT [dbo].[chitiethoadon] OFF
GO
INSERT [dbo].[dangnhap] ([tendangnhap], [matkhau], [quyen]) VALUES (N'111', N'111', 1)
INSERT [dbo].[dangnhap] ([tendangnhap], [matkhau], [quyen]) VALUES (N'222', N'222', 1)
GO
SET IDENTITY_INSERT [dbo].[hoadon] ON 

INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (1, 1, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (2, 2, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (5, 1, CAST(N'2023-01-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (6, 1, CAST(N'2023-01-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (7, 2, CAST(N'2023-01-18T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (8, 1, CAST(N'2023-01-19T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (9, 5, CAST(N'2023-01-19T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (10, 7, CAST(N'2023-01-19T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[hoadon] ([mahoadon], [makh], [ngaymua], [damua]) VALUES (11, 7, CAST(N'2023-01-19T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[hoadon] OFF
GO
SET IDENTITY_INSERT [dbo].[khachhang] ON 

INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (1, N'nguyen van a', N'hue', N'123', N'123@gmail.com', N'111', N'111')
INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (2, N'nguyen van b', N'da nang', N'456', N'456@gmail.com', N'222', N'222')
INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (3, N'nguyen van c', N'ha noi', N'789', N'789@gmail.com', N'333', N'333')
INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (4, N'a 7 ', N'hue', N'09123', N'ttt123@gmail.com', N'jkp', N'123')
INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (5, N'nguyen van d', N'ha noi', N'147', N'147@gmail.com', N'444', N'444')
INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (6, N'Nguyá»n ÄÃ¬nh TÃ i', N'Huáº¿', N'0777', N'0777@gmail.com', N'555', N'555')
INSERT [dbo].[khachhang] ([makh], [tenkh], [diachi], [sodt], [email], [tendn], [pass]) VALUES (7, N'Nguyen Dinh Tai', N'Hue', N'0777', N'0777@gmail.com', N'666', N'666')
SET IDENTITY_INSERT [dbo].[khachhang] OFF
GO
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (1, N'tẩy trang')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (2, N'chống nắng')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (3, N'sữa rữa mặt')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (4, N'toner')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (5, N'serum ')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (6, N'bông tẩy trang')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (7, N'mặt nạ')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (8, N'tẩy tế bào chết da mặt')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (9, N'chăm sóc da dầu mụn')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (10, N'chăm sóc da vùng mắt')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (11, N'khăn ướt')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (12, N'chiết mỹ phẩm ')
INSERT [dbo].[loai] ([maloai], [tenloai]) VALUES (13, N'kem - gel - xịt dưỡng da')
GO
SET IDENTITY_INSERT [dbo].[skincare] ON 

INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (1, N'Nước Tẩy Trang L''Oréal Paris 3 In 1 Micellar Water', 100, 219000, 1, N'image_skincare/1a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (11, N'Nước Tẩy Trang Dưỡng Ẩm Cho Da Thường, Khô', 50, 219000, 1, N'image_skincare/1b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (12, N'Nước Tẩy Trang 3 In 1 Micellar', 100, 219000, 1, N'image_skincare/1c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (13, N'Nước Tẩy Trang Bí Đao Cocoon ', 150, 295000, 1, N'image_skincare/1d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (14, N'Sữa Chống Nắng Dưỡng Da Kiềm Dầu Bảo Vệ Hoàn Hảo', 100, 715000, 2, N'image_skincare/2a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (15, N'Kem Chống Nắng Kiểm Soát Nhờn Không Màu', 10, 535000, 2, N'image_skincare/2b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (16, N'Kem Chống Nắng L''Oreal', 20, 349000, 2, N'image_skincare/2c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (17, N'Sữa Chống Nắng Dưỡng Da Trắng Mịn', 30, 208000, 2, N'image_skincare/2d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (18, N'Sữa Rửa Mặt Dịu Nhẹ Cho Da Nhạy Cảm', 40, 132000, 3, N'image_skincare/3a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (19, N'Sữa Rửa Mặt Kiềm Dầu Hỗ Trợ Ngừa Mụn', 50, 132000, 3, N'image_skincare/3b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (20, N'Sữa Rửa Mặt Cấp Ẩm', 60, 132000, 3, N'image_skincare/3c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (21, N'Kem Rửa Mặt Dưỡng Ẩm', 70, 79000, 3, N'image_skincare/3d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (22, N'Nước Hoa Hồng Không Mùi Dưỡng Ẩm Và Làm Mềm Da', 80, 409000, 4, N'image_skincare/4a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (23, N'Nước Hoa Hồng Dưỡng Ẩm Cân Bằng Da', 90, 160000, 4, N'image_skincare/4b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (24, N'Nước Hoa Hồng Dưỡng Ẩm Da Và Làm Mềm Da', 100, 409000, 4, N'image_skincare/4c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (26, N'Nước Hoa Hồng Rau Má', 110, 480000, 4, N'image_skincare/4d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (27, N'Serum Vitamin C Giảm Thâm Hỗ Trợ Sáng Da', 120, 180000, 5, N'image_skincare/5a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (28, N'Tinh Chất Dưỡng Sáng Và Làm Đều Màu Da', 130, 455000, 5, N'image_skincare/5b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (29, N'Tinh Chất Skin1004', 140, 610000, 5, N'image_skincare/5c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (30, N'Tinh Chất Pond''S 3D Glow Serum', 150, 246000, 5, N'image_skincare/5d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (31, N'Bông Tẩy Trang Jomi 120', 160, 37000, 6, N'image_skincare/6a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (32, N'Bông Tẩy Trang Cao Cấp Silcot', 170, 47000, 6, N'image_skincare/6b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (33, N'Bông Tẩy Trang Hộp Vuông Guardian ', 180, 29000, 6, N'image_skincare/6c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (34, N'Bông Tẩy Trang Siêu Mềm Guardian', 190, 39000, 6, N'image_skincare/6d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (35, N'Mặt Nạ Giúp Dưỡng Sáng', 200, 29000, 7, N'image_skincare/7a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (36, N'Mặt Nạ Giúp Phục Hồi Da', 210, 29000, 7, N'image_skincare/7b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (37, N'Mặt Nạ Dưỡng Ẩm Cho Da', 220, 29000, 7, N'image_skincare/7c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (38, N'Mặt Nạ Collagen Giúp Ngừa Lão Hoá', 230, 15000, 7, N'image_skincare/7d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (39, N'Tẩy Tế Bào Chết Môi', 240, 75000, 8, N'image_skincare/8a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (40, N'Dak Lak Coffee Face Polish Cocoon', 250, 165000, 8, N'image_skincare/8b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (41, N'Gel Tẩy Tế Bào Chết Và Giúp Tái Tạo Da Purederm', 260, 44000, 8, N'image_skincare/8c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (42, N'Gel Tẩy Tế Bào Chết Gommage Rosette', 270, 175000, 8, N'image_skincare/8d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (43, N'Miếng Dán Mụn Mayancare ', 280, 35000, 9, N'image_skincare/9a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (44, N'Kem Giảm Mụn Anti Acne Cream Derma', 290, 19000, 9, N'image_skincare/9b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (45, N'Miếng Dán Mụn Cho Mọi Loại Da Spot Patch', 300, 92000, 9, N'image_skincare/9c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (46, N'Kem Giảm Mụn Ngừa Thâm La Roche-Posay', 10, 475000, 9, N'image_skincare/9d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (47, N'Kem Vàng Giảm Thâm Mắt', 20, 160000, 10, N'image_skincare/10a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (48, N'Gel Hỗ Trợ Gỉam Nhăn Và Thâm Quầng Mắt', 30, 229000, 10, N'image_skincare/10b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (49, N'Cây Lăn Mắt Lô Hội Và Collagen', 40, 129000, 10, N'image_skincare/10c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (50, N'Dầu Dừa Dưỡng Mi Sense Plus', 50, 38000, 10, N'image_skincare/10d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (51, N'Khăn Giấy Ướt Hương Tự Nhiên Luck Lady', 60, 10000, 11, N'image_skincare/11a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (52, N'Khăn Ướt Tẩy Trang Tươi Mát', 70, 40000, 11, N'image_skincare/11b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (53, N'Khăn Ướt Tẩy Trang Dưỡng Ẩm Có Dầu', 80, 25000, 11, N'image_skincare/11c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (54, N'Khăn Ướt Tẩy Trang Dưỡng Ẩm Dịu Da', 90, 40000, 11, N'image_skincare/11d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (55, N'Bộ Chiết Mỹ Phẩm Du Lịch Guardian', 100, 39000, 12, N'image_skincare/12a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (56, N'Bộ Chiết Mỹ Phẩm Du Lịch N.B', 110, 101000, 12, N'image_skincare/12b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (57, N'Bộ Chiết Mỹ Phẩm Du Lịch Guardian Dạng Tuýp', 120, 39000, 12, N'image_skincare/12c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (58, N'Bộ Chiết Mỹ Phẩm Du Lịch Guardian 6 Món', 130, 99000, 12, N'image_skincare/12d.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (59, N'Kem Dưỡng Giúp Phục Hồi Da La Roche-Posay B5', 140, 390000, 13, N'image_skincare/13a.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (60, N'Kem Dưỡng Cấp Ẩm', 150, 389000, 13, N'image_skincare/13b.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (61, N'Kem Dưỡng Cải Thiện Lão Hóa Da', 160, 274000, 13, N'image_skincare/13c.jpg')
INSERT [dbo].[skincare] ([maskincare], [tenskincare], [soluong], [gia], [maloai], [anh]) VALUES (62, N'Kem Dưỡng Hồi Phục', 170, 465000, 13, N'image_skincare/13d.jpg')
SET IDENTITY_INSERT [dbo].[skincare] OFF
GO
ALTER TABLE [dbo].[chitiethoadon]  WITH CHECK ADD  CONSTRAINT [FK_chitiethoadon_hoadon] FOREIGN KEY([mahoadon])
REFERENCES [dbo].[hoadon] ([mahoadon])
GO
ALTER TABLE [dbo].[chitiethoadon] CHECK CONSTRAINT [FK_chitiethoadon_hoadon]
GO
ALTER TABLE [dbo].[chitiethoadon]  WITH CHECK ADD  CONSTRAINT [FK_chitiethoadon_skincare] FOREIGN KEY([maskincare])
REFERENCES [dbo].[skincare] ([maskincare])
GO
ALTER TABLE [dbo].[chitiethoadon] CHECK CONSTRAINT [FK_chitiethoadon_skincare]
GO
ALTER TABLE [dbo].[hoadon]  WITH CHECK ADD  CONSTRAINT [FK_hoadon_khachhang] FOREIGN KEY([makh])
REFERENCES [dbo].[khachhang] ([makh])
GO
ALTER TABLE [dbo].[hoadon] CHECK CONSTRAINT [FK_hoadon_khachhang]
GO
ALTER TABLE [dbo].[skincare]  WITH CHECK ADD  CONSTRAINT [FK_skincare_loai] FOREIGN KEY([maloai])
REFERENCES [dbo].[loai] ([maloai])
GO
ALTER TABLE [dbo].[skincare] CHECK CONSTRAINT [FK_skincare_loai]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "khachhang"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "hoadon"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 170
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "chitiethoadon"
            Begin Extent = 
               Top = 7
               Left = 774
               Bottom = 170
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "skincare"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4140
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      En' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vadminxn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'd
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vadminxn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vadminxn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "chitiethoadon"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "skincare"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "hoadon"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 170
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 4056
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vhoadon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vhoadon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "skincare"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "khachhang"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "hoadon"
            Begin Extent = 
               Top = 7
               Left = 532
               Bottom = 170
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "chitiethoadon"
            Begin Extent = 
               Top = 7
               Left = 774
               Bottom = 170
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 4056
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2052
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4140
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      En' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vlichsu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'd
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vlichsu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Vlichsu'
GO
