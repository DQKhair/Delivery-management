/****** Object:  Database [GiaoHang]    Script Date: 04-Jun-23 8:03:22 PM ******/
CREATE DATABASE [GiaoHang]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 10 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [GiaoHang] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [GiaoHang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GiaoHang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GiaoHang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GiaoHang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GiaoHang] SET ARITHABORT OFF 
GO
ALTER DATABASE [GiaoHang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GiaoHang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GiaoHang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GiaoHang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GiaoHang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GiaoHang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GiaoHang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GiaoHang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GiaoHang] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [GiaoHang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GiaoHang] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [GiaoHang] SET  MULTI_USER 
GO
ALTER DATABASE [GiaoHang] SET ENCRYPTION ON
GO
ALTER DATABASE [GiaoHang] SET QUERY_STORE = ON
GO
ALTER DATABASE [GiaoHang] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  DatabaseRole [QuanLy]    Script Date: 04-Jun-23 8:03:22 PM ******/
CREATE ROLE [QuanLy]
GO
/****** Object:  DatabaseRole [NVXL]    Script Date: 04-Jun-23 8:03:22 PM ******/
CREATE ROLE [NVXL]
GO
/****** Object:  DatabaseRole [NVVC]    Script Date: 04-Jun-23 8:03:22 PM ******/
CREATE ROLE [NVVC]
GO
/****** Object:  Schema [Account_Pack]    Script Date: 04-Jun-23 8:03:23 PM ******/
CREATE SCHEMA [Account_Pack]
GO
/****** Object:  Schema [QLThongKe]    Script Date: 04-Jun-23 8:03:23 PM ******/
CREATE SCHEMA [QLThongKe]
GO
/****** Object:  Schema [QLTimKiem]    Script Date: 04-Jun-23 8:03:23 PM ******/
CREATE SCHEMA [QLTimKiem]
GO
/****** Object:  UserDefinedFunction [dbo].[Count_Account]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE   FUNCTION [dbo].[Count_Account]()
RETURNS int
AS 
BEGIN
	declare @count int;

	select @count = Count(*) 
	from NhanVien 
	where TenTaiKhoan is not null
    RETURN @count
END
GO
/****** Object:  UserDefinedFunction [dbo].[Count_DaNhan_Ngay]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Count_DaNhan_Ngay]
(
    @ngay int, @thang int, @nam int
)
RETURNS int
AS
BEGIN
	declare @count int
	
	select @count  = count(MaDonHang)
	from DonHang
	where day(ThoiGianNhan) = @ngay and month(ThoiGianNhan) = @thang and year(ThoiGianNhan) = @nam
    RETURN @count
END
GO
/****** Object:  UserDefinedFunction [dbo].[Count_NhanVien]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Count_NhanVien]
(
    
)
RETURNS int
AS
BEGIN
	declare @count int;

	select @count = Count(*) 
	from NhanVien 
    RETURN @count
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetName]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetName]
(@manv int)

returns varchar(50)

as begin
	declare @ten varchar(50);

	select @ten = TenTaiKhoan from NhanVien
	where MaNhanVien = @manv
return @ten;
end;
GO
/****** Object:  UserDefinedFunction [dbo].[ThongKe_LoaiNhanVien]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ThongKe_LoaiNhanVien](@maloai int)
RETURNS @table table
(
    MaNhanVien int,
	TenNhanVien nvarchar(50),
	LoaiTaiKhoan nvarchar(30)
)

AS
BEGIN
	insert into @table
	select MaNhanVien, TenNhanVien, TenTaiKhoan
	from NhanVien
	join LoaiTaiKhoan on NhanVien.LoaiTaiKhoan = MaLoaiTaiKhoan
	where NhanVien.LoaiTaiKhoan = @maloai
	return
END
GO
/****** Object:  Table [dbo].[LoaiTaiKhoan]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiTaiKhoan](
	[MaLoaiTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[LoaiTaiKhoan] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiTaiKhoan] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[TenNhanVien] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[Email] [varchar](100) NULL,
	[SoDienThoai] [varchar](11) NULL,
	[TrangThai] [bit] NULL,
	[MaKhuVuc] [int] NULL,
	[TenTaiKhoan] [varchar](50) NULL,
	[MatKhau] [varchar](4000) NULL,
	[LoaiTaiKhoan] [int] NULL,
	[ImageData] [varbinary](max) NULL,
	[ImageExtension] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_DanhSachTK]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_DanhSachTK]
as
	select nv.MaNhanVien,nv.TenTaiKhoan,nv.TenNhanVien,ltk.LoaiTaiKhoan 
	from NhanVien nv
	join LoaiTaiKhoan ltk on nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan 
	where nv.TrangThai = 1
GO
/****** Object:  Table [dbo].[KhuVuc]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuVuc](
	[MaKhuVuc] [int] IDENTITY(1,1) NOT NULL,
	[TenKhuVuc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhuVuc] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_DanhSachNV]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_DanhSachNV]
as
       SELECT nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
		FROM NhanVien nv
		LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
		WHERE nv.TrangThai=1
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDonHang] [int] IDENTITY(1,1) NOT NULL,
	[Tu] [nvarchar](100) NULL,
	[NguoiGui] [nvarchar](100) NULL,
	[SdtNguoiGui] [varchar](11) NULL,
	[DiaChiNguoiNhan] [nvarchar](50) NULL,
	[DiaChiPhuong] [nvarchar](100) NULL,
	[DiaChiQuan] [nvarchar](50) NULL,
	[DiaChiThanhPho] [nvarchar](50) NULL,
	[NguoiNhan] [nvarchar](100) NULL,
	[Sdt] [varchar](11) NULL,
	[GhiChu] [nvarchar](200) NULL,
	[ThoiGianNhan] [datetime] NULL,
	[NhanVienNhan] [int] NULL,
	[ThoiGianPhanPhoi] [datetime] NULL,
	[NhanVienPhanPhoi] [int] NULL,
	[ThoiGianLayHang] [datetime] NULL,
	[NhanVienGiao] [int] NULL,
	[TrangThai] [int] NULL,
	[ThoiGianNhanDon] [datetime] NULL,
	[ThoiGianGiao] [datetime] NULL,
	[ThoiGianDaGiao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_DanhSachDH]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_DanhSachDH]
as
   			select * from DonHang
			where TrangThai=1
GO
/****** Object:  Table [dbo].[ChucNang]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucNang](
	[MaChucNang] [int] IDENTITY(1,1) NOT NULL,
	[TenChucNang] [nvarchar](100) NULL,
	[BieuTuong] [nvarchar](4000) NULL,
	[Controller] [varchar](100) NULL,
	[RouteName] [nvarchar](200) NULL,
	[MaLoaiTaiKhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChucNang] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThaiDonHang]    Script Date: 04-Jun-23 8:03:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiDonHang](
	[MaTrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TenTrangThai] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTrangThai] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChucNang] ON 
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (1, N'Quản lý tài khoản', N'
<svg width="29" height="31" viewBox="0 0 29 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M20.3713 7.64154C20.1001 11.2992 17.3273 14.2831 14.2832 14.2831C11.2392 14.2831 8.46153 11.2999 8.19517 7.64154C7.91844 3.83649 10.6166 1 14.2832 1C17.9499 1 20.6481 3.90567 20.3713 7.64154Z" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M14.2832 18.7108C8.26435 18.7108 2.15552 22.0316 1.02507 28.2995C0.888784 29.055 1.31633 29.78 2.10709 29.78H26.4594C27.2509 29.78 27.6784 29.055 27.5421 28.2995C26.411 22.0316 20.3021 18.7108 14.2832 18.7108Z" stroke="#228542" stroke-width="2" stroke-miterlimit="10"/>
</svg>
', N'TaiKhoan', N'index', 1)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (2, N'Quản lý nhân viên', N'
<svg width="33" height="31" viewBox="0 0 33 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M20.3713 7.64154C20.1001 11.2992 17.3273 14.2831 14.2832 14.2831C11.2392 14.2831 8.46153 11.2999 8.19517 7.64154C7.91844 3.83649 10.6166 1 14.2832 1C17.9499 1 20.6481 3.90567 20.3713 7.64154Z" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M28 10V18" stroke="#228542" stroke-width="2" stroke-linecap="round"/>
<path d="M32 14L24 14" stroke="#228542" stroke-width="2" stroke-linecap="round"/>
<path d="M14.2832 18.7107C8.26435 18.7107 2.15552 22.0315 1.02507 28.2994C0.888784 29.0549 1.31633 29.7799 2.10709 29.7799H26.4594C27.2509 29.7799 27.6784 29.0549 27.5421 28.2994C26.411 22.0315 20.3021 18.7107 14.2832 18.7107Z" stroke="#228542" stroke-width="2" stroke-miterlimit="10"/>
</svg>
', N'NhanViens', N'index', 1)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (3, N'Nhận đơn', N'
<svg width="31" height="31" viewBox="0 0 31 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M23.1385 26.4495V2.66038C23.1372 2.22042 22.9618 1.79883 22.6507 1.48773C22.3396 1.17662 21.918 1.00128 21.4781 1H2.66038C2.22042 1.00128 1.79883 1.17662 1.48773 1.48773C1.17662 1.79883 1.00128 2.22042 1 2.66038V27.0127C1.00219 27.746 1.29445 28.4486 1.81294 28.9671C2.33144 29.4856 3.03405 29.7778 3.76731 29.78H26.4592" stroke="#228542" stroke-width="2" stroke-linejoin="round"/>
<path d="M26.4593 29.78C25.5785 29.78 24.7339 29.4301 24.1111 28.8074C23.4884 28.1846 23.1385 27.3399 23.1385 26.4592V6.53461H28.1196C28.56 6.53461 28.9823 6.70954 29.2937 7.02092C29.6051 7.3323 29.78 7.75463 29.78 8.19499V26.4592C29.78 27.3399 29.4302 28.1846 28.8074 28.8074C28.1846 29.4301 27.34 29.78 26.4593 29.78Z" stroke="#228542" stroke-width="2" stroke-linejoin="round"/>
<path d="M14.2831 6.53461H18.7108" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M14.2831 10.9623H18.7108" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M5.42767 15.39H18.7108" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M5.42767 19.8177H18.7108" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M5.42767 24.2454H18.7108" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M9.85536 11.0692H5.42766C5.39931 11.0692 5.37211 11.058 5.35206 11.0379L4.64495 11.745L5.35206 11.0379C5.332 11.0179 5.32074 10.9907 5.32074 10.9623V6.53463C5.32074 6.50627 5.332 6.47907 5.35206 6.45902C5.37211 6.43897 5.39931 6.4277 5.42766 6.4277H9.85536C9.88371 6.4277 9.91091 6.43897 9.93096 6.45902L10.6381 5.75191L9.93096 6.45902C9.95101 6.47907 9.96228 6.50627 9.96228 6.53463V10.9623C9.96228 10.9907 9.95101 11.0179 9.93096 11.0379L10.6381 11.745L9.93096 11.0379C9.91091 11.058 9.88371 11.0692 9.85536 11.0692Z" stroke="#228542" stroke-width="2"/>
</svg>
', N'DHs', N'index', 2)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (4, N'Phân phối đơn', N'
<svg width="34" height="31" viewBox="0 0 34 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M3.39838 7.5954V26.7821C3.40075 27.5764 3.71736 28.3376 4.27907 28.8993C4.84077 29.461 5.60193 29.7776 6.39629 29.78H26.7821C27.5765 29.7776 28.3376 29.461 28.8994 28.8993C29.4611 28.3376 29.7777 27.5764 29.78 26.7821V7.5954" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M30.0798 1H3.09854C1.93955 1 1 1.93955 1 3.09854V4.89729C1 6.05628 1.93955 6.99583 3.09854 6.99583H30.0798C31.2388 6.99583 32.1783 6.05628 32.1783 4.89729V3.09854C32.1783 1.93955 31.2388 1 30.0798 1Z" stroke="#228542" stroke-width="2" stroke-linejoin="round"/>
<path d="M21.3858 18.9875L16.5891 23.7841L11.7925 18.9875" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M16.5891 22.127V12.9916" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
', N'DH_DaNhan', N'index', 2)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (5, N'Theo dõi đơn', N'
<svg width="34" height="31" viewBox="0 0 34 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M3.39838 7.5954V26.7821C3.40075 27.5764 3.71736 28.3376 4.27907 28.8993C4.84077 29.461 5.60193 29.7776 6.39629 29.78H26.7821C27.5765 29.7776 28.3376 29.461 28.8994 28.8993C29.4611 28.3376 29.7777 27.5764 29.78 26.7821V7.5954" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M30.0798 1H3.09854C1.93955 1 1 1.93955 1 3.09854V4.89729C1 6.05628 1.93955 6.99583 3.09854 6.99583H30.0798C31.2388 6.99583 32.1783 6.05628 32.1783 4.89729V3.09854C32.1783 1.93955 31.2388 1 30.0798 1Z" stroke="#228542" stroke-width="2" stroke-linejoin="round"/>
<path d="M14.5891 22.7841L9.79248 17.9875" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M15 23L24 13" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
', N'TheoDoiDon', N'index', 1)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (6, N'Báo cáo thống kê', N'<svg width="29" height="29" viewBox="0 0 29 29" fill="none" xmlns="http://www.w3.org/2000/svg">
<mask id="path-1-inside-1_54_835" fill="white">
<path d="M27.8207 28.78H1.91867C1.4098 28.78 0.921784 28.5779 0.561965 28.218C0.202145 27.8582 0 27.3702 0 26.8613V0.959333C0 0.704902 0.101072 0.460892 0.280982 0.280982C0.460892 0.101072 0.704902 0 0.959333 0C1.21376 0 1.45777 0.101072 1.63768 0.280982C1.81759 0.460892 1.91867 0.704902 1.91867 0.959333V26.8613H27.8207C28.0751 26.8613 28.3191 26.9624 28.499 27.1423C28.6789 27.3222 28.78 27.5662 28.78 27.8207C28.78 28.0751 28.6789 28.3191 28.499 28.499C28.3191 28.6789 28.0751 28.78 27.8207 28.78Z"/>
</mask>
<path d="M0 26.8613H-2H0ZM0.959333 0V-2V0ZM1.91867 0.959333H3.91867H1.91867ZM1.91867 26.8613H-0.0813333V28.8613H1.91867V26.8613ZM27.8207 26.78H1.91867V30.78H27.8207V26.78ZM1.91867 26.78C1.94024 26.78 1.96093 26.7886 1.97618 26.8038L-0.852249 29.6322C-0.117357 30.3671 0.879371 30.78 1.91867 30.78V26.78ZM1.97618 26.8038C1.99143 26.8191 2 26.8398 2 26.8613H-2C-2 27.9006 -1.58714 28.8974 -0.852249 29.6322L1.97618 26.8038ZM2 26.8613V0.959333H-2V26.8613H2ZM2 0.959333C2 1.23533 1.89036 1.50003 1.6952 1.6952L-1.13323 -1.13323C-1.68821 -0.578249 -2 0.17447 -2 0.959333H2ZM1.6952 1.6952C1.50003 1.89036 1.23533 2 0.959333 2V-2C0.17447 -2 -0.578249 -1.68821 -1.13323 -1.13323L1.6952 1.6952ZM0.959333 2C0.683332 2 0.418634 1.89036 0.223471 1.6952L3.0519 -1.13323C2.49692 -1.68821 1.7442 -2 0.959333 -2V2ZM0.223471 1.6952C0.0283079 1.50003 -0.0813333 1.23533 -0.0813333 0.959333H3.91867C3.91867 0.17447 3.60688 -0.578249 3.0519 -1.13323L0.223471 1.6952ZM-0.0813333 0.959333V26.8613H3.91867V0.959333H-0.0813333ZM1.91867 28.8613H27.8207V24.8613H1.91867V28.8613ZM27.8207 28.8613C27.5447 28.8613 27.28 28.7517 27.0848 28.5565L29.9132 25.7281C29.3582 25.1731 28.6055 24.8613 27.8207 24.8613V28.8613ZM27.0848 28.5565C26.8896 28.3614 26.78 28.0967 26.78 27.8207H30.78C30.78 27.0358 30.4682 26.2831 29.9132 25.7281L27.0848 28.5565ZM26.78 27.8207C26.78 27.5447 26.8896 27.28 27.0848 27.0848L29.9132 29.9132C30.4682 29.3582 30.78 28.6055 30.78 27.8207H26.78ZM27.0848 27.0848C27.28 26.8896 27.5447 26.78 27.8207 26.78V30.78C28.6055 30.78 29.3582 30.4682 29.9132 29.9132L27.0848 27.0848Z" fill="#228542" mask="url(#path-1-inside-1_54_835)"/>
<path d="M8.39417 23.9427H5.99584C5.68859 23.9427 5.39392 23.8206 5.17666 23.6033C4.9594 23.3861 4.83734 23.0914 4.83734 22.7842V13.6705C4.83734 13.3632 4.9594 13.0686 5.17666 12.8513C5.39392 12.634 5.68859 12.512 5.99584 12.512H8.39417C8.70143 12.512 8.9961 12.634 9.21336 12.8513L9.92046 12.1442L9.21336 12.8513C9.43062 13.0686 9.55267 13.3632 9.55267 13.6705V22.7842C9.55267 23.0914 9.43062 23.3861 9.21336 23.6033C8.9961 23.8206 8.70143 23.9427 8.39417 23.9427Z" stroke="#228542" stroke-width="2"/>
<path d="M17.0281 23.9427H14.6298C14.3226 23.9427 14.0279 23.8206 13.8106 23.6034L13.1035 24.3105L13.8106 23.6034C13.5934 23.3861 13.4713 23.0914 13.4713 22.7842V10.7925C13.4713 10.4852 13.5934 10.1906 13.8106 9.97332C14.0279 9.75606 14.3226 9.634 14.6298 9.634H17.0281C17.3354 9.634 17.6301 9.75606 17.8473 9.97332L18.5544 9.26621L17.8473 9.97332C18.0646 10.1906 18.1866 10.4852 18.1866 10.7925V22.7842C18.1866 23.0914 18.0646 23.3861 17.8473 23.6034C17.6301 23.8206 17.3354 23.9427 17.0281 23.9427Z" stroke="#228542" stroke-width="2"/>
<path d="M25.6406 23.9427H23.2422C22.935 23.9427 22.6403 23.8206 22.4231 23.6033L21.7189 24.3075L22.4231 23.6033C22.2058 23.3861 22.0837 23.0914 22.0837 22.7842V6.95516C22.0837 6.64791 22.2058 6.35324 22.4231 6.13598C22.6403 5.91872 22.935 5.79666 23.2422 5.79666H25.6406C25.9478 5.79666 26.2425 5.91872 26.4598 6.13598L27.1669 5.42887L26.4598 6.13598C26.677 6.35324 26.7991 6.64791 26.7991 6.95516V22.7842C26.7991 23.0914 26.677 23.3861 26.4598 23.6033C26.2425 23.8206 25.9478 23.9427 25.6406 23.9427Z" stroke="#228542" stroke-width="2"/>
</svg>', N'ThongKe', N'index', 1)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (9, N'Theo dõi đơn', N'
<svg width="34" height="31" viewBox="0 0 34 31" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M3.39838 7.5954V26.7821C3.40075 27.5764 3.71736 28.3376 4.27907 28.8993C4.84077 29.461 5.60193 29.7776 6.39629 29.78H26.7821C27.5765 29.7776 28.3376 29.461 28.8994 28.8993C29.4611 28.3376 29.7777 27.5764 29.78 26.7821V7.5954" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M30.0798 1H3.09854C1.93955 1 1 1.93955 1 3.09854V4.89729C1 6.05628 1.93955 6.99583 3.09854 6.99583H30.0798C31.2388 6.99583 32.1783 6.05628 32.1783 4.89729V3.09854C32.1783 1.93955 31.2388 1 30.0798 1Z" stroke="#228542" stroke-width="2" stroke-linejoin="round"/>
<path d="M14.5891 22.7841L9.79248 17.9875" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M15 23L24 13" stroke="#228542" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
', N'TheoDoiDon', N'index', 2)
GO
INSERT [dbo].[ChucNang] ([MaChucNang], [TenChucNang], [BieuTuong], [Controller], [RouteName], [MaLoaiTaiKhoan]) VALUES (10, N'Báo cáo thống kê', N'<svg width="29" height="29" viewBox="0 0 29 29" fill="none" xmlns="http://www.w3.org/2000/svg">
<mask id="path-1-inside-1_54_835" fill="white">
<path d="M27.8207 28.78H1.91867C1.4098 28.78 0.921784 28.5779 0.561965 28.218C0.202145 27.8582 0 27.3702 0 26.8613V0.959333C0 0.704902 0.101072 0.460892 0.280982 0.280982C0.460892 0.101072 0.704902 0 0.959333 0C1.21376 0 1.45777 0.101072 1.63768 0.280982C1.81759 0.460892 1.91867 0.704902 1.91867 0.959333V26.8613H27.8207C28.0751 26.8613 28.3191 26.9624 28.499 27.1423C28.6789 27.3222 28.78 27.5662 28.78 27.8207C28.78 28.0751 28.6789 28.3191 28.499 28.499C28.3191 28.6789 28.0751 28.78 27.8207 28.78Z"/>
</mask>
<path d="M0 26.8613H-2H0ZM0.959333 0V-2V0ZM1.91867 0.959333H3.91867H1.91867ZM1.91867 26.8613H-0.0813333V28.8613H1.91867V26.8613ZM27.8207 26.78H1.91867V30.78H27.8207V26.78ZM1.91867 26.78C1.94024 26.78 1.96093 26.7886 1.97618 26.8038L-0.852249 29.6322C-0.117357 30.3671 0.879371 30.78 1.91867 30.78V26.78ZM1.97618 26.8038C1.99143 26.8191 2 26.8398 2 26.8613H-2C-2 27.9006 -1.58714 28.8974 -0.852249 29.6322L1.97618 26.8038ZM2 26.8613V0.959333H-2V26.8613H2ZM2 0.959333C2 1.23533 1.89036 1.50003 1.6952 1.6952L-1.13323 -1.13323C-1.68821 -0.578249 -2 0.17447 -2 0.959333H2ZM1.6952 1.6952C1.50003 1.89036 1.23533 2 0.959333 2V-2C0.17447 -2 -0.578249 -1.68821 -1.13323 -1.13323L1.6952 1.6952ZM0.959333 2C0.683332 2 0.418634 1.89036 0.223471 1.6952L3.0519 -1.13323C2.49692 -1.68821 1.7442 -2 0.959333 -2V2ZM0.223471 1.6952C0.0283079 1.50003 -0.0813333 1.23533 -0.0813333 0.959333H3.91867C3.91867 0.17447 3.60688 -0.578249 3.0519 -1.13323L0.223471 1.6952ZM-0.0813333 0.959333V26.8613H3.91867V0.959333H-0.0813333ZM1.91867 28.8613H27.8207V24.8613H1.91867V28.8613ZM27.8207 28.8613C27.5447 28.8613 27.28 28.7517 27.0848 28.5565L29.9132 25.7281C29.3582 25.1731 28.6055 24.8613 27.8207 24.8613V28.8613ZM27.0848 28.5565C26.8896 28.3614 26.78 28.0967 26.78 27.8207H30.78C30.78 27.0358 30.4682 26.2831 29.9132 25.7281L27.0848 28.5565ZM26.78 27.8207C26.78 27.5447 26.8896 27.28 27.0848 27.0848L29.9132 29.9132C30.4682 29.3582 30.78 28.6055 30.78 27.8207H26.78ZM27.0848 27.0848C27.28 26.8896 27.5447 26.78 27.8207 26.78V30.78C28.6055 30.78 29.3582 30.4682 29.9132 29.9132L27.0848 27.0848Z" fill="#228542" mask="url(#path-1-inside-1_54_835)"/>
<path d="M8.39417 23.9427H5.99584C5.68859 23.9427 5.39392 23.8206 5.17666 23.6033C4.9594 23.3861 4.83734 23.0914 4.83734 22.7842V13.6705C4.83734 13.3632 4.9594 13.0686 5.17666 12.8513C5.39392 12.634 5.68859 12.512 5.99584 12.512H8.39417C8.70143 12.512 8.9961 12.634 9.21336 12.8513L9.92046 12.1442L9.21336 12.8513C9.43062 13.0686 9.55267 13.3632 9.55267 13.6705V22.7842C9.55267 23.0914 9.43062 23.3861 9.21336 23.6033C8.9961 23.8206 8.70143 23.9427 8.39417 23.9427Z" stroke="#228542" stroke-width="2"/>
<path d="M17.0281 23.9427H14.6298C14.3226 23.9427 14.0279 23.8206 13.8106 23.6034L13.1035 24.3105L13.8106 23.6034C13.5934 23.3861 13.4713 23.0914 13.4713 22.7842V10.7925C13.4713 10.4852 13.5934 10.1906 13.8106 9.97332C14.0279 9.75606 14.3226 9.634 14.6298 9.634H17.0281C17.3354 9.634 17.6301 9.75606 17.8473 9.97332L18.5544 9.26621L17.8473 9.97332C18.0646 10.1906 18.1866 10.4852 18.1866 10.7925V22.7842C18.1866 23.0914 18.0646 23.3861 17.8473 23.6034C17.6301 23.8206 17.3354 23.9427 17.0281 23.9427Z" stroke="#228542" stroke-width="2"/>
<path d="M25.6406 23.9427H23.2422C22.935 23.9427 22.6403 23.8206 22.4231 23.6033L21.7189 24.3075L22.4231 23.6033C22.2058 23.3861 22.0837 23.0914 22.0837 22.7842V6.95516C22.0837 6.64791 22.2058 6.35324 22.4231 6.13598C22.6403 5.91872 22.935 5.79666 23.2422 5.79666H25.6406C25.9478 5.79666 26.2425 5.91872 26.4598 6.13598L27.1669 5.42887L26.4598 6.13598C26.677 6.35324 26.7991 6.64791 26.7991 6.95516V22.7842C26.7991 23.0914 26.677 23.3861 26.4598 23.6033C26.2425 23.8206 25.9478 23.9427 25.6406 23.9427Z" stroke="#228542" stroke-width="2"/>
</svg>', N'ThongKe', N'index', 2)
GO
SET IDENTITY_INSERT [dbo].[ChucNang] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (1, N'8826 Northwestern Avenue', N'Prentiss Clowsley', N'6489709182', N'23869 Paget Court', N'Phường 10', N'Quận 8', N'TP. Hồ Chí Minh', N'Sunny Sinderland', N'1022613935', N'Được kiểm hàng', CAST(N'2023-05-19T02:16:53.277' AS DateTime), 5, CAST(N'2023-05-04T02:20:47.070' AS DateTime), 5, CAST(N'2023-05-21T13:55:04.000' AS DateTime), 12, 7, NULL, NULL, CAST(N'2023-05-25T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (2, N'75471 Meadow Valley Circle', N'Roselia MacFall', N'4131937211', N'7 Katie Center', N'Phường 10', N'Quận 3', N'TP. Hồ Chí Minh', N'Brian Greatland', N'6545400712', N'Hàng dễ vỡ', CAST(N'2023-05-25T12:58:35.380' AS DateTime), 1, NULL, NULL, CAST(N'2023-05-31T04:19:18.757' AS DateTime), 6, 7, CAST(N'2023-05-30T04:41:15.430' AS DateTime), CAST(N'2023-05-31T04:19:25.623' AS DateTime), CAST(N'2023-05-31T04:19:38.520' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (4, N'833 Gateway Trail', N'Padraig Durston', N'6231795330', N'9252 Veith Trail', N'Phường 5', N'Quận 12', N'TP. Hồ Chí Minh', N'Selina Cullimore', N'6668597732', N'Được kiểm hàng', CAST(N'2023-05-25T17:05:13.320' AS DateTime), 2, NULL, NULL, CAST(N'2023-05-27T14:32:07.930' AS DateTime), 6, 7, CAST(N'2023-05-29T10:16:52.427' AS DateTime), NULL, CAST(N'2023-05-29T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (5, N'893 Starling Crossing', N'Reagan Wheater', N'5641149281', N'64 Eastlawn Avenue', N'Phường 6', N'Quận 1', N'TP. Hồ Chí Minh', N'Kermy Trenholme', N'7677771493', N'Không được kiểm hàng', CAST(N'2023-05-25T17:10:21.793' AS DateTime), 2, NULL, NULL, CAST(N'2023-05-28T13:55:04.000' AS DateTime), 6, 7, CAST(N'2023-05-29T10:16:52.427' AS DateTime), NULL, CAST(N'2023-05-29T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (6, N'3169 Lindbergh Junction', N'Marillin Laverack', N'9293386588', N'84437 Westerfield Drive', N'Phường 5', N'Quận 1', N'TP. Hồ Chí Minh', N'Sarita Foulis', N'1872649084', N'Không được kiểm hàng', CAST(N'2023-05-30T05:18:12.080' AS DateTime), 1, CAST(N'2023-05-30T05:18:27.170' AS DateTime), 1, CAST(N'2023-05-27T12:07:13.013' AS DateTime), 5, 4, CAST(N'2023-05-27T07:20:28.267' AS DateTime), NULL, CAST(N'2023-05-29T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (7, N'11820 Vidon Avenue', N'Tito Colten', N'9691942480', N'5663 Dakota Hill', N'Phường 9', N'Quận Bình Tân', N'TP. Hồ Chí Minh', N'Mel Grishinov', N'2644393536', NULL, CAST(N'2023-05-27T17:10:21.793' AS DateTime), 2, NULL, NULL, CAST(N'2023-05-28T13:55:04.000' AS DateTime), 6, 7, NULL, NULL, CAST(N'2023-05-29T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (8, N'0604 Vera Point', N'Benjamin Really', N'8469043597', N'1322 Mccormick Point', N'Phường 3', N'Quận 1', N'TP. Hồ Chí Minh', N'Almeta Abotson', N'4543434791', N'Không được kiểm hàng', CAST(N'2023-05-27T17:10:21.793' AS DateTime), 2, NULL, NULL, CAST(N'2023-05-28T13:55:04.000' AS DateTime), 6, 7, CAST(N'2023-05-27T07:20:28.267' AS DateTime), NULL, CAST(N'2023-05-29T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (9, N'6945 Arizona Road', N'Martie Burfoot', N'3961409735', N'428 Tenne Terrace', N'Phường 9', N'Quận 3', N'TP. Hồ Chí Minh', N'Rosalinde Beinisch', N'7189313427', NULL, CAST(N'2023-05-21T15:24:28.917' AS DateTime), 1, CAST(N'2023-05-26T02:00:18.530' AS DateTime), 1, CAST(N'2023-05-22T13:55:04.000' AS DateTime), 6, 7, CAST(N'2023-05-27T06:05:18.663' AS DateTime), NULL, CAST(N'2023-05-25T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (10, N'5554 Lindbergh Trail', N'Corby Kleinhandler', N'5275421061', N'8 Sherman Lane', N'Phường 4', N'Quận 5', N'TP. Hồ Chí Minh', N'Adriano Dilleway', N'4534373764', N'Hàng dễ vỡ', CAST(N'2023-05-17T13:05:58.677' AS DateTime), 1, CAST(N'2023-05-17T18:00:18.530' AS DateTime), 4, CAST(N'2023-05-19T13:55:04.000' AS DateTime), 6, 2, NULL, NULL, CAST(N'2023-05-24T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (11, N'2635 Autumn Leaf Drive', N'Sukey McFarlane', N'7023173882', N'642 David Terrace', N'Phường 10', N'Quận 11', N'TP. Hồ Chí Minh', N'Hewitt Artinstall', N'7298370269', N'Được kiểm hàng', CAST(N'2023-05-20T18:10:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:15:00.000' AS DateTime), 4, CAST(N'2023-05-21T13:55:04.000' AS DateTime), 6, 4, CAST(N'2023-05-31T04:18:40.567' AS DateTime), NULL, CAST(N'2023-05-22T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (12, N'224 Lunder Hill', N'Kathi Ciraldo', N'4984646875', N'0 Prentice Hill', N'Phường 2', N'Quận 10', N'TP. Hồ Chí Minh', N'Fianna Pesik', N'9809267391', N'Hàng dễ vỡ', CAST(N'2023-05-26T18:11:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:16:00.000' AS DateTime), 4, CAST(N'2023-05-27T13:55:04.000' AS DateTime), 6, 7, CAST(N'2023-05-27T13:57:34.037' AS DateTime), CAST(N'2023-05-27T13:55:16.720' AS DateTime), CAST(N'2023-05-28T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (13, N'5125 Annamark Court', N'Kalinda Nassy', N'5157833462', N'9590 Graedel Avenue', N'Phường 3', N'Quận 7', N'TP. Hồ Chí Minh', N'Sibbie Rollitt', N'5644837052', NULL, CAST(N'2023-04-02T18:11:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:16:30.000' AS DateTime), 4, NULL, 6, 7, NULL, NULL, CAST(N'2023-04-08T18:11:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (14, N'3 Sheridan Hill', N'Ranice Juanes', N'4981207120', N'72 Amoth Drive', N'Phường 10', N'Quận Bình Thạnh', N'TP. Hồ Chí Minh', N'Mohandis Dine-Hart', N'2469433699', N'Hàng dễ vỡ', CAST(N'2023-04-10T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, NULL, 6, 4, CAST(N'2023-05-31T04:18:40.567' AS DateTime), NULL, CAST(N'2023-04-15T18:11:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (15, N'49770 Charing Cross Junction', N'Ryley Woollam', N'5842145099', N'959 Anniversary Alley', N'Phường 4', N'Quận Tân Bình', N'TP. Hồ Chí Minh', N'Virgina Long', N'7417824640', N'Không đư?c ki?m hàng', CAST(N'2023-04-10T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, NULL, 7, 7, NULL, NULL, CAST(N'2023-04-15T18:11:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (16, N'7 Artisan Point', N'Talbot Erley', N'2348973396', N'4553 Eagan Place', N'Phường 8', N'Quận Bình Thạnh', N'TP. Hồ Chí Minh', N'Benedick Emburey', N'6982854724', NULL, CAST(N'2023-04-10T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, NULL, 7, 7, NULL, NULL, CAST(N'2023-04-15T18:11:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (17, N'82 Moulton Hill', N'Cathi Swanton', N'7502135105', N'1415 Prairie Rose Way', N'Phường 7', N'Quận 3', N'TP. Hồ Chí Minh', N'Emlynne Exelby', N'1099523302', N'Không đư?c ki?m hàng', CAST(N'2023-04-10T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, NULL, 7, 7, NULL, NULL, CAST(N'2023-04-15T18:11:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (18, N'03 Northridge Lane', N'Trace Bizley', N'3751231780', N'448 Colorado Road', N'Phường 2', N'Quận Gò Vấp', N'TP. Hồ Chí Minh', N'Biddie Minci', N'1894550046', N'Hàng dễ vỡ', CAST(N'2023-04-10T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, NULL, 7, 7, NULL, NULL, CAST(N'2023-04-16T18:11:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (19, N'1 Mendota Avenue', N'Urbain Swinfon', N'7155289710', N'63785 Melrose Point', N'Phường 1', N'Quận 4', N'TP. Hồ Chí Minh', N'Jessey Clery', N'1787595413', NULL, CAST(N'2023-05-19T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, CAST(N'2023-05-20T13:55:04.000' AS DateTime), 7, 5, NULL, NULL, CAST(N'2023-05-30T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (20, N'3 Summit Junction', N'Quintana Braunlein', N'2992237422', N'9 Steensland Center', N'Phường 1', N'Quận 5', N'TP. Hồ Chí Minh', N'Sarge Sheringham', N'2248681324', NULL, CAST(N'2023-04-15T18:12:00.000' AS DateTime), 4, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 4, NULL, 7, 4, CAST(N'2023-05-31T04:20:22.990' AS DateTime), NULL, CAST(N'2023-04-25T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (21, N'9479 Pine View Drive', N'Des Durkin', N'8429841279', N'11 Declaration Crossing', N'Phường 5', N'Quận Tân Bình', N'TP. Hồ Chí Minh', N'Margaux Smitheman', N'3948762167', N'Được kiểm hàng', CAST(N'2023-04-15T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 7, 7, CAST(N'2023-05-27T06:05:18.663' AS DateTime), NULL, CAST(N'2023-04-26T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (22, N'20503 West Hill', N'Chryste Kilbee', N'9099929120', N'82551 Fremont Road', N'Phường 3', N'Quận 8', N'TP. Hồ Chí Minh', N'Hilario Dedenham', N'5037169043', N'Hàng dễ vỡ', CAST(N'2023-04-15T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 7, 7, CAST(N'2023-05-27T06:05:18.663' AS DateTime), NULL, CAST(N'2023-04-26T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (23, N'8585 Susan Court', N'Elsbeth Mattes', N'7198158088', N'9 Dennis Court', N'Phường 6', N'Quận 1', N'TP. Hồ Chí Minh', N'Roxanne Honeywood', N'2655126737', N'Hàng dễ vỡ', CAST(N'2023-04-16T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 9, 7, CAST(N'2023-05-27T07:17:46.187' AS DateTime), NULL, CAST(N'2023-04-26T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (24, N'7462 Meadow Ridge Lane', N'Phaedra Boullen', N'8181966439', N'4028 Westridge Way', N'Phường 7', N'Quận 5', N'TP. Hồ Chí Minh', N'Ermanno Elvy', N'7104019399', NULL, CAST(N'2023-04-16T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 12, 4, NULL, NULL, CAST(N'2023-04-26T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (25, N'125 Carpenter Place', N'Darrel Peeters', N'9637714212', N'0 Dixon Way', N'Phường 9', N'Quận 10', N'TP. Hồ Chí Minh', N'Colleen Pallis', N'4319518403', N'Được kiểm hàng', CAST(N'2023-04-18T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 15, 4, NULL, NULL, CAST(N'2023-04-26T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (26, N'21060 Clove Plaza', N'Ted Antonucci', N'7703557507', N'5 School Street', N'Phường 2', N'Thành phố Thủ Đức', N'TP. Hồ Chí Minh', N'Brocky Rolfs', N'9084447800', NULL, CAST(N'2023-04-18T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, CAST(N'2023-05-31T06:04:00.617' AS DateTime), 7, 7, CAST(N'2023-05-27T06:05:18.663' AS DateTime), CAST(N'2023-05-31T06:05:31.243' AS DateTime), CAST(N'2023-05-31T06:06:12.433' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (27, N'00 Ryan Parkway', N'Tanhya Jonk', N'4906443345', N'27 Onsgard Lane', N'Phường 3', N'Quận 12', N'TP. Hồ Chí Minh', N'Stavros Pignon', N'5399984806', NULL, CAST(N'2023-04-18T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 16, 7, NULL, NULL, CAST(N'2023-04-28T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (28, N'07729 Center Plaza', N'Anna-maria Genders', N'2526057805', N'9 International Road', N'Phường 9', N'Thành phố Thủ Đức', N'TP. Hồ Chí Minh', N'Petronella Hintzer', N'7187692174', N'Được kiểm hàng', CAST(N'2023-04-21T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 20, 3, NULL, NULL, CAST(N'2023-04-27T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (29, N'111 Randy Avenue', N'Petronille Divisek', N'7733851190', N'9441 Golden Leaf Junction', N'Phường 8', N'Quận Tân Bình', N'TP. Hồ Chí Minh', N'Brook Kibbe', N'2667554566', NULL, CAST(N'2023-04-21T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 10, 7, CAST(N'2023-05-27T07:17:50.013' AS DateTime), NULL, CAST(N'2023-04-28T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (30, N'28485 Delaware Parkway', N'Brucie Bealton', N'3308716036', N'158 Springs Drive', N'Phường 8', N'Quận 1', N'TP. Hồ Chí Minh', N'Dorena Crosthwaite', N'8007142115', N'Được kiểm hàng', CAST(N'2023-04-21T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 8, 3, CAST(N'2023-05-27T06:27:28.430' AS DateTime), NULL, CAST(N'2023-05-12T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (31, N'706 Iowa Trail', N'Harold Fleetwood', N'2365890124', N'39 Bay Terrace', N'Phường 10', N'Quận Tân Phú', N'TP. Hồ Chí Minh', N'Andrey', N'2569874589', NULL, CAST(N'2023-04-21T18:12:00.000' AS DateTime), 5, CAST(N'2023-04-21T18:17:00.000' AS DateTime), 5, NULL, 19, 7, NULL, NULL, CAST(N'2023-05-12T18:12:00.000' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (32, N'702 loveWord', N'Harole Fleet', N'0837483819', N'37 Bay Ray', N'Phường 2', N'Quận 7', N'TP. Hồ Chí Minh', N'Anrell', N'0937493719', N'Hàng dễ vỡ', CAST(N'2023-05-27T16:56:27.810' AS DateTime), 5, CAST(N'2023-05-26T01:09:15.530' AS DateTime), 1, CAST(N'2023-05-27T20:55:04.000' AS DateTime), 11, 7, CAST(N'2023-05-27T07:17:55.710' AS DateTime), NULL, CAST(N'2023-05-30T13:55:20.223' AS DateTime))
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (33, N'1278 Trường Sa, quận 3, TP. Hồ Chí Minh', N'Tống Thiên Văn', N'0905487961', N'88 Sư Vạn Hạnh', N'Phường 12', N'Quận 10', N'TP. Hồ Chí Minh', N'Nguyễn Tuấn Anh', N'0354587998', N'Hàng dễ vỡ', CAST(N'2023-05-31T06:00:45.740' AS DateTime), 80, CAST(N'2023-05-31T06:01:16.623' AS DateTime), 80, NULL, 66, 3, NULL, NULL, NULL)
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (34, N'478/2 Tô Hiến Thành, quận 10, TP. Hồ Chí Minh', N'Trần Thị Ngọc Duyên', N'0245687921', N'1300 Phạm Thế Hiển', N'Phường 1', N'Quận 8', N'TP. Hồ Chí Minh', N'Trương Văn An', N'0254687942', NULL, CAST(N'2023-06-01T15:37:00.763' AS DateTime), 5, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL)
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (35, N'309 Cộng Hòa, phường 4, quận 3, TP. Hồ Chí Minh', N'Đinh Quang Khải', N'0954878946', N'7 Nguyễn Thị Minh Khai', N'Phường 8', N'Quận 3', N'TP. Hồ Chí Minh', N'Đoàn Văn Hậu', N'0907854603', N'Không kiểm hàng', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (36, N'200 Võ Văn Kiệt, TP.Hồ Chí Minh', N'Nguyễn Ngọc Phương', N'0123569459', N'75/2 Thành Thái', N'Phường 2', N'Quận 10', N'TP. Hồ Chí Minh', N'Trương Thiên Phú', N'0245687958', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (37, N'124 Âu Cơ, quận Tân Phú, TP. Hồ Chí Minh', N'Lý Nam Đế', N'0246879443', N'29 Nhật Tảo', N'Phường 10', N'Quận 10', N'TP.Hồ Chí Minh', N'Nguyễn Kim', N'0145456457', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (38, N'60 Cao Văn Lầu', N'Chiêm Đức Giang', N'0846985234', N'366 Lý Thường Kiệt', N'Phường 7', N'Quận 10', N'TP. Hồ Chí Minh', N'Nguyễn Văn Hiếu', N'0578945632', N'Hàng dễ vỡ', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[DonHang] ([MaDonHang], [Tu], [NguoiGui], [SdtNguoiGui], [DiaChiNguoiNhan], [DiaChiPhuong], [DiaChiQuan], [DiaChiThanhPho], [NguoiNhan], [Sdt], [GhiChu], [ThoiGianNhan], [NhanVienNhan], [ThoiGianPhanPhoi], [NhanVienPhanPhoi], [ThoiGianLayHang], [NhanVienGiao], [TrangThai], [ThoiGianNhanDon], [ThoiGianGiao], [ThoiGianDaGiao]) VALUES (39, N'781 Điện Biên Phủ, quận Bình Thajh, TP. Hồ Chí Minh', N'Phạm Ngọc Lan Vy', N'0548799623', N'82 Mai Văn Thưởng', N'Phường 2', N'Quận 6', N'TP. Hồ Chí Minh', N'Trần Nguyễn Minh Thư', N'0488955439', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KhuVuc] ON 
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (1, N'Quận 1')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (2, N'Quận 3')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (3, N'Quận 4')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (4, N'Quận 5')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (5, N'Quận 6')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (6, N'Quận 7')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (7, N'Quận 8')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (8, N'Quận 10')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (9, N'Quận 11')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (10, N'Quận 12')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (11, N'Quận Tân Bình')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (12, N'Quận Tân Phú')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (13, N'Quận Bình Thạnh')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (14, N'Quận Bình Tân')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (15, N'Quận Phú Nhuận')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (16, N'Quận Gò Vấp')
GO
INSERT [dbo].[KhuVuc] ([MaKhuVuc], [TenKhuVuc]) VALUES (17, N'Thành phố Thủ Đức')
GO
SET IDENTITY_INSERT [dbo].[KhuVuc] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiTaiKhoan] ON 
GO
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTaiKhoan], [LoaiTaiKhoan]) VALUES (1, N'Admin')
GO
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTaiKhoan], [LoaiTaiKhoan]) VALUES (2, N'Nhân viên xử lý')
GO
INSERT [dbo].[LoaiTaiKhoan] ([MaLoaiTaiKhoan], [LoaiTaiKhoan]) VALUES (4, N'Nhân viên giao hàng')
GO
SET IDENTITY_INSERT [dbo].[LoaiTaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (1, N'Admin', CAST(N'2002-01-10' AS Date), N'admin@ad.admin', N'0123654780', 1, NULL, N'Admin', N'$2a$10$4XC5HsDxCPVrv.KyvICk0OtP/dVLBM3pReT5YWi5Ihcp.xiDbrn4u', 1, 0xFFD8FFE000104A46494600010101004800480000FFDB00430006040506050406060506070706080A100A0A09090A140E0F0C1017141818171416161A1D251F1A1B231C1616202C20232627292A29191F2D302D283025282928FFDB0043010707070A080A130A0A13281A161A2828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828FFC200110802E002E003012200021101031101FFC4001B00010001050100000000000000000000000001020304050607FFC400190101000301010000000000000000000000000102030405FFDA000C03010002100310000001CE1E67A3631EFE3DA362844CC106C35F9C8DD40C24240000000000000000000000000000000000000000000000000000000000E5C37C7C6CAC5B46CA08908363AECD46EC31000000000000000000000000000000000000000000000000000000000000E5C37C6C7C8C7B46C4448419D83988DE225880000000000000000000000000000000000000000000000000000000000072E1BD8C5C8B131B009083330F351BB44B1000000000000000000000000000000000000000000000000000000000000E5C37C7C6C9C6B5762988B0419987968DE4C4B1000000000000000000000000000000000000000000000000000000000000E5C37C7C5C9C7B46CA2262420CBC4CB46F24620000000000000000000000000000000000000000000048C7D14BA5707936766A66A970DDCC82800000003970DF1F17271AD1B21121065E265237B231014D5A7BC6B2E747A6E9CEDE4E8B455B7A464F8EE7D2DEA8F3DE8693D08A020000000000000000000000000000011A896E2C70DA2D63ADE6F0FADDE38FBBE97D0DE9E43D6769334B3A4E838388D17A4709D661B6C162FF003DC20000001CB86F670F3312636122420C9C6CA37C180187E77DB715D35F5F9A67A79E6126BB4DD5427CBF9CF73C18B7946F36DCBD34EE765E39B1C2DEA4E6FA3CA645401120020900000000000000000C6964E9F99E6F68D96B3AEECBA29C3759B8D6D63618D83B7CEF3929E8E711631F21116FCD7ABE229AFA4CC4F0EC10000000E5C37B189978935D8CC54B40832F13351BB0C40D3F09DFF97F4C7B3E6E9767B679034C80014D4353C5FA4E9F2D3C933BBDE531E8EAB73E3DB153D41A9DAE132044A0000000000000000022CF0D76EB8A767D55E53D36BD329BEC3C4AB9779AA3755B53929F4388589862D0CBA2F666B732D4D6F927B678A4C7A96C795EAB8B60A0000003970DEC6265E25ABB1AADD717083330EF2BD0CC4B1096B7CB7D5FCA378F5BC9D2EDF49D9CE2E56DCC1300011AADB61657D4C4BCDF42C723DAB4AF96EF7A7E1FA71F53BBE4FE839C6DC640000000000904000930F47C669156CB73D374D32B53AFCBC34B59872F425B5B5672E5E9700898A702AB79EE14D5918F76699DE47EB9E45AE1B6EDF81EFB9370C64000003970DEC6265E25ABB19898B8443231EF9D086004791FAEF976F1D6745CD74BB273F5F7E63346BCE000B7710D263EF74DC3D96C73EEA2B1CB731EA1A4E9CA7ACF20EC2F975EB37B092CF312EB5E7B8378F50C2F34B16771634D99A57229C2BB2B976314DBDDE5EA89EDF3BC8E9A4FB1735C7C14FA2D5A7D2BB4D7DDCEE4E8A2B32D066DAB7B3D3E979E17859AB06978832E9015D15CC6C3CA3D5FC875E7C9F44F35F4BE5D8309000000E5C37B18999876AEC669AA2E110BD6AF9BF9896003CFFD0398D1CBFA678F7B074C48ADF36FEBB61AF348BD001035B181C9D01C7D601364D4F29D453D19F3BB6C2DD6B9727BBED48D06CF22D56D466F3897514F3087537792DD55B2B9AC52DB5AF4FABBD7ABC0E6ABD2BB0B58911339F76F72F405644973776B23D0E10DF24316B36ED197504480AA9998D97937AC78EEBCDB8EEF89ED78F7919480000072F306F6B0F330AD1B19A2E44C2508C8C7CA46F6625880C1CE8978E7A579FF0059DB4EAC5349C8C65A36738B93AF3489863646871D2883CEEF0006A765A5B250BD6777ADDA564292C0CFD3CAC8D2A2E432B61134B0428D2EC75B6817AC9D9D5550112036B89B7EAE6993B7940A75D958996C14D80015D15CC65F897B578A6BCFDB759C8F5DC5B48CE4000003970DED6166E15A33EE5AB9121065E2DD974331318008989713A3EFFCBFAABECB6F5BB2B49315B3330E6D5D9ADDCD79A8E7FA1D172F45B1C7D600183AFC9C6BC2633259D70CE40B7A5DAEAAD01686DF1763590AC8187ADDE61DA3076EBA05640554EC6F4CDBA7A5E785889C78635063D41160005CB77E6B87E47EA3E5BAE3DF74DA6DD70EA149000000E5C37B389978968CDB945712109AE8BD2E8248C0009479BFA4E96F1C97A2F8EFA57546E3330B3118B4E6D05EB913A60D66CE8A5B9F5EB3E6F784580D5E2ED31EF1636F45D805640C7D4EFB0ECD6E567DD4449590000000009DF60EC7B78E4756003033F0697B2BB7B3DB119B892A456E032F1336F9F2BE7BD97216A7AC5FA6AE0D420000001CB86F67132F0ED5CEB96EE45820B96EF1D106000098CCD6BE5D6FD47CA7AABE977B1B2EB6CC1AF38480C7D4EFADE3AE81B0D7F0F5852E000000000000000000AA9CEB576559EA79C120008A2BC3ACDAA4CBA822409D86BF3B4C7CDB075BDA567A91C770800000072E1BD9C3CDC2B4675DB57626041728B8745312C0001C7F61C0EB1B0EB380F4CEBC6AAA66D40900022712B3ACB4797E804580000005D98B4DD57D18689B0D7E3A852E000000D9EB36DB639A3D1E2000014D485BC7CC88B6B19B859EE15BDCD6EDF96D39FCFBD4FCEFD570D439E402DD70912000E5C37B3879B8568CFB966F44C2508BD6AE9D05512C00034DE6DE8FE79D31B4F5AE7BA2E8C02D500001A6DC73FCDB52387B40000006CAF4A7649F438434AD1A6DDE1E1AEA5553E7F7000000373A6DFF004F3DC1DDC8000000046365444EB272672DEEF99FA7F9BE98E17A2F3BD2F36D40C2C221ADBAB5E5746C9AB74572F235DB2BC48EACB970DEDE166E0CC6C2BB17D313082EDAACE926258000380ED392DEBDF65C4F5F38480000B5A0E879FE4E90E3EA0001245FCCCEE9E6B1909ECE60B40089185ABE835FCDBEB531C3D80000656E31F27D0E00DF300000000084911C975BC056DCF77BAEE8F9B7918594D1AEE6BE7ECB9EC8A2F62579795EBAA27D0C40E5C37B7839F8168CEBB6AEC4C082EDAB8748180034B2E5FB6E23D4FBB191A660000016F41D169397A2C0E2EB0064CC58DC577BBB883A32000000448C4D47438BCDBE9D958DC7D504D6D1995EC7A79AA93B79424000000000068FCCB75B1CF5C4EE35BB2E4D0339C3B99118DF1F0F6B6F2B6AF6D8F9500ECC80E5C37B7839B8568CDBD66EC484176D5674A896003CCBB2F36E88F51E8F5791D5CF9AC2998CC620CB635E2B5B92B502BC1CD5679E8DD51C5D5A8BF9F9768C4CC9757344978000000000029B192ACEBB2EF2B312695000000000000448F37D8DCD4E3B76F313C7A0400000000E5C37A3033F026332FD9BC98105DB551D3239E9C36DE7B46F3AB2E237D72C6B1EA773CCB516A7B2C78CE31EDEF0BA8F70B7E2549EE54789550F689F21CC97A9CF9EEC11D9DDE772CDC5DC0946C2BD65733B0625F2DE4731D3869B6E54B5742292B5341758F886CDC9E921E8EF27D527DB2DF855B87B353E3307ADD1E503D56D7978F4ED9F8F41ED1B6F04ACF78781D72F7C791F468EE5CAEF8CC42531CCF090ED384D4456FE8BD5F8BFB2F2E958C6E000000072E1BD183B0D75AB9B76D5D8B0415D15CB0F80D96BBB38B370972F16A6F4A2D4DD84D0AC53158B6B82D45E1617C585F82C2E528C8EC3861EC19BE33D3DA3BF9C5BF31CFF005FC6740693AAE577C6B3758970BB471BCC43BFD2F0E89DE695526D4DE989B4BA2DCD6295421222578A236F51A4A37949A38DA62431A2FC4AD6559B68EA74FAD134C804E57B2F997A67368931B8B755C535480000E5C37A30361AFB4665FB17E042254D58B2E0662AEFE1CCCDBB8263400000000004A04C028AC588C8B66D3D1FC86B98F62BDC2F5735D84E8B9D96FF0084D6CD6D1372A89A6A0025000000000AAFE30D8DED449B9B785063A609B772D96C02B28AFB7C53A3DE73BD1716C15960E763617C7D86A3278B5CF44FA7CE5330912E5C37A3036181319976CDE48418B96979BDCE9B99EDE1DE6BF3EDD9AB4C0000000000000026045ABD4968004DEA6A00000000000000124272D1869260816660C9EBB67DB4D78CE9B326623C83D83C817E9FA7E43AFE1DC2861DEC0E3D7370B7EDB3E7EBB963CBE96D2D5FEEC43AF3E5C37A30361AF98CCBD62FA420AE8AA5B4F2AF64E3B6E5E6B2F45B8E9CECE06EF10D7AAA4000000000000011368A4005F535000000000000036462F5BD9EC26BABD8D78D318F1939470FCCFAF16F07DB7A2F9D45BD89E77DCCD32C4C3C83D63C4A2FE81D1EB367C1BB0B331B96F8319F5F06DAFCFC6C785DD86366F5E61D9901CB86F1AED8EBA632EFD8BE9082AA64E9262B9C3CA751EC1E53D596664F3D95AD767859190699B4D610490000000000414DB983236FD6F4335F1BC6F54F324D9BD62626F22400000000015991EC7CE74535CB9C1998AAC32C9BD132104D8BE3CDB45ECDCED6F3D0F897A4173CDBA8D6D6DE85313C3A84008D66D2CF3DF1F3A26F01AD40E5C376B763AE98CCBD66F24209893A4AEDDC9C634BBB4C78A5BDB57DB969ABA135C9A6C49BAD7D56090004C000045B2BA2913DBD1DD4D6DCDDAA62C69BA0B678BD8F58F34ADB0AE5B26FAC5C2B448000000E9B99F4F46EEC6163D75DE5354698CAD5C2E65E0D48C9C4A72E5780072BE77EDBC656FC6F61C07AEE1ADE989E6B040044A400400E5C376B763AE98CCBD63213020AA9A8E966267008703B6D8703D74F44E1BD2B63B63E054FBBF3C794BB3D544E859F8A5B9884D555B15A815440337728E77D4F69B4988995A00029C4CD1E73C57BDE1567C31E85CAC4E9EAA49AEAB42EAD0B91456446CF728E4FDB389EDA635391B257663E46AA698DB3D66DF3DEFD15C6DCB397895A33113201123CC68F4AF39CF4E976FC875FCBA065600000003970DE35DB1D75A32F231F22260415425D34D15B00853E65E9FCCEB1A8F4CF0CF4CECCBA89899CD129534D7262DBCE43417B7234591B51A9CBCB109202640355815D7A45355B20000357ACE9D0E230BD0F5E9E3B2FA42359B0AD284C1CE74DCCF4F09C6C7C2A6FB8A3579D12CF89B6430A6335A8DBAD7B270336D9D4001123CD3BBE37339B7E9472DC0000000E5C379D66CB5D3193918D929082609E9AAA2B9E70829A92F3DE7FD7FC8FA63DA6ED8A7A79B2D8F78A80000000000073F8BD463E7BE455137C024000030F3318C50082624733BED3E544D089E7EE44C272767A3BF7C76FA5DD61DF2C5DB5ABA3231EEDB3CA130001A9F31F64E76B7C3DEF94FA7F1ED7C652000001CB86ED6EC75F319193632130209893A3B966F4E0101A8957E756BD0BAE9D5D371B618D1936A54D76E0BB558192C6192C619338B7CAC000C686BB4F973976EEB3391EAAFCF705F2008125246055400122155668F0BA4E6CD8598B98F5512536898A91B9ACE8E2042E5BACCC44CC0044155350F25DB74DE6796DEB2A6AE2D020000072EB533BDCD766624C5FC9C5BD0B8A2535224E8EEE3CB1BE8C2458F3A8E8FAEB95DF535ED804C00891145C169745A5D166DE55A29BB8F264AD5C2759B3889C5AB260E77A1988B54B76ED4AA88ACA26A14C55051358A26292B5A82F2C417F4BB2A4E6B618F6227718B46EA9B69F373E62512D30000BB9581948AE99B72AE9BB0540A3C63DABCAAB7ECF63E67BAE2E8EC9C7AB3D7DAE4693B171C87635F172273266F80CF935ED80D7B6126B9B1A8D6B634985CEEFF94DB3D87AE6BB6FD5CC135000000013124260A2D64418CBD414D502A50115565AAEED4515800001836B3B0400002353B71CCD5BDD19BDCAD4EDA2400005DB433899800079B7A4F9EC5B41D4F21DB71F5D95D657B317C6332463B200089000400538DAEBC68BA2E77D93B39AF49A62209000000000000000000000000031B260D6A6000001CEF43CD9BACFC4CB89000000C9BD8B9530000E17BAE2A278DED786EE793B030B8000000000012E2B073F6DDB86D7BAB57B4E7098448008B65D000001300209000013000000000062E36C700A400014739D1F3674B7AC5F890000009CDC1CB45C124488F3AF45F258B62F67C8F5DC7D618DC0000000000166589A1C4F4BEDE6E824D7028B264B1864B1A4BF62B922EDABA0000005A28320A0AA71EF1500A649000000000B37A0D6ABA05517CC798BE60E837DA03A8AEDDC890000008C9C6BC6509802D7897A6798574E9B7BAED8F0F58524000035155E36AD3D06EDA2BA6E1A2ACDD62EBB5568D8FA479E6FBAF93AE7278F6AF654F21275AE5B08ED29E5AD9D655C8629E813E7D9A768E530CEDDC50ED5C9621DC384A93DBD8E42DA3BA70978EB9C7EBCF497258A761473764EC2E7039276AE3AA3AF70B70ED9C5631DF380BE770E1F2CEB5C5D47518DA2B074D779393A4C9E42B37DCFC69CEF2F71D29EC1CE6BCECDC85E8752D1614BAA71D950E9EBE5B025E88E1F211D8470F51ACE6ECE6E7B76373498DCBD1D234930DD34726EDA3B6740D2DA30AAEE6BBE5C1D7DF552F3FA7D0E11E795F7F27035F76870377BA1C1477D27051DE41C2D9F418385B7DF91C0D5DE42781B9DD0E123BB938777238677130E131FD092E067BC9382A7BE93CEEAF411C05CEF079FDCEF079EDDEF60E063BF9380A7D052F3EABBE9879FBBF1E771E8A979D55E87279ED1E8A3CEA9F4693CDEE7A241E7B6BD220F3DB5E8E3CEED7A541E6573D2625E70F474479DD3E904F9AD3E97279BDBF4B23CDE3D289F32B7E9F2797DDF4B83CD69F4D83CC9E9D07985CF4D83CD6CFA7CA36323329A92080000002249841542444C13092082660009882A802600120898000482089804802609841544C09802489404880092122094C044C000012225099804C1000000000000000000000000002624800000000000000000000000000000000000000000000000000000000000000000002624800000000000000000000000000000000000000000000000000000000000000000002624224204904A2480000000000000000000000000000000000000000000000000000000000000262484C004A24800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007FFC4003110000103030205040202020203010000000102030400051112201013303132141521400633222350602434253541A0FFDA0008010100010502E0EF64F96D87E7FEA8ED27BED883FB3FD51DA1DF6C3F2FF547BB0EFB627EDFF547B7C5FD9FEA8F50EFB62FEDFF00547BB0EFB629FEDFF547A877DB17F67FAA3BBE2901CFF547B7C6C737FD51EDF1BF77FAA3DC06D8DFBBFCF2DE6D14ABBB014EDE1D348BC654289094A2E0F48B875DDEDBA3101DDAA3A42AF4D522F2C902EF1702E314961F69F4839FF20EBADB497EF382F4C7DD5A8951434B5D336F94F22D9692D2F40ABCBA19816704CEEBBDBE37EDDAD5CDA54C7E0467CAAC4C1A5589E14FC290C201229332426A3DD9F6EA3DD59707F8B9370618A72EEF953CE29E710852D4CD8DC34C5A2334B03E38FE48555638CE2DF9F35A874C39CD6BAAEF8D0DB1CE1DD930E98B6AFF00D88D8FC38EFD4BB332E97ACF25158A6A5BED545BBAD34C4D61FF00F0F3A7B71932E73D27844B3BCE29AB4C441CB6D573CA8B48C6D7D943E8384250972E73C7C759DF11DF6C6197B65DCABD05A95A2E3BDD8ACBA87AC4D913ADEEC65D4598EC630AE88795FE09F790C372EEAB7520152A3D91C518F0D88F4B7128A5BCA550054596F46FBEB8E350ED5239127ACF76A4F6D91BF6ECBB0CC0B768F5A17FCBA18A990189553AD0A612460C796F47312E0CC93F7E65D5B6C3EFB8FAE2437A4AE240623538FA5054F2D5C00C969B081C54BC51513495D0ABBA12B81505E0F47EABBDA87C0D914E1CD973C7A1ED51FF004347E3A320E5C75B438265BD49514A9351A73CC18B3997D1F6DE790CA275D14F861871F540B369A7A4A19A5ADD90529D3C00C96D01038B8AC0E2D1F89090B64F7B0B854CF55DEC2876D9171CDD97119834CE9E524E0F4657C2B83AD21D4CBB7A994D5BE7AE3B8DAD2E27EC4A9088EDCA90B92E5B2DEB985A6DA8ACC896A5ADB6CE78B2DE81C547144E7634785D9B6D99BF8F93AFAAEF6A4F6D8D7EDD93125716AD3FFAFA6D7D195E1B1F8ACBF5263AE3AE3497232E1CF6A57D7B85CF944A9D90E5BACE497E4A58A515C85B68D03877A61BD3B56727637E55775055C2C39F55D577C6876D8C7EDDAFA396F589C2A87C127237AD3A83C8D0AD8A485A66DBBE124A5502EBCC5741E92CB346F0CE557A457BD1A4DE8E7DE9CCA2F4722F2CD22EF1D5499B18A42D2AE1759FC8A8CC3929E890188299134A821B2BA48C0E31D181B16AC0DA9EF57A1FF91B2BDCA97D577B50F91B1938736DCD3A67D80FFC5E0D9C745C46B0B4149DB360A5E0E214D2D9BCA7434E25D4538E25A43D7940A72ED2143DC24E5525F50436B75C6ED33163D924F2459E61A165944FB13F5ECB2E8DB26051B5CC0168520A49496663ECD466CCA97FD1010EBAB74B4D6D8EDE76A8E06E4F7ABAA82EE1690E19BD577B50EDB1AFD9B6FC3FE5DB247A795C50ACF40D3CB46F9410E97D82D18B31D8D4FDDDE557F6C875AB3CB5D26C3F02CF085330ADF1E9126322BD7B546E0DD7AF6A84A491EA3E7D40C73D35CE6EB5B4E176DB11D53B648E54965880A00A8A19036B68D6A48C0E27E02D59DE3BD5E194333AC5CC2E755DED49F1D8C0CBBB6FC8D51A878F049C742439F3B9C5694D292141E87F36F84DA509521B1CD5D6696AD293B5034A78C8FD9495293456A34949516D011B40C9691A13B1D574455C14152FF1FF003EAB9E343B6C63F6ED9AD9722D59D4576DE295EE75CD03FF00BB9E56A5F14F6E3255B63A762D5A539CF16D1ACA13A46D8EDE06C347E4EF4F9387082493616006BAAEF8D27C7647197774A48449FC7A40DADAB6B872BDCE7C238B08D4AD8E9D4BE284EA5631B249FE3C1B4EB52404EE8E8D4BDAE9E8A7C9F5F2992727F1F3FC3AAE78D23C7646387775F99FECB7C8F4B29CF2D885F1578EF927E380F9A4274A78B9E1B1A4681B24F8D019A6D1A06D0325B4E84ED577E837E5764955BEAC23117AAE78D23C7635FB375C58E7C4AB53DCFB7EC1F148391469630BDCF9CAF8474FCEC7FC38C74677286A1C9FE484046F8A9DCE1C0E8B43E6FC1660D5A33E83AAEF8D37E1B1032ADF77679332CD23912CF7145208230691DB848492ADD23F65368D6A030363D9D3C1A6B3D7033481A53B5CF2E8B3DBF239050C24151651CA67AAEF8D23C363232EEFB9C3F54D55B65FAB6A9B390E2334847CF150C85B653B9C6B51E41C368D09DDC9A4A129FA1193BD60E4209A0D8AC0483B9AF1FC95DCBAD275B83B755DF1A4786C46756F0335788A5997699098F269AF2DCF235A5C4141FBA91929181D051C0273BC0C0FC856153ED0D0767759DF1A478EC6BF66F478BED25E6956E9297DB429B4343E77AD0155212903EE454FF2E8B99CEF510843EE739EB0207A6EB3BDA9BF0D88F3DF32ECB6E422FB84C27D329823343A2EAB52FEE44EDD12335A45291B51E57E7345BAA033C889D673C69BF0D8D8CB9BE6C769EB846B4BEE2DB6D0DA7A2FAB4A7AA96D4AA43494D684E5E6F09EA451FD7D4713F1C5A15F922D21A82D73A5ED2A02876E83BE348F1D8DAB4A86EBA4BF4AC64D5B1A7DF91D292ACB9D4699C8E2A190EA742BA71FF5755D1F1C13DBF205EA9F6446A9DB5CF36978E2B77149394EC73C69BF1D8D6399BAEF1F9F15B5A9A5D9DF0FB3D134BF9574D9677484E52A0527A48184F5948A423E6AFB15C4BF65841A65430763A9FEC7105B29594D294554846AA1DB639E349F1D8DFECDF7AE57A98CDF298E8B9E1D24B4A5536D04741D6B5950C2BA11D3A97F4AE57465B5489F22455BB5FA4E24814D7F6BCB42554FB4842509D447C0DAE78535E3B11E5BA53BC88F63409170E92BB7400CD36C63A6F3634F4184E947D1342C8B263DA5A6CF15AF4851D4412290FA934FB9CC53634A7739E14DF8EC6FF66EBBCCE73B678FE9E1749CF946F009A651A13D475A0AA3F1BA3A32AFA57599E9633F25E7EACCFBEB91C5682A586C0A2D0A5A74701DB72FC29BF1D88F2DB7495E9A3D9227A893D334EA74AB6A192A28404F5D6C85538D148E2863E00C0FA5F9067DC1AB7B32130E237153B9490AA435D073C69AF1D8D9C2F6DD5DE6CBB1321B81D4929CA78A1B2A2D33A7E9B8D8557A7A08481F53F2346995625A4C5FA0E78D37E3B13E4365CA6A23B551886E3F30D730D732B995CCAE65050AD62B50AD42B50E2A6C1AE42283202BFC5FE48165AFC7CAB9BF417E34D78EC6FF006709321B8EDCEBABB2423BDADAE74E0851AE59AE5572AB975CBA28C50D06B4834AFE3C7359341445733E4395AC5039D9CE4737E82D694055CE1A695738896BDEE1E45F22102FB0F1EFF1757BFC6CBB7686D88B718F29C4A8286A0692A0AE8DFD614C4393E95EB75D7D42FAEBF0A6BC3627BD4DBAB31CB3125DCDC36DB7C4A9CE5BCB5027FA25397C96BAF5B2A95324A8A9C7175935A9582A27864D6B55265C84A13749496D77B772C5ED0422E71565B971DCA073C751A4B94140D3475CFA9128A5DAD69D759AD428902B58AE60A7E6331D2EDF22A02FF215E5CBE4C51953A449AE63944923A09252AE62C0C9A0B526A15D9F8E17F90B4298BE4458624B52070B9DD5B8A24DD653CE1F9351DC2D3E9394F597E34DF8EC4F97E42FA90DD2E5BEA471C562B4D6288C9D358AC563A0CBEB656C5E872A2C96A5238671483A5615F081A9D795A598470F1593449344E039748A90EDF061DBACA70294547862B158AC562B158AC562B145B345A22B966B4D60D6389A8F21C8E5BBECA4A5E9D25E49F9D910032BAEAED4D78EC4FC1B848F532B8049358EBE2B158E2CBCE326DB75E5258790FB67B53475B7A3FB08FE2D361B04848957B095489D21F570C569AC74DAC05712906B91452470C563A1658AB7A4EC5282681CF497E34D78EC5A8253C186F552BFAD1F4F1C60CF76254594DC96D4D21549184F09974663D4B9AF4A340569FA00915CD341E4D0503C17E3C55B8273567650D43D9205217A7A4BF1A6BC764AFF00ADC123097CFF002FAA47042948541BC14D7AD8F4E5D6222A6DE14E0A158FAC87714B7350E2AD894951B5598937F29F5D6356616C7FC29A5E9A073C090372FC69AF1D9281547A40CAA9E1FCFEB11B87DC3C23B2B90EB76070B6D58584D311596135753AAE161D3E9763E7E23B2149524A082456B5567253F0362BC69AEDB6F91436A41C293D9C4EA4FD756D1F5DA8CF3A9C712715FF00CAFC7EDCA636DD7FF61F8F83A38A96135E6A46025680B0FA12829055486C0DCBF1A6BC7627CA6C64CC8EFB4B61D61594D3ADE7EB9EDB076FA6CB2E3CB16173951E0B0C328425094C1612FBB022BB522C29A7EDB29AA2915688A991336DD57CCB858BFE9F071C39E19396DF212015A929091B95E34D76D83E4A0613F90C652E92B29A4A814D29AC950C1FA8ADA9FA7022AA5C88911A889E0A729B24AF8CEB6B32CCA86FC55DBAEEB4AA3486E42383CBE5B5DEADADF2A0F02D668342B969A711A7831D03DA9AEDB07C524E524022E708C478288A69C0A14A405538DE9FA6A3C1865C7D6FDAA4B46432B8EE50FA51585497E3B2861AE0E2A80CD369C6D75A43CDDCAD2E34B8725C88F5B2E29962AFAA02DF11B2EC9DEE0D2A601CEF3DA9AEDB53E352E3A64B32E3AE33C0E290F14D25E49AC8A284FD4B3450C45AB9411352F34A65DE03AE94952AD307D18D4786A3C107E37DCADA89695071876D57212EBF24772F58C6676F520288181D16BC76A7C785CE1096D2D1A788562B9878210025CF3EA13C07CD5BED2929EC385C60A65A1E696D39C01EB58A38764D7353AA8F10A3C14AC04F9ECBE42F50D34E2D8766C954A7EC6CB8DC7FA07B535E3B51E1C66A02253D6E790CEC43E451564F4B344F1B04224E28209AE59AE59AD26A74244B4498CEC65F1CD67A767679505F56A50EFC3989CF7E1AB15F2A2846375EEDFCCE0CA52867E935E3B077D97988A43BF8D2BF8CCB4C79352ECF258A524A7766B359AD559ACD676368538B85696131C0DD8A7A3A1D44DB12852DB5215C7359ACD66B359AD559E2DFEB58C29846554F2B4A2A3E74F01F14939DF7C85C8798B9ADA856A756FC2EB9ED4CF6D83BECBA8D502148545910A4A25334E32D38245923381EB03C9A369980AE1C845042CD118E8262C85D47B2CB74C184D43474A44566454AB0034FDB65B237A50A5535024BA19B23A49B7C7696839471907FB2994E9471477DCF36975A9D6C722B25DF6E4F5CF6A67B6C1DC76E24645CD80C4BB34EF4EBDC109A2C364AA2B2A02D30C28DB629A16A862BDBE26136E889A44665BFA2F408CF51B1C334E5818C7B13742C6D537678A9A4C18A9A4A4207057CA87C0A2F2414B89553C8D54DB3F3B50AE84A41917E3D73DA99EDB53DB65ED8E63356EB932A63EA4A9050512969A1DBA27E42860EEC6543B3CE64F043D40E47079DC14B8A1C53F2375F42E3CAB75C8C85FD06B70EDB08C8B9405B6E82525A24B59FA72DA57352CAD4A1DBA4E8F9DA7B5307FE3EC69CD3493A852FCD94EA5F06B7DC21A6634EB6F4191699464B1D767727C769F84A71CD6C619ACD03F4B9A8D7D374EF78242E3AF4A36B4AD2AA53229B4E94F06FBEFBC433298872151DE65D4BCD7599DC8F0DB3E52233115A2FC91D8A6B1C335AAB556AACF0CD67A32DF2083831D7ADAE8A8E01DF2D27524E0AF07724EA4EC477E85E2388F3AC323AA7B533DB6B3FAB65C6608ADBCE2DD5D8E07213C4A6B07A20EE7D7CB6E3B7CD7652021C42CA149394EF270147278E3869AD34EB6952143058734D286360F923E06C49C11B0D039E37A60BF062B9C9900E47559DCDFCA38CF9698ADC879721DB1DB82C7434D69AD35A6B4D11C01A0764D4952186F96875B4B8111CF3B89571CF03F358E18DC6A5363834F6496688C7065B217B91C15D9269748EFC14322535C99305C4AE1EC2E205731141C41AE6228106B58AD628AC5629B38AD42B50AD42B23825412D0750454C9098CC48794FBB67B6FA809000EB14F10AACEFD559E1A6B4D69AC70C560D138AD55AAB51AC9E24643AD96F832EA9149295D6067A083F0AEC3BD01B2FA929B84057C6B55731782E2C8CFD2CD4B775AEDD14CB90D369691F408AC1E39AC9AD55AAB3C74D01D0707F2DE69C8FF3414534C2F5A3A083F3BFF233FF0032DDFF0063426B426B426B969AE5A6B942B942B942B942B942B969AE5A6B426B426B426B969AD09AD02B48AD29AD09A9AA4B4CA1256AB7444C463E994D69358358AC562B4D69A03A4B4E7A45A490B4E8541E90EDBBF25400EC256995FF00CFA64E04974BEE5861879DFF000EE000745CF97220C35D141F8DDF9376858F53F4DF90DB3571787222B2643ECB6965BFF0E7B1E89EF1BF5745BF2DDF9301C98B9E7FD39BABD4D7E3B1B4ABFC4BA3A0B384537E3D1143B713C3F24712A91073EABE9CA78ADFB346664486DB4B69E86AEA77FAAA190460EE5F8D32308E923B6DBBBAA766DB3FECFD3BA45CC4B6A14ECDE89F8A41E92E91F59C1F1C71C314FF00EAA4F4DBDAEAB421C3A976A4FF005FD2797CB696FB8B559508F47C147159D99A0AA3F3491D25D0E0AEC0E281E24E2B3D62334B18343B9ED47B3FFA691DBA4DF7D97E7D4CC5A809D317E9485361B4DB8490C361A678115A6B4D69AD3C474D5DA87CD1E00F1577A49EB3BC13DCF6E0E8CB63E0A0E47491E5B3F207C392584EB7509D29E899EC82B9CD2419ED0A170463DC13467B593714E57706C5353D0AA99279F56FB9262A157B630F5EE3A43D7B46B72F8DA5D6EFACE117C8EA71DBEFF355F5A0972FA8D2BBDB5ABDF0E45F554DDF1BE5B5798FC837D4F2C5F505D37D6F96E5EE3847BF26BDFA9ABE8A17E4E557B4F33DF7149BEA792DDED2526F6ED48BC32D945F13CAF7A8E53EF4CE966F672DDF11CB4DF59D4BBE470137EA5DF51CB55F5B096EFC6BDF4E05F935EFC9D6F5ED842E3DED0A29BE346937B60A9778605397869057796B0E5DDA4D7BCB15EF0C92A9C8E61BBB6849BD269CBBC64D2AF7F28BD24962F0DAD5EEB17422F2D149BD02A76F0D250BBC3011EF8728BEA7522FAC1A72FC28DF12A5A8EA315E4B07DC1BCFB89CAAE0804CF406FDC118F706EBDC1142E1FC7DC1BA3714D26DD24816D918F6D9194DB241A36C934AB6C914BB6C84D7B648A45A9F349B53D4DDB1F557B4BD936A7F29B5BE49B53D936A7E85A9FAF6C9346D4EE936B919F6B9146D4FE0DAE452ED4F026D4F57B5BF5ED2ED1B4BD81697728B538A0BB53C00B6C9C7B5C8D7ED6FD0B5C8AF6B9142DD24D7B6C8A36C934BB5BE28DB2401ED6FF2C5B6492BB5BE902D920D7B649AF6B915ED9270AB64814AB5C815ED92326D92051B74915EDF274A20495526DD20D7B6C9A5DBE4A6936F92AAF41271E824E7DBA4E7DBA46910649AF6D935E824D7B7C9AF43268C57C1F45273E864E510A42E84093460C807D0C9AF47232A81252150E425B4C1926BD149C7A4914A8CF26BD33DAFD1C8AF4722BD2BF95467935E99EC18EF0AF492057A2915E9DE0AD6757F2CA41556835A159D0AC84955685568556856742AB96AAD0AAD0AAD24D6935A155A555A0D6935A0D6935A4D6935835A4D6935A4D6935A4D14915A4D60D6935835A4D60D60D6935A4D6935A4D6935835835A4D60D6935835A4D6935A4D6935835A4D6935A4D6935835A4D049AC56938D26B49AC1AD26B06B06B1C706B49AC1A009AC560D6935A4D62B06B07860F0F9E1A4F1C1FF007C3FFE237FFFC400281100010304020104030101010000000000010002110310122030312113404150042251321480FFDA0008010301013F0146EEEBEB8F5F566E7AFAE3D7D59BBBAFAB373D7D59B9EAE4C20F59A9F725C8BD17940C9531C06E7ABBAF2507A0E953ED0BD06B9E9CC6B3BED4CDD83E780DCF5729EDD69F9308B08F625D0835CF4CA2076AA540C0899F28094D600AA37E53380DCE9D8444694CC3AC5B28B639899F01328FCBACF7E2113919366363CD9FD267686E6E746AA8DF1AD2A9220DDD4FF9A4A9592C82C9656941A5E9AC0DB39D8894E76466CC6CDCA621C474167883A52A53E4E8E6CAC4AC1C57A27FABD0FE95E805E8357A0D46805E81F829B48FCA02F56A666CD1250117299DF19EB43E2CE6CA222D4D999E53AD77FC0BD31F3A1E93380DCE8537AB39B36FC7EFD8BDD88953361E5011A3BA4CE0373A8ED54FE842A78B35D8994D703D7B0AEF9317A7DA2F0135F37A9D2673B8C04D74A71FD74A75304C7642799EEC44EAD125017AA9BC07729D1A8129A2046C4C2FFA0263F313B57FF1B07109AECACFF2E4380DCEAE3AD012ED9EF0D4F797F76A4FC4EDF907C46E0C2F5026F683AE208C57A253C06F817373A38EDF8FF3ABEBC7F94493DE94AA4783AD5764EE16840598CC954A2E27F54D2E6B3F6EF4373A3CED41DE62EE706F6AA56CBC0DE955C7C14D78774A554ADE207135A85B33109B508ED54703A142C743DECD389943F2027D7FE2738BBBE1048E91793DF1B3AE1372A517A9F0A142850A1428E3850A142850A142851A0309A6780A1771E3851B472C5D9C050B1FA21DA1667FA5529FC8D4A162888F791AB3BBD36F9943F208779E90C5C32551C0F57285DE3DD4DC39782888B32CC89F2BD46AC5AF0AA1F38E850B94E1CB3C6760EFEA7353068C76253DD919D0E86C4471CF236978F368D5AEF84070943570B4F04EB2A77F57C42A6322AAF5B35C819E03BBC71B68B9C276953A329CF68B31F2D4E717768027A4E616F7AB4F01DCF1B6B1023882167D39F21527007CAA8EC8EAD74701436718E2ED3316FEBF2AB53C0F1527CF83628EED3237286A4C226789A7132B233927BCBFBE36D523B4EAB3C0C28050B158AC777A719FA16F699D71D477D137B54F889844C9FA26F699D7138FD1B026F5AC85216414845C9F2A0AC4AC4A82B12B12B12B12B12B12B12B12B12A0A82A0A85056256256254150A0A82A0A82A0A82A1415895895894D10B20B20A42C82C85BC2F16F1A78F611EC22D0A2D1FF0090FF00FFC4002C110001030206010304030101000000000001000211031310122021303104404151142232504261805271FFDA0008010201013F01FF00050692AD9509CDCBCCC6E62AC856423451A647A60250A4536980A142CA027B0B8F3511A21160468FC22D23D13697CA0D4FA8D620F7543B2023179DB647968F481D355D944A6D56BB629D4BE1111CCD69726B004EA81A9F5CBBA54E99794D000818174A69453C41E5A2BDD033A2B096E0CA85A9AF6D44FA79791B4E7B5B342A95FE1132A9B0BCEC9ADCA2060E380ED1557BE5A3DA29A74D6A794C8C69D6F6727D3F76E01A4AB45595682B4D5682B21594DA50774E786A7D42EC1ADCC60263034460E31A0AABDF2D330E47069D15AB7F11A18FCA8967655E60E97D47F4AF957DC8D772FA8726F90EF757FF00A46B7C22671A34F28DF0261133A0AA9DF2843718030819C2B3F20477C5B83B0189380C09C7C7A7FC8E2F3EDA4AA9F973523B23803187923AD034370271089C58DCC61011AC229FDF35330514D5970A8DCC2116C620A271054F078EC812717A011118B7B4E479A9B7315950EF455A59D3D990C7331B98C21B683B686AA86073D212501A5C604A73B319D404AFA629ECC863550FCF510888C1BD2AC7DB19131C94BA434F9061B1A98C2F2994C33AC2B3330D5E30DF595970AAD3DE2ECF4EA1705F5AD8FED78EF7D425CEEB8A88DF5795EDA69F8F3BB90681D68AD4A771A68B32B784AA8F9DB0ADE40A7FFABC7F2E90196A0ED3994EB56FB06C80CBB0E102531B1ABC96FBE21A4F4A951CBB9D7568E6DC2734B7BC2950332789CE84F749DB0FA764E62AB78AD23EDED78945D4E4BB8A937DF5B9B98423E3B933C7FF00A4D606F5C25A0F68536B7AE3AA36E502532947784A952A54A953C72A54A952A54A952A741DD556E5EB929881C93A654FA0AC77C090373C239E54A9F44FEF0F244D32BC6F2329CAE532A7504D323F42554FCB0F2AA80328ED3BC00EA432F69C2A5376495E351737EE7EBA4F8DBD6C6829FDAF233E5FB10F12A1DD0AB57C772F169822E1EF869BF372C718D50814F3B68F228DC6EDDAA14EDB238418286FE9CBF590AA9DB846AA464611C11CB9374E30137BD4E6CAAAD83C035533050E3CC38CBD669ED01089840CE9AADDB806BA6E2EE32C1C4716B9384A688D242A8D83CA04AA6CCBC664EE9A6789C311ADED911CB4E9C71951EC808E32C59381C9C20E30A35D26FBA1FA12AAF7C41B29ADFD1155BBE26F487E88AADDF084C1023F4653CC9D390AC85642B23936999414A952A54E32A54A952A54E12A54A952A54A95384E12A70952A7072C8E2B21590AC8E591CAEB95C72B8E571CAEB95C72BAE575CAEB95D72BAE571CAE395C72BAE42AB95D72B8E575CAEB95D72BAE575C8552AE9575CAE9574ABA55D2AE9574ABA55D2AF2BC7E15D3F0AF1F8578FC2BA55D2AF1574ABA55D2AF1FF21FFFC400421000010204020706040503010705000000010002031121311220102230404151611323327181910433425250606292A17282B1142434435363C1D170A0A2E1F1FFDA0008010100063F02D2331F2FCAA33CF97E5519DDF9547E5C19EFF9547E5C19C7E551F9707E5C19C4FF002A8CE3F2A8CE3F1F38E2344B99540F21776C6B7F94016C9B2F1719E82E7193454950C3096C22E961E9BBD7312782D484F3E664B598F69F75F58FED47BDB7144C278701754FC42711E1A3AA220327D5CB11887C829BAA56A31C7C82C50E11975A2ED3E26448F0806DA220A12FD50132B6DC067199B018260996358A2426E2E764EC2F8839744E94461A53AA0E8909C02A1548AE1E4BBC9441D5779DDBBF0CF1637726AD40C68F29A2F8866E2A4C6971E89862C40DE607041D22F3FA948506484309C23EA5DB0A31BFCA6870C4E3C0704D89220384EBBAB72C63396A9AAF879FDD97BC84DFF0A70BBA774B2D518FCB41C115DFE54BE20631CC5D6A3FDE9F839008745E0D527993790545DF830DB2BA9E0C5FD455001E4149814DC66E3970C4136AE4D09CF74B034D7CB92A6DC666E58987D7C940265E2E3B0731F0DB275E49DD8C470770C564ED52E863EB968D474C7DA6CB0C5021BB85687F03C715D20B0C11D98E278A90A929862B835844CF31D10ECA1B411C78AADD725D575CF8A13F0D647AA188CA1BAFB719C658BEEA176BE19AAECBBC6EB7DC2EB1427F69D2555221776F32E46CA4351DC9DC7F002D81AEFE7C1628AEC454A1B0CB8B8D82EEDBAFF71BA90ABB92E5E5A24175CD5D1171CE42B4D0D3C6427BAD72C6C5394B86887FD236927B43BCD17401367DA382A8210AE302C1C9BAC1AF3F493BE6288E905820CD8CE3D56182C2E3D107FC5D4FD8161E3C826CE8DE8A9A24152FB17B5CDC408B73D0F649B26FBEEA27963FF4E8676666D950EDB0C4130B14325EDE34D12886708DFA2C4C7070E9BCE288E0397558E27A0E4B1138610B941AC93181618141CF9AC4FC9D766F8709B203ACD4503CF756F9E58AD6DCB4E885EBFE7448EDB5DB5E62EA4F14E0562867D39A90D589F69DDCB2089BBEE4278A23CAC7F1829C19FF0095D9B1B61EC8B975C9337DA462D76213BA7DE5879EE032B733D95D532AA2D3F43A9B3915D32E17004754E89029FA102D3221067C4483B83B63DE44683CB8AA31E56AC177A95F27F947141F2915F2992F35AF069FA4A1363C73471636FA269ED995EA849C0CEDA3B3827BDE7C96087571A925768ED689F722D8541CD12E9A96499BE5EBB0896E165870CFB4D5F2DD5B9A30EAA20C4278A61B3D35D8CB3E28726C4FF28B5E24E0876D0CE2E6D41EC3369D05D11C1A0735DCB0BBA9526E16CC5C227B535527468847F52C0C6973CF044F6587FA8DD174DB8FEC4351BFB97FC31EABE6C347C14EB752EC4F9F044F656EAA4E690502D3223885A911DEA98D713AEEA9152BB3F8760C6B58FA29BB2E236DB462093595533B3F532B0DB0CEDF3CCDA0AB7DD0320716AD786D799CF22D1E6B98E6BBB34E45774033F95F54479F55ACD6C31FA8AD6F88AF46AAE227FAD126510FEBAA716364E754D2EACE546B8AB394DA0AF0AB2E2BC4079AC336B9623087F6D10C25EC6F1AA3FE9E6E8A44B11365D556A72C94865E9B17863A73D63D13F010197775E9B80CA27998FE2D7680798D9E11B1D60BBAB72283BE221879E454A0C2643E140AFA27980CDAA485573BDD4866905D72CB65124E2FD63AC78A8DE4370A656E68AC6991234309FA49192B9BAEC3A64190372E23909C9754CD337DB0448BC9126E9D1FEA2708E9B80CA33C56B41003A934FF008622A7581CB5CA73996499B6C65940C94CDD06E0F89F689A24F151456E3701B464600C889129B130E2E12CD2D27612E192590D6597AE7A679052DC2300654D0E35ABB70195B9DEDFA8546864CCDECD53B1233F969C5B1C473497454CF8B712193BD65CB4439CB75036065E17EB293A58226A9278661A683652CB41A666DB79296E2C82D3E3F1792005494C65F0896E032B46C29488DB68D7976ADBCB257210BA669EC6A5506E188EC6BB1850BED1329A27255DC06512D85139DF43F5977864C7096C64A477E9290DCA43E9680993B375B766F9EC5D0DE26D705D97664BBA26B5E66E014F6155D77DC5CB722E36154F892962334F74AA5D29EEC25B0732006C9B4994DC50A6EFAAA99145F972D993BEBB676CEF00F8886E886CE3299DC4656F9EC1F0E0B835D2C4E24D269A757B235C77042C30DA1ADE4365D4EDACACA724308DFA6A133082E33974509839CF3576832CF3EAFCC751A8D6F74D101EF686DDD3F08D9F96D66EC92DA8DCB0FDAD01077DA2798A91D3440ED1B3B673846BB6A25C5626CA7D44D1C3F0E2134711C4ECCED26ECD3E2A476606DE9A5FF11763A4BB78864E7DBCB301CD5553474D80CADA4F60190983B4FAA4A1B2404870D91D9D975D80446C7CB7330833B670F60537B47F84CC484943315C5CE709D725563360AA14D7454CC738F3CEF8929E109F162D5CDD6F5DD66ED9D05763D7732E8D1873A263DEE2F70AF4CD425735D36432B73984C3DD34FB94CFB9DACED99D85175DAD299E7C37371691DA9B05DEC4739602F2E87733C9D345364738CD4F98EA0589F3C0CAFAED6C735681537012193595373A99EA84C8CDD4696F870A221CEB7273D55760738399D270734504935C2F1358ED67CB2CCDF74BEED0DF2F136E8B47881AEF03296E2EF5C2806886D609343465B64BABABE93D744FF0C8787161157725144B56553B89CEDE1A71457003FCA2C6F770FA5CE88608981AC74DF454ABAA9017CD67BAA3DA55C66E8AB9BB39EB6E3AEE0DF32ABF10CF4AA644318617594B1BBF6A3578FED55ED07F6A9618B2E72435222F9C1C653D5AAC109DADD429B4CC232229D55083E5B1ECC4786D22A5A5D74224B1744D851187B43C5B6DC0E71A30B7BD7FE93446254CFEB7597FB67C4CDFF68A26B7E0E1B9AE06E45C27B9B083DE69326C8E12C6790B2FF788BFB94DDF1117F72D67B8F0A9572BC47DD5493A2E50D634B5506B62B8342C1DA791E2B521B00EB55DFB08773164EEF40973A4D6A46867D5534DD5744FF568C2C91D1867AD92BA6719E1A860C4F3C805DDC06CBA95AA58C1C8043B58869CA8BC6EE575524EC4169208E21483DD29CEEAE50C2E2256AAC275C7EAE0876705E7CCC96B97433D429C17878E9A70C2C2F8BCB92C42216746D14F431EDBB4A079EDCE7099098F03178871D01862B830096106436153B46B98E342BBF693127F4AC508CF9F4C80F544A1337374E737929F4D3328F79888E002EEA0FEE288C787FA429B8927AED6DA38E771872D6184CC238B03CF322CA512338855C90B150621C27BC3A24A42C06F07B27B993E4BB3F88991C1DFF958E119B51D00AC3D561E0BAA9B8803AA97C3B310E6E44BA2103ED6D06E13392AAEABB31141C2C86673CB554D91CE5CEF08BE999B232BEEE43645A79AC50CFA1BA34AA90D326F78FE41778ED5FB45B73BE533D9B4B3EBA93CF282BA6C8E78B3FB7480A5BC62612D7730B0FC54DC381011EF9A2579D11EF317F48583E18601F71BEF35B2B6C24D049E413637C58D5FF967FEE83583C2D00A94E72767AE9AE639E206D491F8F8870C4DC985D1035C7C5D10C6F7BEB5E080850DAD971E3A23DFC5C53A5E2C55CB2589CA5A2F9CEC0470EF986A3F17C50E1B8B79E59E831E38C2F224D6F219635EEA29E13CC0055520A99CE713580D3883C93A1BC49CD55D131F8806C269712BE6B7B4E5C02C0D60B55DC4A0D60934582ED4335A52E816BC1672A0929C08B2E8E5AD0491FA6BA1AD7C4C12D61D7347339EB495BEAD321A6EA47453399EC004C8EC130D1272A64AFE1A21B6D771E411105B29DEB7D34CB88CD8FF00B9A8E26BA4D3478583E29D89A64311FA56282F0E1A5EE26521353509A6F299C95AE8A6E40A91B2FF00A6EF095457AE8AAE9BA86426E2256AB7B41CDAB0451276E8D84CBBBF84190C000699672C8826D3C139FF000EDC50AF2176AC70FC883C516B861883F9D1106200BB9F150D8DE2761D3711A0C37FBF2461BFFF00DD1D34927746BFEB89AC74375B0B9B64E86F1270DC835A264A2F79EF5C247A6596C0B9BAB1A543CFCD566C88D3EC8438948C07BA870BED188A9F269D857711A6948ADF09441B8C97D16AA3B7A26458E673AE15216D3CA28B39163C488DC4C475A1D479E8967EA865ED618EF59FC841EC385ED5DA3A9D1173ECFAB46F232466D641C508AD18D844CCBE9F3CBAD5DC0FC4BDB4146E4A68D6A3C59C8B6234F9F03B8339BF58A9701925354C9D7376DF0F0F5FEB971D0C6B3C205378ADB2BA381DDBAFE6A333949121B81FCDA8B9A3B467E9BAD6046E0190DA5CE3C0283DBC26F6ADA933E3B02D789B4F028BBE14CC7D8561782D775DB37CB8A2A66C34753A2B6D9F6B0D9282EE5CD76604E236C784907C433762227B81DA45F74D8AD13970E684465398E5A24F86D3E8BBB9C37745DD3DAFF3A2F95FCAD682FF006546B8FA2AEC3560C43FDA8636886DE6E52842BC5C6E767DF436B94FE1A24BF4BD4DF04CB98AEC355A4F90536C274BAD177CF6B474AA12C4E7379940EE2E86F136B848A258EED185C142F8487AD15C43A21DC0ED083629CD6893382ECE210211ADB8E7B29986D27C948C364BC94FB11EABE443F65F21AA5FE9E1FB2A7C3C3F65A90983D371D782CF3024BC2F1FDC8E189117CE7FB2AC67FB2D6C4FF32A9019ECA4D000E9A4A1A6EA8A6EDB764EB6297A6E4730CAD78BB744263DCD63E5865BAE16DF9AD633086CE5B1C22DA403654D326ABEC9B1A14DBDA0A9421461DE1FA86E273532C8D4288F84CEEAEA62E1309B903742E0260A9613BA0F2CB5B298D0574D900EA16D5A8570BC59C110FF0098CBF5DC0E61989265D50C756CEB24D02C06EA5B3A8DA4B3EAD938137B0CDE7A28A5B318258D954D7B6D3A8E69AF6784EDCE61989755C681BCD43863EA3BA9633D4E807729CA9640A9B3303B6706F85DAC13A038FEA6EDCE66F965E711DE158A23B13B995DB45F98E141C86E85CAB6B95AA2881081DCA4A44EAAE9929B7760F137594388672699D14C6D8E6193FEA1B046244355FEA238A4F507FDF7568689D501C78AD65223572532D76589B21A035F50B56A15740276F2E0A243FB5D250483F48196AE6FBAF1B7DD51C1789BEEA846CDA499053C625A1D10D65608C489729B1E29EEC1F0CAEA42DF85C95744A74EAA62AA72AEE2F24481B22DF55E277BA96374BCD4B13BDF7490F08419F4DDC5063049A2C3F0ED4B68A1210DC594FA161E042B2B2B69BABE6B2B2B2B2B2B2B2B2B23F71A041ADB9A20D00633E33CCFE212442772DC613E466E129A872E34DD666CB11F40BB68835196F3FC22DB2779AF3DC6056B5A264C4F74D735E4835A7C7FE132136EE4D6431268B7E2450DC609E388A64B9EE8FC5A22C578A8D51F854F604E81E5B8C360F13055325BA44AEADA5D11310F86A18B0B0487E172CE7437CB717F681A1CDD5D55E9BA438AC1333389426349133523F1376E4E7721344CE73AD538CB8DF7373F9040B9E4C9438A18D0F74E67D7F137681B80C3679C2743773EF7C25177C23CB9A257E698C1F4897E1A333868079EE021B1E64D1AC384D344A7CD068B0D95265094DD3E484838AAB4AF09540E5461210C20B91C7AA9B2120132161D59EB391C2D797705DD87C43ECA1884D98FA89E09C1ACC4C167735DE31E0F4AA939AF637EE29C21C2D5E049430C3793FE10C108CF8CF82D586E23D91EE29E687723F7225EC38B8342698AE945955A1A50942D7E2269A3B32D87C49AAA42763E5C112C0F73B94A4BE41FDCBE47FF0025DEC123FA4AAC132F3430C2D4E24A1283FCA25D0BBC9D0029FDAB24E96A86F14250D839AC30E5129398B2D76779D2CA65AFBCBFFB51486998F003F527768C68007B944BE1EB52838AD686F03DD6A32238FB2D681ECE4DC308977113B26E1844922B5B23DAC1FDA552089CF9AAC13E850EE0E1F3AA9436BA20E764FED860E5C50C50C8A19A939AE0CE051C2D885776D2FA7926C9A7F50E4B55AE721AB13D90181F2E253A435381E69A21B1CEA71A26F75E755AB8DFE8B560D3A95AF0A43A15DF3700E1C54F13A7CB0AD76381E4100C8721CDC537034BDC44F94912D0E2FE5292A401FB96BC290973471437B7F95DDC0FDC500D6616CAAE7224DCD51387139785CBE58979A32131CD0329BF921AA7AA34723AA7A75556566BC2E424C2A7807A95E11EEBC23DD5708F55669F5546B4FAAA343BC8A3E1F7BAAE06FAA389CC0B5B0B578D92E6A85A42332D68EBC551CC3EAA861FBAAB98159BEEA789B8B9232C27ACD7D1EEA8584F29AFA3DD6A163879A3273536ADAFF0A8F62A3D8AAF6494F1B47985AAE6BBA2F00F752D59739AFA3DD5700F55667EE5E01EEBC23DD59A7FB9370E174FF84EA34CBADD4E6DC5F6A96103D5530BBA047C225D6EACDFDCBE9F7530D07D559A7C8A1E13EAACDF75669F547BB9CBAA9F67FCAF972F3A2AB25E68EA0F75F2E7E457CBFE54FB32BE515E0F59A2705B84EEBE5397807BAF946F25F2FF0095F29CA5D93FD901D8BEB544764E5484479D17CA52ECC9E345F29CA5D8BFD94FB227C907982FC3E4BE53BD57C9721DCBFD95613FD96110DD3F25F25FECBE4BD4BB272D686E1E8A7D93FD9561BFD97C97FB2F92F52EC9F3F252C266BC0558AA294959515959595B45B459595959595959595B459595959595B459595B4595959595959595959595959595959595959595959595959595B45959595959595B25959595B4D95B2DB25BFF00442FFF00B1F3FFC4002C1001000202010303040105010101000000010011213141205161103071408191A1B150C1D1E1F060F1A0FFDA0008010100013F21F46D0E27EC75773FF953D20B3F3D56AE03FF002BE29A75F7EAECB15BFF00CB0C871D431F8FFCB05D95D55CD03583BFFE5445297AEA4D02B5FF0096190EAA315DE3E3FF002C6BBEAAEEE6B1FF0095D74F43474E426528FF00CB06CF9EAABF13FF002BA41BEA3786F7FF0096069B9A1D37C3E7FAF87DC6E08B4166C2AD98D26F6E52C1F05A5FD8ED15826A512ABD8101BA00E7CBCFD01C1F435D201DB47CF50A8A02B0B5F2611A372EB02FB44055BB3A4370072083F1DE28C1A5DA00B4278FEA0A8D3BA16C163FC5100B9C250456CAE55DC0EC7F2B1927DFB3E2E523AA6D2DE6105E055CF3CFDA3B80C97CE3E83F07A1AE9ECEFF00B79EAE42B562FC7796B6A6997EA34AD75B13FCA640A5B14B76F11633E4CD7CD6A5E2C629A652622B81A8851FB33F99B32C0A727E7FA5AD6F0106D7B95C5ED4703F922C7DE5849C5A0170DB3F26B7C2E3603D0ECFC4A340E0E866FA5EC5ED2E838CB5BF6976DCF4B1DE01D540DABDEFE5F4B5677D3A15DB5D3C2BFC4C4021A57A1504C84E42DFA976FC42DFDB89A1EA5AA03ED72C1931AFBCC33580DBC3E629F6E6098A3BED9BF7379FE8D46C1FFD3B408FB171F980A8055D04E7F30117F12F36FE43F112D78BAA348CB897E407A19B6786A2BED13E0094F7ADC8038F2B800000341EF2D7BCFDE9CF4FC033D2431BA32D5B3070260DAB6543CEFAAA3D135D14DF78D1C1990FEF03B68061515AAECEA5B529AB6E2DF96DFF0002192CC9FD09F10FF2F80E65FAA725AFBF10202EA032ACA3DC12FF00DC8177252FF298C5F0235868704A082C09B72F7E3AF828F068C230E25CFC4358F7D1B8ACBD2D2AE7A74FBA0DBB329CEADF05DBC7EEA265941BF610DDF306BAF530C5A78BDEB0D721ECC29F9597DA5EB786AFC3BFF40A90E2E1F3E65CBFE83E080FB605077956DA0A73FCBC7DA7DB94E27215EDE872C8CF31ED95EA789966C1953594564A2086BE47A1ADB2153035AF79E24E61A4E90C2D9474ED83BAAB7820B90A272456CEFF00B12DA727B2C453822B1CF64BAACF9218E76B2566279534B50F88B3AFEE5FD63731FEFE25547097727FB4AB8D97B20A402DD98FBB1F361F625E190050F97D1882D6630F27A3006FA2CA7696E3C191A46A9A94955D9B5F7F78E0F69B4CC3D3A25E31D356B0DADF44F538EE4A961AF6452F09EB533C1E218FBA41E673E6106B36CBE441CA3CAFA94B8035797623F62EA8343B115D9B5C8F82075E637F3DD82110ECCC7322F7CB35AF405682D9B4DF70F5A6AC676F450D544B2282AF779973F6F89895A13EF6BF4CCF4BADBF0E9E378A13BB1FF67A22FB20EDD3BE9D07F671BE0FC6908FCE5A868768BFF03CFD3893662DA1F10D92741B5862A6F6E5FF009C47682E0AC1D8466576F043EF777A82A894EACFF5D0EA2F8BA75FA7FC5A2A9AA10BBA067939F7961F3E9FADD246FEFD2E651DB3829962D542AEF9F4377ECF0701349B6BA5E2DEC1708C082DFF000FF117A3AC4D8C006AC0E07E7B7B26B52EEBFC21E815EF1AEF32AE76A61CC671591D29A9B1F12D2D68C31FED8CDD9EC6BFCC229A7BDAE0B4388E5F738842AA5D1D9E94F71BA5D7FCCAFBB8183CAC36959BFF00010D0BF16DCC3079798243474633CB5F12BA3107535FA55CEEE7880295190FCBDE387A3A5AE9BB79EAD959BE5BDE615F65CC028B6BD75963D928A84FCF5350D8F1F296503925405A598814F513D0A215AC329E51A3F11596328C9E480981A1AD5768AD0365B30823342D66821C00C50DAFA2DAFDF53482DAC8C4AEB477652308F6CC68759A8E70A0BE6A89FB4773D341BBED108A61B2294D24A4892FC256460D704C1CB15762CB79FCB2D2EE6CE04A5369A3A6CD186881D17EC556DEAD7E860A33787F69517E6B1C9EF5EAF4344F1D3FA6EA0180A726FE5304FCB6AA299E8D477EC2A232E8EBACCD58EF9DFF00EA91343BB6958CC29FDF69603C7654AD507C9F8270AEED3FCC041F78C6334EEC7E096BA8C19AF33063E1A847EE9820DFE182E89EF2FB61F30DE7707720F30E6F90A9B27335B80857CA8FD88A99C232BED57A9622DC23594332B372A5E98D5B5CB000283A1163A8AFAD8987795026277BC40503A5E706BDE6BF4E474815566FE7A8C4FF0001829937C457B543FAF5758F619ECB7D67755AE09CDB280091725FC08A13F262A6A20CAA6A2855E5932B2E9456ABCF405B46E7857A15A3B105302C52D4F0C0A947952A6411ACBDFA50363068E5B61EE037300B8978E1F33FE3ED1E1CE7E0E7DEFE786CBD463D8E917F3F559C073E962AB62F6BE8A8A8BBE92FD022DD9DF5DA5386A0E73A8EE730513C1D09FB3A5ED0F8E8BB788A4AEDF5C661DE0D7D5C1D9FEA5742A158F27B07F244BA512517189B4DAB1A59560D0FA01DF48437E7AB71DA501B5439919B9BC6BA51BB10D7AB159E7ADABDAA3EB8030FE7A6D1E38E8AA1F77C428A35D14770FAE338E609468EACB303A7107B3AA0A5A7FC48DBD256239D04F1FF00DFA0CD74C25740E33D6E227809E27039792B78832E906BD5FA1EC2D07CBD42A8DC001C742A4E0DC7D7707BAB7D26C359BDFA5FADBE20526F97A98F6304074EA3B7ECE99C8A971C0FA77DDFC1EF77FD1F1574810757D754D727DCF4C01E636F8BFB7A05EBD55AC942BE9A4AA9BA7AEDFECF5B6CD1AE9619DEFA2D701AEACE14F88970B2BCC212D9E7AC695BD1D58CE5F6AEBF680CAC523867F1E8462B741DAFDE5A777D3571D34672D435D4E4A750D37D0C73C904A815A57CA61B0F922A61A4C4C53E828BD4CF66D7AFF83D1283072CAA1A3A7BDA38F4474D7F2878F791836C301A3A9DAF1ED6CC40465EC734FF00705B51404CE3836AAF797A793DBA7E4AF600EE595BFC7A2AAEE51158E1F4C6BC4E0EE53683D7CC0465E473D58B213C2BB81419F3D7555B99A437BFA0C687821D2CB452784213BA3E162CE0A3AD0002ECBE744C4BBBB65E9CBDEFE6F4C7A4E4B77C7B0902D17B0181788E9B553579E27C47F975A52DFD784431CB04B410F62ED8AB3D46509524EE0933CEE009BB19F1AFDFBFFCFE8C4D5FBA14054C0E8126610B47443CC02800A157375AF603A30BD15AFD6D8ADED08B3A7ACD91C5A1B3E08EB84F53884A6FBD0031EF8BC7D3574DBBAB3D87C66B0B97F31B9FD850F15092ACC6DB43D8CC1451EC5CECC71F5BFB5ED06C5C5B846D84AAE8362E60C1F9839F4B88FE41CFBFBFAE300E47B16428C0BB39E226AB816F8037984C034141ED5FD2683DEA8A74F300E4F799145C501573F3EED09EEFBB66074A5C27495C719A8DCE2E6AE8331E97E9545763DB0574CC622B07ABE40F83CC08C9C72DCD5513549BFCC347B580E057BA23CDC40F5BBB55CC61AF715FBA30720F40B828CBF175FDE2581A7FBB8EBD706C7A286E0E19B3C8074D6F7E9DFE94139BAD108AD42DF09C60AB18FC31CAAD1A6B9A8F6B48ADF77DB32D128FD643A71CD3894869F6B6D4A7383DE4BDCC33435FB7A39694379310128941C570FCCC75F4D9CE8AEF2D3088DA31FF00BD0500E3A6D6F4BE4E9C53935EC1AA9BBC2D747CCB914635A2F9F6AB96EAB8F6F5543BB32467ACC6AD477678A1F6722EB287D112F5DB6E27F30E021C1466FBF2BB73D06DAA854820D5D2AC515A08FF00B90006075723D32FBBA4599BA75F74C2AEAE1AC9138C5DFF00AA1ED6FBD46AF1AF611505B0E9B7B40F68ED7BBC4AAF637DB65FA249ADCCEF4AABB7E59AD94B9B028A3D43C9DA2A2B983500F98965FBA50A5D0C4A539E7AF74653174BA4C61E7ADC93B22040AC79BBBC7E3DB143C471BEB77060E4DB6FB9529B61DB98154F567A610FA2D5103B57CD4A6C05ED98FC8EF576F8E8ECCEE9BE2E2FB222CFA68F662B19B7A459D5E75D4298B85EDDD8151B6F3C061EDE90A900EEF3D58A18035EFD0B56202312B7E99ED2EC28FCC300507D13161A85056897FE76A4FF00BCCB1E3F31D644019CFC7B0ABD21D3060D3D56ECA02C545E2D3FB010F730D15844D9EB4D4A9C55FA220EC82F695B328680D6BE9195854C9DE91965B763BEBE876FA6BCF54C0035D1478D0DE3CBE27F3319D0099D4F8665E25EB45CBF625FB227344A1B88B4B3C689EC4F0A58C60E3BAD8E4A2BFB438B35C4AFE96ED937B0E0FE6103745EC3C7D1EFE5E923634BDFAAEE3A39F810291F85F9182EF50F22E0F8FF007510D57CC39A5BFF0088ABDE2507197AF317565BED29D99E7116AC3D8C194C1BA6128393CCDFA0AAB88136316DCF1466C3131EE1EAF4203ECFE82F5E65F86EE44DDBF97F6412DB7CB1E388DBD12EE1E1A9A3258AB5AED9CFE22DFC5C182B1DA862738257F57CC7AF6B7545FC4A90EE10CA3E55A41AFE717ECD9D661C9EDFEA65C8A46F573223DAFA019F5872B57E94BF05E0A3D963500DB08CE8FF000420B8B2A7F02D99513B897960916D2952144175BFEE604D975DED19A0BBCC8E18F296B8ED3B9F926861ED69C5E776189A82835980E1957930C75E8A031AE4D5A6151E2B1E69955F973FE50FA8E8960B028B558C0D83F0FA5BDE07CA649471280A229F4A5F46EFBF68382E0E89A175E94EF05D3368A8D7B9E2678E0076FDA3D5B7615F763F07E5AC66D83FFAD9934ECC1F898AB8F935DA0E08342DD7454AE8CB9984A480A48A01D0F7F9818800EF3B8F25B82951DAF10ABDB2D73F98D51F9ABFCA59BB5AEFD91A8645CB8A12DA2DDCEF3539D0B48944DAE57BFA519544BD4AE11A5D9CFD0A6B5EDD374C2DB20FC2E9399C7DBD03050D603C1155B77E95E25A5F9F41360A5BCCF94BF8979794F595454D5E183BDA98145711CD7181595EA20D31C7E205B95528BDDFEE8F455308AE0BCAE73189B46032506D9F2EC2CFC4ACDD59757E251587C099EF13F7695FA54BCBC27CE525253D42D8A82ABA5E2592E8946C870BF4AC329F414D5EBB477CBB43103427543F48F9D72975CC4AB4AF75E80D7B47FB5CCFD7BFB7AD54B69F12AED663783D7583F6803DDA944A768CDBB4AFB7A2EB8295D4CCB770169BB7BA04BBB5749FCCFD6F4F2A19B826BF0B82D5652B1282656D8E0036AA0884E5DF07E08ECB6928979B66D85A520095ED22AD56A59677E3D49A188EDF8C6506BD2913129CF5D7601773D8E93600DFB85E3E7A747A2FC3A36C8ECE7E8D2E3DB12BD330CC532AF88589952E29F696C73F2412D04A3B17E971F36E0F966A45ECD4F4460257BFA450E79C8B20C2377E8C1A983A38F537C209CAE44A7FD3A687EC47C2A0475ECAAF8BD2F6ED7D356A596F4330882808AF68FA5733B3E86C2392985B48ADB1F3052FC39D8FB3298261795B8F52A67F81DA5B05B007D3220C811EAA05F46DD01D8DA02D60A3370917FE712E807B63C01F1322690A5D1D3FC9E838480B3D3680864B3A4DFC5D69F78409A65415706C8C5B87E9EC895D22E057D5AAF4BC102D7C45F3562AEBC7CB34DCB770ED8FE6716E34FE52A2AD06643ABDF7F6F4E27DF11861D4628C8CD23316D2DB330523D3FADE9BFE7A4C24CFEB33DEB71C90B96DA6307244A51FA718E9D7E981745C5C158C31715CD4AECFA508DB6EAEBD2C96C86FB8F9E9DD003CCABF33C4F07CF411E7B4573ED97D0AAC4AE1961F3B7C476A68572F57E97A6CEF7D35C8A2E217B3F2D2C64233AF37DA1349A79FEA008D6AB06258AD94AA7C96F30E34E147C9980F4B41A2513809383C1C3399559583F1116B5D9B3F241EEE557FE19D854365A4E58E8EAB0002946CA31327A65F7F502839DEFD362D714E5430CDEF7959521D75EC2BD1E679E93406DC4C997455C0AC42AE0EF1960C33E61DE357B8AC7D295F4AB1FA3B74248D1F98A5F5558FCE654E2BA2BA51F93E4E6268F1163C37C416A40369E7BF13B9E3AE1ECFA90A07B3F116CADB96290474934B9F504E619CE3C52D5E9E8F78FBFB06D5EBD2B7EF7D2AC3DA011A4B8C86D148C6D596BFEC4DCB177090DAB9F4FEF28A2C6FE8DC1E8A4155E3F3379068FF00045B562EAEFD15306CFA1DD6DBECE59D91E46FCFADB675CC454129E76F490FDF53FE8348EF3971E187695B0A5978B76F457D28055B1A9B701E3472C7A9070EA5E9F64B06D03D8D9F1E873F9EAE3EABD28B29D52EDDE13F9323C0EF1558D43C286D989D0BF7827267CC7D0DF31DFD02D45B7D106A8780383D2CA77EF57BE1974234FA5D6A2B3DF6F0BA0EEC5B169864CF88A732DEF28CDEA19609033EB67AB0A207B13FE3994B3F792836C63DBCC95FB8FB83FEA3D0BD8F608305418F61D3E836EEF55706ABD75FEC1FC312A51A93B43799F1197C4B4ABCDC2163BA3EC99F7688B679BD40A016B8025D7630EBC66000003007A9E4AC4F076622B5647D7BBEF592A2046B7308B6EBD415E80C7106C86D93C23B6777D2A16C347E28E79186A3E1CC00B82888AD39E0F7FA1D9F1D60D375739A5635D03D56E3702F7285F01E8EF1E829A83542C976E65FB4922B1F4661CA9B7962C324D01F98D98CC6D4C88D8D0C345B5235F3E21921C57F03EA30EF807DBCD3FC96BF51562B5689C677E9C17B4105E9E96D61E7B03373D4625C3745A77AEF0CA6687995AD5CA7D0BA7D367CF4D69DCCC3457458C932ECA5AE5A4838E66693F15FCC3810E7FB113A43B25755A5A5E7C25E5E5BBCB7D5FC0519165849EA6D146A574544257102E929857BEEB73F662708D82BA041509ACACAC67E114CCC328379C4AE3BAAE94EA25A2B33FEA87D318760F46DD8A60F472CED6FADB933306AAF81CF1C1330401CB114A6D181F41FADE9B7E7A4583BB0C00745602D0E55CCDAC01B552785959B76F45627CC3FA709567E266BC641A19D7209675C36CDEE33B288A823D93ACCB88659DE146045B4CFE26FF7ED8022D4D299230FE54FDC56C9DE17EBD8FE66C87AD98BFF0024B9F65E682B6CB5C0BF119A2948E4A750C6B1E88A38307A50DF39E8547388756350045E6110293758E72CAAB463E783E83F5BD367CF4EACD67715846FCF7E8231614CB9100E57C4BBBA7C8F6660882647A5077017449E6CA3696DEEDACADD7C253F136531D56FCDC0A8A66E773BDA5462F547D83D93DCE5B6C3F24BAFC270A803CA31E0FC5948B3F021B8377A7F886D7DEDA551AE057ABB59CBCC34BB1E8C0DE6B130C65E661BB118C5C71D59038EB753890381B05E60473EFEC9CCFB0E91AC932BBB74B0B57CFC7A0EB592AE4C1F9867E91199865711A305BEF1DB6AFDA361DE232EA74D429072D10800D04B84C37EB4D1A055C20559DFD52ECBE63F8B1D9F4E62C9D4C723183CA717BD54DECA4C03CEBE81DC78ECE90B42102687493089B18812B56B821AB21181B497ED286DFA3BECE54C706695353007B7458E7AB6D618E1480641AE0F4A3AB3DB0479232B87BCA8B1A67D561EB7CDB4877A97E6CB347E2280A949EED3EFBB7ADFD63A995442EDC799CA3E5C979A81AA90F4192C3E859651FB91D7775A01AF97785D86F93A986B957A2954FC77679E397DB713489BE4AD47E1C5E2448EC6CF75D4F8EA0C256E79BAE7A8803FEA9DA6FC475C1CC140346203E2286A6997399F0845201E6286E53BCA77967B0E5557FF0008809B25F177A6CF68EE62B6DEB10C55A47336779CF91DE31D3748CF30E7DDD84B5185F3BFDC22A0EE7ECF7764F89FB5D5C96F0E9C1CA1871F2C56E4DC12B3FEC5E7D6A7623D8F64A8CE7A858DE8F98965F3B656D045C601A3897462CB875E6267BD7ED2DDA52F1050EF63A1C79ED2CEC35DA65D677789B59B69F4D7A040D960A05B7AA559D0A8953D44C5B07C86E1DA1602A84496258FBAED9B0EA6AD294E8DF042779A7C701D8819A8C9D3E5DFAEA25C44F947CA7CA7CE525FA2901E8683E08759DCBCC314BAD45DF1B7DA1E8FA4B99EF2DDE0A732D0A76947694EDD48ACCB588E6F97D1A9FA7246DB208A827CCA718DC28A83ADD2FA2A8EF4D3A02645A292711883E388493633C8574286D21D62810BC1F084E5FDE64ACD1B41F0CF9A699C2F4036F9834F3CF2C1392286D20E2A0CAC4829737044B1B26501859B62697DAD1E0801BF837FB406203007BCE6763D06A77201F4A95E9530441A8A77E82496968B3894F66098C8153113C49F04656F7F4245A62DD8E9F4A5A338D31C2E700F2F66EA4170709566601D14F123E67796D328DA03A90FC60800AA38B453796D9CF40A6A11F67C7A5AA85AED732D7F7583DB0E01A200A3D071F437988FAD6EF3CD2D2D2DDFD4504F6285E7D81654613A0E5F4FD5630F22D30FCFB3564E27128EAB870ADBBE63BB2EC621FF00D916387C40BBBE666E67CD3CC9E44F2B1EE30E5B662D7EE789FCFA4F17D600384CBA40343F13C59E24AF8EC8EBCCC863D094D84519FF0047D1A4B35E87825BB4B76968283827B556F93DA6E8A16F0C755BA96BF8BDAD1D62AB02B631C54650BB7ED3BAF3DBDCBAF609D2816B1695155D8231BBCBE7FD61FD1F18C9F69D8BB8A87BAFDAEF33D75F39FC538B97E71F4942358B0172ABDDA28E44ABBD1CC1A83A1FD200AB829D7B0DD6372F9B2DC359F8BFA12C2BC43B5567FB4E4F74D7D25B5DC38F8E236C4A52A04D5E5FEDFD29DF6390AA8DCDEE3B7F0F695315DBA34C7A6E18FE50AEC9CFD2530ADF783FEA7EEF6FF7F10A8CF83D85A859C90F6C4D3E96C08DD7103BAA7D104F03DB567A566E85F6B1A8143C0AE1F4684FA01A267069D81986BD84B2084D7B4B1516FD46F5F462A7C745EAFD1413F4E72733862B1EDBE3B74E04BBA9F0410D5996128C7AD3CBE8F010E6AEF1BB1A763ED164DA81E50F51F2F5BF32F3B900630DFB4398E93D3CDE82C3D436817DE014C0ACF4C84DD0CA4DF3F47D3F40F6D69C74859BFB06BD1ACDE6DCFD1B219A2BBC384C1F2712A0A8302BD419495E222A5FBC44DFA24C5C3DADB5E8E90099894D4A186BA0B30FBC7387A689BA1B3D188DA474357CCF0C2FDB5507438AD2B5FC132FCDD83B7303B403DAAC53AD8469542EB8412C49AAD47A40FCC2FC967729065F3AA85605777B8CE9DBD5788803DE723089CC1A777090157ABBEF1079B881007CDCD1917AA5F6CC3075FF0055DE3176606A9CE18D19766B4098853DCFD1368F5C87CD4BA365A287C2055AF450158B95795F33703B09336AEB394A0E683DF9BD54636C8AA5F625E56CBC00E331B8D6D58FB1C4A4517CDA81F300890A743F7F1311F77080ACE7FF003B45F60736678226A3E7BB142C7239FC129B0EE459668C627758ECE5C85BCBC447CD0DB7155AE06FC3E665074C5B0E7F10AD56F40CD56214011286579ED1A89940BBE2222941027DCFC46D29FB2BF49F7C302079FF00E3C41229BB287DD182DE0C2DDBCF1350BDB0FF0031E79E8AC12896719868879ACB0823270BED9FE6501D7351B78F998E1D946E9E0FBC46BC8516D72A4E4938B02E29D72AF97310F51D9B529B7B9AC63FCCC036EF0C7EF330A2B081886BF45F721DCA652A546AE9C27293B14FE67FB098E6FA3191B8E4C9052FEE60EF59CD72F1F293F7098BB9BD5F625598170F0F9834F052A1FBC69346F9FF0048EA2E559657B108C38BE2CF698563DFFD33607C8BA6B822E54968E1698BBA02666A34E331A9500A9C8C69732DC559E3EF1C6DEB876266E318F333EA064F2ED0DB7801E3BCC6FF006E56B77917530B1E062EC8BDA1BC0E77ACAEA5FDF5845A15EF9C17EC24B464218B1C1021B3E4E6D16D00D66EE6768F96D8D10C0CE5B86671456A56E0D2BFB20E8077C27297E11D7A0EF7F699938EEE4799ECFF009822A4570DCAAADF2AD218BCB30540250AEB26B3E7A9C1FC4B1635AF312C16D9CE91CF8578BB80C83DB24A9014CB2D8CD4A4BF98AD4BB30B121A3E4C430FE2E6773439E71576945528AEF14983359335F2DC80371AC7ED05B136CD43C1C0065F08970AE59FCC63844CB84BCB7BD95FCCCE6ED2FF0054CCC48061FC437E8C8506DBE62603600D05775A4CE307793ACF089C52AE419CAFE2970DBBFCF0DBA2D651DEF015CC1D70F8983618D5D2099B48ECA5CA69C77B2A235D7C150B7829E4F812B9AAFBD11A6FF01825EB3B133872E6B8F4259966EA12C8870E3CC43320BC6A0D61417C8F9499F256CBA9FF00110B54D0BCD25C5E02148408B17FE13425CF08D05A7E2219658D17E37825AFFEB711A829AE4F13B8375A87A8D751D92ABB8ADDACC3B100BF8324407670179906A712E8D7DD2698B9CCB54169BCCC0D91C7D7BDC22C59A99FF9DC43BE1857F999AA3C1FBF49E287393CA98AE3CC94F299EAD118C3BC1794476542ADA795F89E747BE82356B9E7442AB3E221B506E53CB99A9183F39E64F23F13CB82B568234479D3CF896D449CA82F295F2982ED336DF89E74F3FF00110DA992ADF898AED10369E54F3A79F06E52B84DD2C4B1C337AD3C88F753355AE7952BDAFC4F225BB329ED29ECC18B154C3BCCD569A65143553B030EEA797F896ECC3806506994F682694A5E195C0653730EDF8889B188F24380651F4B5F4D5FD02BDBCF4574176DB8E9CF8EB6ECEDEA5D66AFC7B0DF10F5CFA05D35D0F8DFBA0DB76F652F94F8FF00F0E7FFDA000C03010002000300000010FC0FFF00FDF0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FD4FF00FAC20C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FECFFF00BCB0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FDBFF00F9CA0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FE557FFEA0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FF8FF00FAE30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C338E2080C30C30C3FF008DFF00FE30C287B2C00C31C32CB1C32CB0C30C30C30C30C31C70C0DAB3D30430C30C3FEE7FFE830FD78A11922B4C38CB4CF8D30C30C30C30C30C5964B6CE7C9CB2430C30C3FCB63FEC31FA9D4B2C70BFA11C34C30C30C30C30C30C3D1034F07C1DFC670830C30C3FF57BEBEA0EBBE8F3CF2D4FCF080C30C30C32C31CB357A8F3E6D7A73EFD78430C30C3FE55BFF830F175CD3CF3A17DF9C9093C759D0E32677871FEB4560B7BEA0E4030C30C3FD573F9AB0C2DFEBBCF3C17DF63B43FD202DB6F0FAB4EFF00EC3CBD4FBEA173C30C30C3FC477FAEB0C74FF37CF125BDF64DC57429CBDBD4F65FFF006613CDFEFBEF05FC30C30C3FF4BBF8AB0D7665FF0087FBF7DF761FFF00770F7F7D5ECF7D847F0777EFBEEC54C30C30C3FC85FF00AA30C3DE8975FF00A6FDF70F7DF784FF00F7FF00FDF7DB9CF13FBAFBEA37A830C30C3FEDFF00FAC30C3512CDEF2C815F7DF7DF7DF7DF7DF7DF4A03CF2CFF00CFBE10D0C30C30C3FF00C9FF008EB0C7BB0EFCF3CDB7F7DF7DF75D3BF7DF7DF6BF3CF3C79ED7E2DE0C33C30C3FD4B7FAAB0C7112B3CF3C5DDF7DF7DFEF70AEBDF7DF7DF3CF3CF3CE3AC490C636E203FCA337AAB0C3FF00EF3CF3CE3DF7DFB7F9CF38F37F7DEF6F3CF3CF3CB3D9F0DC992CA43FD49BFE830C76FCF3CF3C83DF7EECCF3CF3CF0E6B23F6F3CF3CF3CF38D095F65130C3FF00C3BFB830D88BC43CE34253B2F73CF3CF3CF2CFBF33CF3CF3CF3CF3CC694CB0C30C3FD6CBFF008E9271382292E407407CE10738D3090F82A1414678ECDF7E331490D38C30C3FE55BFEFDFBDB0C71CB38839A8C35E79615537071CF08328F32501B9F3268C72C30C3FF4CFFAB9C1CF3CF3CF3CB1C33A12607070CF1CF3CF3CF3C63CF18F38B8B0500C11C3FD25BFD0793CF3CF3CF3CF3CF2C22C22CF3CF3CF3CF3CF3CFF00DF18A6F12A05C90FD43FF25BFBDD434F3CF3CF3CF3CF3CB3CB14F3CF3CF3CF3CF0D347065434260311B790C3FDEDBFAE9EBC33CE3CF3CF3CF3893BC68F3CF3CF3CF38CE3CBCF3C5F6A690C35410C3FDE5BFBEAC3437CE34F3CF3CD243739F2F3CD3CF3CF374C6523054A3EBEB0C34C30C3FF00773FAFF0DDE83CF3A2800CEF7F0CB3C5B292433C0ED835FA45DCF2C86B0C30C30C3FC80FFDCF0F552662CBBFBEEFFCF0C13CF2C3F60E1D1B5411C3B1DD3C2220C30C30C3FDFF00FF00F830C129C434F3CF3CF3CF0BDBCF3CF2800403A675775302D3CF206430C30C3FFAEBFEE30C2BD630CF1CB38D3C9F18D4E3CC0012C329F21A7088253CD3C0480C30C3F3CDFBCE60402BCB2C73C3306302F5B40A3CF24B38604AB0DB8082BC8B3C96C2111C3134F71C4526CF3CF3CF3CA2473C800E24F2CF2C1348004144820821B4F3C333B423AEBDBFDFFF0010B4F34F3CF3CF3CF2C33CF3CF3CF3CA0000001C882082094F3C4EAFFF00FF00FF00FF00FF00FA7C59CF1CF34F3CF18D3CF3CD3CF3CF3CB200000148820820A7F3C54BFF00FF00FF00FF00FF00FF00A6AD3401C114F3CF2CC2053CE14F3CF3CF2820810C0820820BED38466FFF00FF00FB77EB3F43615E64947EF7FF00E257556594D97D59C749978C7A4D1C129D7E7FF2EB7FA6C705FCFC64067B310EB71CEB776EDF1DF93099EA1891DA4CAB5D275AA4E36E39E3041FFE3EAF2F7FF7595DFF00E7EEB7F7FEF7EFD3D9FF003FD7D7FF00FBF1B5956CFCFF004D36A5AFDFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BFFF00FF00F7FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EBFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FEBAFF007EBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFFF00F2FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC400231100020202020301010101010000000000000111311021203041516140507180C1FFDA0008010301013F102D9B05FCA77C28FE55858BBF96F370BF956CD82FE55B377F02491B852C4E7A2C2C5D98922448F09FCEDC08567A468640C8B4745858BB34CA57918AC4D05F8CD88543AD50865E4366978FA899CBA2C2C5D9491294AE2AF78DC227BDB815618EB48F6E640958F790C68424129407D40B9D8F18594C58625A07BC3E11385DC7EE27D8D8D6F29F61894281733B1FE4317978497C14E763C629963DA2492BE09C6D0A98DE1A926D84DAD3E06847D9F421EC48FC92344A4F9485DA10A730D63625CF8231465BA0F34CB229C72E622E12043E05E1412D887B30A631B48FA64012B7D08586E2CD42A58D30B5859A9A05CD8B177077B213910B0C7BC3C6B5D2124942CB204B0F2B59212CFF00EB675F05C798B9D858D939E0B23CC3D122D46A1C0CA4B837C1E165A12CCF86CD2F0924911238343494173B0AB14E0D4A26BFD1249023776372E47210432D96B6259684BA13169661B32C19274B5978290BA1D8AB0EB83E6426C21B3E0DD3C0989DC8689972F8689884A165A909092E8B0B0EB85767A89711C18C9221B916B2D8D6E1215039343727B22F06817043BE361629C1923AE3B4F5C90CB184E1A974C4D352B8A92F33DA4D1234CD886E30C75DAD9B3E0B9599B0B14E084A4997C6DC0DC6D8AD361ECB707BAAB84C1594BA20437B16AB0D6F82A36AA254DB0DCEDE6C2AC53878D7289BDB2825867A9CDADE1C1202A56F52A25890A3148C79E846A5C2D950786D50F32E4D420CDA134584B74B5962EDD6D3D2B0B141A2B3C48509098912CF2244323A6448973E244461291CA3D37D172987448FAA30D38A5824913D4D490CA42C24DE973D30D098EFB5A92190251F8768090A30F08299570B6492A090D7EB924461B81B6C50B0C7252185D83E834358A70530E8936BF53124B4355929D58DB617722219546AD21D70D5052E893C10BD76B09CF56C471F08836A8894F0DF3AE402C3A2C353D91F86244FA1924986B704D5A23841B112D74B14C3A1E2644B584AE523E24C24E32363671094A64172EB86449E92AC31DE19B6571925924660B5A1EB8492244E63486B93C0F630D3E0E697AE92ACBBCA0EFAA1B544B77D372B857B0310A41F0A827D1A618EDE190B11D0936842B75DAC6CCA9F4A2160A1671DB1230DA270EDE17B31EFD4D42781B376C84F4EA4E368D26C4284B83E103824524C5910C8208C40D1A257CFD0C5C1F0781B882082393691E0F7FA974947D531B371FBDE5642F4991CB7FC079F30909C7EC7D8FA1F6111A11B47CB07C0F91F03E049E0F8099E0F81F03E18263E58A7E8F91F0C1F03E44BD09DE0F91F217A8F91109D9F2243E07C05E841E45EC3ED83E842C9A23D8D7B257B21121C3211A3468D0E069221092346884421A4D6882B211088468D1A3442217B1AFA68D1088F4C85ECFF00442F643D9021608647E19C263EF9E75FF0B7FFC400251101000201040300030003010000000000010011211020314130516140507180B1D1F1FFDA0008010201013F1087EB8E3F5C7EB8FD711FD69FA3E0098EE09688B41F01B9EA8D388F544E9FC7A4E11D97138221A66484C43A22534EF37542EB46861927B9312FE082E08CE60C3054E5B9954C4862B54176F008ED594BDA7684D852A0B971153E653138DE666DE660B025ABAEE74A2286622C4770C32C7791DAB0C716942F65BC670F308F313238F23E7C2763044718C4C9948810D0B5D38A0877C8ED5910D3286A0EA825316830E828D9A0DD0446A71241E0BB67CE1E89F38C51D3320A63FB8C662DC72954DA50D4E74573DE476D443DE961B005D40B8D87529C1C1CA27A87A0D039501EE29C095EE0D308FA02F043B865D2A5C457A9CC588F7C8ED54DEA1159285E9C2F2C56B751DE8BAD0DBAD8EB659C6B66A58EC1CE9BDB791DD7D7D434EB86CB8C8BA955A9A22D116F63AB552EC6B5F0668D168B8E5BD82D9CE3B7BC8EF7CC9470C55D1028A82EE33A4D42A59A81CC65DFEFA75B5545677DD92A8AD5DE4771D0F1302882A90D4459CC6B0F9AA60528D8E971CEA7965A3E023B832C42577B0594B0DC554414CB1EC6E3636A5C165CAD04706A190726D23B8991CC1B7FB8DD58205433A674E4889876A2DDE2E5AE25152E7A6B59F039FF0093935FC4FE303523B95B750DA396C0BC113A901A15B04279D84A9BE5F0BA219A698F33E91D2155AF5FF914151F5DC01D1A91DA8A88468DD607A6ACD083EE6FF5D6295151038E0784F9C2BB41642D7DC4E9A80302F611DAF015B89DCE93156D406BC2268472C78C171F011D5151072C9955BC0A4B3C54D4BE935B494964B8B0983050F804751397E2B86E18BF25CBD310D0DB2882259B48E82D21C79461148FE0AA5EF7AB1C171D7C80164A5D5E7523A2A460927E784009C67368A5AD41DC4F3F7FB1DF21E988AD9753658B71F9412A5462AA09A3C456D858394C9B1FD880B6FF00DCE482D8475E250A793CC4AFC03EB3A195A63AF15C22936DD84763024C432BC41AA78095346826DEC2574F7E111E76E31EA568ADE456AC494EDA813B34037A0D87D2062F09E7772E9D6A54A952A56A934EDA254AD595344386086200B87B77D8EBC276988653E3436B0F0F08E88618C312BE76DC4CB1C3BC8ED4544A59F12D658FE094ABC55B6684E1E08256DA611D80AD128FD815E216540040F0F125C1788533E0E12F654AD4B972E5CB972C6D0D7E8784357972E5CBDCC88063F45C270788E3057E79AF08AC1E2507E8CE5CEDF8CF9CF9CF944912A2025252525252592C94949494949494964A4A4A4A4A4A404A4A4B2525929291652525259128A4E654F9CF9CF94F94F4131F13E5A5F189E8FC27C251D4F86DA90724F9697CB49F447A8D01F24F593E53E52FEA7C662E27CE7B887713E72DEB60C0EC8F943D53E13E53E53E50F46B52A5792B4A9538E34A952B756CA95B2A54A95026251FE0AFFFC4002C10010002020103030402020301010000000100112131415161711020813091A1B140C1D1F060E1F15080FFDA0008010100013F10F42738DCAA0B587B88BBA69D73FEFDE71E87FC4AE28CEF7C4A1E3236D73EE6E60DF9750D7FC535FC9FD4759464C8D7B9B455593BC76FCFE266B3BFF8A3E86F9DC201697B868F68363A682F30FF008A2D2BAB72E2D949AC7B4D76804DD89BFF008A00BB5C6A2081436D6E1A315DBDA4C615765E3FE2A335F3A81100DB54C307B68D545B786E3BFF008A643E3355A8C1741CE7882259AF6730A7601A0E674FF8A36AAA75E655E261E0F68BB95545D2CE7FE28F06DE66657586E6B1ED6826E9006D710FF8A2C4055EE05205AA7B82C2A08AE31B63871FF14E5E0BE2545051BCC4AC80D71ED633A9034F151DFF00F7785E08EB43B22385E4DCBC73C2ABF40B82B9659D98778717C4B0F58074A868E8ADF3DA05E2C096263E600E5CB445AC017378B915EA417D09BC9AFAECF187AC314CC83DBDACA36290BB51CFB6CACAAADA056BE06194D77FA15FF51AA15D020682379EA81199DAB4BF70D418BA2DB0EE2F273463C6628FB031E4DF1D1E677214ACFF00E8104EB511F836FC4082402504378673DD87AF5298B800C63598C7D5C9A7AAC08BE2890D16B6158AFC420B5014CFE0B0ACB0C5BA5285DBC5D94675006AF3B65EEC420F5039A67ED04B048EC5B074F3C75C90D43EB5B4BD997F24561EA7B4371797FE9DBDCFD185418F4361717A965880DE81A1B1718F05550562ECB175C8F79BFA3C05B977D1A724BF196ADF5C9F7446C348C589498ED7F7982480002B42829AEF3090DE8D7B0D1D2A1D32A33B6D59D1D6F52F03C258F5967B2BD6BD2BD6BD6BD2BF8D52A09546C2B412BAB8A526797467BCB26116A1E12B94E9AED34FC4471802B41D081930992BC621D59DB45D1A2F1D0EF3363906DEB529F9B21191801D1F681454A8E232C60D398181BB032BD4082F0BEE49C578EAFC7306DC4F582EF5D8E619A157516AEBB67EB156DF09CD1314AE19AF6DCA9D4757EC26DC5C52ED6FFC85EBC01AA69AFCCD3D1076110DD984A4EB0E8F961C337BF0D47ED5D8F03C7A35F68D277AF0AEC85C062AF3DB2D8B16CD31D9E63F432442B400355DA5D82BA3E1349F98EA296ABBBC1B7C41A0323A4D7A0FADFABE87ADFABFC6000C22A837599C375B80948C9AEDD8E7E63972A05ABD8E63651DE1D7436C7737031ED20A141E1DF37B9A3D6AA24F885582A172BFE22EA00B1D7621EBB4027B6BE69BAF1D634C925305FA20C62A8058A3AA8E7556B04A3002803007D623B8ADC361D41F986DED1BDABFDA7B51529450E43F155CD930A4D800096B79CE3BD4B8568DFA91F46DB985852586AC647BF9EB14B8A5E6666D0B626CF704BA5B7E39757001AECB3A7C70E25B10B11B2EEB8F8A967840D6478B76F38620984D2363EA47DCFF0020A4160DAFDD3B12BA9D3E0A0695D33DE033B00ADC1CAB02A903B5D894776895A2145EFBAF379835B69AB301BC53FB1E614526314A07676102A1E974C5CFA670496051A517FE3F504CE2C0E6B93ACF375988428472273F558A83BF5ED343565F598012CC5FB4DAC8110E4F6B186EB4A550DBD6BA7312375C088453465BAA1512B90752A09CCAF5AF4A950D02C148E9819C009D41C5E93C92DA6D4AC1D6C69FB44807B3A4F862C10396ADCE583C998D086AC86C66E354E9BE6A539B29378F4BF6DFF1AA2D0AA01BB978B5ACB4A72E578AED989E85A0703D8C1AE25BB1A504392EFC1960F4B59090A45F2B784BBDADBB4EABA3C4D2E67FE8C6D6DBB7AC086DD10D6043FE9F1006A54711CC3C9D08B3A7A11AE118ACEA058363CC06305C06CB32E8EBDA1A3FB20F31CD090D3C15835F55D4AF06D6FED0E1CCEBB847D97E05B0E47B4BEBEA4383EB60561911DB57DA25B442523D98ED32B9EF5B83771A0EA4BFA2612E103A4C3989014F0ECF89AF4558E2D5725CCEA8D9E0AB33C988619024AEF6B3F3105A6BD6C943A6E9AE75D6597F35FCB09B9CB95D06D7B12CFD0016629A30ABD3798BCAD40C0EEE8DC09A00471FBDE0C4AB2D613A0D62F83463A2444232C1A17CBBB565140BA0DB0894B482550300E5581E973AF2FC11CB7BBF465C6714DCB1ECB0FBD662BC6421CD53A8F4B1F4AABBEA0AABF8E3EAB1D2188542D42E2A6BA4E7DA86416BF47FDBF61185CFAB2A8478FB40B72A77388D953D3003318CEB598AC2557687BD228C7EE3CCB9719015D9DBEA3C3022C5A6079D0BB3F50C6943F0C331EADFF22F273E61D18108992FE37A73FC95DBB91A9174197883C9C17D31FDED9A456DB7ABA7AF770778198F6815D56FB8C4965A013E4C10F8161A393BAC285003A13F10D29300730AFAB9D1C1D21AF50A451A8E5BC7A84B9DCF3058411291D240C78B11B80E190E8AEF14612F45A9900E4CA3D31E3EB5A9A12F7008C5851555ED6608C0EA9CFB060130A5E6AFEF899ECDC2E76A69C707920A3E2025F0C3E85970345F22638F5C8D986670CEAE8FBDCFCDCD8B2D0DDAEBD6B64A8897D35C89FDEE386D66F6B7C1D5C3F50DFA2D4B97E847D8237DAD66C3DC8BE2558C08B6F40E71F60E9308DC0E65F234634737C41E37019D9074383B438C38E80E03ACDB47DD3F07A30C0AAB404C3AFD4E900F5549ED1D6E8E09AF630BBA306FCC4E2D4B3790047612BE25D641A34007EC0E97738FAA55E2DF9439A9F80F68115332BAF10D7B0210A1E161A6458D853C902AB5C29598BE5B5758BF4547A219215D7E827D9D92CCB8169FCCDFAD4D568503F781001805BDDABC7471010596A0731B2681DAEDE4F5319E2526FDF4DE99DBDC34ED4CCD788D017D0B77DA102B66C03B580CAC2DC2B48F018834E68276363714A31836C6F399707EA25DDED46AA535CA1603D4ACFE11E15161C9D515CF9C7782B0AE18AF1B3E50A50552A85886EAA221689F111418B1037E15F8DF483F3550039F2BE5B8D592B4AAB2B2E8C5F7885C16C4CEDD0FCCBE1CA6C4F39E213210AF47897D5769D9FD2FD07A5C374CA2E73ED17E7805108F46892C338094535567F98C5123536CAB93199C1F56E6CB4EEB10C371D3A59AF6A880B867BE27EFDB4004A79CD0B5F4CCE9AD10C09C054CF3508F6838036EF70475AF7B2C20D99E92A9E8B5682EBDB9350D7B54EBAE743DE2B722CA73BF0929822212CE5A7275AEF5075CDFE9767B7A5F20855F6E5F88C9D307CEA99FD45322B4A97791C358E7AEE0DFF440D2D406E8CE7ACBA60DF45BA97289761CAEFF00E594F9C6F4B3016F5BB68C758D024BD9031A876F3A81272E687ABDBC5BDA287B1CD3F05FE211526D06BE6A646AC0D5EA631F34C61382C9E596BBCA11EAA43B41CD73D3BC498A83993C93F5F7C8090998E5977866629A0B19FF00B26D68457F3BDEC7EA3612D0638304517497D1EEFF00886AA07A5CDBE4A436F5F8F439F461721D2334BF70B3EF0282A67B8022AE0D568251DA2854825E0EDD974798FD542C616D9D3308AC80CFB6B9B5FD939F57D2F7B84B20A5F7050762255CC561600DEF1CE2694F41A4639E216B0F7858A07794CE16EDA33F9F731B5049D2BCD3D20433A453E1EF3043E5ABF67C4D07FB96BD7380F863743740B6F638FD4A9A41B341F237D9A8C1416C2EA7943708A633415ADD1A96452D8E16C00ABEF4BF996EFB523AE57FB602552BC257E65286EEFD93741F17FB8C956569CCB8218E8CAFCCAD7AD8387E639A5E11B883C4D5697F49A9A54AABFCD41DE03084EE8105BEA2BD70A281F2CB57C8251C8060595F57A93B7959AB664E84E3D8411067A042E02A03D8E1E86D9B1A703DEECF462C020162510C878AF9CD6F5CAFD9EAEF0153C5AB75656F316CFA9C40AE000E73E852D5B5EC2A9B73E2572583B8E273EC752F030A814A33E32196219299F235F9971383B55761F50E3A173073EE5EF2D0A1931DBD257B4C3AB8EB20A3ABFE22AA0CADB71331F0C00BEB0B67C1E6230A5B0E2C635BB65485A8761617FB80563E4C469143D5600E318CC5BC5AB6F72E5CB8C6169A3CC1A8D43E799BF4D4131B08AE07982200E1070C52DC52B18E91F21148A1FCC3194E578266CA617C9D227B09056A0858F53ACC0063D59751E3738F79521BB8E8D171F319FB62EE20A2B0007765CD4AEC91202591FCA97E2E3F55D328D253BC67C40AABE1ED738A6F86BDC4CCA096A8CA63AD57CC1AE29E930C93CD8B14F357B9C7A0A366E1E61CE1DC28B35ECB89736E0CC969B5EB1F6DC6CA1EBA1EFF00EF485995B5A0D5C429305F2DCAB01B5A8AEAD01654A952A00025D9AF60AA2555BAF586BD4281862DE66E04B7CFAAB0142F05C7EBB40C54395E581ECBED3C5604D21015EA388017155ED6FE85C70966CC8B0528EB718C288655737F32806F170174F36A7C10FAAC2B56AFDA32C97C51457B59C40BC1AC8477EDA05348E1BD4D78DFB5B1FF005DAA2B2A5D628051C60BBF31DB78F425E65429628621B1CF7F5542C652A602F486FDDCA019BAAEF387A0A6BA54C88DFE78439F55AB5688A9A3A5383D28BC0D46B157ACC504E5B0E3942100180F65449B139A3D5C6F4728E095D3DAE61EC6201DE66F97820AC1C43D9411C3B3E8FE6CAD1686B5B13F24CA8622E555FDC61B4417151D1D5CF6086BEAA2DD6E758031B2AEE3EC416459E1E3BC375EDF1174038C499E305345EDF131FC97DBAE574EAEE2049802A1EA34E20356682E0FA3A5E6D5F699BF7876C6D77E0FEE3E824ED603AB332D4CBD5EBECD1C742FD805005AE88CC53257F5E0CFB35309E94C34799D632DCF104DBFD79817326FA8FBAB795A3B451EE8CB5B7AC3D58A057882C152F9E271F4009B1E82EB96052BB841B95828457400C77EAF89CE7EAD2CAACE3CFA5D50E18E7BCBF5A8AC856B6D621D4CDF3ED262CC6E541972F44B26EB163C42EB130017B3969D75E8F7A2D4704398C3B0626D89E82D19D4C7830350F7108AA1F2798FA3D7A2FCD868F63D1E4281ABF3DA5FAA09572797AFC43F1ED1A41636A9FBC5F7150D95EBE25BCB926EFDD7143366CEDCC3D8EA290E8FD2B1E22643FA25A14B5C2AD8652358B165AAD17D55B6FBFD6031742312E1018F3ECBC571178E5A5F30800D051ED201005148F3057A39A809C1D69FD914E214B1BB2F75BEB78710E2A1422588E4639BC7332A0AB3A454F8273530668F5C9F660FEE5975EEBDAEEA94254614603286887A600435EC2D02DC5ED0E6A0B23C34C33881D02E92A9FE20028006A07D5326D009A4F2BCCAF63144BD0471364A5141421EE0D985F312C0C072AA8F0EDD6A0972096ABD08619152C9455D7D6A11D508CBA987443D8285D26EBEF0F7A0550B692B2DDE68AEF0C2271999FBC1CBD2EB39D60A8C61417088C7415149C6B883D6DC52E30C0BA422D28B7A7587B55DE264ADB0719B69BC0578DCBA565B69B7DCB8EF0251D5A0A2E2384891192DEB3987D6AE92A9E1ABB9A7B74C43D705C2733747926D1688068E439B84E270047DACA51CD7996FB4AB9E167817E61B6232FA0FF2BA0E549C0302EBAD7D61BF6461EA317F987B0A14180B53BFA0BD0C9CEA26F4D196994D50DEBCC49E4B3DA3AEB379EF31CACEA73004670C4E7DB5710D79596D172F40D9627A1FCB618AA81880E015076F7BEDE83C8711B2F9C47DA3BA30497443436B1CAD2FE884224341DB4F9647D7051ACD3318000061B87B1D576E050D7E7E810368309C67E13B8E465061135B94A2AFF7C92835B7882B0711D40D0C79F7A5C07701B8A971401E0FE632FA1580736CAC40F7B37434568979EFEE3AB764B492A9D05BBEC4A9D00A80B83ED2A5CAC39DA9D0571F5D4D461B4ED1DCC71565F98FB3E2DBCDCE71EEA7ACBBB7B84F754303881CCC68E7BB7BE4755887D6AC82EC27E07ED0DC08D2C120A0FA082EDD6677B15E10FA9E3D5C7D461A6E13FAFA2904A2A7581235554328ABA11E4F600F4BB8A015F5E51B07C1F694DE0B5E0E65120714ABCCBFBD7C43DBC7D14943438654578A82CFCFB29ABC6EA6C5C1F99CFB48F69884B5E7C2F637DDAF017BDA12778153435639A9A50E372301E87BD8A22601DF763D61AFA6CB255314C748DC2C14ADB0225DDB52A20E70CBFF00887D3DC0E417EA39C3A817108DAF6894FEBD6EB7C6080580A90C80695D5B7CE25B500526CCD38D1CDEE64ABB5F61995E69350092C74FD15A773D10EEEAE71EB4748802259805FF00AF330255835D3DA42E40838C72FC5E3BCA5CC1D96EF3D720F92594D509C238BD28DFC43456B455BB7D39F7B317BA1F2DBF501B9B49C8B68866000AD4AF4CA4A2ACDC11BD46DFA6DC44A570773EA8B7B420A8DD63538ED1101CC335560C40E526EADB55F72574BB97162BF661AF60665F2EEFF11842F83B4112C44802A00964075B89DA81F6D09B580FA5A9D4B5ED07141BC5F8FCD43DA4144EA48D3F95FC41C34AA57BA229C44F40A057D0071D55DD435F45025D411551517CFD265802D7007319A39FB3E60A3D8CADB14001BB621A01925FD1AA00AAD40D100F9FAC42B21E2014195CAF04DD30FBBBC311A10AAD53000DA63E26B1E7332657CFF620554B5D3D8EAD802094DD65CB570C8956A32244C2E2AB83BD4BF503A4705C7280D4851ED09C4032DFEA3508C4BA307189C7AB1D05B5AEB879BEFEEE6E130958654C663A9779252A19E146879BFA592602BE551ABC6BDCCAEFEB436260C1F330429B5E3C40ED0D7B4623111E9E5E810465462E1F40C42CEDE7881AFACEA54AAE21071846A72CBE50F074DCA9E1F23C2E3A71D20D630B86417BD561D6A1B952A634DC757C43AEA8406E9347C6E031743C9E3A4139D417714E1039730C00347B90702A2D11A97AB53EC629C1401D730F713631EE85600BE52232C330D0B5BC50B4CFE20A2BE901B014CAF4E60B2ED1C78FA00549800B9612F7C7079806B5F41F440CB25B95CDC56094FBEAF06F894E0FE1000E2D1AB68BE2E5F0A55D52DCE0DB6E357E655E193A0DA42AD3585827A0C042788DAF3C6D1235B49C788BDA3618330C82DBBBF78606900EEF9968EC5C0515EEC3E1F46808573CBD63EC26120B6E8214967B5ED12888DA0908ABC8375F7E91448320A68C7814FCFD350DA5502A853D3DCC74228E0FB41201CDFD1000C4AFA48764B5800E99EC880511AC92FD97DE21B9D77A58035FC206158C8B6736C29FC4A21B8040CB6E0C7F822F372064AAA2E8B583D8E92A8DA15B2ED7FC476D3D7CCA0D5B719CD4E442FB4C912B1EFAE5E91E7ACCF8863C7B71EAE4EECEA5563A7B41A82B970AAC3D2F1DD22F72BA92891B5B1CAF5A86AAB5D3E98B5DF11919E2DBBF5F65CE7102958B579221032DABCC0AFAA96C4843580D5F58218715B4C7319A0A4C4B80AA937DA19A9DE06BC542ED80040AFE0AA2C8A56378C35E2F9BA5BEFDA3BF5A101AA56F79B45D98EE3A29B6983F7EC732B10C4AD0F15190C5B3A3FCC0A28F7F02CE273082802AAF78FB1DD270348F0C326EFBFB1C1D2066E55A7A010A6EEEAC5772C1BCC361BEC2833DE5B9F5B3E831C042E0D5441104DD9A971CEA5CE10B6C4A80B42E98257681F5DD412812EF30B082390CB05048DB47E218B4E6950D7F09511F08AD8E6557C1583AC73121A00E06F383B57E7F8374CA2AAEFD2B516768719F6BA6B0CED2EBBD54069028F5FDC6D323C37155703ABCEAE2ADEDFBAD84FCB280C16CEB6B7DE37E396AA5CDA070749E5DC3C545EEEEBC789DA0F31084C69620A8BBADF33763E20E81745AAC79831FDB0D447C3159FE48B451B2BCAFFAB10E29D02FD9183AE94A3B7987DBFF00CB111542F308F7BA7CCCA693752D2BAB6FDA79C7A9B8FD4067E93F518E36B6BBF691E1376AA86BD0962159B7E9B963DB0CA12E9D0EC63CCA15A0BFE230E400F06C6082DF25C23EEE1D30B72F203144EA465106AABD16F9DC578A683F372B6C70B74B78B600A8D95B45D5B9C66365A602A79A62393A84197A799664532C2018516E5C8DF98429D7462A955DAB6C74856E9C4DAB78A872DD5BBE3D9400AC5477BAFB67D2F3F46F3160FA75AE2204283A0EDF10632A8015E99772E305BBBF43108E928AEC8D9B74E43641E30B6BA717472BC7F7305FF6BB3D01FDCB497B2AEAEB6304E2D7A435AD9F32D162B01F5C2DC0C8B10F89796ADA0BB809F3BCA8DE5BAFE9835B1A12CBE9E7B4CF578C7E74E3E65097696231E3E82D170EA8C60CD032A89C2EEA0AA414DC316F642182AB80D37916C02F3DBDA47E91A3758B9E60039E5B8B6FB2988B45834EE58634572C6E9BB4CA55DC6D42DFBC7A316B44F439ACE088BCAC3635553DD483C9F64778A2A3DBAF68534E94D968019BC7DA3461C850AAA2CF37571EDC93799FF7C4DDB3D59F810FC45077489B52DD768B858AC96DA81561BD28BF1702008002A15ADB085A2AF61CF99484ACA5A8BDD4C4BEABC919C334B4920BBCF3F300182A0D2B25D66CC377C4A0FEA6D8132D2073821EB8AD1B0E71A78CE792155A1446178B3882840684AF14D303B34CD827E3D00005437282929BB58852C8F3D2321AD6F1294822A9617AAEDA96540C7183E6BAB8AC4418D359ECC76DB02E422D17C440B4055DDCB4A710DB0EC60D226BA7307BBC66208629957E21965F5337811CB833C55EC89722C2A0EF544462EC0542F591EDC5C518F6A6D8DDD3166AFA4BB415A7135B6A32F354826AD07968FB11BE1FCCA454AB76CA7ACB75FC4B753ED0188CA63056B6A3A899238371C24A40356317B9A9B8061E4731AC6DA6B6EECAD6731793829A72EA39763A4025BBA4780CBEF33164179CB5C9E58B3C29553F669AEF502972B4B9A84FEA52914E3A7B2974CA03C6D004A5F2F5731252D436A76AF2F794D658A384ABF2CDD710025101404BB2F8CFD7367758978219450AB5ED2025A84B372E802800FC1B77D52B52B1511ECDAD68C46F37B58811536AB6AF55E67896EA839750678129D609B732F90D6ACAB3482EDC3C48CECC41D3F6F4AF4F32DE6E9E19E73E6362323626E93920A4CBC65BE4E1E8FC6F32C07442105D37FBED1C6C4973045652758EC164EF0E7F51D8285574779C1A021D76809A655E0EFF001B94F5B67A5D67EF5F78FA60B82000A8688224D68D01DE36DF0441775490195645DB00ADC06D8ACD911D5114AA5B0323C5F42A3E7FB6A7E59B29825A0872953B84B36FDA03BA76C9D92748253A129D0960165680251DD3079E9042A3D2BCF88DAA5596C9A05A74D439AA3489E221B12177BAF32C505556AC7C31891A96F71A391B0C890854BBD3AD52FC3D632664343B642B4EBA476C5950AFCBE8465E546B988DD579555778839AB74E9DA1F595285A161DF89BCF5CC4A6EB0A7B6B2A4E5DC39AF88B8874054D0B7CBBAF432D45723B0B9C064EBEAC1FA15D894E8453613B698547E225570654D5BACC4B2292362EFF00ADC12A6B882A916B4C5017F68F89C19C4DE00CC8AC2D16F88E160AF798D19D3F105BE5456907719A2ABB68AAC4EFF47B7B7885F5EC4F21711214A3E610A6BCCC691930E30037C19731B5D5EEB962A15AE08C9E087523D92006C3DB50F652C86F0BCCE78B163B4756DDCA1746712BF7A3B7881ADBA2B98D44525F1F11ABA63D027C88DED0612CB8F3322B73CF6AE51CDE2A73EC08A73C0661D611FA56C3775C4CF318AAA3B3D7DA0428D1BA19AEF0DF5EF0801068E0EB2AABC032CE7D95F4EE5FA00A48E6559DE22CFA0B5DA770B94D80A59F9E217D71153C87A432AB1E8E6EFCC0D80A802068952F3592E132EE8E166AE8EC705EB88F06E1F3D55D6D7BB1ADB15D6206AF2C01A263A4F10FA96552F74C3E18B4060E1CC6866F8B800C2A27785921284E75FDCAF97D13134EAF76634F4A6E0602CC86B5D0DD7DF9F6AD8EF494CC3876A84DAB3E8E836349E2108ED847D86E2B1A0E6B1F99CE60B0756A52880A9AE6B3EFFC500A4883CC894D2532D4F00E01C392214103B161D8BEB7BC778D2D2AB5557581FB44303211D82D172A39A75BBD835862F2EEAB71472AF989413685B3C621FC2A20EB3A967AB146DE9399E072FB18807D86FC4810E8036F6957A16D2C867546069BB2EB528BD8CC1BC81A046B6BDA310855DD540706FF003ED25578351CB66E116B4EAB300288F4F4441475711B03DA83371C4356BBB7EDED5AEA81ABC912C1C229510E26ED168AE615D4847EF2367F8FE30D4139DC454EA6B5003158E916D9CC5746B98031FCBAFDE2DB6C0A4329AC0B7F06A263E2D0A4A01CB77903BD41B90BF170458CD2E4E2B128223017C9595EF34A31341402C9407C18C110B09785D26EEB57A87B04439587A4A51D6B98E3CA1AD9D66C7DDE186F510B5529ACC4CB90F6BAF2A1A88AB932F602B55C47632523644FB703DA6642515A2AA5A80E02EA61BBA5D473A4961577DA36F0349FC57D2CB7B0D4356FE36E6F02E3088B1791AA1EBFEE203614A7F5332C1F1111A6158C3586F43DEAEBED37832F6812E61695B0E174E0F32A57A73326A34597145EC51CE9A9712E099AC2D7ED5EBE23CB6F8C1C58250AD011553C52EACEB33200DFCC20A52E4D382520D7334A1E5FF1EFEBED2B83B98F6566061895B5745CC72556BE8B5D29A6292A47A3D13A8EE0F1AE16B398AF24245B156B8FE3D457ECED050FE210D01BD17CAE83BB2E1A2D80AF2D8834045118BA8F409192FB32B2089A1E842EDA3E4800BE2836757AB0C6E5E080DE1A53DE6402A95C2F06CC1D98CB10AC05F167F116F21B4DC032303AC37F0F3D718839BE7D8C75576142007A15F78870AA5776202DFCC27994A2717CC4A54AB6CBE973155330DE486FDEACEDE08D155AB10654E55DB2E5FB597B64BADC2153356BEBED5DB807CCB5922EE45934259BAC5DB291839633C7C7F72F902D60EF28A4CBCC68FBAC563E203548FF0016D15AF6A89D9CFF000EBF5E8E0AADF3C07561D42AB88696DEEF12BB45E7A46B66FD23CB28ACE3D2B372AA1031A001D98BEEDC0EA6B437C036BAACD8C0E1A20044500B6CAF7B95E85A4B3D23630475E96CC9FD0524BF9A8AA7228F572CC71B02538576B3D1D3DE252B3AF319341306AA068DBE59B897D7862B50ACEEE5FD0FDFA71EE0253937A9BCE339A389A27A9DBDB9569430D34103B407AD6404763168DF0CC1CDFB9F92546002BC29A95946D62AD8365C28A64D0DC475AABC648D8D253CFF000A8C39815286745606173A050B9E906046666D7AAC9E587984400CF44C3DFA7A25D6D748561FC13FF415A0D9D8217470C42B95D55CDCB0CB8F32C4BBC4B56698472F49774BD888ED39BB7B4C8656A39B3E465A71BB561D29C8EE5B5B815C0ECB30B470E37B20615AC3212FE78AF4CBD22D5193A9A350DE6C97201B43A0115ABEE351B4524AC8A5A1183C0938586BDF83D5D29CB0AE0A5F6B159D4A6069AFB7A519B2B15455079A594BBC6DB4E842EF472310764473961F05736283CCA007E18661A088C8E2B994103839A9ADC71BC7D575045CB97D068D6851068E68E7AB0CEE04005121C3B958E3988EA98E1EE3C8EEFD061B5400CE79FAE498A6DA688462A281654B6AD16EBB625766789DE63BCC7C8E86896CEEDB616B553CB119895EB92ACBE9EA2CEB2A1C80D26E80679391E22223B0E01A7FC3A61542146B37D06B29E6A6F3985764FC1FBC22147A359A01F3F42FC71C75ED09080E87D0FC28DDB2A74A6CF27B0C378FB433003AD0056B5E95058426F50DEFB4FE18BA00C66C34C050545E5ABA828DAA8751A72138886A9F307867C41ABC362F32E6AD001B3EA7982EB6C2B6DED3155BBEB14A280155E2A299A0995CEDCB9B21C1400A00D041A8CA72515ACB21C9575DE52D7C0FC9D477739A828D8C1718BD659571EDF5098C84414D0DE9AA5AF1C4505A0EEB51B028E4183D0EA54EF1C4341597499D1B389DA802EB110AAFCA1AF57515438256F2F91B3E496622F013088F1C230775989AC1ABEB5700618B56537AD5E30F01AFA1CE61F431F3A5DC65C156F3DA1AF43D0850070E997C62AE1C76F5D226C6E1060878AEF35E60ED4591C9742E90CB5355677DEE52DC26E2E2929B991BD2D67506C42F094EA411D3F416B73B933418260991F9956855B7A8BE848DE2E9BE43063973883170D0543EF0755503414757D2508A316E20C155C846A0C4CB2E839EC87CD3449EE7A883860D55A6007EF3E4F759EAA195A08F5E8C9223E0BE82195CB41D5EB2ECA3605F2DC2E851E4912D3AC2F2B07C20D415C8C080B2306065839FB44A6BBF440A3D59533E6C284CB3AC3B653AC0128C0B68EF32E6585081BF9DFCCB3E8BEF4886E98E39972E2AED7D61ECE5F830E9798C5B4413C47D4BD1E825DEB1374D6F533ED081412D5DF1A8592DBA8B3B34CCAEB6CB07577FB5C7A57B52FCC1F60D6A77181F33C7F682ACD98F115F13FDAA2FFE04536AF9F5A5039AC4263E2A6854B4AB358D5900D003A05110EEA543D1094E4EF2D80ECA9B533807BCBD156A80EDCDF31C7CD2C862529D3D69071E25264CC3A53B4CED304D11E8139696B987280B4DE61A20D104029B1C8F9CC35502AC626E2B315CFA0992B48E43963D25EA1E9A06F9972D445718085D3D219F6910023B188F4019655A3E0571D226202DD8E44E53479ED2F329C594D9AECD68D7F01525D6598B79884EB3CBE3DB9AC282D6880D0028F63D337455A8671BADD6AC211CCC682148BF67C84379CAFD9EA9E7FC4E6382E535389C96DCB1DD71E213DC016FBDB2F68F413E2D971E4D09F72283965EAF3889CAF6813E18E0CFA6667A45F12AB3C40802D7837072C69A5FA8C89840A9D8E57B352B852C614F3C1D8C4AEDEEBF4625909FFA9684CCCE7569603B073F72365AC90B1BD9A8E1AD3D3D2FDA9A22669BF4965F54AC7FD3BCC182CFFD3879CCA99006A19AA1C79959A153E2118056C799520407011C45DAD204D6E3848392BD00BBF45D02C37189637EEBB13760FF0066FE23545DEAA170A649DB1AB86F00106960175AEBFDC70A77FAEE9B7940CCB39CA34A8FB29975BC3BC2182981F97B0F2200822787103B83EDB0BB5E6C54EE768769A357580299FBF48C8D0B1393D08C4825013A315575968AB661C055655E58A52B9D1FA97C87FDC26A16941E95FD45B956EEE7F7155978FF002DC490DDBFC8B841B7DA323D6EAE0273F994FB5C115CD92BDC9D3702DB9505EB819825C31ADE06134D4E8BF1995711BE6240A8383148D791F8D210C0003771DDB830DD40C07C4AB7303310EB2F819CBCCC23481555C4502D43CC4CAD327E5F12E8271055CA7AD3AE7A10BE32C6F6F79C1997095E8C368F0F730B694D0A5B5B615195725F73A4541A5CD5FD7367D46722268B68E0A8FA9110949918D5D2D0B5A95EC76F201ABEDF383EF1BB6BC5C02774D942A6B8672AC74F57F83B5BAD0B743ACAACD62163CC764B11AE9F4BB7E9491674F715CCBAC56FE232ACDE346DDF6991F003772A0164A73AE7EF2D82DE1AF109197016EB50BA2F06212B30BD472B74F499099B2596CE083413ACAC1D21EDD312F223446108D1C8604F98581AB80C30469ABFB7D7EB5BE26DBCBA6355651D7B73205A16B5342901E3DA3542816240CB2445A5DD176E7EC47048BBA2649892C355A856B8DC5D40306FF85603234CD3D3F04C4BCC1079FC4392D01F4C6A1CAD5F715176083D31B8708B4D5D55C0058979AAFF00BCCC5E278F5769430339FF00798F0582E6971246A5F8A8284652555F17DA5DFA223C09EFBEACCA81D33D4D59DA0ED52E2955364A768950C1229B0B68F09F11D7D5C73A98E6BCB9EB06163821EC5A231A4A1C4F18F6A4302BA6C1ADBB1B89D9711205E44E2D2EA2B4A8C94A014E3B4FDF59AB71D2193A79209D7F8185B506CBC045C5BC0C38FA6037B4DF8F755E3ACEABEBE4BA60C0AC099C32BD0D116A5CBF53BAD02BF315AAD302A8ABA753999355CD1ACF128AF47917455C3DC971A9A518E65DB85A3B7580C5433D651139A153B8474F7CA52764E1EDF540A1D266356F0BC7896A3DC75E7DA945A8E13897BD063819F6B0130A946C9C9F97DA1138E5C325A3C16C3B9200BED880580B9A8C69E21792EE1D83A30C73F9415D3116966884DA0260BA57999F485D564F1EEB23207A4F534FEE3375987A32CB23968B4FEA5C3D4CC4AF63BD8E8E588E96ADFAD7A57A02052A2B65B55F3286EDB2964B572CDC54774783D77E8523637F6968155C21E97E88E16FEA1AF7952AA740D411C1F16FB92C905CA0B5A04E5E7E1FABF80C6ADCABBC05959E571F612C661B3E3DB942814E0FE82E52922C5E380E81293C05C65BAF773D0C758147A52E2DAAB82DA94DF37E2535913D3315E65DC2C85DDD97D6579F920FB19940D1EAB52ACA1C05BBAF97F173922F1B2F3752E086D0D5C70162A79F62CE6BEF2FA32E5C27530211ACDB7EB4DD5BED052ED50D4513BC404D9E21025322B74ABD454D0A97497F3DD5B2A9512B41B0D24A82AB2C7D0CEB004C0A002D55FB5010BBC306C11F60BAEF8991366FD4B6842B36683E15F8853930292B569559CF6B80606036226FEA3DE102152DCB1F2AA8F6EA9E0CB293C0A5557C7B1DAAD2CEFBB5C7F71E0628302D0701000A9C6433470BC06B0B033ECAF4A5EA0EC5C4EAC95EA8298432E18B30B6E30C5C4DD3CCA41C9300399ADFA319C6E60B4C6254558E45FF00AC42E5CAD1ACA4084AE6EFCBF508763886A502D6889934EB2DD597C113BA8B5888B025206E27B4FB43847DA6B52DF4C4BA25A08A845B92552DFDEE5EC84CD5436A2E0CF1174B0F2D21FDCB307A0A9815AAD5DEA3472297B6CA8FBB3CD5147CC25B56DC446CCAA0BBDEA2461A7D40934EE44A4FB4AA86CAABBF56F1518DB742CB81CEEC7BEA009CC665E25A22ACB6D544430DD88342AAAFFDA2C4F3687111F8E520F7E357F51A4417C419C9C97AD420857BC2DCCB1F8067BC5AB2716EA64D60DC6693EF456CC7398D68102DF05F2C5AD4A692A1A12691B2536D22E4FA3B75F04BBCBD603C7402384B41A5E6B75956AEE931056AD000070040FA95052A542A7C57A268C53071DE01638F46C43088735001176353182FBC672C748E65C2C274D19DF23556662FE88B604F304CB000F481D663FF0062163F8453775D88B6D4FDC070411B2EEE1DA8EA75E25E30C5A9F88633FA872EE36ADD2778B0480A1193D2FDC35DA502553ACBCAB5DE233C5596218172C6BD5820B372D22BEE6E20C4B856D5C7F52F6A0EE96601E59B6C8845A960FCC4929B15CBE62F0A85068FB4732BA0442D53D4C3306216C033ACE271351218273E988A1B8AA5953A7100BB6035AB5D105F88CD90219EC2BFA9D8F779BABE1747760091EA01FEEFEB1E943B87820901C6BBCA7996A05E080985F781707CCBF80806F2F98E7CBEF1B76ACABC05B1BC04E26DF4ABE0959E3D3EDE88A512EDE530CC7BACF82578859593016B9B7E2234E3135D1774817290422DDE11FA0B5D0F8EF0CC04D816FB5842964B7E6FF55528D95B8769920D36E29492981EE54C1E8B3BAE39554E83885DA5672C7A4FDA769EED3001157ADEA61D19F0C25FE7545697F36B9D54F946B0D7CB703FEC8F4FF762B587C2CACA6AC17981DB37CC4AC7F08A7F862BFF007449A0D1C891FB0817D0DA0B5688304929A06697347451F5CF65867503607C44BA7DE24C77FF0068F51F68370FDA278A9C87ED323B7BFB0F7108C68888A3BFA0825259186DB0433D7F108B2E6417BA07CE7FAFA26E668693DF79509CD850E0E6EFBCBA0159D823FE7E2015E4561C75BF513365E21ED5C4231E4BDD6BD6BDA3BDA4680DB04B1523606BEFB63AA615C0BAC7B838EA9D20C7F16A5128FE0314ECD978FA4EF8B2A46C8211944FE3FAFA44814BEFAF73A899568D966AB2AF38B851268564B871FDE3AC35F52BDF482CA113FA8A5051D670A7E335F69BEE180E459E85B50C2AC87072F776C3D56A0DFD47F8E402CAD4BB2C1C5958FA1623718F3C4209D0ADEADC42B6BFC8FD2D1E1F7712AE54C86C3977B29F305A40E254A5967886BF84C6AE8AF83FEAAFBC791550AF88808078E01AFAE95B337E87AD4AFF00E1B30030149F42E8575A175DEA2DAD5DADBD651D40D014F1AFA482DA7884434FB2D7B23DA175982C2B0DBC5C40E359BEF5C472B022878A61A3F8556873FB89006BE800D3D321BDC6C42ECDA1BC5F230C61798C8A94EB2DABD55FA002DD43D01D6E2B2CD7D1E62D170CB58D423E87B9FA7DED239464D77F781AA2E0E7106FBC2681121D7E9D0A92BDB539D7300B048960D2BD69835ED0BD9F89A1FC273072A44234B95E4C2B0C8C3696667FEF566AF6286D8365D952CEA7A5D0CBC8DD3A886CD95F458801A770A83BDFA2C116BD84673F551CD252DE33ECF0DE97046BAD4BE3FBFCCAA0ADB5D669F01D3B7D2E65A3C07B7B8E3AAEC77F1003F89595CB65BCAC35F67DD0355D06F30FE166E085342E0FBCD212AB63774695DA60B8A7AE069E98D4D3D2B1595E22FB25A99560A69482D8AE071470B969297BCB431F41F44B298AA9627984F03FB96140B80486FD54A8D5B39FAAC42C771CE9ABAE9E86877952AE9050EAC363D0C4376FDFE66EF1C7E6604EFF00A8FA551C26AD967EBD6E5A14DB8B26978B8178D905F3E2BD0B8AE87D3DFD0E5E4ECDB78A951E038215A5EC52F05E1612E30402865A00CB6C35E8CDB87AC0F196E29B32D29478BD44341E915C1F35E9B42962130C3DEFA05E44C899C9041366E56A1D91A897DE3988438F4B596FB4BA4AB18ED417D97ECBF73AA2BD2F5F417E68C33711D2778B8B75537BA6B1F330190804C34C01EE832EFF004EA2F92A687ABAC4C303A81751B6169DF1A8E2267922FF0049A3932705E0FA3708D96D8B4F4A6989D06A05F6B7CC58B008A5BA5BCC2270BA067355E79F88E00D829B03AE250CA82C072CDDCAB9C06047507506035A833796FCCBF4C32AF60BC3F8CCAC6E5B1B1AA7E035D6038339596C8E48517CD60351D441498D3B604E2AF88F026426EB29CB07694A2DC9A77494D02DBF10FBF46D73282B90FBCB1D6C01B01B5157555F314D8AA21A8E0CCE480505BA73CEDA1E3C46919805736CDA7531999C16D3D2F25985AE9D48A182CA6C6594A315CB70E003155BBE5AD576DCB33595D8F158C129B896C555B3C16B94EF1FCD6A433C8E3A66FE65F0C24C3348D9533558EB091739A1584F02F6C1BDE8AF618792D5628CC584EDC1766D5D56678B852B7D69B3B635E65AB47498FF00AC7E62D400D927803557D57106A79956CCE8AAE9F9959276937AD1DCC5F31E696599F66BCFE26C21E894A46B931B97C61090FC2386BE2F6E2045B2BAE19AE9F986C95A11B78BD5F538A216FD6CD095E4B9115D6EF1DB1EEA1DAEC8585392AD44965683AC0DB4B08D73752C8D3EE8636DA176F12C2943DDAE8B2815D6F2758D85155C2DE3628ADE7734913802F8CDB1AA87A56E2BBF54D3B8DA468D32A671AD398E0D8822E42C9D0ACC535B20C1606788F7CB12DDB02A838D5E57E2002B4584B7901E22A2C305FD9454A2CED4F42005A7F62A2E1941AAE6EC18D2B15BD4B4B40AC176E969BD17E62F90A55461354E28B5B18159040145EED7A6751640B9072B837A02B576B18301A158955C26F3FDC782295508CBDBF0AAA3AC2D0C7D93C7731C7588923C086EAE86DC7F88316B8AC4BC51C0F7804F83411E98B5F3A804A8AEAEDC359C4231C6D3F72E9AF1143535C9B57D8AD7E7B4AE4EAD7DC06C3B665D326D606ED71415C673A600485AE0DA68E9C6EEB24DC1ACBD78CAB667B4A8DE98A2F74DD570663A9788E5ED39695AF1999850AC5D86555DCCF17035B82D8A9DB84143A9530140AA2D02D712CCA514F40C2AAFAF681E9668FC85211D65615868379A0CE7B44A5493AAB6FEE636A75D67559B71F6899DA4D1B3A6F1E661DB90A5FBC7E7073058A292CE6DD6209107255966FB2BE6C8256A44FBC757B79ED1C2116342DF4AE260414BF1455757D62C004037AAED5C631DE53658160193D2EFF30EAE06A8B714F31E9AAD002F70E91081A530DF56CC147DE5184315073F7EF52F666D99F20FEA0B18A1414EB14B92D3B33BCD41D49563C639BAA99CCE6789AB4E81CDE7189449161CA0CE683FBE630F0A13E86AB1F32DB2B4FCE51FE65C555D34E8AACF9844D06D4DD553AA337AAEF0492B7CF705ABE61D44DD835D12D8132BDD5BF1FEDF684E176DECF81E331B250000A2AD5764DEA04188CABCE72AD6E6886CA8BEE8DE39BAF9970E4F25FD331278E47DC4A6038283C86D44D12BD4C112BBA28FEE1690064A5EB21D29EB2B08D2CC6ADB7BF04B97183014EB8C1E21B6DF9C0AEB6F317A9B76A3D039F38D403948C5050A746AFC24098AE91C8C19C5BDDA8BDBF655B31792F03AF8830222EA29DAB77F10AF384543F09C211AC9B7835CFE225ACAAC29EE625F336CA8F39DEB1F92A70D842E8506979CF1F9A8BB6AC0167CB8868F155A70DDBB3F30BAB56CBAB4F9E6A20E6084F870BF9980B026189763C869AE659F905855D7421E03D42C3B9038F35A820D6014A29F188CE59ABE1FC425747E3A50E872B55DE2149BCE19ADD077F12AA230DDE8AD7DE34460D5A83ACD74CFE1979EE70EF7DEBCC66E50B56EFA162FDA64A1A4E67BD5C4C04218979A65341C81CF72AF1DE0F07594BCF533FBA8C0405ADAE2F576FDA6698A1439D65DF3074105FD894377126E2E42A765BABED308D4987F7AFF0011F6B66C1ABA1BFC40088E8BD181B6DC19DFC4234D4E4429D4369304BC5AC0B577BC9DF51279A5C93CB38FFC8D8538B578EB5D62D1886CB4375AF0C6D55459C26B2BC3D9D46825A285761BA5EC4CF7CA567EC8CA9C3AB6B57E672D55551759CEE20BB37BE8BEB175444600EB7CBD20E0D56F9480C5CDE8C8E01C8C853D333A7BE5535F2E6180D62A97F25DF1FEE2322F685FFD20161DEDB9D6A6451820933F67CDC7437B7AB6A2C17BA56BC67A4B0944A9D634FE617F0324DBD0ABBF88560B510F497FEF30042A201341D6B5E218BA0285AAFC73DA6AF6681FDEBBC38D43225FB4592FE4FDA5A3962BA04304C403888C01E4D0C29ABE655B80B8718EFF0030285AB9AFF0732EBEC6D7C91AA69CA054792D42CC99ED15822AEC95BD6E5162F378850353E104E8F29282F3F0DC6B07E4A8E6E3ED05C8F1799FF971A46CC6A26B386B0625DDA7C660F629DE4A835954E1772B1A9283B4C9CF052C836B2A2BB0A83EBE6875D97946E814D6A0762FC4FF00CD88509EE4CB14F54A839657E20D7C3DD0C7FA65308913A14DF685378FC4379F6634515EA4A301F116C7CD88E657F105781AAACC2C05A6E3977F698221C417DA14A92E884F417592165A1E84C463BD6214D9F6E63BDBDB316015DEA28A55F40B9C2833788AA927C4B74DF9FB4FFC7800B11ED10B3B2A9E4FC449632310E1DE988EFE620828BA609516FDA8B901CD4DEB4BE92F141E89536B039E23D4946B05C12D553C1CC41656F69570C22A6630E1990E1F41895643DB10414546DA8ED21F10A949F10BB6FB0DC7786F70A095B0B501E8904E41EE47E1FD81953745F89564AAFF00B8315EB389A279947495E972BB7A63A109E7F13128952A6D88E254ABEF2B14C4B94D5563D00CEE572EE04AF5CF10B9BE3C4AED994F69A344CCA65B9267A4AED2B153885D759F04304B618E9F6F4CD6370B27C43CC6C33A9FB9D3B7A505F3E59999E92DAA6180DCBBE3D3333D22A95533D267A4CD769F0FB4AA98BD13E0899D431A96FA0769E0998659D47F31AE937C128B685F895C7108C16AD55456BE7DBB378715EFD156D7D7B7AE37133C3D08FB0DDDE2B531385F7D4B57AF9566F19BED2F10107777603FBF525A9B9D17A99A34BCC165CB971BE1A9C7A2B8A7CFA036E7C76F4B420745057D16D3CA547DEC23ECB65BD7DB5F4987B0F4AFE657D57FF98C3FF8FC7FF64FFE1F139FF8DF1FF1CE3D2BD6BD5FF8A71E83EEE3FE29C4657A919CFF00C6EFFF00D47FFFD9, N'jpg')
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (2, N'Eicke', CAST(N'2002-01-01' AS Date), N'reicke1@jugem.jp', N'7072308901', 0, NULL, N'heicke1', N'Eiyw@123', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (3, N'Cusick', CAST(N'2002-01-01' AS Date), N'ccusick2@wordpress.com', N'1575457749', 0, NULL, N'cusick123', N'cusick123@GHK2P', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (4, N'Alcido', CAST(N'2003-11-11' AS Date), N'ralcido0@mozilla.com', N'7785564414', 0, NULL, N'alcido', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (5, N'Crampsy', CAST(N'2002-01-01' AS Date), N'pcrampsy1@aol.com', N'0905987899', 1, 1, N'nvxl', N'$2a$10$zu/f3xYoqvchCTS.fohfJ.Q3K0cLvMmiojWgt1GKSDu5JsIwu.vGi', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (6, N'Haggish', CAST(N'2002-01-01' AS Date), N'shaggish0@wordpress.org', N'2289883529', 1, 1, N'shiper1', N'1', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (7, N'Enoch', CAST(N'2002-01-01' AS Date), N'denoch1@un.org', N'6358330484', 1, 2, N'shiper2', N'1', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (8, N'Xie', CAST(N'2002-01-10' AS Date), N'Xie@gmail.com', N'0123654780', 1, 1, N'fkeningley2', N'fkeningley2@GHK2P', 4, NULL, N'')
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (9, N'Casperri', CAST(N'2002-01-01' AS Date), N'casperri@network.com', N'7822147002', 1, 1, N'bcasperri3', N'Lihn@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (10, N'Claasen', CAST(N'2002-01-01' AS Date), N'lclaasen4@wikipedia.org', N'5338732422', 1, 5, N'tclaasen4', N'tclaasen4@GHK2P', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (11, N'Tidey', CAST(N'2002-01-01' AS Date), N'btidey5@bbc.co.uk', N'9872706536', 1, 6, N'ctidey5', N'ctidey5@GHK2P', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (12, N'Collough', CAST(N'2002-01-01' AS Date), N'dcollough6@mozilla.com', N'2074881294', 1, 7, N'fcollough6', N'Eiyt@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (13, N'Leathlay', CAST(N'2002-01-01' AS Date), N'bleathlay7@washington.edu', N'2974510741', 1, 8, N'mleathlay7', N'Sgqc@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (14, N'Edgworth', CAST(N'2002-01-01' AS Date), N'hedgworth8@wp.com', N'6312345998', 1, 9, N'hedgworth8', N'Ylxr@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (15, N'Winger', CAST(N'2002-01-01' AS Date), N'pwinger9@myspace.com', N'5349633725', 1, 10, N'ewinger9', N'$2a$10$qh4f30.MlkoywSBpqFgxku/Ojt3DVyQXRWhaQkcBjdah/UfE43XO2', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (16, N'Derell', CAST(N'2002-01-01' AS Date), N'tderella@cdbaby.com', N'5983253362', 1, 11, N'mderella', N'Pfyn@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (17, N'Viel', CAST(N'2002-01-01' AS Date), N'qvielb@squidoo.com', N'3886657602', 1, 12, N'wvielb', N'Pjeh@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (18, N'Marklew', CAST(N'2002-01-01' AS Date), N'wmarklewc@fema.gov', N'4441189057', 1, 13, N'zmarklewc', N'Jxmu@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (19, N'Murdy', CAST(N'2002-01-01' AS Date), N'mmurdyd@hostgator.com', N'5642903075', 1, 14, N'smurdyd', N'smurdyd@GHK2P', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (20, N'Aulsford', CAST(N'2002-01-01' AS Date), N'naulsforde@simple.org', N'3963451688', 1, 15, N'faulsforde', N'faulsforde@GHK2P', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (21, N'Walshaw', CAST(N'2002-01-01' AS Date), N'swalshawf@ft.com', N'6817670869', 1, 16, N'awalshawf', N'$2a$10$5IH5UZvBNh2HyLtotEykgOTOeGIBQgKlCz11wJLYdgUJSq74ntIbW', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (22, N'Nguyen', CAST(N'2002-01-01' AS Date), N'rdashperg@chicago.com', N'3632144798', 0, 17, N'wdashperg', N'Cnhb@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (23, NULL, CAST(N'2002-01-01' AS Date), NULL, NULL, NULL, NULL, N'alcido', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (24, NULL, CAST(N'2002-01-01' AS Date), NULL, NULL, NULL, NULL, N'alcido', N'Alcido@123', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (25, N'a', CAST(N'2002-01-01' AS Date), N'hellley@gmail.com', N'0569774531', 0, NULL, N'Khaingu@123', N'Alcido@123', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (26, N'Nguyễn Hoàng Nam', CAST(N'2002-01-01' AS Date), N'hnam@gmail.com', N'0569878999', 0, NULL, N'Khaidan@123', N'Cusick@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (27, N'Potato ', CAST(N'2002-01-01' AS Date), N'potato@gmail.com', N'0987654321', 0, NULL, N'cusick1234', N'Cusick@123', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (28, N'Tomato', CAST(N'2002-01-01' AS Date), N'tomato@gmail.com', N'0489640259', 0, 1, N'cusick123', N'Alcido@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (29, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'nnp@gmail.com', N'0135792468', 0, 1, N'nnphuong', N'Phuong@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (30, N'Đặng Ngọc Phúc', CAST(N'2002-01-01' AS Date), N'dnp@gmail.com', N'0123456789', NULL, NULL, N'Phucngu@123', N'Cusick@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (31, N'Đinh Quang Khải', CAST(N'2002-01-01' AS Date), N'khai@gmail.com', N'1234567890', NULL, NULL, N'alcido', N'Alcido@123', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (32, N'Tống Bảo Hiệp', CAST(N'2002-01-01' AS Date), N'hiep@gmail.com', N'0123456789', 0, NULL, N'alcido', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (33, N'Đinh Quang Khải', CAST(N'2002-01-01' AS Date), N'phuc@gmail.com', N'0135792468', 0, NULL, N'cusick123', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (34, N'Chiêm Đức Giang', CAST(N'2002-01-01' AS Date), N'phuc@gmail.com', N'0987654321', 0, NULL, N'alcido', N'Alcido@123', 1, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (35, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'phuc@gmail.com', N'0987654321', 0, NULL, N'cusick123', N'Alcido@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (36, N'Potato ', CAST(N'2002-01-01' AS Date), N'phuc@gmail.com', N'0987654321', 0, NULL, N'cusick123', N'Alcido@123', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (37, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'nnp@gmail.com', N'0135792468', 0, NULL, N'alcido', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (38, N'Potato ', CAST(N'2002-01-01' AS Date), N'potato@gmail.com', N'0135792468', 0, NULL, N'cusick123', N'Cusick@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (39, N'Tống Bảo Hiệp', CAST(N'2002-01-01' AS Date), N'phuc@gmail.com', N'0135792468', 0, NULL, N'alcido', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (40, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'nnp@gmail.com', N'0987654321', 0, NULL, N'alcidorgergbd', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (41, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'phuc@gmail.com', N'0123456789', 0, NULL, N'alcido907', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (42, N'aaaa', CAST(N'2002-01-01' AS Date), N'khai@gmail.com', N'0135792468', 0, 1, N'ghnfgnfg', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (43, N'Nguyen An', CAST(N'2002-01-01' AS Date), N'potato@gmail.com', N'0135792468', 0, NULL, N'asdasfdvsd', N'Cusick@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (44, N'Đặng Ngọc Phúc', CAST(N'2002-01-01' AS Date), N'khai@gmail.com', N'0135792468', 0, NULL, N'aaaaaa2312434', N'Alcido@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (45, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'nnp@gmail.com', N'0235587421', 0, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (46, N'Đinh Quang Khải', CAST(N'2002-01-01' AS Date), N'khai@gmail.com', N'0135792468', 0, 1, N'khai', N'Admin@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (47, N'Đặng Ngọc Phúc', CAST(N'2002-01-01' AS Date), N'dnp@gmail.com', N'0135792468', 0, 10, N'nphuc', N'Phuong@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (48, N'Đặng Ngọc Phúc', CAST(N'2002-01-01' AS Date), N'dnp@gmail.com', N'0987654321', 0, 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (49, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'nnp@gmail.com', N'0135792468', 0, 10, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (50, N'Đinh Quang Khải', CAST(N'2002-01-01' AS Date), N'khai@gmail.com', N'0987654321', 0, 11, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (51, N'Nguyễn Ngọc Phương', CAST(N'2002-01-01' AS Date), N'nnp@gmail.com', N'0135791232', 0, 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (60, N'Giang', CAST(N'2000-01-01' AS Date), N'giang@gmail.com', N'123456789', 0, 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (62, N'Loi', CAST(N'2000-01-01' AS Date), N'giang@gmail.com', N'123456789', 0, 1, N'loi', N'Loi@123', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (65, N'giang duc', CAST(N'2000-06-15' AS Date), N'giangduc@gmail.com', N'0934346389', 0, 2, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (66, N'Nguyễn Hoàng Nam', CAST(N'2002-10-30' AS Date), N'nam@gmail.com', N'0987654321', 0, 8, N'nam', N'$2a$10$X2VznnI8B/WgeCiDShGAreD3RCuKYz.4GMp6sIZzGeVkUN8g/oEBW', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (67, N'Đặng Ngọc Phúc', CAST(N'2002-11-20' AS Date), N'phucdang@gmail.com', N'0135792468', 0, 2, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (69, N'Đặng Ngọc Phúc', CAST(N'2001-11-19' AS Date), N'a@gmail.com', N'0905674831', 1, 8, N'admin123', N'admin123@GHK2P', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (70, N'Phuong', CAST(N'2003-07-25' AS Date), N'phuong@gmail.com', N'0123456789', 0, 1, N'admin12345', N'$2a$10$FNDqlPAtD5rZ6R8TBraIiOXolGp/NBZmRgZHZv9pehmFeiOoOwf12', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (72, N'Giangoc', CAST(N'2002-06-26' AS Date), N'giangoc@gmail.com', N'03943483619', 0, 5, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (73, N'Giangoc', CAST(N'2002-06-26' AS Date), N'giangoc@gmail.com', N'03943483619', 0, 5, N'giangoc', N'$2a$10$DpKiQuoc81Fd0gveD0Ocee4Mopk.UgNEcQPmL1er83VxigueThFbW', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (74, N'Đức Giang', CAST(N'2002-06-26' AS Date), N'giangduc@gmail.com', N'0343483519', 1, 5, N'giangduc', N'$2a$10$wBVSONRzhYzD/FlzoyoVOOqVPnYNMFC5bgWeTQLBYvE0qzgN0e3yO', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (75, N'Nguyễn Ngọc Phương', CAST(N'2003-02-25' AS Date), N'johndemon2307@gmail.com', N'0905674831', 0, 1, N'phuong123', N'$2a$10$vdKPx60i.IFZOeozErn.se4JQXky8CPM4u.5lDOwQ3TAmerW4UBT2', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (76, N'A', CAST(N'2005-07-20' AS Date), N'a@gmail.com', N'0905674831', 0, 1, N'nam123', N'$2a$10$M.NdnddiJQ1s5L9k2ZIqv.bEpSD.K25naNmbiCYXPGLte9SAvrcBS', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (77, N'Nguyễn Ngọc Phương', CAST(N'2001-07-25' AS Date), N'a@gmail.com', N'0905674831', 0, 1, N'nam12345', N'$2a$10$jhrgqaanMuQhcIM/fatol.U/YfCjSDbSmlJ5izP5pOP3slWCh5T2.', 2, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (78, N'Nguyễn Ngọc Phương', CAST(N'2003-07-25' AS Date), N'a@gmail.com', N'0905674831', 1, 1, N'ngocphung123', N'$2a$10$AeV.ab7VEZtVr/qOjt.y2eTIKEYRbL4AQCHZvbuC78ddcwTIrHpQG', 4, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (80, N'Đinh Quang Khải', CAST(N'2002-07-23' AS Date), N'khai@gmail.com', N'0987659999', 1, 8, N'khai12345', N'$2a$10$WZ0YkVOceEfgWpccNXwZSuI2e2BuwnY5GaSOKVYs7t5MlN2.nc0wK', 2, 0xFFD8FFE000104A46494600010101004800480000FFDB00430006040506050406060506070706080A100A0A09090A140E0F0C1017141818171416161A1D251F1A1B231C1616202C20232627292A29191F2D302D283025282928FFDB0043010707070A080A130A0A13281A161A2828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828FFC200110802E002E003012200021101031101FFC4001B00010001050100000000000000000000000001020304050607FFC400190101000301010000000000000000000000000102030405FFDA000C03010002100310000001CE1E67A3631EFE3DA362844CC106C35F9C8DD40C24240000000000000000000000000000000000000000000000000000000000E5C37C7C6CAC5B46CA08908363AECD46EC31000000000000000000000000000000000000000000000000000000000000E5C37C6C7C8C7B46C4448419D83988DE225880000000000000000000000000000000000000000000000000000000000072E1BD8C5C8B131B009083330F351BB44B1000000000000000000000000000000000000000000000000000000000000E5C37C7C6C9C6B5762988B0419987968DE4C4B1000000000000000000000000000000000000000000000000000000000000E5C37C7C5C9C7B46CA2262420CBC4CB46F24620000000000000000000000000000000000000000000048C7D14BA5707936766A66A970DDCC82800000003970DF1F17271AD1B21121065E265237B231014D5A7BC6B2E747A6E9CEDE4E8B455B7A464F8EE7D2DEA8F3DE8693D08A020000000000000000000000000000011A896E2C70DA2D63ADE6F0FADDE38FBBE97D0DE9E43D6769334B3A4E838388D17A4709D661B6C162FF003DC20000001CB86F670F3312636122420C9C6CA37C180187E77DB715D35F5F9A67A79E6126BB4DD5427CBF9CF73C18B7946F36DCBD34EE765E39B1C2DEA4E6FA3CA645401120020900000000000000000C6964E9F99E6F68D96B3AEECBA29C3759B8D6D63618D83B7CEF3929E8E711631F21116FCD7ABE229AFA4CC4F0EC10000000E5C37B189978935D8CC54B40832F13351BB0C40D3F09DFF97F4C7B3E6E9767B679034C80014D4353C5FA4E9F2D3C933BBDE531E8EAB73E3DB153D41A9DAE132044A0000000000000000022CF0D76EB8A767D55E53D36BD329BEC3C4AB9779AA3755B53929F4388589862D0CBA2F666B732D4D6F927B678A4C7A96C795EAB8B60A0000003970DEC6265E25ABB1AADD717083330EF2BD0CC4B1096B7CB7D5FCA378F5BC9D2EDF49D9CE2E56DCC1300011AADB61657D4C4BCDF42C723DAB4AF96EF7A7E1FA71F53BBE4FE839C6DC640000000000904000930F47C669156CB73D374D32B53AFCBC34B59872F425B5B5672E5E9700898A702AB79EE14D5918F76699DE47EB9E45AE1B6EDF81EFB9370C64000003970DEC6265E25ABB19898B8443231EF9D086004791FAEF976F1D6745CD74BB273F5F7E63346BCE000B7710D263EF74DC3D96C73EEA2B1CB731EA1A4E9CA7ACF20EC2F975EB37B092CF312EB5E7B8378F50C2F34B16771634D99A57229C2BB2B976314DBDDE5EA89EDF3BC8E9A4FB1735C7C14FA2D5A7D2BB4D7DDCEE4E8A2B32D066DAB7B3D3E979E17859AB06978832E9015D15CC6C3CA3D5FC875E7C9F44F35F4BE5D8309000000E5C37B18999876AEC669AA2E110BD6AF9BF9896003CFFD0398D1CBFA678F7B074C48ADF36FEBB61AF348BD001035B181C9D01C7D601364D4F29D453D19F3BB6C2DD6B9727BBED48D06CF22D56D466F3897514F3087537792DD55B2B9AC52DB5AF4FABBD7ABC0E6ABD2BB0B58911339F76F72F405644973776B23D0E10DF24316B36ED197504480AA9998D97937AC78EEBCDB8EEF89ED78F7919480000072F306F6B0F330AD1B19A2E44C2508C8C7CA46F6625880C1CE8978E7A579FF0059DB4EAC5349C8C65A36738B93AF3489863646871D2883CEEF0006A765A5B250BD6777ADDA564292C0CFD3CAC8D2A2E432B61134B0428D2EC75B6817AC9D9D5550112036B89B7EAE6993B7940A75D958996C14D80015D15CC65F897B578A6BCFDB759C8F5DC5B48CE4000003970DED6166E15A33EE5AB9121065E2DD974331318008989713A3EFFCBFAABECB6F5BB2B49315B3330E6D5D9ADDCD79A8E7FA1D172F45B1C7D600183AFC9C6BC2633259D70CE40B7A5DAEAAD01686DF1763590AC8187ADDE61DA3076EBA05640554EC6F4CDBA7A5E785889C78635063D41160005CB77E6B87E47EA3E5BAE3DF74DA6DD70EA149000000E5C37B389978968CDB945712109AE8BD2E8248C0009479BFA4E96F1C97A2F8EFA57546E3330B3118B4E6D05EB913A60D66CE8A5B9F5EB3E6F784580D5E2ED31EF1636F45D805640C7D4EFB0ECD6E567DD4449590000000009DF60EC7B78E4756003033F0697B2BB7B3DB119B892A456E032F1336F9F2BE7BD97216A7AC5FA6AE0D420000001CB86F67132F0ED5CEB96EE45820B96EF1D106000098CCD6BE5D6FD47CA7AABE977B1B2EB6CC1AF38480C7D4EFADE3AE81B0D7F0F5852E000000000000000000AA9CEB576559EA79C120008A2BC3ACDAA4CBA822409D86BF3B4C7CDB075BDA567A91C770800000072E1BD9C3CDC2B4675DB57626041728B8745312C0001C7F61C0EB1B0EB380F4CEBC6AAA66D40900022712B3ACB4797E804580000005D98B4DD57D18689B0D7E3A852E000000D9EB36DB639A3D1E2000014D485BC7CC88B6B19B859EE15BDCD6EDF96D39FCFBD4FCEFD570D439E402DD70912000E5C37B3879B8568CFB966F44C2508BD6AE9D05512C00034DE6DE8FE79D31B4F5AE7BA2E8C02D500001A6DC73FCDB52387B40000006CAF4A7649F438434AD1A6DDE1E1AEA5553E7F7000000373A6DFF004F3DC1DDC8000000046365444EB272672DEEF99FA7F9BE98E17A2F3BD2F36D40C2C221ADBAB5E5746C9AB74572F235DB2BC48EACB970DEDE166E0CC6C2BB17D313082EDAACE926258000380ED392DEBDF65C4F5F38480000B5A0E879FE4E90E3EA0001245FCCCEE9E6B1909ECE60B40089185ABE835FCDBEB531C3D80000656E31F27D0E00DF300000000084911C975BC056DCF77BAEE8F9B7918594D1AEE6BE7ECB9EC8A2F62579795EBAA27D0C40E5C37B7839F8168CEBB6AEC4C082EDAB8748180034B2E5FB6E23D4FBB191A660000016F41D169397A2C0E2EB0064CC58DC577BBB883A32000000448C4D47438BCDBE9D958DC7D504D6D1995EC7A79AA93B79424000000000068FCCB75B1CF5C4EE35BB2E4D0339C3B99118DF1F0F6B6F2B6AF6D8F9500ECC80E5C37B7839B8568CDBD66EC484176D5674A896003CCBB2F36E88F51E8F5791D5CF9AC2998CC620CB635E2B5B92B502BC1CD5679E8DD51C5D5A8BF9F9768C4CC9757344978000000000029B192ACEBB2EF2B312695000000000000448F37D8DCD4E3B76F313C7A0400000000E5C37A3033F026332FD9BC98105DB551D3239E9C36DE7B46F3AB2E237D72C6B1EA773CCB516A7B2C78CE31EDEF0BA8F70B7E2549EE54789550F689F21CC97A9CF9EEC11D9DDE772CDC5DC0946C2BD65733B0625F2DE4731D3869B6E54B5742292B5341758F886CDC9E921E8EF27D527DB2DF855B87B353E3307ADD1E503D56D7978F4ED9F8F41ED1B6F04ACF78781D72F7C791F468EE5CAEF8CC42531CCF090ED384D4456FE8BD5F8BFB2F2E958C6E000000072E1BD183B0D75AB9B76D5D8B0415D15CB0F80D96BBB38B370972F16A6F4A2D4DD84D0AC53158B6B82D45E1617C585F82C2E528C8EC3861EC19BE33D3DA3BF9C5BF31CFF005FC6740693AAE577C6B3758970BB471BCC43BFD2F0E89DE695526D4DE989B4BA2DCD6295421222578A236F51A4A37949A38DA62431A2FC4AD6559B68EA74FAD134C804E57B2F997A67368931B8B755C535480000E5C37A30361AFB4665FB17E042254D58B2E0662AEFE1CCCDBB8263400000000004A04C028AC588C8B66D3D1FC86B98F62BDC2F5735D84E8B9D96FF0084D6CD6D1372A89A6A0025000000000AAFE30D8DED449B9B785063A609B772D96C02B28AFB7C53A3DE73BD1716C15960E763617C7D86A3278B5CF44FA7CE5330912E5C37A3036181319976CDE48418B96979BDCE9B99EDE1DE6BF3EDD9AB4C0000000000000026045ABD4968004DEA6A00000000000000124272D1869260816660C9EBB67DB4D78CE9B326623C83D83C817E9FA7E43AFE1DC2861DEC0E3D7370B7EDB3E7EBB963CBE96D2D5FEEC43AF3E5C37A30361AF98CCBD62FA420AE8AA5B4F2AF64E3B6E5E6B2F45B8E9CECE06EF10D7AAA4000000000000011368A4005F535000000000000036462F5BD9EC26BABD8D78D318F1939470FCCFAF16F07DB7A2F9D45BD89E77DCCD32C4C3C83D63C4A2FE81D1EB367C1BB0B331B96F8319F5F06DAFCFC6C785DD86366F5E61D9901CB86F1AED8EBA632EFD8BE9082AA64E9262B9C3CA751EC1E53D596664F3D95AD767859190699B4D610490000000000414DB983236FD6F4335F1BC6F54F324D9BD62626F22400000000015991EC7CE74535CB9C1998AAC32C9BD132104D8BE3CDB45ECDCED6F3D0F897A4173CDBA8D6D6DE85313C3A84008D66D2CF3DF1F3A26F01AD40E5C376B763AE98CCBD66F24209893A4AEDDC9C634BBB4C78A5BDB57DB969ABA135C9A6C49BAD7D56090004C000045B2BA2913DBD1DD4D6DCDDAA62C69BA0B678BD8F58F34ADB0AE5B26FAC5C2B448000000E9B99F4F46EEC6163D75DE5354698CAD5C2E65E0D48C9C4A72E5780072BE77EDBC656FC6F61C07AEE1ADE989E6B040044A400400E5C376B763AE98CCBD63213020AA9A8E966267008703B6D8703D74F44E1BD2B63B63E054FBBF3C794BB3D544E859F8A5B9884D555B15A815440337728E77D4F69B4988995A00029C4CD1E73C57BDE1567C31E85CAC4E9EAA49AEAB42EAD0B91456446CF728E4FDB389EDA635391B257663E46AA698DB3D66DF3DEFD15C6DCB397895A33113201123CC68F4AF39CF4E976FC875FCBA065600000003970DE35DB1D75A32F231F22260415425D34D15B00853E65E9FCCEB1A8F4CF0CF4CECCBA89899CD129534D7262DBCE43417B7234591B51A9CBCB109202640355815D7A45355B20000357ACE9D0E230BD0F5E9E3B2FA42359B0AD284C1CE74DCCF4F09C6C7C2A6FB8A3579D12CF89B6430A6335A8DBAD7B270336D9D4001123CD3BBE37339B7E9472DC0000000E5C379D66CB5D3193918D929082609E9AAA2B9E70829A92F3DE7FD7FC8FA63DA6ED8A7A79B2D8F78A80000000000073F8BD463E7BE455137C024000030F3318C50082624733BED3E544D089E7EE44C272767A3BF7C76FA5DD61DF2C5DB5ABA3231EEDB3CA130001A9F31F64E76B7C3DEF94FA7F1ED7C652000001CB86ED6EC75F319193632130209893A3B966F4E0101A8957E756BD0BAE9D5D371B618D1936A54D76E0BB558192C6192C619338B7CAC000C686BB4F973976EEB3391EAAFCF705F2008125246055400122155668F0BA4E6CD8598B98F5512536898A91B9ACE8E2042E5BACCC44CC0044155350F25DB74DE6796DEB2A6AE2D020000072EB533BDCD766624C5FC9C5BD0B8A2535224E8EEE3CB1BE8C2458F3A8E8FAEB95DF535ED804C00891145C169745A5D166DE55A29BB8F264AD5C2759B3889C5AB260E77A1988B54B76ED4AA88ACA26A14C55051358A26292B5A82F2C417F4BB2A4E6B618F6227718B46EA9B69F373E62512D30000BB9581948AE99B72AE9BB0540A3C63DABCAAB7ECF63E67BAE2E8EC9C7AB3D7DAE4693B171C87635F172273266F80CF935ED80D7B6126B9B1A8D6B634985CEEFF94DB3D87AE6BB6FD5CC135000000013124260A2D64418CBD414D502A50115565AAEED4515800001836B3B0400002353B71CCD5BDD19BDCAD4EDA2400005DB433899800079B7A4F9EC5B41D4F21DB71F5D95D657B317C6332463B200089000400538DAEBC68BA2E77D93B39AF49A62209000000000000000000000000031B260D6A6000001CEF43CD9BACFC4CB89000000C9BD8B9530000E17BAE2A278DED786EE793B030B8000000000012E2B073F6DDB86D7BAB57B4E7098448008B65D000001300209000013000000000062E36C700A400014739D1F3674B7AC5F890000009CDC1CB45C124488F3AF45F258B62F67C8F5DC7D618DC0000000000166589A1C4F4BEDE6E824D7028B264B1864B1A4BF62B922EDABA0000005A28320A0AA71EF1500A649000000000B37A0D6ABA05517CC798BE60E837DA03A8AEDDC890000008C9C6BC6509802D7897A6798574E9B7BAED8F0F58524000035155E36AD3D06EDA2BA6E1A2ACDD62EBB5568D8FA479E6FBAF93AE7278F6AF654F21275AE5B08ED29E5AD9D655C8629E813E7D9A768E530CEDDC50ED5C9621DC384A93DBD8E42DA3BA70978EB9C7EBCF497258A761473764EC2E7039276AE3AA3AF70B70ED9C5631DF380BE770E1F2CEB5C5D47518DA2B074D779393A4C9E42B37DCFC69CEF2F71D29EC1CE6BCECDC85E8752D1614BAA71D950E9EBE5B025E88E1F211D8470F51ACE6ECE6E7B76373498DCBD1D234930DD34726EDA3B6740D2DA30AAEE6BBE5C1D7DF552F3FA7D0E11E795F7F27035F76870377BA1C1477D27051DE41C2D9F418385B7DF91C0D5DE42781B9DD0E123BB938777238677130E131FD092E067BC9382A7BE93CEEAF411C05CEF079FDCEF079EDDEF60E063BF9380A7D052F3EABBE9879FBBF1E771E8A979D55E87279ED1E8A3CEA9F4693CDEE7A241E7B6BD220F3DB5E8E3CEED7A541E6573D2625E70F474479DD3E904F9AD3E97279BDBF4B23CDE3D289F32B7E9F2797DDF4B83CD69F4D83CC9E9D07985CF4D83CD6CFA7CA36323329A92080000002249841542444C13092082660009882A802600120898000482089804802609841544C09802489404880092122094C044C000012225099804C1000000000000000000000000002624800000000000000000000000000000000000000000000000000000000000000000002624800000000000000000000000000000000000000000000000000000000000000000002624224204904A2480000000000000000000000000000000000000000000000000000000000000262484C004A24800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007FFC4003110000103030205040202020203010000000102030400051112201013303132141521400633222350602434253541A0FFDA0008010100010502E0EF64F96D87E7FEA8ED27BED883FB3FD51DA1DF6C3F2FF547BB0EFB627EDFF547B7C5FD9FEA8F50EFB62FEDFF00547BB0EFB629FEDFF547A877DB17F67FAA3BBE2901CFF547B7C6C737FD51EDF1BF77FAA3DC06D8DFBBFCF2DE6D14ABBB014EDE1D348BC654289094A2E0F48B875DDEDBA3101DDAA3A42AF4D522F2C902EF1702E314961F69F4839FF20EBADB497EF382F4C7DD5A8951434B5D336F94F22D9692D2F40ABCBA19816704CEEBBDBE37EDDAD5CDA54C7E0467CAAC4C1A5589E14FC290C201229332426A3DD9F6EA3DD59707F8B9370618A72EEF953CE29E710852D4CD8DC34C5A2334B03E38FE48555638CE2DF9F35A874C39CD6BAAEF8D0DB1CE1DD930E98B6AFF00D88D8FC38EFD4BB332E97ACF25158A6A5BED545BBAD34C4D61FF00F0F3A7B71932E73D27844B3BCE29AB4C441CB6D573CA8B48C6D7D943E8384250972E73C7C759DF11DF6C6197B65DCABD05A95A2E3BDD8ACBA87AC4D913ADEEC65D4598EC630AE88795FE09F790C372EEAB7520152A3D91C518F0D88F4B7128A5BCA550054596F46FBEB8E350ED5239127ACF76A4F6D91BF6ECBB0CC0B768F5A17FCBA18A990189553AD0A612460C796F47312E0CC93F7E65D5B6C3EFB8FAE2437A4AE240623538FA5054F2D5C00C969B081C54BC51513495D0ABBA12B81505E0F47EABBDA87C0D914E1CD973C7A1ED51FF004347E3A320E5C75B438265BD49514A9351A73CC18B3997D1F6DE790CA275D14F861871F540B369A7A4A19A5ADD90529D3C00C96D01038B8AC0E2D1F89090B64F7B0B854CF55DEC2876D9171CDD97119834CE9E524E0F4657C2B83AD21D4CBB7A994D5BE7AE3B8DAD2E27EC4A9088EDCA90B92E5B2DEB985A6DA8ACC896A5ADB6CE78B2DE81C547144E7634785D9B6D99BF8F93AFAAEF6A4F6D8D7EDD93125716AD3FFAFA6D7D195E1B1F8ACBF5263AE3AE3497232E1CF6A57D7B85CF944A9D90E5BACE497E4A58A515C85B68D03877A61BD3B56727637E55775055C2C39F55D577C6876D8C7EDDAFA396F589C2A87C127237AD3A83C8D0AD8A485A66DBBE124A5502EBCC5741E92CB346F0CE557A457BD1A4DE8E7DE9CCA2F4722F2CD22EF1D5499B18A42D2AE1759FC8A8CC3929E890188299134A821B2BA48C0E31D181B16AC0DA9EF57A1FF91B2BDCA97D577B50F91B1938736DCD3A67D80FFC5E0D9C745C46B0B4149DB360A5E0E214D2D9BCA7434E25D4538E25A43D7940A72ED2143DC24E5525F50436B75C6ED33163D924F2459E61A165944FB13F5ECB2E8DB26051B5CC0168520A49496663ECD466CCA97FD1010EBAB74B4D6D8EDE76A8E06E4F7ABAA82EE1690E19BD577B50EDB1AFD9B6FC3FE5DB247A795C50ACF40D3CB46F9410E97D82D18B31D8D4FDDDE557F6C875AB3CB5D26C3F02CF085330ADF1E9126322BD7B546E0DD7AF6A84A491EA3E7D40C73D35CE6EB5B4E176DB11D53B648E54965880A00A8A19036B68D6A48C0E27E02D59DE3BD5E194333AC5CC2E755DED49F1D8C0CBBB6FC8D51A878F049C742439F3B9C5694D292141E87F36F84DA509521B1CD5D6696AD293B5034A78C8FD9495293456A34949516D011B40C9691A13B1D574455C14152FF1FF003EAB9E343B6C63F6ED9AD9722D59D4576DE295EE75CD03FF00BB9E56A5F14F6E3255B63A762D5A539CF16D1ACA13A46D8EDE06C347E4EF4F9387082493616006BAAEF8D27C7647197774A48449FC7A40DADAB6B872BDCE7C238B08D4AD8E9D4BE284EA5631B249FE3C1B4EB52404EE8E8D4BDAE9E8A7C9F5F2992727F1F3FC3AAE78D23C7646387775F99FECB7C8F4B29CF2D885F1578EF927E380F9A4274A78B9E1B1A4681B24F8D019A6D1A06D0325B4E84ED577E837E5764955BEAC23117AAE78D23C7635FB375C58E7C4AB53DCFB7EC1F148391469630BDCF9CAF8474FCEC7FC38C74677286A1C9FE484046F8A9DCE1C0E8B43E6FC1660D5A33E83AAEF8D37E1B1032ADF77679332CD23912CF7145208230691DB848492ADD23F65368D6A030363D9D3C1A6B3D7033481A53B5CF2E8B3DBF239050C24151651CA67AAEF8D23C363232EEFB9C3F54D55B65FAB6A9B390E2334847CF150C85B653B9C6B51E41C368D09DDC9A4A129FA1193BD60E4209A0D8AC0483B9AF1FC95DCBAD275B83B755DF1A4786C46756F0335788A5997699098F269AF2DCF235A5C4141FBA91929181D051C0273BC0C0FC856153ED0D0767759DF1A478EC6BF66F478BED25E6956E9297DB429B4343E77AD0155212903EE454FF2E8B99CEF510843EE739EB0207A6EB3BDA9BF0D88F3DF32ECB6E422FB84C27D329823343A2EAB52FEE44EDD12335A45291B51E57E7345BAA033C889D673C69BF0D8D8CB9BE6C769EB846B4BEE2DB6D0DA7A2FAB4A7AA96D4AA43494D684E5E6F09EA451FD7D4713F1C5A15F922D21A82D73A5ED2A02876E83BE348F1D8DAB4A86EBA4BF4AC64D5B1A7DF91D292ACB9D4699C8E2A190EA742BA71FF5755D1F1C13DBF205EA9F6446A9DB5CF36978E2B77149394EC73C69BF1D8D6399BAEF1F9F15B5A9A5D9DF0FB3D134BF9574D9677484E52A0527A48184F5948A423E6AFB15C4BF65841A65430763A9FEC7105B29594D294554846AA1DB639E349F1D8DFECDF7AE57A98CDF298E8B9E1D24B4A5536D04741D6B5950C2BA11D3A97F4AE57465B5489F22455BB5FA4E24814D7F6BCB42554FB4842509D447C0DAE78535E3B11E5BA53BC88F63409170E92BB7400CD36C63A6F3634F4184E947D1342C8B263DA5A6CF15AF4851D4412290FA934FB9CC53634A7739E14DF8EC6FF66EBBCCE73B678FE9E1749CF946F009A651A13D475A0AA3F1BA3A32AFA57599E9633F25E7EACCFBEB91C5682A586C0A2D0A5A74701DB72FC29BF1D88F2DB7495E9A3D9227A893D334EA74AB6A192A28404F5D6C85538D148E2863E00C0FA5F9067DC1AB7B32130E237153B9490AA435D073C69AF1D8D9C2F6DD5DE6CBB1321B81D4929CA78A1B2A2D33A7E9B8D8557A7A08481F53F2346995625A4C5FA0E78D37E3B13E4365CA6A23B551886E3F30D730D732B995CCAE65050AD62B50AD42B50E2A6C1AE42283202BFC5FE48165AFC7CAB9BF417E34D78EC6FF006709321B8EDCEBABB2423BDADAE74E0851AE59AE5572AB975CBA28C50D06B4834AFE3C7359341445733E4395AC5039D9CE4737E82D694055CE1A695738896BDEE1E45F22102FB0F1EFF1757BFC6CBB7686D88B718F29C4A8286A0692A0AE8DFD614C4393E95EB75D7D42FAEBF0A6BC3627BD4DBAB31CB3125DCDC36DB7C4A9CE5BCB5027FA25397C96BAF5B2A95324A8A9C7175935A9582A27864D6B55265C84A13749496D77B772C5ED0422E71565B971DCA073C751A4B94140D3475CFA9128A5DAD69D759AD428902B58AE60A7E6331D2EDF22A02FF215E5CBE4C51953A449AE63944923A09252AE62C0C9A0B526A15D9F8E17F90B4298BE4458624B52070B9DD5B8A24DD653CE1F9351DC2D3E9394F597E34DF8EC4F97E42FA90DD2E5BEA471C562B4D6288C9D358AC563A0CBEB656C5E872A2C96A5238671483A5615F081A9D795A598470F1593449344E039748A90EDF061DBACA70294547862B158AC562B158AC562B145B345A22B966B4D60D6389A8F21C8E5BBECA4A5E9D25E49F9D910032BAEAED4D78EC4FC1B848F532B8049358EBE2B158E2CBCE326DB75E5258790FB67B53475B7A3FB08FE2D361B04848957B095489D21F570C569AC74DAC05712906B91452470C563A1658AB7A4EC5282681CF497E34D78EC5A8253C186F552BFAD1F4F1C60CF76254594DC96D4D21549184F09974663D4B9AF4A340569FA00915CD341E4D0503C17E3C55B8273567650D43D9205217A7A4BF1A6BC764AFF00ADC123097CFF002FAA47042948541BC14D7AD8F4E5D6222A6DE14E0A158FAC87714B7350E2AD894951B5598937F29F5D6356616C7FC29A5E9A073C090372FC69AF1D9281547A40CAA9E1FCFEB11B87DC3C23B2B90EB76070B6D58584D311596135753AAE161D3E9763E7E23B2149524A082456B5567253F0362BC69AEDB6F91436A41C293D9C4EA4FD756D1F5DA8CF3A9C712715FF00CAFC7EDCA636DD7FF61F8F83A38A96135E6A46025680B0FA12829055486C0DCBF1A6BC7627CA6C64CC8EFB4B61D61594D3ADE7EB9EDB076FA6CB2E3CB16173951E0B0C328425094C1612FBB022BB522C29A7EDB29AA2915688A991336DD57CCB858BFE9F071C39E19396DF212015A929091B95E34D76D83E4A0613F90C652E92B29A4A814D29AC950C1FA8ADA9FA7022AA5C88911A889E0A729B24AF8CEB6B32CCA86FC55DBAEEB4AA3486E42383CBE5B5DEADADF2A0F02D668342B969A711A7831D03DA9AEDB07C524E524022E708C478288A69C0A14A405538DE9FA6A3C1865C7D6FDAA4B46432B8EE50FA51585497E3B2861AE0E2A80CD369C6D75A43CDDCAD2E34B8725C88F5B2E29962AFAA02DF11B2EC9DEE0D2A601CEF3DA9AEDB53E352E3A64B32E3AE33C0E290F14D25E49AC8A284FD4B3450C45AB9411352F34A65DE03AE94952AD307D18D4786A3C107E37DCADA89695071876D57212EBF24772F58C6676F520288181D16BC76A7C785CE1096D2D1A788562B9878210025CF3EA13C07CD5BED2929EC385C60A65A1E696D39C01EB58A38764D7353AA8F10A3C14AC04F9ECBE42F50D34E2D8766C954A7EC6CB8DC7FA07B535E3B51E1C66A02253D6E790CEC43E451564F4B344F1B04224E28209AE59AE59AD26A74244B4498CEC65F1CD67A767679505F56A50EFC3989CF7E1AB15F2A2846375EEDFCCE0CA52867E935E3B077D97988A43BF8D2BF8CCB4C79352ECF258A524A7766B359AD559ACD676368538B85696131C0DD8A7A3A1D44DB12852DB5215C7359ACD66B359AD559E2DFEB58C29846554F2B4A2A3E74F01F14939DF7C85C8798B9ADA856A756FC2EB9ED4CF6D83BECBA8D502148545910A4A25334E32D38245923381EB03C9A369980AE1C845042CD118E8262C85D47B2CB74C184D43474A44566454AB0034FDB65B237A50A5535024BA19B23A49B7C7696839471907FB2994E9471477DCF36975A9D6C722B25DF6E4F5CF6A67B6C1DC76E24645CD80C4BB34EF4EBDC109A2C364AA2B2A02D30C28DB629A16A862BDBE26136E889A44665BFA2F408CF51B1C334E5818C7B13742C6D537678A9A4C18A9A4A4207057CA87C0A2F2414B89553C8D54DB3F3B50AE84A41917E3D73DA99EDB53DB65ED8E63356EB932A63EA4A9050512969A1DBA27E42860EEC6543B3CE64F043D40E47079DC14B8A1C53F2375F42E3CAB75C8C85FD06B70EDB08C8B9405B6E82525A24B59FA72DA57352CAD4A1DBA4E8F9DA7B5307FE3EC69CD3493A852FCD94EA5F06B7DC21A6634EB6F4191699464B1D767727C769F84A71CD6C619ACD03F4B9A8D7D374EF78242E3AF4A36B4AD2AA53229B4E94F06FBEFBC433298872151DE65D4BCD7599DC8F0DB3E52233115A2FC91D8A6B1C335AAB556AACF0CD67A32DF2083831D7ADAE8A8E01DF2D27524E0AF07724EA4EC477E85E2388F3AC323AA7B533DB6B3FAB65C6608ADBCE2DD5D8E07213C4A6B07A20EE7D7CB6E3B7CD7652021C42CA149394EF270147278E3869AD34EB6952143058734D286360F923E06C49C11B0D039E37A60BF062B9C9900E47559DCDFCA38CF9698ADC879721DB1DB82C7434D69AD35A6B4D11C01A0764D4952186F96875B4B8111CF3B89571CF03F358E18DC6A5363834F6496688C7065B217B91C15D9269748EFC14322535C99305C4AE1EC2E205731141C41AE6228106B58AD628AC5629B38AD42B50AD42B23825412D0750454C9098CC48794FBB67B6FA809000EB14F10AACEFD559E1A6B4D69AC70C560D138AD55AAB51AC9E24643AD96F832EA9149295D6067A083F0AEC3BD01B2FA929B84057C6B55731782E2C8CFD2CD4B775AEDD14CB90D369691F408AC1E39AC9AD55AAB3C74D01D0707F2DE69C8FF3414534C2F5A3A083F3BFF233FF0032DDFF0063426B426B426B969AE5A6B942B942B942B942B942B969AE5A6B426B426B426B969AD09AD02B48AD29AD09A9AA4B4CA1256AB7444C463E994D69358358AC562B4D69A03A4B4E7A45A490B4E8541E90EDBBF25400EC256995FF00CFA64E04974BEE5861879DFF000EE000745CF97220C35D141F8DDF9376858F53F4DF90DB3571787222B2643ECB6965BFF0E7B1E89EF1BF5745BF2DDF9301C98B9E7FD39BABD4D7E3B1B4ABFC4BA3A0B384537E3D1143B713C3F24712A91073EABE9CA78ADFB346664486DB4B69E86AEA77FAAA190460EE5F8D32308E923B6DBBBAA766DB3FECFD3BA45CC4B6A14ECDE89F8A41E92E91F59C1F1C71C314FF00EAA4F4DBDAEAB421C3A976A4FF005FD2797CB696FB8B559508F47C147159D99A0AA3F3491D25D0E0AEC0E281E24E2B3D62334B18343B9ED47B3FFA691DBA4DF7D97E7D4CC5A809D317E9485361B4DB8490C361A678115A6B4D69AD3C474D5DA87CD1E00F1577A49EB3BC13DCF6E0E8CB63E0A0E47491E5B3F207C392584EB7509D29E899EC82B9CD2419ED0A170463DC13467B593714E57706C5353D0AA99279F56FB9262A157B630F5EE3A43D7B46B72F8DA5D6EFACE117C8EA71DBEFF355F5A0972FA8D2BBDB5ABDF0E45F554DDF1BE5B5798FC837D4F2C5F505D37D6F96E5EE3847BF26BDFA9ABE8A17E4E557B4F33DF7149BEA792DDED2526F6ED48BC32D945F13CAF7A8E53EF4CE966F672DDF11CB4DF59D4BBE470137EA5DF51CB55F5B096EFC6BDF4E05F935EFC9D6F5ED842E3DED0A29BE346937B60A9778605397869057796B0E5DDA4D7BCB15EF0C92A9C8E61BBB6849BD269CBBC64D2AF7F28BD24962F0DAD5EEB17422F2D149BD02A76F0D250BBC3011EF8728BEA7522FAC1A72FC28DF12A5A8EA315E4B07DC1BCFB89CAAE0804CF406FDC118F706EBDC1142E1FC7DC1BA3714D26DD24816D918F6D9194DB241A36C934AB6C914BB6C84D7B648A45A9F349B53D4DDB1F557B4BD936A7F29B5BE49B53D936A7E85A9FAF6C9346D4EE936B919F6B9146D4FE0DAE452ED4F026D4F57B5BF5ED2ED1B4BD81697728B538A0BB53C00B6C9C7B5C8D7ED6FD0B5C8AF6B9142DD24D7B6C8A36C934BB5BE28DB2401ED6FF2C5B6492BB5BE902D920D7B649AF6B915ED9270AB64814AB5C815ED92326D92051B74915EDF274A20495526DD20D7B6C9A5DBE4A6936F92AAF41271E824E7DBA4E7DBA46910649AF6D935E824D7B7C9AF43268C57C1F45273E864E510A42E84093460C807D0C9AF47232A81252150E425B4C1926BD149C7A4914A8CF26BD33DAFD1C8AF4722BD2BF95467935E99EC18EF0AF492057A2915E9DE0AD6757F2CA41556835A159D0AC84955685568556856742AB96AAD0AAD0AAD24D6935A155A555A0D6935A0D6935A4D6935835A4D6935A4D6935A4D14915A4D60D6935835A4D60D60D6935A4D6935A4D6935835835A4D60D6935835A4D6935A4D6935835A4D6935A4D6935835A4D049AC56938D26B49AC1AD26B06B06B1C706B49AC1A009AC560D6935A4D62B06B07860F0F9E1A4F1C1FF007C3FFE237FFFC400281100010304020104030101010000000000010002110310122030312113404150042251321480FFDA0008010301013F0146EEEBEB8F5F566E7AFAE3D7D59BBBAFAB373D7D59B9EAE4C20F59A9F725C8BD17940C9531C06E7ABBAF2507A0E953ED0BD06B9E9CC6B3BED4CDD83E780DCF5729EDD69F9308B08F625D0835CF4CA2076AA540C0899F28094D600AA37E53380DCE9D8444694CC3AC5B28B639899F01328FCBACF7E2113919366363CD9FD267686E6E746AA8DF1AD2A9220DDD4FF9A4A9592C82C9656941A5E9AC0DB39D8894E76466CC6CDCA621C474167883A52A53E4E8E6CAC4AC1C57A27FABD0FE95E805E8357A0D46805E81F829B48FCA02F56A666CD1250117299DF19EB43E2CE6CA222D4D999E53AD77FC0BD31F3A1E93380DCE8537AB39B36FC7EFD8BDD88953361E5011A3BA4CE0373A8ED54FE842A78B35D8994D703D7B0AEF9317A7DA2F0135F37A9D2673B8C04D74A71FD74A75304C7642799EEC44EAD125017AA9BC07729D1A8129A2046C4C2FFA0263F313B57FF1B07109AECACFF2E4380DCEAE3AD012ED9EF0D4F797F76A4FC4EDF907C46E0C2F5026F683AE208C57A253C06F817373A38EDF8FF3ABEBC7F94493DE94AA4783AD5764EE16840598CC954A2E27F54D2E6B3F6EF4373A3CED41DE62EE706F6AA56CBC0DE955C7C14D78774A554ADE207135A85B33109B508ED54703A142C743DECD389943F2027D7FE2738BBBE1048E91793DF1B3AE1372A517A9F0A142850A1428E3850A142850A142851A0309A6780A1771E3851B472C5D9C050B1FA21DA1667FA5529FC8D4A162888F791AB3BBD36F9943F208779E90C5C32551C0F57285DE3DD4DC39782888B32CC89F2BD46AC5AF0AA1F38E850B94E1CB3C6760EFEA7353068C76253DD919D0E86C4471CF236978F368D5AEF84070943570B4F04EB2A77F57C42A6322AAF5B35C819E03BBC71B68B9C276953A329CF68B31F2D4E717768027A4E616F7AB4F01DCF1B6B1023882167D39F21527007CAA8EC8EAD74701436718E2ED3316FEBF2AB53C0F1527CF83628EED3237286A4C226789A7132B233927BCBFBE36D523B4EAB3C0C28050B158AC777A719FA16F699D71D477D137B54F889844C9FA26F699D7138FD1B026F5AC85216414845C9F2A0AC4AC4A82B12B12B12B12B12B12B12B12B12A0A82A0A85056256256254150A0A82A0A82A0A82A1415895895894D10B20B20A42C82C85BC2F16F1A78F611EC22D0A2D1FF0090FF00FFC4002C110001030206010304030101000000000001000211031310122021303104404151142232504261805271FFDA0008010201013F01FF00050692AD9509CDCBCCC6E62AC856423451A647A60250A4536980A142CA027B0B8F3511A21160468FC22D23D13697CA0D4FA8D620F7543B2023179DB647968F481D355D944A6D56BB629D4BE1111CCD69726B004EA81A9F5CBBA54E99794D000818174A69453C41E5A2BDD033A2B096E0CA85A9AF6D44FA79791B4E7B5B342A95FE1132A9B0BCEC9ADCA2060E380ED1557BE5A3DA29A74D6A794C8C69D6F6727D3F76E01A4AB45595682B4D5682B21594DA50774E786A7D42EC1ADCC60263034460E31A0AABDF2D330E47069D15AB7F11A18FCA8967655E60E97D47F4AF957DC8D772FA8726F90EF757FF00A46B7C22671A34F28DF0261133A0AA9DF2843718030819C2B3F20477C5B83B0189380C09C7C7A7FC8E2F3EDA4AA9F973523B23803187923AD034370271089C58DCC61011AC229FDF35330514D5970A8DCC2116C620A271054F078EC812717A011118B7B4E479A9B7315950EF455A59D3D990C7331B98C21B683B686AA86073D212501A5C604A73B319D404AFA629ECC863550FCF510888C1BD2AC7DB19131C94BA434F9061B1A98C2F2994C33AC2B3330D5E30DF595970AAD3DE2ECF4EA1705F5AD8FED78EF7D425CEEB8A88DF5795EDA69F8F3BB90681D68AD4A771A68B32B784AA8F9DB0ADE40A7FFABC7F2E90196A0ED3994EB56FB06C80CBB0E102531B1ABC96FBE21A4F4A951CBB9D7568E6DC2734B7BC2950332789CE84F749DB0FA764E62AB78AD23EDED78945D4E4BB8A937DF5B9B98423E3B933C7FF00A4D606F5C25A0F68536B7AE3AA36E502532947784A952A54A953C72A54A952A54A952A741DD556E5EB929881C93A654FA0AC77C090373C239E54A9F44FEF0F244D32BC6F2329CAE532A7504D323F42554FCB0F2AA80328ED3BC00EA432F69C2A5376495E351737EE7EBA4F8DBD6C6829FDAF233E5FB10F12A1DD0AB57C772F169822E1EF869BF372C718D50814F3B68F228DC6EDDAA14EDB238418286FE9CBF590AA9DB846AA464611C11CB9374E30137BD4E6CAAAD83C035533050E3CC38CBD669ED01089840CE9AADDB806BA6E2EE32C1C4716B9384A688D242A8D83CA04AA6CCBC664EE9A6789C311ADED911CB4E9C71951EC808E32C59381C9C20E30A35D26FBA1FA12AAF7C41B29ADFD1155BBE26F487E88AADDF084C1023F4653CC9D390AC85642B23936999414A952A54E32A54A952A54E12A54A952A54A95384E12A70952A7072C8E2B21590AC8E591CAEB95C72B8E571CAEB95C72BAE575CAEB95D72BAE571CAE395C72BAE42AB95D72B8E575CAEB95D72BAE575C8552AE9575CAE9574ABA55D2AE9574ABA55D2AF2BC7E15D3F0AF1F8578FC2BA55D2AF1574ABA55D2AF1FF21FFFC400421000010204020706040503010705000000010002031121311220102230404151611323327181910433425250606292A17282B1142434435363C1D170A0A2E1F1FFDA0008010100063F02D2331F2FCAA33CF97E5519DDF9547E5C19EFF9547E5C19C7E551F9707E5C19C4FF002A8CE3F2A8CE3F1F38E2344B99540F21776C6B7F94016C9B2F1719E82E7193454950C3096C22E961E9BBD7312782D484F3E664B598F69F75F58FED47BDB7144C278701754FC42711E1A3AA220327D5CB11887C829BAA56A31C7C82C50E11975A2ED3E26448F0806DA220A12FD50132B6DC067199B018260996358A2426E2E764EC2F8839744E94461A53AA0E8909C02A1548AE1E4BBC9441D5779DDBBF0CF1637726AD40C68F29A2F8866E2A4C6971E89862C40DE607041D22F3FA948506484309C23EA5DB0A31BFCA6870C4E3C0704D89220384EBBAB72C63396A9AAF879FDD97BC84DFF0A70BBA774B2D518FCB41C115DFE54BE20631CC5D6A3FDE9F839008745E0D527993790545DF830DB2BA9E0C5FD455001E4149814DC66E3970C4136AE4D09CF74B034D7CB92A6DC666E58987D7C940265E2E3B0731F0DB275E49DD8C470770C564ED52E863EB968D474C7DA6CB0C5021BB85687F03C715D20B0C11D98E278A90A929862B835844CF31D10ECA1B411C78AADD725D575CF8A13F0D647AA188CA1BAFB719C658BEEA176BE19AAECBBC6EB7DC2EB1427F69D2555221776F32E46CA4351DC9DC7F002D81AEFE7C1628AEC454A1B0CB8B8D82EEDBAFF71BA90ABB92E5E5A24175CD5D1171CE42B4D0D3C6427BAD72C6C5394B86887FD236927B43BCD17401367DA382A8210AE302C1C9BAC1AF3F493BE6288E905820CD8CE3D56182C2E3D107FC5D4FD8161E3C826CE8DE8A9A24152FB17B5CDC408B73D0F649B26FBEEA27963FF4E8676666D950EDB0C4130B14325EDE34D12886708DFA2C4C7070E9BCE288E0397558E27A0E4B1138610B941AC93181618141CF9AC4FC9D766F8709B203ACD4503CF756F9E58AD6DCB4E885EBFE7448EDB5DB5E62EA4F14E0562867D39A90D589F69DDCB2089BBEE4278A23CAC7F1829C19FF0095D9B1B61EC8B975C9337DA462D76213BA7DE5879EE032B733D95D532AA2D3F43A9B3915D32E17004754E89029FA102D3221067C4483B83B63DE44683CB8AA31E56AC177A95F27F947141F2915F2992F35AF069FA4A1363C73471636FA269ED995EA849C0CEDA3B3827BDE7C96087571A925768ED689F722D8541CD12E9A96499BE5EBB0896E165870CFB4D5F2DD5B9A30EAA20C4278A61B3D35D8CB3E28726C4FF28B5E24E0876D0CE2E6D41EC3369D05D11C1A0735DCB0BBA9526E16CC5C227B535527468847F52C0C6973CF044F6587FA8DD174DB8FEC4351BFB97FC31EABE6C347C14EB752EC4F9F044F656EAA4E690502D3223885A911DEA98D713AEEA9152BB3F8760C6B58FA29BB2E236DB462093595533B3F532B0DB0CEDF3CCDA0AB7DD0320716AD786D799CF22D1E6B98E6BBB34E45774033F95F54479F55ACD6C31FA8AD6F88AF46AAE227FAD126510FEBAA716364E754D2EACE546B8AB394DA0AF0AB2E2BC4079AC336B9623087F6D10C25EC6F1AA3FE9E6E8A44B11365D556A72C94865E9B17863A73D63D13F010197775E9B80CA27998FE2D7680798D9E11B1D60BBAB72283BE221879E454A0C2643E140AFA27980CDAA485573BDD4866905D72CB65124E2FD63AC78A8DE4370A656E68AC6991234309FA49192B9BAEC3A64190372E23909C9754CD337DB0448BC9126E9D1FEA2708E9B80CA33C56B41003A934FF008622A7581CB5CA73996499B6C65940C94CDD06E0F89F689A24F151456E3701B464600C889129B130E2E12CD2D27612E192590D6597AE7A679052DC2300654D0E35ABB70195B9DEDFA8546864CCDECD53B1233F969C5B1C473497454CF8B712193BD65CB4439CB75036065E17EB293A58226A9278661A683652CB41A666DB79296E2C82D3E3F1792005494C65F0896E032B46C29488DB68D7976ADBCB257210BA669EC6A5506E188EC6BB1850BED1329A27255DC06512D85139DF43F5977864C7096C64A477E9290DCA43E9680993B375B766F9EC5D0DE26D705D97664BBA26B5E66E014F6155D77DC5CB722E36154F892962334F74AA5D29EEC25B0732006C9B4994DC50A6EFAAA99145F972D993BEBB676CEF00F8886E886CE3299DC4656F9EC1F0E0B835D2C4E24D269A757B235C77042C30DA1ADE4365D4EDACACA724308DFA6A133082E33974509839CF3576832CF3EAFCC751A8D6F74D101EF686DDD3F08D9F96D66EC92DA8DCB0FDAD01077DA2798A91D3440ED1B3B673846BB6A25C5626CA7D44D1C3F0E2134711C4ECCED26ECD3E2A476606DE9A5FF11763A4BB78864E7DBCB301CD5553474D80CADA4F60190983B4FAA4A1B2404870D91D9D975D80446C7CB7330833B670F60537B47F84CC484943315C5CE709D725563360AA14D7454CC738F3CEF8929E109F162D5CDD6F5DD66ED9D05763D7732E8D1873A263DEE2F70AF4CD425735D36432B73984C3DD34FB94CFB9DACED99D85175DAD299E7C37371691DA9B05DEC4739602F2E87733C9D345364738CD4F98EA0589F3C0CAFAED6C735681537012193595373A99EA84C8CDD4696F870A221CEB7273D55760738399D270734504935C2F1358ED67CB2CCDF74BEED0DF2F136E8B47881AEF03296E2EF5C2806886D609343465B64BABABE93D744FF0C8787161157725144B56553B89CEDE1A71457003FCA2C6F770FA5CE88608981AC74DF454ABAA9017CD67BAA3DA55C66E8AB9BB39EB6E3AEE0DF32ABF10CF4AA644318617594B1BBF6A3578FED55ED07F6A9618B2E72435222F9C1C653D5AAC109DADD429B4CC232229D55083E5B1ECC4786D22A5A5D74224B1744D851187B43C5B6DC0E71A30B7BD7FE93446254CFEB7597FB67C4CDFF68A26B7E0E1B9AE06E45C27B9B083DE69326C8E12C6790B2FF788BFB94DDF1117F72D67B8F0A9572BC47DD5493A2E50D634B5506B62B8342C1DA791E2B521B00EB55DFB08773164EEF40973A4D6A46867D5534DD5744FF568C2C91D1867AD92BA6719E1A860C4F3C805DDC06CBA95AA58C1C8043B58869CA8BC6EE575524EC4169208E21483DD29CEEAE50C2E2256AAC275C7EAE0876705E7CCC96B97433D429C17878E9A70C2C2F8BCB92C42216746D14F431EDBB4A079EDCE7099098F03178871D01862B830096106436153B46B98E342BBF693127F4AC508CF9F4C80F544A1337374E737929F4D3328F79888E002EEA0FEE288C787FA429B8927AED6DA38E771872D6184CC238B03CF322CA512338855C90B150621C27BC3A24A42C06F07B27B993E4BB3F88991C1DFF958E119B51D00AC3D561E0BAA9B8803AA97C3B310E6E44BA2103ED6D06E13392AAEABB31141C2C86673CB554D91CE5CEF08BE999B232BEEE43645A79AC50CFA1BA34AA90D326F78FE41778ED5FB45B73BE533D9B4B3EBA93CF282BA6C8E78B3FB7480A5BC62612D7730B0FC54DC381011EF9A2579D11EF317F48583E18601F71BEF35B2B6C24D049E413637C58D5FF967FEE83583C2D00A94E72767AE9AE639E206D491F8F8870C4DC985D1035C7C5D10C6F7BEB5E080850DAD971E3A23DFC5C53A5E2C55CB2589CA5A2F9CEC0470EF986A3F17C50E1B8B79E59E831E38C2F224D6F219635EEA29E13CC0055520A99CE713580D3883C93A1BC49CD55D131F8806C269712BE6B7B4E5C02C0D60B55DC4A0D60934582ED4335A52E816BC1672A0929C08B2E8E5AD0491FA6BA1AD7C4C12D61D7347339EB495BEAD321A6EA47453399EC004C8EC130D1272A64AFE1A21B6D771E411105B29DEB7D34CB88CD8FF00B9A8E26BA4D3478583E29D89A64311FA56282F0E1A5EE26521353509A6F299C95AE8A6E40A91B2FF00A6EF095457AE8AAE9BA86426E2256AB7B41CDAB0451276E8D84CBBBF84190C000699672C8826D3C139FF000EDC50AF2176AC70FC883C516B861883F9D1106200BB9F150D8DE2761D3711A0C37FBF2461BFFF00DD1D34927746BFEB89AC74375B0B9B64E86F1270DC835A264A2F79EF5C247A6596C0B9BAB1A543CFCD566C88D3EC8438948C07BA870BED188A9F269D857711A6948ADF09441B8C97D16AA3B7A26458E673AE15216D3CA28B39163C488DC4C475A1D479E8967EA865ED618EF59FC841EC385ED5DA3A9D1173ECFAB46F232466D641C508AD18D844CCBE9F3CBAD5DC0FC4BDB4146E4A68D6A3C59C8B6234F9F03B8339BF58A9701925354C9D7376DF0F0F5FEB971D0C6B3C205378ADB2BA381DDBAFE6A333949121B81FCDA8B9A3B467E9BAD6046E0190DA5CE3C0283DBC26F6ADA933E3B02D789B4F028BBE14CC7D8561782D775DB37CB8A2A66C34753A2B6D9F6B0D9282EE5CD76604E236C784907C433762227B81DA45F74D8AD13970E684465398E5A24F86D3E8BBB9C37745DD3DAFF3A2F95FCAD682FF006546B8FA2AEC3560C43FDA8636886DE6E52842BC5C6E767DF436B94FE1A24BF4BD4DF04CB98AEC355A4F90536C274BAD177CF6B474AA12C4E7379940EE2E86F136B848A258EED185C142F8487AD15C43A21DC0ED083629CD6893382ECE210211ADB8E7B29986D27C948C364BC94FB11EABE443F65F21AA5FE9E1FB2A7C3C3F65A90983D371D782CF3024BC2F1FDC8E189117CE7FB2AC67FB2D6C4FF32A9019ECA4D000E9A4A1A6EA8A6EDB764EB6297A6E4730CAD78BB744263DCD63E5865BAE16DF9AD633086CE5B1C22DA403654D326ABEC9B1A14DBDA0A9421461DE1FA86E273532C8D4288F84CEEAEA62E1309B903742E0260A9613BA0F2CB5B298D0574D900EA16D5A8570BC59C110FF0098CBF5DC0E61989265D50C756CEB24D02C06EA5B3A8DA4B3EAD938137B0CDE7A28A5B318258D954D7B6D3A8E69AF6784EDCE61989755C681BCD43863EA3BA9633D4E807729CA9640A9B3303B6706F85DAC13A038FEA6EDCE66F965E711DE158A23B13B995DB45F98E141C86E85CAB6B95AA2881081DCA4A44EAAE9929B7760F137594388672699D14C6D8E6193FEA1B046244355FEA238A4F507FDF7568689D501C78AD65223572532D76589B21A035F50B56A15740276F2E0A243FB5D250483F48196AE6FBAF1B7DD51C1789BEEA846CDA499053C625A1D10D65608C489729B1E29EEC1F0CAEA42DF85C95744A74EAA62AA72AEE2F24481B22DF55E277BA96374BCD4B13BDF7490F08419F4DDC5063049A2C3F0ED4B68A1210DC594FA161E042B2B2B69BABE6B2B2B2B2B2B2B2B2B23F71A041ADB9A20D00633E33CCFE212442772DC613E466E129A872E34DD666CB11F40BB68835196F3FC22DB2779AF3DC6056B5A264C4F74D735E4835A7C7FE132136EE4D6431268B7E2450DC609E388A64B9EE8FC5A22C578A8D51F854F604E81E5B8C360F13055325BA44AEADA5D11310F86A18B0B0487E172CE7437CB717F681A1CDD5D55E9BA438AC1333389426349133523F1376E4E7721344CE73AD538CB8DF7373F9040B9E4C9438A18D0F74E67D7F137681B80C3679C2743773EF7C25177C23CB9A257E698C1F4897E1A333868079EE021B1E64D1AC384D344A7CD068B0D95265094DD3E484838AAB4AF09540E5461210C20B91C7AA9B2120132161D59EB391C2D797705DD87C43ECA1884D98FA89E09C1ACC4C167735DE31E0F4AA939AF637EE29C21C2D5E049430C3793FE10C108CF8CF82D586E23D91EE29E687723F7225EC38B8342698AE945955A1A50942D7E2269A3B32D87C49AAA42763E5C112C0F73B94A4BE41FDCBE47FF0025DEC123FA4AAC132F3430C2D4E24A1283FCA25D0BBC9D0029FDAB24E96A86F14250D839AC30E5129398B2D76779D2CA65AFBCBFFB51486998F003F527768C68007B944BE1EB52838AD686F03DD6A32238FB2D681ECE4DC308977113B26E1844922B5B23DAC1FDA552089CF9AAC13E850EE0E1F3AA9436BA20E764FED860E5C50C50C8A19A939AE0CE051C2D885776D2FA7926C9A7F50E4B55AE721AB13D90181F2E253A435381E69A21B1CEA71A26F75E755AB8DFE8B560D3A95AF0A43A15DF3700E1C54F13A7CB0AD76381E4100C8721CDC537034BDC44F94912D0E2FE5292A401FB96BC290973471437B7F95DDC0FDC500D6616CAAE7224DCD51387139785CBE58979A32131CD0329BF921AA7AA34723AA7A75556566BC2E424C2A7807A95E11EEBC23DD5708F55669F5546B4FAAA343BC8A3E1F7BAAE06FAA389CC0B5B0B578D92E6A85A42332D68EBC551CC3EAA861FBAAB98159BEEA789B8B9232C27ACD7D1EEA8584F29AFA3DD6A163879A3273536ADAFF0A8F62A3D8AAF6494F1B47985AAE6BBA2F00F752D59739AFA3DD5700F55667EE5E01EEBC23DD59A7FB9370E174FF84EA34CBADD4E6DC5F6A96103D5530BBA047C225D6EACDFDCBE9F7530D07D559A7C8A1E13EAACDF75669F547BB9CBAA9F67FCAF972F3A2AB25E68EA0F75F2E7E457CBFE54FB32BE515E0F59A2705B84EEBE5397807BAF946F25F2FF0095F29CA5D93FD901D8BEB544764E5484479D17CA52ECC9E345F29CA5D8BFD94FB227C907982FC3E4BE53BD57C9721DCBFD95613FD96110DD3F25F25FECBE4BD4BB272D686E1E8A7D93FD9561BFD97C97FB2F92F52EC9F3F252C266BC0558AA294959515959595B45B459595959595959595B459595959595B459595B4595959595959595959595959595959595959595959595959595B45959595959595B25959595B4D95B2DB25BFF00442FFF00B1F3FFC4002C1001000202010303040105010101000000010011213141205161103071408191A1B150C1D1E1F060F1A0FFDA0008010100013F21F46D0E27EC75773FF953D20B3F3D56AE03FF002BE29A75F7EAECB15BFF00CB0C871D431F8FFCB05D95D55CD03583BFFE5445297AEA4D02B5FF0096190EAA315DE3E3FF002C6BBEAAEEE6B1FF0095D74F43474E426528FF00CB06CF9EAABF13FF002BA41BEA3786F7FF0096069B9A1D37C3E7FAF87DC6E08B4166C2AD98D26F6E52C1F05A5FD8ED15826A512ABD8101BA00E7CBCFD01C1F435D201DB47CF50A8A02B0B5F2611A372EB02FB44055BB3A4370072083F1DE28C1A5DA00B4278FEA0A8D3BA16C163FC5100B9C250456CAE55DC0EC7F2B1927DFB3E2E523AA6D2DE6105E055CF3CFDA3B80C97CE3E83F07A1AE9ECEFF00B79EAE42B562FC7796B6A6997EA34AD75B13FCA640A5B14B76F11633E4CD7CD6A5E2C629A652622B81A8851FB33F99B32C0A727E7FA5AD6F0106D7B95C5ED4703F922C7DE5849C5A0170DB3F26B7C2E3603D0ECFC4A340E0E866FA5EC5ED2E838CB5BF6976DCF4B1DE01D540DABDEFE5F4B5677D3A15DB5D3C2BFC4C4021A57A1504C84E42DFA976FC42DFDB89A1EA5AA03ED72C1931AFBCC33580DBC3E629F6E6098A3BED9BF7379FE8D46C1FFD3B408FB171F980A8055D04E7F30117F12F36FE43F112D78BAA348CB897E407A19B6786A2BED13E0094F7ADC8038F2B800000341EF2D7BCFDE9CF4FC033D2431BA32D5B3070260DAB6543CEFAAA3D135D14DF78D1C1990FEF03B68061515AAECEA5B529AB6E2DF96DFF0002192CC9FD09F10FF2F80E65FAA725AFBF10202EA032ACA3DC12FF00DC8177252FF298C5F0235868704A082C09B72F7E3AF828F068C230E25CFC4358F7D1B8ACBD2D2AE7A74FBA0DBB329CEADF05DBC7EEA265941BF610DDF306BAF530C5A78BDEB0D721ECC29F9597DA5EB786AFC3BFF40A90E2E1F3E65CBFE83E080FB605077956DA0A73FCBC7DA7DB94E27215EDE872C8CF31ED95EA789966C1953594564A2086BE47A1ADB2153035AF79E24E61A4E90C2D9474ED83BAAB7820B90A272456CEFF00B12DA727B2C453822B1CF64BAACF9218E76B2566279534B50F88B3AFEE5FD63731FEFE25547097727FB4AB8D97B20A402DD98FBB1F361F625E190050F97D1882D6630F27A3006FA2CA7696E3C191A46A9A94955D9B5F7F78E0F69B4CC3D3A25E31D356B0DADF44F538EE4A961AF6452F09EB533C1E218FBA41E673E6106B36CBE441CA3CAFA94B8035797623F62EA8343B115D9B5C8F82075E637F3DD82110ECCC7322F7CB35AF405682D9B4DF70F5A6AC676F450D544B2282AF779973F6F89895A13EF6BF4CCF4BADBF0E9E378A13BB1FF67A22FB20EDD3BE9D07F671BE0FC6908FCE5A868768BFF03CFD3893662DA1F10D92741B5862A6F6E5FF009C47682E0AC1D8466576F043EF777A82A894EACFF5D0EA2F8BA75FA7FC5A2A9AA10BBA067939F7961F3E9FADD246FEFD2E651DB3829962D542AEF9F4377ECF0701349B6BA5E2DEC1708C082DFF000FF117A3AC4D8C006AC0E07E7B7B26B52EEBFC21E815EF1AEF32AE76A61CC671591D29A9B1F12D2D68C31FED8CDD9EC6BFCC229A7BDAE0B4388E5F738842AA5D1D9E94F71BA5D7FCCAFBB8183CAC36959BFF00010D0BF16DCC3079798243474633CB5F12BA3107535FA55CEEE7880295190FCBDE387A3A5AE9BB79EAD959BE5BDE615F65CC028B6BD75963D928A84FCF5350D8F1F296503925405A598814F513D0A215AC329E51A3F11596328C9E480981A1AD5768AD0365B30823342D66821C00C50DAFA2DAFDF53482DAC8C4AEB477652308F6CC68759A8E70A0BE6A89FB4773D341BBED108A61B2294D24A4892FC256460D704C1CB15762CB79FCB2D2EE6CE04A5369A3A6CD186881D17EC556DEAD7E860A33787F69517E6B1C9EF5EAF4344F1D3FA6EA0180A726FE5304FCB6AA299E8D477EC2A232E8EBACCD58EF9DFF00EA91343BB6958CC29FDF69603C7654AD507C9F8270AEED3FCC041F78C6334EEC7E096BA8C19AF33063E1A847EE9820DFE182E89EF2FB61F30DE7707720F30E6F90A9B27335B80857CA8FD88A99C232BED57A9622DC23594332B372A5E98D5B5CB000283A1163A8AFAD8987795026277BC40503A5E706BDE6BF4E474815566FE7A8C4FF0001829937C457B543FAF5758F619ECB7D67755AE09CDB280091725FC08A13F262A6A20CAA6A2855E5932B2E9456ABCF405B46E7857A15A3B105302C52D4F0C0A947952A6411ACBDFA50363068E5B61EE037300B8978E1F33FE3ED1E1CE7E0E7DEFE786CBD463D8E917F3F559C073E962AB62F6BE8A8A8BBE92FD022DD9DF5DA5386A0E73A8EE730513C1D09FB3A5ED0F8E8BB788A4AEDF5C661DE0D7D5C1D9FEA5742A158F27B07F244BA512517189B4DAB1A59560D0FA01DF48437E7AB71DA501B5439919B9BC6BA51BB10D7AB159E7ADABDAA3EB8030FE7A6D1E38E8AA1F77C428A35D14770FAE338E609468EACB303A7107B3AA0A5A7FC48DBD256239D04F1FF00DFA0CD74C25740E33D6E227809E27039792B78832E906BD5FA1EC2D07CBD42A8DC001C742A4E0DC7D7707BAB7D26C359BDFA5FADBE20526F97A98F6304074EA3B7ECE99C8A971C0FA77DDFC1EF77FD1F1574810757D754D727DCF4C01E636F8BFB7A05EBD55AC942BE9A4AA9BA7AEDFECF5B6CD1AE9619DEFA2D701AEACE14F88970B2BCC212D9E7AC695BD1D58CE5F6AEBF680CAC523867F1E8462B741DAFDE5A777D3571D34672D435D4E4A750D37D0C73C904A815A57CA61B0F922A61A4C4C53E828BD4CF66D7AFF83D1283072CAA1A3A7BDA38F4474D7F2878F791836C301A3A9DAF1ED6CC40465EC734FF00705B51404CE3836AAF797A793DBA7E4AF600EE595BFC7A2AAEE51158E1F4C6BC4E0EE53683D7CC0465E473D58B213C2BB81419F3D7555B99A437BFA0C687821D2CB452784213BA3E162CE0A3AD0002ECBE744C4BBBB65E9CBDEFE6F4C7A4E4B77C7B0902D17B0181788E9B553579E27C47F975A52DFD784431CB04B410F62ED8AB3D46509524EE0933CEE009BB19F1AFDFBFFCFE8C4D5FBA14054C0E8126610B47443CC02800A157375AF603A30BD15AFD6D8ADED08B3A7ACD91C5A1B3E08EB84F53884A6FBD0031EF8BC7D3574DBBAB3D87C66B0B97F31B9FD850F15092ACC6DB43D8CC1451EC5CECC71F5BFB5ED06C5C5B846D84AAE8362E60C1F9839F4B88FE41CFBFBFAE300E47B16428C0BB39E226AB816F8037984C034141ED5FD2683DEA8A74F300E4F799145C501573F3EED09EEFBB66074A5C27495C719A8DCE2E6AE8331E97E9545763DB0574CC622B07ABE40F83CC08C9C72DCD5513549BFCC347B580E057BA23CDC40F5BBB55CC61AF715FBA30720F40B828CBF175FDE2581A7FBB8EBD706C7A286E0E19B3C8074D6F7E9DFE94139BAD108AD42DF09C60AB18FC31CAAD1A6B9A8F6B48ADF77DB32D128FD643A71CD3894869F6B6D4A7383DE4BDCC33435FB7A39694379310128941C570FCCC75F4D9CE8AEF2D3088DA31FF00BD0500E3A6D6F4BE4E9C53935EC1AA9BBC2D747CCB914635A2F9F6AB96EAB8F6F5543BB32467ACC6AD477678A1F6722EB287D112F5DB6E27F30E021C1466FBF2BB73D06DAA854820D5D2AC515A08FF00B90006075723D32FBBA4599BA75F74C2AEAE1AC9138C5DFF00AA1ED6FBD46AF1AF611505B0E9B7B40F68ED7BBC4AAF637DB65FA249ADCCEF4AABB7E59AD94B9B028A3D43C9DA2A2B983500F98965FBA50A5D0C4A539E7AF74653174BA4C61E7ADC93B22040AC79BBBC7E3DB143C471BEB77060E4DB6FB9529B61DB98154F567A610FA2D5103B57CD4A6C05ED98FC8EF576F8E8ECCEE9BE2E2FB222CFA68F662B19B7A459D5E75D4298B85EDDD8151B6F3C061EDE90A900EEF3D58A18035EFD0B56202312B7E99ED2EC28FCC300507D13161A85056897FE76A4FF00BCCB1E3F31D644019CFC7B0ABD21D3060D3D56ECA02C545E2D3FB010F730D15844D9EB4D4A9C55FA220EC82F695B328680D6BE9195854C9DE91965B763BEBE876FA6BCF54C0035D1478D0DE3CBE27F3319D0099D4F8665E25EB45CBF625FB227344A1B88B4B3C689EC4F0A58C60E3BAD8E4A2BFB438B35C4AFE96ED937B0E0FE6103745EC3C7D1EFE5E923634BDFAAEE3A39F810291F85F9182EF50F22E0F8FF007510D57CC39A5BFF0088ABDE2507197AF317565BED29D99E7116AC3D8C194C1BA6128393CCDFA0AAB88136316DCF1466C3131EE1EAF4203ECFE82F5E65F86EE44DDBF97F6412DB7CB1E388DBD12EE1E1A9A3258AB5AED9CFE22DFC5C182B1DA862738257F57CC7AF6B7545FC4A90EE10CA3E55A41AFE717ECD9D661C9EDFEA65C8A46F573223DAFA019F5872B57E94BF05E0A3D963500DB08CE8FF000420B8B2A7F02D99513B897960916D2952144175BFEE604D975DED19A0BBCC8E18F296B8ED3B9F926861ED69C5E776189A82835980E1957930C75E8A031AE4D5A6151E2B1E69955F973FE50FA8E8960B028B558C0D83F0FA5BDE07CA649471280A229F4A5F46EFBF68382E0E89A175E94EF05D3368A8D7B9E2678E0076FDA3D5B7615F763F07E5AC66D83FFAD9934ECC1F898AB8F935DA0E08342DD7454AE8CB9984A480A48A01D0F7F9818800EF3B8F25B82951DAF10ABDB2D73F98D51F9ABFCA59BB5AEFD91A8645CB8A12DA2DDCEF3539D0B48944DAE57BFA519544BD4AE11A5D9CFD0A6B5EDD374C2DB20FC2E9399C7DBD03050D603C1155B77E95E25A5F9F41360A5BCCF94BF8979794F595454D5E183BDA98145711CD7181595EA20D31C7E205B95528BDDFEE8F455308AE0BCAE73189B46032506D9F2EC2CFC4ACDD59757E251587C099EF13F7695FA54BCBC27CE525253D42D8A82ABA5E2592E8946C870BF4AC329F414D5EBB477CBB43103427543F48F9D72975CC4AB4AF75E80D7B47FB5CCFD7BFB7AD54B69F12AED663783D7583F6803DDA944A768CDBB4AFB7A2EB8295D4CCB770169BB7BA04BBB5749FCCFD6F4F2A19B826BF0B82D5652B1282656D8E0036AA0884E5DF07E08ECB6928979B66D85A520095ED22AD56A59677E3D49A188EDF8C6506BD2913129CF5D7601773D8E93600DFB85E3E7A747A2FC3A36C8ECE7E8D2E3DB12BD330CC532AF88589952E29F696C73F2412D04A3B17E971F36E0F966A45ECD4F4460257BFA450E79C8B20C2377E8C1A983A38F537C209CAE44A7FD3A687EC47C2A0475ECAAF8BD2F6ED7D356A596F4330882808AF68FA5733B3E86C2392985B48ADB1F3052FC39D8FB3298261795B8F52A67F81DA5B05B007D3220C811EAA05F46DD01D8DA02D60A3370917FE712E807B63C01F1322690A5D1D3FC9E838480B3D3680864B3A4DFC5D69F78409A65415706C8C5B87E9EC895D22E057D5AAF4BC102D7C45F3562AEBC7CB34DCB770ED8FE6716E34FE52A2AD06643ABDF7F6F4E27DF11861D4628C8CD23316D2DB330523D3FADE9BFE7A4C24CFEB33DEB71C90B96DA6307244A51FA718E9D7E981745C5C158C31715CD4AECFA508DB6EAEBD2C96C86FB8F9E9DD003CCABF33C4F07CF411E7B4573ED97D0AAC4AE1961F3B7C476A68572F57E97A6CEF7D35C8A2E217B3F2D2C64233AF37DA1349A79FEA008D6AB06258AD94AA7C96F30E34E147C9980F4B41A2513809383C1C3399559583F1116B5D9B3F241EEE557FE19D854365A4E58E8EAB0002946CA31327A65F7F502839DEFD362D714E5430CDEF7959521D75EC2BD1E679E93406DC4C997455C0AC42AE0EF1960C33E61DE357B8AC7D295F4AB1FA3B74248D1F98A5F5558FCE654E2BA2BA51F93E4E6268F1163C37C416A40369E7BF13B9E3AE1ECFA90A07B3F116CADB96290474934B9F504E619CE3C52D5E9E8F78FBFB06D5EBD2B7EF7D2AC3DA011A4B8C86D148C6D596BFEC4DCB177090DAB9F4FEF28A2C6FE8DC1E8A4155E3F3379068FF00045B562EAEFD15306CFA1DD6DBECE59D91E46FCFADB675CC454129E76F490FDF53FE8348EF3971E187695B0A5978B76F457D28055B1A9B701E3472C7A9070EA5E9F64B06D03D8D9F1E873F9EAE3EABD28B29D52EDDE13F9323C0EF1558D43C286D989D0BF7827267CC7D0DF31DFD02D45B7D106A8780383D2CA77EF57BE1974234FA5D6A2B3DF6F0BA0EEC5B169864CF88A732DEF28CDEA19609033EB67AB0A207B13FE3994B3F792836C63DBCC95FB8FB83FEA3D0BD8F608305418F61D3E836EEF55706ABD75FEC1FC312A51A93B43799F1197C4B4ABCDC2163BA3EC99F7688B679BD40A016B8025D7630EBC66000003007A9E4AC4F076622B5647D7BBEF592A2046B7308B6EBD415E80C7106C86D93C23B6777D2A16C347E28E79186A3E1CC00B82888AD39E0F7FA1D9F1D60D375739A5635D03D56E3702F7285F01E8EF1E829A83542C976E65FB4922B1F4661CA9B7962C324D01F98D98CC6D4C88D8D0C345B5235F3E21921C57F03EA30EF807DBCD3FC96BF51562B5689C677E9C17B4105E9E96D61E7B03373D4625C3745A77AEF0CA6687995AD5CA7D0BA7D367CF4D69DCCC3457458C932ECA5AE5A4838E66693F15FCC3810E7FB113A43B25755A5A5E7C25E5E5BBCB7D5FC0519165849EA6D146A574544257102E929857BEEB73F662708D82BA041509ACACAC67E114CCC328379C4AE3BAAE94EA25A2B33FEA87D318760F46DD8A60F472CED6FADB933306AAF81CF1C1330401CB114A6D181F41FADE9B7E7A4583BB0C00745602D0E55CCDAC01B552785959B76F45627CC3FA709567E266BC641A19D7209675C36CDEE33B288A823D93ACCB88659DE146045B4CFE26FF7ED8022D4D299230FE54FDC56C9DE17EBD8FE66C87AD98BFF0024B9F65E682B6CB5C0BF119A2948E4A750C6B1E88A38307A50DF39E8547388756350045E6110293758E72CAAB463E783E83F5BD367CF4EACD67715846FCF7E8231614CB9100E57C4BBBA7C8F6660882647A5077017449E6CA3696DEEDACADD7C253F136531D56FCDC0A8A66E773BDA5462F547D83D93DCE5B6C3F24BAFC270A803CA31E0FC5948B3F021B8377A7F886D7DEDA551AE057ABB59CBCC34BB1E8C0DE6B130C65E661BB118C5C71D59038EB753890381B05E60473EFEC9CCFB0E91AC932BBB74B0B57CFC7A0EB592AE4C1F9867E91199865711A305BEF1DB6AFDA361DE232EA74D429072D10800D04B84C37EB4D1A055C20559DFD52ECBE63F8B1D9F4E62C9D4C723183CA717BD54DECA4C03CEBE81DC78ECE90B42102687493089B18812B56B821AB21181B497ED286DFA3BECE54C706695353007B7458E7AB6D618E1480641AE0F4A3AB3DB0479232B87BCA8B1A67D561EB7CDB4877A97E6CB347E2280A949EED3EFBB7ADFD63A995442EDC799CA3E5C979A81AA90F4192C3E859651FB91D7775A01AF97785D86F93A986B957A2954FC77679E397DB713489BE4AD47E1C5E2448EC6CF75D4F8EA0C256E79BAE7A8803FEA9DA6FC475C1CC140346203E2286A6997399F0845201E6286E53BCA77967B0E5557FF0008809B25F177A6CF68EE62B6DEB10C55A47336779CF91DE31D3748CF30E7DDD84B5185F3BFDC22A0EE7ECF7764F89FB5D5C96F0E9C1CA1871F2C56E4DC12B3FEC5E7D6A7623D8F64A8CE7A858DE8F98965F3B656D045C601A3897462CB875E6267BD7ED2DDA52F1050EF63A1C79ED2CEC35DA65D677789B59B69F4D7A040D960A05B7AA559D0A8953D44C5B07C86E1DA1602A84496258FBAED9B0EA6AD294E8DF042779A7C701D8819A8C9D3E5DFAEA25C44F947CA7CA7CE525FA2901E8683E08759DCBCC314BAD45DF1B7DA1E8FA4B99EF2DDE0A732D0A76947694EDD48ACCB588E6F97D1A9FA7246DB208A827CCA718DC28A83ADD2FA2A8EF4D3A02645A292711883E388493633C8574286D21D62810BC1F084E5FDE64ACD1B41F0CF9A699C2F4036F9834F3CF2C1392286D20E2A0CAC4829737044B1B26501859B62697DAD1E0801BF837FB406203007BCE6763D06A77201F4A95E9530441A8A77E82496968B3894F66098C8153113C49F04656F7F4245A62DD8E9F4A5A338D31C2E700F2F66EA4170709566601D14F123E67796D328DA03A90FC60800AA38B453796D9CF40A6A11F67C7A5AA85AED732D7F7583DB0E01A200A3D071F437988FAD6EF3CD2D2D2DDFD4504F6285E7D81654613A0E5F4FD5630F22D30FCFB3564E27128EAB870ADBBE63BB2EC621FF00D916387C40BBBE666E67CD3CC9E44F2B1EE30E5B662D7EE789FCFA4F17D600384CBA40343F13C59E24AF8EC8EBCCC863D094D84519FF0047D1A4B35E87825BB4B76968283827B556F93DA6E8A16F0C755BA96BF8BDAD1D62AB02B631C54650BB7ED3BAF3DBDCBAF609D2816B1695155D8231BBCBE7FD61FD1F18C9F69D8BB8A87BAFDAEF33D75F39FC538B97E71F4942358B0172ABDDA28E44ABBD1CC1A83A1FD200AB829D7B0DD6372F9B2DC359F8BFA12C2BC43B5567FB4E4F74D7D25B5DC38F8E236C4A52A04D5E5FEDFD29DF6390AA8DCDEE3B7F0F695315DBA34C7A6E18FE50AEC9CFD2530ADF783FEA7EEF6FF7F10A8CF83D85A859C90F6C4D3E96C08DD7103BAA7D104F03DB567A566E85F6B1A8143C0AE1F4684FA01A267069D81986BD84B2084D7B4B1516FD46F5F462A7C745EAFD1413F4E72733862B1EDBE3B74E04BBA9F0410D5996128C7AD3CBE8F010E6AEF1BB1A763ED164DA81E50F51F2F5BF32F3B900630DFB4398E93D3CDE82C3D436817DE014C0ACF4C84DD0CA4DF3F47D3F40F6D69C74859BFB06BD1ACDE6DCFD1B219A2BBC384C1F2712A0A8302BD419495E222A5FBC44DFA24C5C3DADB5E8E90099894D4A186BA0B30FBC7387A689BA1B3D188DA474357CCF0C2FDB5507438AD2B5FC132FCDD83B7303B403DAAC53AD8469542EB8412C49AAD47A40FCC2FC967729065F3AA85605777B8CE9DBD5788803DE723089CC1A777090157ABBEF1079B881007CDCD1917AA5F6CC3075FF0055DE3176606A9CE18D19766B4098853DCFD1368F5C87CD4BA365A287C2055AF450158B95795F33703B09336AEB394A0E683DF9BD54636C8AA5F625E56CBC00E331B8D6D58FB1C4A4517CDA81F300890A743F7F1311F77080ACE7FF003B45F60736678226A3E7BB142C7239FC129B0EE459668C627758ECE5C85BCBC447CD0DB7155AE06FC3E665074C5B0E7F10AD56F40CD56214011286579ED1A89940BBE2222941027DCFC46D29FB2BF49F7C302079FF00E3C41229BB287DD182DE0C2DDBCF1350BDB0FF0031E79E8AC12896719868879ACB0823270BED9FE6501D7351B78F998E1D946E9E0FBC46BC8516D72A4E4938B02E29D72AF97310F51D9B529B7B9AC63FCCC036EF0C7EF330A2B081886BF45F721DCA652A546AE9C27293B14FE67FB098E6FA3191B8E4C9052FEE60EF59CD72F1F293F7098BB9BD5F625598170F0F9834F052A1FBC69346F9FF0048EA2E559657B108C38BE2CF698563DFFD33607C8BA6B822E54968E1698BBA02666A34E331A9500A9C8C69732DC559E3EF1C6DEB876266E318F333EA064F2ED0DB7801E3BCC6FF006E56B77917530B1E062EC8BDA1BC0E77ACAEA5FDF5845A15EF9C17EC24B464218B1C1021B3E4E6D16D00D66EE6768F96D8D10C0CE5B86671456A56E0D2BFB20E8077C27297E11D7A0EF7F699938EEE4799ECFF009822A4570DCAAADF2AD218BCB30540250AEB26B3E7A9C1FC4B1635AF312C16D9CE91CF8578BB80C83DB24A9014CB2D8CD4A4BF98AD4BB30B121A3E4C430FE2E6773439E71576945528AEF14983359335F2DC80371AC7ED05B136CD43C1C0065F08970AE59FCC63844CB84BCB7BD95FCCCE6ED2FF0054CCC48061FC437E8C8506DBE62603600D05775A4CE307793ACF089C52AE419CAFE2970DBBFCF0DBA2D651DEF015CC1D70F8983618D5D2099B48ECA5CA69C77B2A235D7C150B7829E4F812B9AAFBD11A6FF01825EB3B133872E6B8F4259966EA12C8870E3CC43320BC6A0D61417C8F9499F256CBA9FF00110B54D0BCD25C5E02148408B17FE13425CF08D05A7E2219658D17E37825AFFEB711A829AE4F13B8375A87A8D751D92ABB8ADDACC3B100BF8324407670179906A712E8D7DD2698B9CCB54169BCCC0D91C7D7BDC22C59A99FF9DC43BE1857F999AA3C1FBF49E287393CA98AE3CC94F299EAD118C3BC1794476542ADA795F89E747BE82356B9E7442AB3E221B506E53CB99A9183F39E64F23F13CB82B568234479D3CF896D449CA82F295F2982ED336DF89E74F3FF00110DA992ADF898AED10369E54F3A79F06E52B84DD2C4B1C337AD3C88F753355AE7952BDAFC4F225BB329ED29ECC18B154C3BCCD569A65143553B030EEA797F896ECC3806506994F682694A5E195C0653730EDF8889B188F24380651F4B5F4D5FD02BDBCF4574176DB8E9CF8EB6ECEDEA5D66AFC7B0DF10F5CFA05D35D0F8DFBA0DB76F652F94F8FF00F0E7FFDA000C03010002000300000010FC0FFF00FDF0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FD4FF00FAC20C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FECFFF00BCB0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FDBFF00F9CA0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FE557FFEA0C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C3FF8FF00FAE30C30C30C30C30C30C30C30C30C30C30C30C30C30C30C338E2080C30C30C3FF008DFF00FE30C287B2C00C31C32CB1C32CB0C30C30C30C30C31C70C0DAB3D30430C30C3FEE7FFE830FD78A11922B4C38CB4CF8D30C30C30C30C30C5964B6CE7C9CB2430C30C3FCB63FEC31FA9D4B2C70BFA11C34C30C30C30C30C30C3D1034F07C1DFC670830C30C3FF57BEBEA0EBBE8F3CF2D4FCF080C30C30C32C31CB357A8F3E6D7A73EFD78430C30C3FE55BFF830F175CD3CF3A17DF9C9093C759D0E32677871FEB4560B7BEA0E4030C30C3FD573F9AB0C2DFEBBCF3C17DF63B43FD202DB6F0FAB4EFF00EC3CBD4FBEA173C30C30C3FC477FAEB0C74FF37CF125BDF64DC57429CBDBD4F65FFF006613CDFEFBEF05FC30C30C3FF4BBF8AB0D7665FF0087FBF7DF761FFF00770F7F7D5ECF7D847F0777EFBEEC54C30C30C3FC85FF00AA30C3DE8975FF00A6FDF70F7DF784FF00F7FF00FDF7DB9CF13FBAFBEA37A830C30C3FEDFF00FAC30C3512CDEF2C815F7DF7DF7DF7DF7DF7DF4A03CF2CFF00CFBE10D0C30C30C3FF00C9FF008EB0C7BB0EFCF3CDB7F7DF7DF75D3BF7DF7DF6BF3CF3C79ED7E2DE0C33C30C3FD4B7FAAB0C7112B3CF3C5DDF7DF7DFEF70AEBDF7DF7DF3CF3CF3CE3AC490C636E203FCA337AAB0C3FF00EF3CF3CE3DF7DFB7F9CF38F37F7DEF6F3CF3CF3CB3D9F0DC992CA43FD49BFE830C76FCF3CF3C83DF7EECCF3CF3CF0E6B23F6F3CF3CF3CF38D095F65130C3FF00C3BFB830D88BC43CE34253B2F73CF3CF3CF2CFBF33CF3CF3CF3CF3CC694CB0C30C3FD6CBFF008E9271382292E407407CE10738D3090F82A1414678ECDF7E331490D38C30C3FE55BFEFDFBDB0C71CB38839A8C35E79615537071CF08328F32501B9F3268C72C30C3FF4CFFAB9C1CF3CF3CF3CB1C33A12607070CF1CF3CF3CF3C63CF18F38B8B0500C11C3FD25BFD0793CF3CF3CF3CF3CF2C22C22CF3CF3CF3CF3CF3CFF00DF18A6F12A05C90FD43FF25BFBDD434F3CF3CF3CF3CF3CB3CB14F3CF3CF3CF3CF0D347065434260311B790C3FDEDBFAE9EBC33CE3CF3CF3CF3893BC68F3CF3CF3CF38CE3CBCF3C5F6A690C35410C3FDE5BFBEAC3437CE34F3CF3CD243739F2F3CD3CF3CF374C6523054A3EBEB0C34C30C3FF00773FAFF0DDE83CF3A2800CEF7F0CB3C5B292433C0ED835FA45DCF2C86B0C30C30C3FC80FFDCF0F552662CBBFBEEFFCF0C13CF2C3F60E1D1B5411C3B1DD3C2220C30C30C3FDFF00FF00F830C129C434F3CF3CF3CF0BDBCF3CF2800403A675775302D3CF206430C30C3FFAEBFEE30C2BD630CF1CB38D3C9F18D4E3CC0012C329F21A7088253CD3C0480C30C3F3CDFBCE60402BCB2C73C3306302F5B40A3CF24B38604AB0DB8082BC8B3C96C2111C3134F71C4526CF3CF3CF3CA2473C800E24F2CF2C1348004144820821B4F3C333B423AEBDBFDFFF0010B4F34F3CF3CF3CF2C33CF3CF3CF3CA0000001C882082094F3C4EAFFF00FF00FF00FF00FF00FA7C59CF1CF34F3CF18D3CF3CD3CF3CF3CB200000148820820A7F3C54BFF00FF00FF00FF00FF00FF00A6AD3401C114F3CF2CC2053CE14F3CF3CF2820810C0820820BED38466FFF00FF00FB77EB3F43615E64947EF7FF00E257556594D97D59C749978C7A4D1C129D7E7FF2EB7FA6C705FCFC64067B310EB71CEB776EDF1DF93099EA1891DA4CAB5D275AA4E36E39E3041FFE3EAF2F7FF7595DFF00E7EEB7F7FEF7EFD3D9FF003FD7D7FF00FBF1B5956CFCFF004D36A5AFDFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BFFF00FF00F7FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EBFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FEBAFF007EBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFFF00F2FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC400231100020202020301010101010000000000000111311021203041516140507180C1FFDA0008010301013F102D9B05FCA77C28FE55858BBF96F370BF956CD82FE55B377F02491B852C4E7A2C2C5D98922448F09FCEDC08567A468640C8B4745858BB34CA57918AC4D05F8CD88543AD50865E4366978FA899CBA2C2C5D9491294AE2AF78DC227BDB815618EB48F6E640958F790C68424129407D40B9D8F18594C58625A07BC3E11385DC7EE27D8D8D6F29F61894281733B1FE4317978497C14E763C629963DA2492BE09C6D0A98DE1A926D84DAD3E06847D9F421EC48FC92344A4F9485DA10A730D63625CF8231465BA0F34CB229C72E622E12043E05E1412D887B30A631B48FA64012B7D08586E2CD42A58D30B5859A9A05CD8B177077B213910B0C7BC3C6B5D2124942CB204B0F2B59212CFF00EB675F05C798B9D858D939E0B23CC3D122D46A1C0CA4B837C1E165A12CCF86CD2F0924911238343494173B0AB14E0D4A26BFD1249023776372E47210432D96B6259684BA13169661B32C19274B5978290BA1D8AB0EB83E6426C21B3E0DD3C0989DC8689972F8689884A165A909092E8B0B0EB85767A89711C18C9221B916B2D8D6E1215039343727B22F06817043BE361629C1923AE3B4F5C90CB184E1A974C4D352B8A92F33DA4D1234CD886E30C75DAD9B3E0B9599B0B14E084A4997C6DC0DC6D8AD361ECB707BAAB84C1594BA20437B16AB0D6F82A36AA254DB0DCEDE6C2AC53878D7289BDB2825867A9CDADE1C1202A56F52A25890A3148C79E846A5C2D950786D50F32E4D420CDA134584B74B5962EDD6D3D2B0B141A2B3C48509098912CF2244323A6448973E244461291CA3D37D172987448FAA30D38A5824913D4D490CA42C24DE973D30D098EFB5A92190251F8768090A30F08299570B6492A090D7EB924461B81B6C50B0C7252185D83E834358A70530E8936BF53124B4355929D58DB617722219546AD21D70D5052E893C10BD76B09CF56C471F08836A8894F0DF3AE402C3A2C353D91F86244FA1924986B704D5A23841B112D74B14C3A1E2644B584AE523E24C24E32363671094A64172EB86449E92AC31DE19B6571925924660B5A1EB8492244E63486B93C0F630D3E0E697AE92ACBBCA0EFAA1B544B77D372B857B0310A41F0A827D1A618EDE190B11D0936842B75DAC6CCA9F4A2160A1671DB1230DA270EDE17B31EFD4D42781B376C84F4EA4E368D26C4284B83E103824524C5910C8208C40D1A257CFD0C5C1F0781B882082393691E0F7FA974947D531B371FBDE5642F4991CB7FC079F30909C7EC7D8FA1F6111A11B47CB07C0F91F03E049E0F8099E0F81F03E18263E58A7E8F91F0C1F03E44BD09DE0F91F217A8F91109D9F2243E07C05E841E45EC3ED83E842C9A23D8D7B257B21121C3211A3468D0E069221092346884421A4D6882B211088468D1A3442217B1AFA68D1088F4C85ECFF00442F643D9021608647E19C263EF9E75FF0B7FFC400251101000201040300030003010000000000010011211020314130516140507180B1D1F1FFDA0008010201013F1087EB8E3F5C7EB8FD711FD69FA3E0098EE09688B41F01B9EA8D388F544E9FC7A4E11D97138221A66484C43A22534EF37542EB46861927B9312FE082E08CE60C3054E5B9954C4862B54176F008ED594BDA7684D852A0B971153E653138DE666DE660B025ABAEE74A2286622C4770C32C7791DAB0C716942F65BC670F308F313238F23E7C2763044718C4C9948810D0B5D38A0877C8ED5910D3286A0EA825316830E828D9A0DD0446A71241E0BB67CE1E89F38C51D3320A63FB8C662DC72954DA50D4E74573DE476D443DE961B005D40B8D87529C1C1CA27A87A0D039501EE29C095EE0D308FA02F043B865D2A5C457A9CC588F7C8ED54DEA1159285E9C2F2C56B751DE8BAD0DBAD8EB659C6B66A58EC1CE9BDB791DD7D7D434EB86CB8C8BA955A9A22D116F63AB552EC6B5F0668D168B8E5BD82D9CE3B7BC8EF7CC9470C55D1028A82EE33A4D42A59A81CC65DFEFA75B5545677DD92A8AD5DE4771D0F1302882A90D4459CC6B0F9AA60528D8E971CEA7965A3E023B832C42577B0594B0DC554414CB1EC6E3636A5C165CAD04706A190726D23B8991CC1B7FB8DD58205433A674E4889876A2DDE2E5AE25152E7A6B59F039FF0093935FC4FE303523B95B750DA396C0BC113A901A15B04279D84A9BE5F0BA219A698F33E91D2155AF5FF914151F5DC01D1A91DA8A88468DD607A6ACD083EE6FF5D6295151038E0784F9C2BB41642D7DC4E9A80302F611DAF015B89DCE93156D406BC2268472C78C171F011D5151072C9955BC0A4B3C54D4BE935B494964B8B0983050F804751397E2B86E18BF25CBD310D0DB2882259B48E82D21C79461148FE0AA5EF7AB1C171D7C80164A5D5E7523A2A460927E784009C67368A5AD41DC4F3F7FB1DF21E988AD9753658B71F9412A5462AA09A3C456D858394C9B1FD880B6FF00DCE482D8475E250A793CC4AFC03EB3A195A63AF15C22936DD84763024C432BC41AA78095346826DEC2574F7E111E76E31EA568ADE456AC494EDA813B34037A0D87D2062F09E7772E9D6A54A952A56A934EDA254AD595344386086200B87B77D8EBC276988653E3436B0F0F08E88618C312BE76DC4CB1C3BC8ED4544A59F12D658FE094ABC55B6684E1E08256DA611D80AD128FD815E216540040F0F125C1788533E0E12F654AD4B972E5CB972C6D0D7E8784357972E5CBDCC88063F45C270788E3057E79AF08AC1E2507E8CE5CEDF8CF9CF9CF944912A2025252525252592C94949494949494964A4A4A4A4A4A404A4A4B2525929291652525259128A4E654F9CF9CF94F94F4131F13E5A5F189E8FC27C251D4F86DA90724F9697CB49F447A8D01F24F593E53E52FEA7C662E27CE7B887713E72DEB60C0EC8F943D53E13E53E53E50F46B52A5792B4A9538E34A952B756CA95B2A54A95026251FE0AFFFC4002C10010002020103030402020301010000000100112131415161711020813091A1B140C1D1F060E1F15080FFDA0008010100013F10F42738DCAA0B587B88BBA69D73FEFDE71E87FC4AE28CEF7C4A1E3236D73EE6E60DF9750D7FC535FC9FD4759464C8D7B9B455593BC76FCFE266B3BFF8A3E86F9DC201697B868F68363A682F30FF008A2D2BAB72E2D949AC7B4D76804DD89BFF008A00BB5C6A2081436D6E1A315DBDA4C615765E3FE2A335F3A81100DB54C307B68D545B786E3BFF008A643E3355A8C1741CE7882259AF6730A7601A0E674FF8A36AAA75E655E261E0F68BB95545D2CE7FE28F06DE66657586E6B1ED6826E9006D710FF8A2C4055EE05205AA7B82C2A08AE31B63871FF14E5E0BE2545051BCC4AC80D71ED633A9034F151DFF00F7785E08EB43B22385E4DCBC73C2ABF40B82B9659D98778717C4B0F58074A868E8ADF3DA05E2C096263E600E5CB445AC017378B915EA417D09BC9AFAECF187AC314CC83DBDACA36290BB51CFB6CACAAADA056BE06194D77FA15FF51AA15D020682379EA81199DAB4BF70D418BA2DB0EE2F273463C6628FB031E4DF1D1E677214ACFF00E8104EB511F836FC4082402504378673DD87AF5298B800C63598C7D5C9A7AAC08BE2890D16B6158AFC420B5014CFE0B0ACB0C5BA5285DBC5D94675006AF3B65EEC420F5039A67ED04B048EC5B074F3C75C90D43EB5B4BD997F24561EA7B4371797FE9DBDCFD185418F4361717A965880DE81A1B1718F05550562ECB175C8F79BFA3C05B977D1A724BF196ADF5C9F7446C348C589498ED7F7982480002B42829AEF3090DE8D7B0D1D2A1D32A33B6D59D1D6F52F03C258F5967B2BD6BD2BD6BD6BD2BF8D52A09546C2B412BAB8A526797467BCB26116A1E12B94E9AED34FC4471802B41D081930992BC621D59DB45D1A2F1D0EF3363906DEB529F9B21191801D1F681454A8E232C60D398181BB032BD4082F0BEE49C578EAFC7306DC4F582EF5D8E619A157516AEBB67EB156DF09CD1314AE19AF6DCA9D4757EC26DC5C52ED6FFC85EBC01AA69AFCCD3D1076110DD984A4EB0E8F961C337BF0D47ED5D8F03C7A35F68D277AF0AEC85C062AF3DB2D8B16CD31D9E63F432442B400355DA5D82BA3E1349F98EA296ABBBC1B7C41A0323A4D7A0FADFABE87ADFABFC6000C22A837599C375B80948C9AEDD8E7E63972A05ABD8E63651DE1D7436C7737031ED20A141E1DF37B9A3D6AA24F885582A172BFE22EA00B1D7621EBB4027B6BE69BAF1D634C925305FA20C62A8058A3AA8E7556B04A3002803007D623B8ADC361D41F986DED1BDABFDA7B51529450E43F155CD930A4D800096B79CE3BD4B8568DFA91F46DB985852586AC647BF9EB14B8A5E6666D0B626CF704BA5B7E39757001AECB3A7C70E25B10B11B2EEB8F8A967840D6478B76F38620984D2363EA47DCFF0020A4160DAFDD3B12BA9D3E0A0695D33DE033B00ADC1CAB02A903B5D894776895A2145EFBAF379835B69AB301BC53FB1E614526314A07676102A1E974C5CFA670496051A517FE3F504CE2C0E6B93ACF375988428472273F558A83BF5ED343565F598012CC5FB4DAC8110E4F6B186EB4A550DBD6BA7312375C088453465BAA1512B90752A09CCAF5AF4A950D02C148E9819C009D41C5E93C92DA6D4AC1D6C69FB44807B3A4F862C10396ADCE583C998D086AC86C66E354E9BE6A539B29378F4BF6DFF1AA2D0AA01BB978B5ACB4A72E578AED989E85A0703D8C1AE25BB1A504392EFC1960F4B59090A45F2B784BBDADBB4EABA3C4D2E67FE8C6D6DBB7AC086DD10D6043FE9F1006A54711CC3C9D08B3A7A11AE118ACEA058363CC06305C06CB32E8EBDA1A3FB20F31CD090D3C15835F55D4AF06D6FED0E1CCEBB847D97E05B0E47B4BEBEA4383EB60561911DB57DA25B442523D98ED32B9EF5B83771A0EA4BFA2612E103A4C3989014F0ECF89AF4558E2D5725CCEA8D9E0AB33C988619024AEF6B3F3105A6BD6C943A6E9AE75D6597F35FCB09B9CB95D06D7B12CFD0016629A30ABD3798BCAD40C0EEE8DC09A00471FBDE0C4AB2D613A0D62F83463A2444232C1A17CBBB565140BA0DB0894B482550300E5581E973AF2FC11CB7BBF465C6714DCB1ECB0FBD662BC6421CD53A8F4B1F4AABBEA0AABF8E3EAB1D2188542D42E2A6BA4E7DA86416BF47FDBF61185CFAB2A8478FB40B72A77388D953D3003318CEB598AC2557687BD228C7EE3CCB9719015D9DBEA3C3022C5A6079D0BB3F50C6943F0C331EADFF22F273E61D18108992FE37A73FC95DBB91A9174197883C9C17D31FDED9A456DB7ABA7AF770778198F6815D56FB8C4965A013E4C10F8161A393BAC285003A13F10D29300730AFAB9D1C1D21AF50A451A8E5BC7A84B9DCF3058411291D240C78B11B80E190E8AEF14612F45A9900E4CA3D31E3EB5A9A12F7008C5851555ED6608C0EA9CFB060130A5E6AFEF899ECDC2E76A69C707920A3E2025F0C3E85970345F22638F5C8D986670CEAE8FBDCFCDCD8B2D0DDAEBD6B64A8897D35C89FDEE386D66F6B7C1D5C3F50DFA2D4B97E847D8237DAD66C3DC8BE2558C08B6F40E71F60E9308DC0E65F234634737C41E37019D9074383B438C38E80E03ACDB47DD3F07A30C0AAB404C3AFD4E900F5549ED1D6E8E09AF630BBA306FCC4E2D4B3790047612BE25D641A34007EC0E97738FAA55E2DF9439A9F80F68115332BAF10D7B0210A1E161A6458D853C902AB5C29598BE5B5758BF4547A219215D7E827D9D92CCB8169FCCDFAD4D568503F781001805BDDABC7471010596A0731B2681DAEDE4F5319E2526FDF4DE99DBDC34ED4CCD788D017D0B77DA102B66C03B580CAC2DC2B48F018834E68276363714A31836C6F399707EA25DDED46AA535CA1603D4ACFE11E15161C9D515CF9C7782B0AE18AF1B3E50A50552A85886EAA221689F111418B1037E15F8DF483F3550039F2BE5B8D592B4AAB2B2E8C5F7885C16C4CEDD0FCCBE1CA6C4F39E213210AF47897D5769D9FD2FD07A5C374CA2E73ED17E7805108F46892C338094535567F98C5123536CAB93199C1F56E6CB4EEB10C371D3A59AF6A880B867BE27EFDB4004A79CD0B5F4CCE9AD10C09C054CF3508F6838036EF70475AF7B2C20D99E92A9E8B5682EBDB9350D7B54EBAE743DE2B722CA73BF0929822212CE5A7275AEF5075CDFE9767B7A5F20855F6E5F88C9D307CEA99FD45322B4A97791C358E7AEE0DFF440D2D406E8CE7ACBA60DF45BA97289761CAEFF00E594F9C6F4B3016F5BB68C758D024BD9031A876F3A81272E687ABDBC5BDA287B1CD3F05FE211526D06BE6A646AC0D5EA631F34C61382C9E596BBCA11EAA43B41CD73D3BC498A83993C93F5F7C8090998E5977866629A0B19FF00B26D68457F3BDEC7EA3612D0638304517497D1EEFF00886AA07A5CDBE4A436F5F8F439F461721D2334BF70B3EF0282A67B8022AE0D568251DA2854825E0EDD974798FD542C616D9D3308AC80CFB6B9B5FD939F57D2F7B84B20A5F7050762255CC561600DEF1CE2694F41A4639E216B0F7858A07794CE16EDA33F9F731B5049D2BCD3D20433A453E1EF3043E5ABF67C4D07FB96BD7380F863743740B6F638FD4A9A41B341F237D9A8C1416C2EA7943708A633415ADD1A96452D8E16C00ABEF4BF996EFB523AE57FB602552BC257E65286EEFD93741F17FB8C956569CCB8218E8CAFCCAD7AD8387E639A5E11B883C4D5697F49A9A54AABFCD41DE03084EE8105BEA2BD70A281F2CB57C8251C8060595F57A93B7959AB664E84E3D8411067A042E02A03D8E1E86D9B1A703DEECF462C020162510C878AF9CD6F5CAFD9EAEF0153C5AB75656F316CFA9C40AE000E73E852D5B5EC2A9B73E2572583B8E273EC752F030A814A33E32196219299F235F9971383B55761F50E3A173073EE5EF2D0A1931DBD257B4C3AB8EB20A3ABFE22AA0CADB71331F0C00BEB0B67C1E6230A5B0E2C635BB65485A8761617FB80563E4C469143D5600E318CC5BC5AB6F72E5CB8C6169A3CC1A8D43E799BF4D4131B08AE07982200E1070C52DC52B18E91F21148A1FCC3194E578266CA617C9D227B09056A0858F53ACC0063D59751E3738F79521BB8E8D171F319FB62EE20A2B0007765CD4AEC91202591FCA97E2E3F55D328D253BC67C40AABE1ED738A6F86BDC4CCA096A8CA63AD57CC1AE29E930C93CD8B14F357B9C7A0A366E1E61CE1DC28B35ECB89736E0CC969B5EB1F6DC6CA1EBA1EFF00EF485995B5A0D5C429305F2DCAB01B5A8AEAD01654A952A00025D9AF60AA2555BAF586BD4281862DE66E04B7CFAAB0142F05C7EBB40C54395E581ECBED3C5604D21015EA388017155ED6FE85C70966CC8B0528EB718C288655737F32806F170174F36A7C10FAAC2B56AFDA32C97C51457B59C40BC1AC8477EDA05348E1BD4D78DFB5B1FF005DAA2B2A5D628051C60BBF31DB78F425E65429628621B1CF7F5542C652A602F486FDDCA019BAAEF387A0A6BA54C88DFE78439F55AB5688A9A3A5383D28BC0D46B157ACC504E5B0E3942100180F65449B139A3D5C6F4728E095D3DAE61EC6201DE66F97820AC1C43D9411C3B3E8FE6CAD1686B5B13F24CA8622E555FDC61B4417151D1D5CF6086BEAA2DD6E758031B2AEE3EC416459E1E3BC375EDF1174038C499E305345EDF131FC97DBAE574EAEE2049802A1EA34E20356682E0FA3A5E6D5F699BF7876C6D77E0FEE3E824ED603AB332D4CBD5EBECD1C742FD805005AE88CC53257F5E0CFB35309E94C34799D632DCF104DBFD79817326FA8FBAB795A3B451EE8CB5B7AC3D58A057882C152F9E271F4009B1E82EB96052BB841B95828457400C77EAF89CE7EAD2CAACE3CFA5D50E18E7BCBF5A8AC856B6D621D4CDF3ED262CC6E541972F44B26EB163C42EB130017B3969D75E8F7A2D4704398C3B0626D89E82D19D4C7830350F7108AA1F2798FA3D7A2FCD868F63D1E4281ABF3DA5FAA09572797AFC43F1ED1A41636A9FBC5F7150D95EBE25BCB926EFDD7143366CEDCC3D8EA290E8FD2B1E22643FA25A14B5C2AD8652358B165AAD17D55B6FBFD6031742312E1018F3ECBC571178E5A5F30800D051ED201005148F3057A39A809C1D69FD914E214B1BB2F75BEB78710E2A1422588E4639BC7332A0AB3A454F8273530668F5C9F660FEE5975EEBDAEEA94254614603286887A600435EC2D02DC5ED0E6A0B23C34C33881D02E92A9FE20028006A07D5326D009A4F2BCCAF63144BD0471364A5141421EE0D985F312C0C072AA8F0EDD6A0972096ABD08619152C9455D7D6A11D508CBA987443D8285D26EBEF0F7A0550B692B2DDE68AEF0C2271999FBC1CBD2EB39D60A8C61417088C7415149C6B883D6DC52E30C0BA422D28B7A7587B55DE264ADB0719B69BC0578DCBA565B69B7DCB8EF0251D5A0A2E2384891192DEB3987D6AE92A9E1ABB9A7B74C43D705C2733747926D1688068E439B84E270047DACA51CD7996FB4AB9E167817E61B6232FA0FF2BA0E549C0302EBAD7D61BF6461EA317F987B0A14180B53BFA0BD0C9CEA26F4D196994D50DEBCC49E4B3DA3AEB379EF31CACEA73004670C4E7DB5710D79596D172F40D9627A1FCB618AA81880E015076F7BEDE83C8711B2F9C47DA3BA30497443436B1CAD2FE884224341DB4F9647D7051ACD3318000061B87B1D576E050D7E7E810368309C67E13B8E465061135B94A2AFF7C92835B7882B0711D40D0C79F7A5C07701B8A971401E0FE632FA1580736CAC40F7B37434568979EFEE3AB764B492A9D05BBEC4A9D00A80B83ED2A5CAC39DA9D0571F5D4D461B4ED1DCC71565F98FB3E2DBCDCE71EEA7ACBBB7B84F754303881CCC68E7BB7BE4755887D6AC82EC27E07ED0DC08D2C120A0FA082EDD6677B15E10FA9E3D5C7D461A6E13FAFA2904A2A7581235554328ABA11E4F600F4BB8A015F5E51B07C1F694DE0B5E0E65120714ABCCBFBD7C43DBC7D14943438654578A82CFCFB29ABC6EA6C5C1F99CFB48F69884B5E7C2F637DDAF017BDA12778153435639A9A50E372301E87BD8A22601DF763D61AFA6CB255314C748DC2C14ADB0225DDB52A20E70CBFF00887D3DC0E417EA39C3A817108DAF6894FEBD6EB7C6080580A90C80695D5B7CE25B500526CCD38D1CDEE64ABB5F61995E69350092C74FD15A773D10EEEAE71EB4748802259805FF00AF330255835D3DA42E40838C72FC5E3BCA5CC1D96EF3D720F92594D509C238BD28DFC43456B455BB7D39F7B317BA1F2DBF501B9B49C8B68866000AD4AF4CA4A2ACDC11BD46DFA6DC44A570773EA8B7B420A8DD63538ED1101CC335560C40E526EADB55F72574BB97162BF661AF60665F2EEFF11842F83B4112C44802A00964075B89DA81F6D09B580FA5A9D4B5ED07141BC5F8FCD43DA4144EA48D3F95FC41C34AA57BA229C44F40A057D0071D55DD435F45025D411551517CFD265802D7007319A39FB3E60A3D8CADB14001BB621A01925FD1AA00AAD40D100F9FAC42B21E2014195CAF04DD30FBBBC311A10AAD53000DA63E26B1E7332657CFF620554B5D3D8EAD802094DD65CB570C8956A32244C2E2AB83BD4BF503A4705C7280D4851ED09C4032DFEA3508C4BA307189C7AB1D05B5AEB879BEFEEE6E130958654C663A9779252A19E146879BFA592602BE551ABC6BDCCAEFEB436260C1F330429B5E3C40ED0D7B4623111E9E5E810465462E1F40C42CEDE7881AFACEA54AAE21071846A72CBE50F074DCA9E1F23C2E3A71D20D630B86417BD561D6A1B952A634DC757C43AEA8406E9347C6E031743C9E3A4139D417714E1039730C00347B90702A2D11A97AB53EC629C1401D730F713631EE85600BE52232C330D0B5BC50B4CFE20A2BE901B014CAF4E60B2ED1C78FA00549800B9612F7C7079806B5F41F440CB25B95CDC56094FBEAF06F894E0FE1000E2D1AB68BE2E5F0A55D52DCE0DB6E357E655E193A0DA42AD3585827A0C042788DAF3C6D1235B49C788BDA3618330C82DBBBF78606900EEF9968EC5C0515EEC3E1F46808573CBD63EC26120B6E8214967B5ED12888DA0908ABC8375F7E91448320A68C7814FCFD350DA5502A853D3DCC74228E0FB41201CDFD1000C4AFA48764B5800E99EC880511AC92FD97DE21B9D77A58035FC206158C8B6736C29FC4A21B8040CB6E0C7F822F372064AAA2E8B583D8E92A8DA15B2ED7FC476D3D7CCA0D5B719CD4E442FB4C912B1EFAE5E91E7ACCF8863C7B71EAE4EECEA5563A7B41A82B970AAC3D2F1DD22F72BA92891B5B1CAF5A86AAB5D3E98B5DF11919E2DBBF5F65CE7102958B579221032DABCC0AFAA96C4843580D5F58218715B4C7319A0A4C4B80AA937DA19A9DE06BC542ED80040AFE0AA2C8A56378C35E2F9BA5BEFDA3BF5A101AA56F79B45D98EE3A29B6983F7EC732B10C4AD0F15190C5B3A3FCC0A28F7F02CE273082802AAF78FB1DD270348F0C326EFBFB1C1D2066E55A7A010A6EEEAC5772C1BCC361BEC2833DE5B9F5B3E831C042E0D5441104DD9A971CEA5CE10B6C4A80B42E98257681F5DD412812EF30B082390CB05048DB47E218B4E6950D7F09511F08AD8E6557C1583AC73121A00E06F383B57E7F8374CA2AAEFD2B516768719F6BA6B0CED2EBBD54069028F5FDC6D323C37155703ABCEAE2ADEDFBAD84FCB280C16CEB6B7DE37E396AA5CDA070749E5DC3C545EEEEBC789DA0F31084C69620A8BBADF33763E20E81745AAC79831FDB0D447C3159FE48B451B2BCAFFAB10E29D02FD9183AE94A3B7987DBFF00CB111542F308F7BA7CCCA693752D2BAB6FDA79C7A9B8FD4067E93F518E36B6BBF691E1376AA86BD0962159B7E9B963DB0CA12E9D0EC63CCA15A0BFE230E400F06C6082DF25C23EEE1D30B72F203144EA465106AABD16F9DC578A683F372B6C70B74B78B600A8D95B45D5B9C66365A602A79A62393A84197A799664532C2018516E5C8DF98429D7462A955DAB6C74856E9C4DAB78A872DD5BBE3D9400AC5477BAFB67D2F3F46F3160FA75AE2204283A0EDF10632A8015E99772E305BBBF43108E928AEC8D9B74E43641E30B6BA717472BC7F7305FF6BB3D01FDCB497B2AEAEB6304E2D7A435AD9F32D162B01F5C2DC0C8B10F89796ADA0BB809F3BCA8DE5BAFE9835B1A12CBE9E7B4CF578C7E74E3E65097696231E3E82D170EA8C60CD032A89C2EEA0AA414DC316F642182AB80D37916C02F3DBDA47E91A3758B9E60039E5B8B6FB2988B45834EE58634572C6E9BB4CA55DC6D42DFBC7A316B44F439ACE088BCAC3635553DD483C9F64778A2A3DBAF68534E94D968019BC7DA3461C850AAA2CF37571EDC93799FF7C4DDB3D59F810FC45077489B52DD768B858AC96DA81561BD28BF1702008002A15ADB085A2AF61CF99484ACA5A8BDD4C4BEABC919C334B4920BBCF3F300182A0D2B25D66CC377C4A0FEA6D8132D2073821EB8AD1B0E71A78CE792155A1446178B3882840684AF14D303B34CD827E3D00005437282929BB58852C8F3D2321AD6F1294822A9617AAEDA96540C7183E6BAB8AC4418D359ECC76DB02E422D17C440B4055DDCB4A710DB0EC60D226BA7307BBC66208629957E21965F5337811CB833C55EC89722C2A0EF544462EC0542F591EDC5C518F6A6D8DDD3166AFA4BB415A7135B6A32F354826AD07968FB11BE1FCCA454AB76CA7ACB75FC4B753ED0188CA63056B6A3A899238371C24A40356317B9A9B8061E4731AC6DA6B6EECAD6731793829A72EA39763A4025BBA4780CBEF33164179CB5C9E58B3C29553F669AEF502972B4B9A84FEA52914E3A7B2974CA03C6D004A5F2F5731252D436A76AF2F794D658A384ABF2CDD710025101404BB2F8CFD7367758978219450AB5ED2025A84B372E802800FC1B77D52B52B1511ECDAD68C46F37B58811536AB6AF55E67896EA839750678129D609B732F90D6ACAB3482EDC3C48CECC41D3F6F4AF4F32DE6E9E19E73E6362323626E93920A4CBC65BE4E1E8FC6F32C07442105D37FBED1C6C4973045652758EC164EF0E7F51D8285574779C1A021D76809A655E0EFF001B94F5B67A5D67EF5F78FA60B82000A8688224D68D01DE36DF0441775490195645DB00ADC06D8ACD911D5114AA5B0323C5F42A3E7FB6A7E59B29825A0872953B84B36FDA03BA76C9D92748253A129D0960165680251DD3079E9042A3D2BCF88DAA5596C9A05A74D439AA3489E221B12177BAF32C505556AC7C31891A96F71A391B0C890854BBD3AD52FC3D632664343B642B4EBA476C5950AFCBE8465E546B988DD579555778839AB74E9DA1F595285A161DF89BCF5CC4A6EB0A7B6B2A4E5DC39AF88B8874054D0B7CBBAF432D45723B0B9C064EBEAC1FA15D894E8453613B698547E225570654D5BACC4B2292362EFF00ADC12A6B882A916B4C5017F68F89C19C4DE00CC8AC2D16F88E160AF798D19D3F105BE5456907719A2ABB68AAC4EFF47B7B7885F5EC4F21711214A3E610A6BCCC691930E30037C19731B5D5EEB962A15AE08C9E087523D92006C3DB50F652C86F0BCCE78B163B4756DDCA1746712BF7A3B7881ADBA2B98D44525F1F11ABA63D027C88DED0612CB8F3322B73CF6AE51CDE2A73EC08A73C0661D611FA56C3775C4CF318AAA3B3D7DA0428D1BA19AEF0DF5EF0801068E0EB2AABC032CE7D95F4EE5FA00A48E6559DE22CFA0B5DA770B94D80A59F9E217D71153C87A432AB1E8E6EFCC0D80A802068952F3592E132EE8E166AE8EC705EB88F06E1F3D55D6D7BB1ADB15D6206AF2C01A263A4F10FA96552F74C3E18B4060E1CC6866F8B800C2A27785921284E75FDCAF97D13134EAF76634F4A6E0602CC86B5D0DD7DF9F6AD8EF494CC3876A84DAB3E8E836349E2108ED847D86E2B1A0E6B1F99CE60B0756A52880A9AE6B3EFFC500A4883CC894D2532D4F00E01C392214103B161D8BEB7BC778D2D2AB5557581FB44303211D82D172A39A75BBD835862F2EEAB71472AF989413685B3C621FC2A20EB3A967AB146DE9399E072FB18807D86FC4810E8036F6957A16D2C867546069BB2EB528BD8CC1BC81A046B6BDA310855DD540706FF003ED25578351CB66E116B4EAB300288F4F4441475711B03DA83371C4356BBB7EDED5AEA81ABC912C1C229510E26ED168AE615D4847EF2367F8FE30D4139DC454EA6B5003158E916D9CC5746B98031FCBAFDE2DB6C0A4329AC0B7F06A263E2D0A4A01CB77903BD41B90BF170458CD2E4E2B128223017C9595EF34A31341402C9407C18C110B09785D26EEB57A87B04439587A4A51D6B98E3CA1AD9D66C7DDE186F510B5529ACC4CB90F6BAF2A1A88AB932F602B55C47632523644FB703DA6642515A2AA5A80E02EA61BBA5D473A4961577DA36F0349FC57D2CB7B0D4356FE36E6F02E3088B1791AA1EBFEE203614A7F5332C1F1111A6158C3586F43DEAEBED37832F6812E61695B0E174E0F32A57A73326A34597145EC51CE9A9712E099AC2D7ED5EBE23CB6F8C1C58250AD011553C52EACEB33200DFCC20A52E4D382520D7334A1E5FF1EFEBED2B83B98F6566061895B5745CC72556BE8B5D29A6292A47A3D13A8EE0F1AE16B398AF24245B156B8FE3D457ECED050FE210D01BD17CAE83BB2E1A2D80AF2D8834045118BA8F409192FB32B2089A1E842EDA3E4800BE2836757AB0C6E5E080DE1A53DE6402A95C2F06CC1D98CB10AC05F167F116F21B4DC032303AC37F0F3D718839BE7D8C75576142007A15F78870AA5776202DFCC27994A2717CC4A54AB6CBE973155330DE486FDEACEDE08D155AB10654E55DB2E5FB597B64BADC2153356BEBED5DB807CCB5922EE45934259BAC5DB291839633C7C7F72F902D60EF28A4CBCC68FBAC563E203548FF0016D15AF6A89D9CFF000EBF5E8E0AADF3C07561D42AB88696DEEF12BB45E7A46B66FD23CB28ACE3D2B372AA1031A001D98BEEDC0EA6B437C036BAACD8C0E1A20044500B6CAF7B95E85A4B3D23630475E96CC9FD0524BF9A8AA7228F572CC71B02538576B3D1D3DE252B3AF319341306AA068DBE59B897D7862B50ACEEE5FD0FDFA71EE0253937A9BCE339A389A27A9DBDB9569430D34103B407AD6404763168DF0CC1CDFB9F92546002BC29A95946D62AD8365C28A64D0DC475AABC648D8D253CFF000A8C39815286745606173A050B9E906046666D7AAC9E587984400CF44C3DFA7A25D6D748561FC13FF415A0D9D8217470C42B95D55CDCB0CB8F32C4BBC4B56698472F49774BD888ED39BB7B4C8656A39B3E465A71BB561D29C8EE5B5B815C0ECB30B470E37B20615AC3212FE78AF4CBD22D5193A9A350DE6C97201B43A0115ABEE351B4524AC8A5A1183C0938586BDF83D5D29CB0AE0A5F6B159D4A6069AFB7A519B2B15455079A594BBC6DB4E842EF472310764473961F05736283CCA007E18661A088C8E2B994103839A9ADC71BC7D575045CB97D068D6851068E68E7AB0CEE04005121C3B958E3988EA98E1EE3C8EEFD061B5400CE79FAE498A6DA688462A281654B6AD16EBB625766789DE63BCC7C8E86896CEEDB616B553CB119895EB92ACBE9EA2CEB2A1C80D26E80679391E22223B0E01A7FC3A61542146B37D06B29E6A6F3985764FC1FBC22147A359A01F3F42FC71C75ED09080E87D0FC28DDB2A74A6CF27B0C378FB433003AD0056B5E95058426F50DEFB4FE18BA00C66C34C050545E5ABA828DAA8751A72138886A9F307867C41ABC362F32E6AD001B3EA7982EB6C2B6DED3155BBEB14A280155E2A299A0995CEDCB9B21C1400A00D041A8CA72515ACB21C9575DE52D7C0FC9D477739A828D8C1718BD659571EDF5098C84414D0DE9AA5AF1C4505A0EEB51B028E4183D0EA54EF1C4341597499D1B389DA802EB110AAFCA1AF57515438256F2F91B3E496622F013088F1C230775989AC1ABEB5700618B56537AD5E30F01AFA1CE61F431F3A5DC65C156F3DA1AF43D0850070E997C62AE1C76F5D226C6E1060878AEF35E60ED4591C9742E90CB5355677DEE52DC26E2E2929B991BD2D67506C42F094EA411D3F416B73B933418260991F9956855B7A8BE848DE2E9BE43063973883170D0543EF0755503414757D2508A316E20C155C846A0C4CB2E839EC87CD3449EE7A883860D55A6007EF3E4F759EAA195A08F5E8C9223E0BE82195CB41D5EB2ECA3605F2DC2E851E4912D3AC2F2B07C20D415C8C080B2306065839FB44A6BBF440A3D59533E6C284CB3AC3B653AC0128C0B68EF32E6585081BF9DFCCB3E8BEF4886E98E39972E2AED7D61ECE5F830E9798C5B4413C47D4BD1E825DEB1374D6F533ED081412D5DF1A8592DBA8B3B34CCAEB6CB07577FB5C7A57B52FCC1F60D6A77181F33C7F682ACD98F115F13FDAA2FFE04536AF9F5A5039AC4263E2A6854B4AB358D5900D003A05110EEA543D1094E4EF2D80ECA9B533807BCBD156A80EDCDF31C7CD2C862529D3D69071E25264CC3A53B4CED304D11E8139696B987280B4DE61A20D104029B1C8F9CC35502AC626E2B315CFA0992B48E43963D25EA1E9A06F9972D445718085D3D219F6910023B188F4019655A3E0571D226202DD8E44E53479ED2F329C594D9AECD68D7F01525D6598B79884EB3CBE3DB9AC282D6880D0028F63D337455A8671BADD6AC211CCC682148BF67C84379CAFD9EA9E7FC4E6382E535389C96DCB1DD71E213DC016FBDB2F68F413E2D971E4D09F72283965EAF3889CAF6813E18E0CFA6667A45F12AB3C40802D7837072C69A5FA8C89840A9D8E57B352B852C614F3C1D8C4AEDEEBF4625909FFA9684CCCE7569603B073F72365AC90B1BD9A8E1AD3D3D2FDA9A22669BF4965F54AC7FD3BCC182CFFD3879CCA99006A19AA1C79959A153E2118056C799520407011C45DAD204D6E3848392BD00BBF45D02C37189637EEBB13760FF0066FE23545DEAA170A649DB1AB86F00106960175AEBFDC70A77FAEE9B7940CCB39CA34A8FB29975BC3BC2182981F97B0F2200822787103B83EDB0BB5E6C54EE768769A357580299FBF48C8D0B1393D08C4825013A315575968AB661C055655E58A52B9D1FA97C87FDC26A16941E95FD45B956EEE7F7155978FF002DC490DDBFC8B841B7DA323D6EAE0273F994FB5C115CD92BDC9D3702DB9505EB819825C31ADE06134D4E8BF1995711BE6240A8383148D791F8D210C0003771DDB830DD40C07C4AB7303310EB2F819CBCCC23481555C4502D43CC4CAD327E5F12E8271055CA7AD3AE7A10BE32C6F6F79C1997095E8C368F0F730B694D0A5B5B615195725F73A4541A5CD5FD7367D46722268B68E0A8FA9110949918D5D2D0B5A95EC76F201ABEDF383EF1BB6BC5C02774D942A6B8672AC74F57F83B5BAD0B743ACAACD62163CC764B11AE9F4BB7E9491674F715CCBAC56FE232ACDE346DDF6991F003772A0164A73AE7EF2D82DE1AF109197016EB50BA2F06212B30BD472B74F499099B2596CE083413ACAC1D21EDD312F223446108D1C8604F98581AB80C30469ABFB7D7EB5BE26DBCBA6355651D7B73205A16B5342901E3DA3542816240CB2445A5DD176E7EC47048BBA2649892C355A856B8DC5D40306FF85603234CD3D3F04C4BCC1079FC4392D01F4C6A1CAD5F715176083D31B8708B4D5D55C0058979AAFF00BCCC5E278F5769430339FF00798F0582E6971246A5F8A8284652555F17DA5DFA223C09EFBEACCA81D33D4D59DA0ED52E2955364A768950C1229B0B68F09F11D7D5C73A98E6BCB9EB06163821EC5A231A4A1C4F18F6A4302BA6C1ADBB1B89D9711205E44E2D2EA2B4A8C94A014E3B4FDF59AB71D2193A79209D7F8185B506CBC045C5BC0C38FA6037B4DF8F755E3ACEABEBE4BA60C0AC099C32BD0D116A5CBF53BAD02BF315AAD302A8ABA753999355CD1ACF128AF47917455C3DC971A9A518E65DB85A3B7580C5433D651139A153B8474F7CA52764E1EDF540A1D266356F0BC7896A3DC75E7DA945A8E13897BD063819F6B0130A946C9C9F97DA1138E5C325A3C16C3B9200BED880580B9A8C69E21792EE1D83A30C73F9415D3116966884DA0260BA57999F485D564F1EEB23207A4F534FEE3375987A32CB23968B4FEA5C3D4CC4AF63BD8E8E588E96ADFAD7A57A02052A2B65B55F3286EDB2964B572CDC54774783D77E8523637F6968155C21E97E88E16FEA1AF7952AA740D411C1F16FB92C905CA0B5A04E5E7E1FABF80C6ADCABBC05959E571F612C661B3E3DB942814E0FE82E52922C5E380E81293C05C65BAF773D0C758147A52E2DAAB82DA94DF37E2535913D3315E65DC2C85DDD97D6579F920FB19940D1EAB52ACA1C05BBAF97F173922F1B2F3752E086D0D5C70162A79F62CE6BEF2FA32E5C27530211ACDB7EB4DD5BED052ED50D4513BC404D9E21025322B74ABD454D0A97497F3DD5B2A9512B41B0D24A82AB2C7D0CEB004C0A002D55FB5010BBC306C11F60BAEF8991366FD4B6842B36683E15F8853930292B569559CF6B80606036226FEA3DE102152DCB1F2AA8F6EA9E0CB293C0A5557C7B1DAAD2CEFBB5C7F71E0628302D0701000A9C6433470BC06B0B033ECAF4A5EA0EC5C4EAC95EA8298432E18B30B6E30C5C4DD3CCA41C9300399ADFA319C6E60B4C6254558E45FF00AC42E5CAD1ACA4084AE6EFCBF508763886A502D6889934EB2DD597C113BA8B5888B025206E27B4FB43847DA6B52DF4C4BA25A08A845B92552DFDEE5EC84CD5436A2E0CF1174B0F2D21FDCB307A0A9815AAD5DEA3472297B6CA8FBB3CD5147CC25B56DC446CCAA0BBDEA2461A7D40934EE44A4FB4AA86CAABBF56F1518DB742CB81CEEC7BEA009CC665E25A22ACB6D544430DD88342AAAFFDA2C4F3687111F8E520F7E357F51A4417C419C9C97AD420857BC2DCCB1F8067BC5AB2716EA64D60DC6693EF456CC7398D68102DF05F2C5AD4A692A1A12691B2536D22E4FA3B75F04BBCBD603C7402384B41A5E6B75956AEE931056AD000070040FA95052A542A7C57A268C53071DE01638F46C43088735001176353182FBC672C748E65C2C274D19DF23556662FE88B604F304CB000F481D663FF0062163F8453775D88B6D4FDC070411B2EEE1DA8EA75E25E30C5A9F88633FA872EE36ADD2778B0480A1193D2FDC35DA502553ACBCAB5DE233C5596218172C6BD5820B372D22BEE6E20C4B856D5C7F52F6A0EE96601E59B6C8845A960FCC4929B15CBE62F0A85068FB4732BA0442D53D4C3306216C033ACE271351218273E988A1B8AA5953A7100BB6035AB5D105F88CD90219EC2BFA9D8F779BABE1747760091EA01FEEFEB1E943B87820901C6BBCA7996A05E080985F781707CCBF80806F2F98E7CBEF1B76ACABC05B1BC04E26DF4ABE0959E3D3EDE88A512EDE530CC7BACF82578859593016B9B7E2234E3135D1774817290422DDE11FA0B5D0F8EF0CC04D816FB5842964B7E6FF55528D95B8769920D36E29492981EE54C1E8B3BAE39554E83885DA5672C7A4FDA769EED3001157ADEA61D19F0C25FE7545697F36B9D54F946B0D7CB703FEC8F4FF762B587C2CACA6AC17981DB37CC4AC7F08A7F862BFF007449A0D1C891FB0817D0DA0B5688304929A06697347451F5CF65867503607C44BA7DE24C77FF0068F51F68370FDA278A9C87ED323B7BFB0F7108C68888A3BFA0825259186DB0433D7F108B2E6417BA07CE7FAFA26E668693DF79509CD850E0E6EFBCBA0159D823FE7E2015E4561C75BF513365E21ED5C4231E4BDD6BD6BDA3BDA4680DB04B1523606BEFB63AA615C0BAC7B838EA9D20C7F16A5128FE0314ECD978FA4EF8B2A46C8211944FE3FAFA44814BEFAF73A899568D966AB2AF38B851268564B871FDE3AC35F52BDF482CA113FA8A5051D670A7E335F69BEE180E459E85B50C2AC87072F776C3D56A0DFD47F8E402CAD4BB2C1C5958FA1623718F3C4209D0ADEADC42B6BFC8FD2D1E1F7712AE54C86C3977B29F305A40E254A5967886BF84C6AE8AF83FEAAFBC791550AF88808078E01AFAE95B337E87AD4AFF00E1B30030149F42E8575A175DEA2DAD5DADBD651D40D014F1AFA482DA7884434FB2D7B23DA175982C2B0DBC5C40E359BEF5C472B022878A61A3F8556873FB89006BE800D3D321BDC6C42ECDA1BC5F230C61798C8A94EB2DABD55FA002DD43D01D6E2B2CD7D1E62D170CB58D423E87B9FA7DED239464D77F781AA2E0E7106FBC2681121D7E9D0A92BDB539D7300B048960D2BD69835ED0BD9F89A1FC273072A44234B95E4C2B0C8C3696667FEF566AF6286D8365D952CEA7A5D0CBC8DD3A886CD95F458801A770A83BDFA2C116BD84673F551CD252DE33ECF0DE97046BAD4BE3FBFCCAA0ADB5D669F01D3B7D2E65A3C07B7B8E3AAEC77F1003F89595CB65BCAC35F67DD0355D06F30FE166E085342E0FBCD212AB63774695DA60B8A7AE069E98D4D3D2B1595E22FB25A99560A69482D8AE071470B969297BCB431F41F44B298AA9627984F03FB96140B80486FD54A8D5B39FAAC42C771CE9ABAE9E86877952AE9050EAC363D0C4376FDFE66EF1C7E6604EFF00A8FA551C26AD967EBD6E5A14DB8B26978B8178D905F3E2BD0B8AE87D3DFD0E5E4ECDB78A951E038215A5EC52F05E1612E30402865A00CB6C35E8CDB87AC0F196E29B32D29478BD44341E915C1F35E9B42962130C3DEFA05E44C899C9041366E56A1D91A897DE3988438F4B596FB4BA4AB18ED417D97ECBF73AA2BD2F5F417E68C33711D2778B8B75537BA6B1F330190804C34C01EE832EFF004EA2F92A687ABAC4C303A81751B6169DF1A8E2267922FF0049A3932705E0FA3708D96D8B4F4A6989D06A05F6B7CC58B008A5BA5BCC2270BA067355E79F88E00D829B03AE250CA82C072CDDCAB9C06047507506035A833796FCCBF4C32AF60BC3F8CCAC6E5B1B1AA7E035D6038339596C8E48517CD60351D441498D3B604E2AF88F026426EB29CB07694A2DC9A77494D02DBF10FBF46D73282B90FBCB1D6C01B01B5157555F314D8AA21A8E0CCE480505BA73CEDA1E3C46919805736CDA7531999C16D3D2F25985AE9D48A182CA6C6594A315CB70E003155BBE5AD576DCB33595D8F158C129B896C555B3C16B94EF1FCD6A433C8E3A66FE65F0C24C3348D9533558EB091739A1584F02F6C1BDE8AF618792D5628CC584EDC1766D5D56678B852B7D69B3B635E65AB47498FF00AC7E62D400D927803557D57106A79956CCE8AAE9F9959276937AD1DCC5F31E696599F66BCFE26C21E894A46B931B97C61090FC2386BE2F6E2045B2BAE19AE9F986C95A11B78BD5F538A216FD6CD095E4B9115D6EF1DB1EEA1DAEC8585392AD44965683AC0DB4B08D73752C8D3EE8636DA176F12C2943DDAE8B2815D6F2758D85155C2DE3628ADE7734913802F8CDB1AA87A56E2BBF54D3B8DA468D32A671AD398E0D8822E42C9D0ACC535B20C1606788F7CB12DDB02A838D5E57E2002B4584B7901E22A2C305FD9454A2CED4F42005A7F62A2E1941AAE6EC18D2B15BD4B4B40AC176E969BD17E62F90A55461354E28B5B18159040145EED7A6751640B9072B837A02B576B18301A158955C26F3FDC782295508CBDBF0AAA3AC2D0C7D93C7731C7588923C086EAE86DC7F88316B8AC4BC51C0F7804F83411E98B5F3A804A8AEAEDC359C4231C6D3F72E9AF1143535C9B57D8AD7E7B4AE4EAD7DC06C3B665D326D606ED71415C673A600485AE0DA68E9C6EEB24DC1ACBD78CAB667B4A8DE98A2F74DD570663A9788E5ED39695AF1999850AC5D86555DCCF17035B82D8A9DB84143A9530140AA2D02D712CCA514F40C2AAFAF681E9668FC85211D65615868379A0CE7B44A5493AAB6FEE636A75D67559B71F6899DA4D1B3A6F1E661DB90A5FBC7E7073058A292CE6DD6209107255966FB2BE6C8256A44FBC757B79ED1C2116342DF4AE260414BF1455757D62C004037AAED5C631DE53658160193D2EFF30EAE06A8B714F31E9AAD002F70E91081A530DF56CC147DE5184315073F7EF52F666D99F20FEA0B18A1414EB14B92D3B33BCD41D49563C639BAA99CCE6789AB4E81CDE7189449161CA0CE683FBE630F0A13E86AB1F32DB2B4FCE51FE65C555D34E8AACF9844D06D4DD553AA337AAEF0492B7CF705ABE61D44DD835D12D8132BDD5BF1FEDF684E176DECF81E331B250000A2AD5764DEA04188CABCE72AD6E6886CA8BEE8DE39BAF9970E4F25FD331278E47DC4A6038283C86D44D12BD4C112BBA28FEE1690064A5EB21D29EB2B08D2CC6ADB7BF04B97183014EB8C1E21B6DF9C0AEB6F317A9B76A3D039F38D403948C5050A746AFC24098AE91C8C19C5BDDA8BDBF655B31792F03AF8830222EA29DAB77F10AF384543F09C211AC9B7835CFE225ACAAC29EE625F336CA8F39DEB1F92A70D842E8506979CF1F9A8BB6AC0167CB8868F155A70DDBB3F30BAB56CBAB4F9E6A20E6084F870BF9980B026189763C869AE659F905855D7421E03D42C3B9038F35A820D6014A29F188CE59ABE1FC425747E3A50E872B55DE2149BCE19ADD077F12AA230DDE8AD7DE34460D5A83ACD74CFE1979EE70EF7DEBCC66E50B56EFA162FDA64A1A4E67BD5C4C04218979A65341C81CF72AF1DE0F07594BCF533FBA8C0405ADAE2F576FDA6698A1439D65DF3074105FD894377126E2E42A765BABED308D4987F7AFF0011F6B66C1ABA1BFC40088E8BD181B6DC19DFC4234D4E4429D4369304BC5AC0B577BC9DF51279A5C93CB38FFC8D8538B578EB5D62D1886CB4375AF0C6D55459C26B2BC3D9D46825A285761BA5EC4CF7CA567EC8CA9C3AB6B57E672D55551759CEE20BB37BE8BEB175444600EB7CBD20E0D56F9480C5CDE8C8E01C8C853D333A7BE5535F2E6180D62A97F25DF1FEE2322F685FFD20161DEDB9D6A6451820933F67CDC7437B7AB6A2C17BA56BC67A4B0944A9D634FE617F0324DBD0ABBF88560B510F497FEF30042A201341D6B5E218BA0285AAFC73DA6AF6681FDEBBC38D43225FB4592FE4FDA5A3962BA04304C403888C01E4D0C29ABE655B80B8718EFF0030285AB9AFF0732EBEC6D7C91AA69CA054792D42CC99ED15822AEC95BD6E5162F378850353E104E8F29282F3F0DC6B07E4A8E6E3ED05C8F1799FF971A46CC6A26B386B0625DDA7C660F629DE4A835954E1772B1A9283B4C9CF052C836B2A2BB0A83EBE6875D97946E814D6A0762FC4FF00CD88509EE4CB14F54A839657E20D7C3DD0C7FA65308913A14DF685378FC4379F6634515EA4A301F116C7CD88E657F105781AAACC2C05A6E3977F698221C417DA14A92E884F417592165A1E84C463BD6214D9F6E63BDBDB316015DEA28A55F40B9C2833788AA927C4B74DF9FB4FFC7800B11ED10B3B2A9E4FC449632310E1DE988EFE620828BA609516FDA8B901CD4DEB4BE92F141E89536B039E23D4946B05C12D553C1CC41656F69570C22A6630E1990E1F41895643DB10414546DA8ED21F10A949F10BB6FB0DC7786F70A095B0B501E8904E41EE47E1FD81953745F89564AAFF00B8315EB389A279947495E972BB7A63A109E7F13128952A6D88E254ABEF2B14C4B94D5563D00CEE572EE04AF5CF10B9BE3C4AED994F69A344CCA65B9267A4AED2B153885D759F04304B618E9F6F4CD6370B27C43CC6C33A9FB9D3B7A505F3E59999E92DAA6180DCBBE3D3333D22A95533D267A4CD769F0FB4AA98BD13E0899D431A96FA0769E0998659D47F31AE937C128B685F895C7108C16AD55456BE7DBB378715EFD156D7D7B7AE37133C3D08FB0DDDE2B531385F7D4B57AF9566F19BED2F10107777603FBF525A9B9D17A99A34BCC165CB971BE1A9C7A2B8A7CFA036E7C76F4B420745057D16D3CA547DEC23ECB65BD7DB5F4987B0F4AFE657D57FF98C3FF8FC7FF64FFE1F139FF8DF1FF1CE3D2BD6BD5FF8A71E83EEE3FE29C4657A919CFF00C6EFFF00D47FFFD9, N'')
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (81, N'Nguyễn Ngọc Phương', CAST(N'2005-02-28' AS Date), N'a@gmail.com', N'0905674831', 1, 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (82, N'Nguyễn Ngọc Phương', CAST(N'2002-07-30' AS Date), N'a@gmail.com', N'0905674831', 1, 4, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (83, N'Nguyễn Ngọc Phương', CAST(N'2002-06-05' AS Date), N'a@gmail.com', N'0905674831', 0, 5, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (84, N'Potato', CAST(N'2001-08-02' AS Date), N'potato@gmail.com', N'0987654321', 1, 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [NgaySinh], [Email], [SoDienThoai], [TrangThai], [MaKhuVuc], [TenTaiKhoan], [MatKhau], [LoaiTaiKhoan], [ImageData], [ImageExtension]) VALUES (85, N'Nguyễn Hoàng Nam', CAST(N'2002-05-31' AS Date), N'hoangnam@gmail.com', N'0987654328', 1, 2, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[TrangThaiDonHang] ON 
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (1, N'Chờ xử lý')
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (2, N'Đã nhận')
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (3, N'Đã phân phối')
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (4, N'Shipper đã nhận đơn')
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (5, N'Đã lấy hàng')
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (6, N'Đang giao hàng')
GO
INSERT [dbo].[TrangThaiDonHang] ([MaTrangThai], [TenTrangThai]) VALUES (7, N'Đã giao')
GO
SET IDENTITY_INSERT [dbo].[TrangThaiDonHang] OFF
GO
ALTER TABLE [dbo].[ChucNang]  WITH CHECK ADD FOREIGN KEY([MaLoaiTaiKhoan])
REFERENCES [dbo].[LoaiTaiKhoan] ([MaLoaiTaiKhoan])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([NhanVienNhan])
REFERENCES [dbo].[NhanVien] ([MaNhanVien])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([NhanVienPhanPhoi])
REFERENCES [dbo].[NhanVien] ([MaNhanVien])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD FOREIGN KEY([NhanVienGiao])
REFERENCES [dbo].[NhanVien] ([MaNhanVien])
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_TrangThaiDonHang] FOREIGN KEY([TrangThai])
REFERENCES [dbo].[TrangThaiDonHang] ([MaTrangThai])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_TrangThaiDonHang]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_KhuVuc] FOREIGN KEY([MaKhuVuc])
REFERENCES [dbo].[KhuVuc] ([MaKhuVuc])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_KhuVuc]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_LoaiTaiKhoan] FOREIGN KEY([LoaiTaiKhoan])
REFERENCES [dbo].[LoaiTaiKhoan] ([MaLoaiTaiKhoan])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_LoaiTaiKhoan]
GO
/****** Object:  StoredProcedure [dbo].[Account_Password]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Account_Password]
@username varchar(100)
AS
BEGIN
	select MatKhau 
	from NhanVien
	where TenTaiKhoan = @username
END
GO
/****** Object:  StoredProcedure [dbo].[Account_Session]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Account_Session]
@TenTaiKhoan varchar(200)
AS 
    begin 
        SELECT *
        FROM NhanVien
        WHERE TenTaiKhoan = @TenTaiKhoan
    end
GO
/****** Object:  StoredProcedure [dbo].[DonHang__Table_NhanDon]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang__Table_NhanDon]
	as 
		begin
			select * from DonHang
			where TrangThai=1
		end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Find_detail]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang_Find_detail] @MaDonHang int
as 
	begin
		if not exists(select MaDonHang from DonHang where MaDonHang = @MaDonHang)
			begin
				raiserror('Đơn hàng không tồn tại',16,1)
			end
		else
			begin
				select * from DonHang where MaDonHang = @MaDonHang
			end
	end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_GetChuaNhan]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang_GetChuaNhan]
as 
	begin
		select * from DonHang where TrangThai = 0
	end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_GetListDonHang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang_GetListDonHang] @MaTrangThai int
as begin
	if (@MaTrangThai is not null)
		begin
			Select * from DonHang where trangthai = @MaTrangThai
		end
end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_PhanPhoi]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang_PhanPhoi] @MaDonHang int,@NhanVienPhanPhoi int,@NhanVienGiao int
as begin
begin transaction
	if @MaDonHang is not null
	begin
		begin try
			update DonHang
			set NhanVienPhanPhoi = @NhanVienPhanPhoi,
				NhanVienGiao = @NhanVienGiao,
				TrangThai = 3,
				ThoiGianPhanPhoi = GETDATE()
				where MaDonHang =@MaDonHang
			commit
		end try
		begin catch
			DECLARE @ErrorMessage VARCHAR(2000)
			SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
			RAISERROR(@ErrorMessage, 16, 1)
		end catch
	end
	else
		begin
			rollback transaction
		end
end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_PhanPhoiSelectList_KhuVuc_NhanVien]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DonHang_PhanPhoiSelectList_KhuVuc_NhanVien] @DiaChiQuan nvarchar(50)
as begin
	begin try
		if(@DiaChiQuan is not null)
			begin
				select a.MaNhanVien, a.TenNhanVien from NhanVien a left join KhuVuc b on a.MaKhuVuc = b.MaKhuVuc  where b.TenKhuVuc = @DiaChiQuan
			end
	end try
	begin catch
	select -1 as result
	raiserror('Lỗi địa chỉ quận không hợp lệ',16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_TimKiemTheoTenNG]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang_TimKiemTheoTenNG] @TenNguoiGui nvarchar(50)
as begin
	begin try
	if (@tenNguoiGui is not null)
		begin
			Select * from DonHang where NguoiGui like '%'+@TenNguoiGui+'%'
		end
	if(@tenNguoiGui is null)
		begin
				Select * from DonHang
		end
	end try
	begin catch
	select -1 as result
	raiserror ('Loi Khong Tim Thay',16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[DonHang_XacNhanDon]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DonHang_XacNhanDon] @MaDonHang int, @MaNhanVien int
as begin
	begin transaction
		begin try
			if @MaDonHang is not null
				begin
					update DonHang
					set NhanVienNhan = @MaNhanVien,
						ThoiGianNhan = GETDATE(),
						TrangThai = 2
						where MaDonHang =@MaDonHang
					commit
				end
		end try
		begin catch
			DECLARE @ErrorMessage VARCHAR(2000)
			SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
			RAISERROR(@ErrorMessage, 16, 1)
			rollback transaction
		end catch
end
GO
/****** Object:  StoredProcedure [dbo].[GetByYear]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GetByYear]
@year int
as
begin
	select MaDonHang, NhanVienNhan, YEAR(ThoiGianNhan) as Nam, month(ThoiGianNhan) as Thang
	from DonHang
	where YEAR(ThoiGianNhan) = @year
END
GO
/****** Object:  StoredProcedure [dbo].[MenuOf]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MenuOf]
    @MaNhanVien INT
as
begin
    select ChucNang.*
    from NhanVien
	join ChucNang on NhanVien.LoaiTaiKhoan = ChucNang.MaLoaiTaiKhoan
    --join ChucNang on ChucNang.MaChucVu = NhanVien.ChucVu
    where NhanVien.MaNhanVien = @MaNhanVien
    ORDER BY ChucNang.MaChucNang
end
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_Add]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NhanVien_Add] 
@TenNhanVien nvarchar(50), 
@NgaySinh date, 
@Email varchar(50),
@Sdt varchar(12),
@MaKhuVuc int
as begin
	declare @result nvarchar(50)
	begin try
	if(@TenNhanVien is not null)
	begin
	if (year(getdate()) - Year(@NgaySinh) < 18)
		begin
			set @result = N'Nhân viên phải từ 18 tuổi trở lên';
			select @result as Result
			return
		end
		insert into NhanVien(TenNhanVien,NgaySinh,Email,SoDienThoai,TrangThai,MaKhuVuc)
		values(@TenNhanVien,@NgaySinh,@Email,@Sdt,1,@MaKhuVuc)
		declare @res int 
		select @res = @@IDENTITY
		set @result = N'Hợp lệ';
		select @result as Result
		return 
	end
	end try
	begin catch
		select @result as Result
		return
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[NhanVien_ChiTiet]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NhanVien_ChiTiet]
@MaNhanVien INT
AS
    BEGIN
        DECLARE @CHECK BIT = (SELECT TrangThai FROM NhanVien WHERE MaNhanVien = @MaNhanVien)
        IF(@CHECK = 0)
            BEGIN
                RAISERROR(16,1,1,'Nhân viên không tồn tại');
                RETURN -1;
            END
        ELSE
            BEGIN
                SELECT  nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, nv.TenTaiKhoan, nv.MatKhau, ltk.LoaiTaiKhoan as TenLoai, kv.TenKhuVuc
				FROM NhanVien nv
                JOIN LoaiTaiKhoan ltk ON nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan
				LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
                WHERE MaNhanVien = @MaNhanVien
            END
    END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_ChuaTK]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[NhanVien_ChuaTK]
AS
BEGIN
    select * from NhanVien
	where  TenTaiKhoan is null and TrangThai = 1
END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_DanhSach]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NhanVien_DanhSach]
AS
    BEGIN
        SELECT nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
		FROM NhanVien nv
		LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
		WHERE nv.TrangThai=1
	END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_KhuVuc]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NhanVien_KhuVuc]
AS
BEGIN
   SELECT * FROM KhuVuc   
END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_LoaiTK]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[NhanVien_LoaiTK]
AS
BEGIN
    select * from LoaiTaiKhoan
	where MaLoaiTaiKhoan != 1
END

GO
/****** Object:  StoredProcedure [dbo].[NhanVien_Sua]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NhanVien_Sua]
    @MaNhanVien int,
    @TenNhanVien NVARCHAR(100),
    @NgaySinh DATE,
    @Email VARCHAR(200),
    @SoDienThoai char(10),
	@MaKhuVuc int
AS
BEGIN
  BEGIN TRANSACTION
    BEGIN TRY
        SELECT 
		    @TenNhanVien = IIF(@TenNhanVien is null,TenNhanVien,@TenNhanVien),
		    @NgaySinh = IIF(@NgaySinh is null,NgaySinh,@NgaySinh),
		    @Email = IIF(@Email is null,Email,@Email),
		    @SoDienThoai = IIF(@SoDienThoai is null, SoDienThoai,@SoDienThoai),
			@MaKhuVuc = IIF(@MaKhuVuc is null, MaKhuVuc, @MaKhuVuc)
        FROM NhanVien
        UPDATE NhanVien
        SET 
            TenNhanVien = @TenNhanVien,
            NgaySinh = @NgaySinh,
            Email = @Email,
            SoDienThoai = @SoDienThoai,
			MaKhuVuc = @MaKhuVuc
        WHERE MaNhanVien = @MaNhanVien

        SELECT @MaNhanVien AS Result
		COMMIT TRANSACTION
     END TRY

     BEGIN CATCH
        SELECT -1 AS Result
		ROLLBACK TRANSACTION
     END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_ThemNhanVien]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[NhanVien_ThemNhanVien] 
@TenNhanVien nvarchar(50), 
@NgaySinh date, 
@Email varchar(50),
@Sdt varchar(12),
@MaKhuVuc int
as begin
	begin try
	if(@TenNhanVien is not null)
	begin
		insert into NhanVien(TenNhanVien,NgaySinh,Email,SoDienThoai,TrangThai,MaKhuVuc)
			values(@TenNhanVien,@NgaySinh,@Email,@Sdt,1,@MaKhuVuc)
		declare @res int 
		select @res = @@IDENTITY
		select @res as Result
	end
	end try
	begin catch
		select -1 as Result
		raiserror('Lỗi thêm nhân viên',16,1);
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_TimKiem]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NhanVien_TimKiem]
    @manv int, 
	@tennv nvarchar(100),
	@khuvuc nvarchar(50)
AS
BEGIN
	IF (@manv is not null OR @tennv is not null OR @khuvuc is not null) 
	  BEGIN
       SELECT nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
	   FROM NhanVien nv
       LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
	   WHERE TrangThai = 1 
	   AND (MaNhanVien = @manv OR TenNhanVien lIKE '%' + @tennv + '%' OR TenKhuVuc LIKE '%' + @khuvuc + '%')
	   ORDER BY MaNhanVien;
	  END
	ELSE
	  BEGIN 
	    SELECT nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
		FROM NhanVien nv
		LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
		WHERE nv.TrangThai = 1
	  END
END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_Xoa]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NhanVien_Xoa](
    @MaNhanVien INT
)
AS
    BEGIN
            BEGIN TRY
                UPDATE NhanVien
                SET TrangThai = 0
                WHERE MaNhanVien = @MaNhanVien
                SELECT @MaNhanVien
            END TRY

            BEGIN CATCH
                SELECT -1 AS Result 
            END CATCH
            
    END
GO
/****** Object:  StoredProcedure [dbo].[NhanVien_Xoa_ChiTiet]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NhanVien_Xoa_ChiTiet]
@MaNhanVien INT
AS
    BEGIN
        DECLARE @CHECK BIT = (SELECT TrangThai FROM NhanVien WHERE MaNhanVien = @MaNhanVien)
        IF(@CHECK = 0)
            BEGIN
                RAISERROR(16,1,1,'Nhân viên không tồn tại');
                RETURN -1;
            END
        ELSE
            BEGIN
                SELECT  nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
				FROM NhanVien nv
				LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
                WHERE MaNhanVien = @MaNhanVien
            END
    END
GO
/****** Object:  StoredProcedure [dbo].[Profile_Get]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profile_Get]
    @Id INT
AS
BEGIN
    SELECT nv.*, ltk.LoaiTaiKhoan as TenLoai, kv.TenKhuVuc
    FROM nhanvien nv
    JOIN LoaiTaiKhoan ltk ON nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan
	left JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
    WHERE nv.MaNhanVien = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Profile_Password]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Profile_Password]
@manv int
AS
BEGIN
	select MatKhau 
	from NhanVien
	where MaNhanVien = @manv
END
GO
/****** Object:  StoredProcedure [dbo].[Profile_Sua]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Profile_Sua]
    @MaNhanVien int,
    @TenNhanVien NVARCHAR(100),
    @NgaySinh DATE,
    @Email VARCHAR(200),
    @SoDienThoai char(10),
	@ImgData varbinary(max),
	@ImgExt varchar(10)
AS
BEGIN
	BEGIN transaction
		BEGIN TRY
			SELECT 
				@TenNhanVien = IIF(@TenNhanVien is null,TenNhanVien,@TenNhanVien),
				@NgaySinh = IIF(@NgaySinh is null,NgaySinh,@NgaySinh),
				@Email = IIF(@Email is null,Email,@Email),
				@SoDienThoai = IIF(@SoDienThoai is null, SoDienThoai,@SoDienThoai),
				@ImgData = IIF(@ImgData is null, ImageData,@ImgData),
				@ImgExt = IIF(@ImgExt is null, ImageExtension,@ImgExt)
			FROM NhanVien

			UPDATE NhanVien
			SET 
				TenNhanVien = @TenNhanVien,
				NgaySinh = @NgaySinh,
				Email = @Email,
				SoDienThoai = @SoDienThoai,
				ImageData = @ImgData,
				ImageExtension = @ImgExt
			WHERE MaNhanVien = @MaNhanVien

			SELECT @MaNhanVien AS Result
			commit transaction
		END TRY

        BEGIN CATCH
            SELECT -1 AS Result
			rollback transaction
        END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Shiper_Don_Hang_Can_Giao]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Shiper_Don_Hang_Can_Giao]
@id int
as
	begin
		begin transaction
		
		update DonHang
		set TrangThai = 4,
			ThoiGianNhanDon= getdate()
		where NhanVienGiao=@id and TrangThai=3

		select d.*,t.TenTrangThai
		from (select MaDonHang,Tu,NguoiGui,SdtNguoiGui,NguoiNhan,DiaChiNguoiNhan,DiaChiPhuong,DiaChiQuan,DiaChiThanhPho,Sdt,GhiChu,NhanVienGiao,TrangThai from DonHang) d
		join TrangThaiDonHang t on d.TrangThai = t.MaTrangThai
		where MaTrangThai in (3,4,5,6,7) and NhanVienGiao = @id;

		commit transaction 
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_Shiper_Thong_Tin_Don_Hang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_Shiper_Thong_Tin_Don_Hang]
@id int
as
	begin
		begin transaction

		select d.*,t.TenTrangThai
		from (select MaDonHang,Tu,NguoiGui,SdtNguoiGui,NguoiNhan,DiaChiNguoiNhan,DiaChiPhuong,DiaChiQuan,DiaChiThanhPho,Sdt,GhiChu,NhanVienGiao,TrangThai from DonHang) d
		join TrangThaiDonHang t on d.TrangThai = t.MaTrangThai
		where MaTrangThai in (3,4,5,6,7) and MaDonHang = @id;

		commit transaction 
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_Xac_Nhan_Da_Giao_Hang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Xac_Nhan_Da_Giao_Hang]
@idDonHang int
as
	begin
		begin try
			update DonHang
			set TrangThai = 7,
				ThoiGianDaGiao =getdate()
			where MaDonHang=@idDonHang and TrangThai=6
		
			select @idDonHang as Result
		end try
		begin catch
			select -1 as Result
		end catch
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_Xac_Nhan_Da_Lay_Hang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[sp_Xac_Nhan_Da_Lay_Hang]
@idDonHang int
as
	begin
		begin try
			update DonHang
			set TrangThai = 5,
				ThoiGianLayHang = getdate()
			where MaDonHang=@idDonHang and TrangThai=4

			select @idDonHang as Result
		end try
		begin catch
			select -1 as Result
		end catch
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_Xac_Nhan_Dang_Giao_Hang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Xac_Nhan_Dang_Giao_Hang]
@idDonHang int
as
	begin
		begin try
			update DonHang
			set TrangThai = 6,
				ThoiGianGiao=getdate()
			where MaDonHang=@idDonHang and TrangThai=5
		
			select @idDonHang as Result
		end try
		begin catch
			select -1 as Result
		end catch
	end
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_Add]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TaiKhoan_Add]
@Username varchar(100),
@Password varchar(2000),
@MaNV int,
@LTK int
AS
BEGIN
	declare @result NVARCHAR(50);
	begin try
		if exists(select TenTaiKhoan from NhanVien where TenTaiKhoan = @Username)
		begin 
					set @result = N'Tài khoản đã tồn tại';
					select @result as Result
					return
		end
			update NhanVien
			set TenTaiKhoan = @Username, MatKhau = @Password, LoaiTaiKhoan = @LTK
			where MaNhanVien = @MaNV;
			set @result = N'Thêm thành công';
			select @result as Result
			return
	end try
	begin catch
		select @result as Result
		return
	end catch
END
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_DangNhap_Shiper]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[TaiKhoan_DangNhap_Shiper]
@TenTaiKhoan varchar(200),
@MatKhau varchar(4000)
AS 
    begin 
        IF EXISTS (Select TenTaiKhoan
                    from NhanVien
					where TenTaiKhoan=@TenTaiKhoan and LoaiTaiKhoan=4)
            BEGIN
                IF EXISTS (Select TenTaiKhoan from NhanVien where TenTaiKhoan = @TenTaiKhoan and MatKhau = @MatKhau )
                    Select top 1 *,0 as Result from NhanVien where TenTaiKhoan=@TenTaiKhoan
                ELSE
                    Select 1 as Result
            END
        ELSE
            BEGIN
                SELECT 2 as Result
            END

    end
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_DanhSach]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TaiKhoan_DanhSach]
AS
BEGIN
	select nv.MaNhanVien,nv.TenTaiKhoan,nv.TenNhanVien,ltk.LoaiTaiKhoan 
	from NhanVien nv
	join LoaiTaiKhoan ltk on nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan 
	where nv.TrangThai = 1 and TenTaiKhoan is not null
END
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_DoiMK]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[TaiKhoan_DoiMK]
    @MaNhanVien INT,
    @MatKhau NVARCHAR(4000)
AS
BEGIN
    
	BEGIN TRY
        

        UPDATE NhanVien
        SET MatKhau = @MatKhau
        WHERE MaNhanVien = @MaNhanVien ;

        SELECT @MaNhanVien AS Result
        END TRY

        BEGIN CATCH
            SELECT -1 AS Result
        END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_LayTen]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[TaiKhoan_LayTen]
@manv int
AS
BEGIN
	select TenTaiKhoan
	from NhanVien
	where MaNhanVien = @manv
END
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_Profile]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[TaiKhoan_Profile]
    @MaNhanVien INT
AS
BEGIN
    
	BEGIN TRY
        SELECT  MaNhanVien, TenTaiKhoan, MatKhau, TrangThai
        FROM TaiKhoan
		WHERE MaNhanVien = @MaNhanVien;


        SELECT @MaNhanVien AS Result
        END TRY

        BEGIN CATCH
            SELECT -1 AS Result
        END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_Reset]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[TaiKhoan_Reset]
@manv int,
@pass varchar(4000)
AS
BEGIN
	update NhanVien
	set MatKhau = @pass
	where MaNhanVien = @manv

	        SELECT @manv AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_RSPass]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[TaiKhoan_RSPass]
@tentk varchar(50),
@pass varchar(4000)
AS
BEGIN
	update NhanVien
	set MatKhau = @pass
	where TenTaiKhoan = @tentk

	        SELECT @tentk AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[TaiKhoan_TimKiem]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TaiKhoan_TimKiem]
   @tentk nvarchar(50),
   @hoten nvarchar(100),
   @loaitk nvarchar(100)
AS
BEGIN
	IF (@tentk is not null OR @hoten is not null OR @loaitk is not null) 
	  BEGIN
       SELECT nv.MaNhanVien, nv.TenTaiKhoan,nv.TenNhanVien,ltk.LoaiTaiKhoan
	   FROM NhanVien nv
	   LEFT JOIN LoaiTaiKhoan ltk ON nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan 
	   WHERE TrangThai = 1
	   AND (TenTaiKhoan LIKE '%' + @tentk +'%' OR TenNhanVien lIKE '%' + @hoten + '%' OR ltk.LoaiTaiKhoan lIKE '%' + @loaitk + '%' )
	   ORDER BY MaNhanVien;
	  END
	ELSE
	  BEGIN 
	    SELECT nv.MaNhanVien, nv.TenTaiKhoan, nv.TenNhanVien, ltk.LoaiTaiKhoan
		FROM NhanVien nv
	    LEFT JOIN LoaiTaiKhoan ltk on nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan 
		WHERE nv.TrangThai = 1 and TenTaiKhoan is not null
	  END
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKe_DaNhan]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[ThongKe_DaNhan]
@year int,@month int
AS
BEGIN
	select day(ThoiGianNhan) as Ngay,month(ThoiGianNhan) as Thang,year(ThoiGianNhan) as Nam,count(MaDonHang) as SL
	from DonHang
	where month(ThoiGianNhan) = @month and year(ThoiGianNhan) = @year
	group by day(ThoiGianNhan), month(ThoiGianNhan),year(ThoiGianNhan)
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKe_LayNam]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[ThongKe_LayNam]
AS
BEGIN
    select distinct year(ThoiGianNhan) as Nam
	from DonHang
	where year(ThoiGianNhan) is not null
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKe_LayThang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[ThongKe_LayThang]
AS
BEGIN
    select distinct month(ThoiGianNhan) as Thang
	from DonHang
	where month(ThoiGianNhan) is not null
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeDonDaGiao]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThongKeDonDaGiao]
@year int,@month int
AS
BEGIN
	select day(ThoiGianDaGiao) as Ngay,month(ThoiGianDaGiao) as Thang,year(ThoiGianDaGiao) as Nam,count(MaDonHang) as SL
	from DonHang
	where month(ThoiGianDaGiao) = @month and year(ThoiGianDaGiao) = @year
	group by day(ThoiGianDaGiao), month(ThoiGianDaGiao),year(ThoiGianDaGiao)
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeDonDaGiao_LayNam]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ThongKeDonDaGiao_LayNam]
AS
BEGIN
    select distinct year(ThoiGianDaGiao) as Nam
	from DonHang
	where year(ThoiGianDaGiao) is not null
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeDonDaGiao_LayThang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeDonDaGiao_LayThang]
AS
BEGIN
    select distinct month(ThoiGianDaGiao) as Thang
	from DonHang
	where month(ThoiGianDaGiao) is not null
END
GO
/****** Object:  StoredProcedure [QLThongKe].[ThongKe_DaNhan]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [QLThongKe].[ThongKe_DaNhan]
@year int,@month int
AS
BEGIN
	select day(ThoiGianNhan) as Ngay,month(ThoiGianNhan) as Thang,year(ThoiGianNhan) as Nam,count(MaDonHang) as SL
	from DonHang
	where month(ThoiGianNhan) = @month and year(ThoiGianNhan) = @year
	group by day(ThoiGianNhan), month(ThoiGianNhan),year(ThoiGianNhan)
END
GO
/****** Object:  StoredProcedure [QLThongKe].[ThongKe_LayNam]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [QLThongKe].[ThongKe_LayNam]
AS
BEGIN
    select distinct year(ThoiGianNhan) as Nam
	from DonHang
	where year(ThoiGianNhan) is not null
END
GO
/****** Object:  StoredProcedure [QLThongKe].[ThongKe_LayThang]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [QLThongKe].[ThongKe_LayThang]
AS
BEGIN
    select distinct month(ThoiGianNhan) as Thang
	from DonHang
	where month(ThoiGianNhan) is not null
END
GO
/****** Object:  StoredProcedure [QLTimKiem].[NhanVien_TimKiem]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [QLTimKiem].[NhanVien_TimKiem]
    @manv int, 
	@tennv nvarchar(100),
	@khuvuc nvarchar(50)
AS
BEGIN
	IF (@manv is not null OR @tennv is not null OR @khuvuc is not null) 
	  BEGIN
       SELECT nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
	   FROM NhanVien nv
       LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
	   WHERE TrangThai = 1 
	   AND (MaNhanVien = @manv OR TenNhanVien lIKE '%' + @tennv + '%' OR TenKhuVuc LIKE '%' + @khuvuc + '%')
	   ORDER BY MaNhanVien;
	  END
	ELSE
	  BEGIN 
	    SELECT nv.MaNhanVien, nv.TenNhanVien, nv.NgaySinh, nv.Email, nv.SoDienThoai, kv.TenKhuVuc
		FROM NhanVien nv
		LEFT JOIN KhuVuc kv ON nv.MaKhuVuc = kv.MaKhuVuc
		WHERE nv.TrangThai = 1
	  END
END
GO
/****** Object:  StoredProcedure [QLTimKiem].[TaiKhoan_TimKiem]    Script Date: 04-Jun-23 8:03:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [QLTimKiem].[TaiKhoan_TimKiem]
   @tentk nvarchar(50),
   @hoten nvarchar(100),
   @loaitk nvarchar(100)
AS
BEGIN
	IF (@tentk is not null OR @hoten is not null OR @loaitk is not null) 
	  BEGIN
       SELECT nv.MaNhanVien, nv.TenTaiKhoan,nv.TenNhanVien,ltk.LoaiTaiKhoan
	   FROM NhanVien nv
	   LEFT JOIN LoaiTaiKhoan ltk ON nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan 
	   WHERE TrangThai = 1 and TenTaiKhoan is null
	   AND (TenTaiKhoan LIKE '%' + @tentk +'%' OR TenNhanVien lIKE '%' + @hoten + '%' OR ltk.LoaiTaiKhoan lIKE '%' + @loaitk + '%' )
	   ORDER BY MaNhanVien;
	  END
	ELSE
	  BEGIN 
	    SELECT nv.MaNhanVien, nv.TenTaiKhoan, nv.TenNhanVien, ltk.LoaiTaiKhoan
		FROM NhanVien nv
	    LEFT JOIN LoaiTaiKhoan ltk on nv.LoaiTaiKhoan = ltk.MaLoaiTaiKhoan 
		WHERE nv.TrangThai = 1
	  END
END
GO
ALTER DATABASE [GiaoHang] SET  READ_WRITE 
GO
