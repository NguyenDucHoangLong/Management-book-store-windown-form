USE [QLSACH_VPP]
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 7/11/2016 12:10:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaHoaDon] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_ChiTietHoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DanhMuc]    Script Date: 7/11/2016 12:10:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMuc](
	[MaDanhMuc] [int] NOT NULL,
	[TenDanhMuc] [nvarchar](50) NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_DanhMuc] PRIMARY KEY CLUSTERED 
(
	[MaDanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 7/11/2016 12:10:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [int] NOT NULL,
	[NguoiLap] [int] NULL,
	[NgayLap] [date] NULL,
	[TongTien] [decimal](18, 0) NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 7/11/2016 12:10:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaNguoiDung] [int] NOT NULL,
	[TenNguoiDung] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](50) NULL,
	[TenDangNhap] [nvarchar](50) NULL,
	[Tuoi] [int] NULL,
	[MatKhau] [nvarchar](50) NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 7/11/2016 12:10:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [int] NOT NULL,
	[TenSanPham] [nvarchar](50) NULL,
	[NhaSanXuat] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
	[MaDanhMuc] [int] NOT NULL,
	[GiaBan] [float] NULL,
	[TacGia] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sach] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (0, N'Bàn, Ghế', N'Các loại bàn ghế ')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (1, N'Bảng, phấn viết', N'Các loại bảng')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (2, N'Sách Ngoại Vănd', N'Các loại sách, tiểu thuyết, truyện nước ngoài')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (4, N'Bảng, phấn viết', N'Các loại bảng')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenNguoiDung], [GioiTinh], [TenDangNhap], [Tuoi], [MatKhau]) VALUES (1, N'Nguyen Van A', N'Nam', N'A@vn', 28, N'123')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (1, N'Cuốn theo chiều gió', N'Văn Học', 10, 2, 100000, N'Margaret Mitchell')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (2, N'Bé tập tô 1', N'Thiếu nhi', 10, 2, 20, N'Lê Phan Việt')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (3, N'Ghê A1', N'Long Tiến', 101, 0, 1000, N'AAAđ')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (4, N'Cuốn theo chiều gió Vesion2', N'Văn Học', 1, 2, 100000, N'10')
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_HoaDon] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaHoaDon])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_HoaDon]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_SanPham]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NguoiDung] FOREIGN KEY([NguoiLap])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NguoiDung]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_DanhMuc] FOREIGN KEY([MaDanhMuc])
REFERENCES [dbo].[DanhMuc] ([MaDanhMuc])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_DanhMuc]
GO
