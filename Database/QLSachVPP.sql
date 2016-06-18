USE [master]
GO
/****** Object:  Database [QLSACH_VPP]    Script Date: 6/18/2016 8:33:36 PM ******/
CREATE DATABASE [QLSACH_VPP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLSACH_VPP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QLSACH_VPP.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLSACH_VPP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QLSACH_VPP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLSACH_VPP] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLSACH_VPP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLSACH_VPP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QLSACH_VPP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLSACH_VPP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLSACH_VPP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLSACH_VPP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLSACH_VPP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLSACH_VPP] SET  MULTI_USER 
GO
ALTER DATABASE [QLSACH_VPP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLSACH_VPP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLSACH_VPP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLSACH_VPP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QLSACH_VPP]
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 6/18/2016 8:33:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaHoaDon] [nvarchar](50) NOT NULL,
	[MaSanPham] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_ChiTietHoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DanhMuc]    Script Date: 6/18/2016 8:33:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMuc](
	[MaDanhMuc] [nvarchar](50) NOT NULL,
	[TenDanhMuc] [nvarchar](50) NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_DanhMuc] PRIMARY KEY CLUSTERED 
(
	[MaDanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 6/18/2016 8:33:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [nvarchar](50) NOT NULL,
	[NguoiLap] [nvarchar](50) NULL,
	[NgayLap] [date] NULL,
	[TongTien] [decimal](18, 0) NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 6/18/2016 8:33:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaNguoiDung] [nvarchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[SanPham]    Script Date: 6/18/2016 8:33:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [nvarchar](50) NOT NULL,
	[TenSanPham] [nvarchar](50) NULL,
	[NhaSanXuat] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
	[MaDanhMuc] [nvarchar](50) NOT NULL,
	[GiaBan] [float] NULL,
	[TacGia] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sach] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'B0', N'Bàn, Ghế', N'Các loại bàn ghế ')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'B1', N'Bảng, phấn viết', N'Các loại bảng')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'S1', N'Sách Ngoại Văn', N'Các loại sách, tiểu thuyết, truyện nước ngoài')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'S2', N'Sách thiếu nhi', N'Các loại sách, tranh vẽ, tô màu ')
INSERT [dbo].[DanhMuc] ([MaDanhMuc], [TenDanhMuc], [MoTa]) VALUES (N'S3', N'Sách giáo dục', N'Sách giáo dục các loại')
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenNguoiDung], [GioiTinh], [TenDangNhap], [Tuoi], [MatKhau]) VALUES (N'1', N'Nguyen Van A', N'Nam', N'A@vn', 28, N'123')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (N'10', N'Cuốn theo chiều gió', N'Văn Học', 10, N'S1', 100000, N'Margaret Mitchell')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (N'11', N'Bé tập tô 1', N'Thiếu nhi', 10, N'S2', 20, N'Lê Phan Việt')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (N'123', N'Ghê A1', N'Long Tiến', 10, N'B0', 1000, N'')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [NhaSanXuat], [SoLuong], [MaDanhMuc], [GiaBan], [TacGia]) VALUES (N'NV2', N'Harry Porter', N'Khoa Học Xã hội', 10, N'S1', 1000, N'')
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
USE [master]
GO
ALTER DATABASE [QLSACH_VPP] SET  READ_WRITE 
GO
