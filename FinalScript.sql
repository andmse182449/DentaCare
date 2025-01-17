USE master
GO

CREATE DATABASE DentaCare
GO

USE [DentaCare]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[accountID] [varchar](10) NOT NULL,
	[username] [varchar](40) NULL,
	[password] [varchar](250) NULL,
	[email] [varchar](30) NULL,
	[fullName] [nvarchar](50) NULL,
	[phone] [char](11) NULL,
	[address] [nvarchar](250) NULL,
	[dob] [date] NULL,
	[gender] [bit] NULL,
	[image] [varchar](200) NULL,
	[googleID] [varchar](100) NULL,
	[googleName] [varchar](100) NULL,
	[roleID] [int] NULL,
	[status] [int] NULL,
	[clinicID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[accountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOOKING]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOKING](
	[bookingID] [varchar](10) NOT NULL,
	[createDay] [date] NULL,
	[appointmentDay] [date] NULL,
	[status] [int] NULL,
	[price] [money] NULL,
	[deposit] [money] NULL,
	[serviceID] [int] NULL,
	[slotID] [int] NULL,
	[customerID] [varchar](10) NULL,
	[dentistID] [varchar](10) NULL,
	[clinicID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[bookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLINIC]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLINIC](
	[clinicID] [int] IDENTITY(1,1) NOT NULL,
	[clinicName] [nvarchar](50) NULL,
	[clinicAddress] [nvarchar](100) NULL,
	[city] [nvarchar](50) NULL,
	[hotline] [char](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[clinicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DAYOFFSCHEDULE]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DAYOFFSCHEDULE](
	[dayOffScheduleID] [int] IDENTITY(0,1) NOT NULL,
	[dayOff] [date] NULL,
	[description] [nvarchar](100) NULL,
	[clinicID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[dayOffScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DENTISTSCHEDULE]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DENTISTSCHEDULE](
	[dentistScheduleID] [int] IDENTITY(0,1) NOT NULL,
	[accountID] [varchar](10) NULL,
	[workingDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[dentistScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FEEDBACK]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FEEDBACK](
	[feedbackID] [varchar](50) NOT NULL,
	[feedbackDay] [datetime] NULL,
	[feedbackContent] [nvarchar](max) NULL,
	[accountID] [varchar](10) NULL,
	[bookingID] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[feedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INVOICE]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVOICE](
	[invoiceID] [varchar](10) NOT NULL,
	[invoiceDay] [date] NULL,
	[invoiceStatus] [int] NULL,
	[bookingID] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[invoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAJOR]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAJOR](
	[majorID] [varchar](3) NOT NULL,
	[majorName] [nvarchar](30) NULL,
	[majorDescription] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[majorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAJORDETAIL]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAJORDETAIL](
	[majorID] [varchar](3) NOT NULL,
	[accountID] [varchar](10) NOT NULL,
	[introduction] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[majorID] ASC,
	[accountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEDIICALRECORDS]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEDIICALRECORDS](
	[medicalRecordID] [varchar](10) NOT NULL,
	[results] [nvarchar](max) NULL,
	[reExanime] [date] NULL,
	[bookingID] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[medicalRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PAYMENT]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAYMENT](
	[paymentID] [char](8) NOT NULL,
	[amount] [money] NULL,
	[orderInfo] [nvarchar](200) NULL,
	[responseCode] [int] NULL,
	[transactionNo] [char](8) NULL,
	[bankCode] [char](5) NULL,
	[paymentDay] [datetime] NULL,
	[bookingID] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[roleID] [int] IDENTITY(0,1) NOT NULL,
	[roleName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SERVICE]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICE](
	[serviceID] [int] IDENTITY(0,1) NOT NULL,
	[serviceName] [nvarchar](50) NULL,
	[serviceType] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[price] [money] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[serviceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SETTING]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SETTING](
	[depositPercent] [int] NULL,
	[limitBooking] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIMESLOT]    Script Date: 7/21/2024 10:23:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIMESLOT](
	[slotID] [int] IDENTITY(0,1) NOT NULL,
	[timePeriod] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[slotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400001', N'ngohung19042004@gmail.com', NULL, N'ngohung19042004@gmail.com', N'Ngo Viet Hung', N'0382296287 ', N'424/8 Pham Van Bach, Tan Binh, HCM', CAST(N'2004-04-19' AS Date), 1, NULL, N'102735074553574840426', N'ngohung19042004@gmail.com', 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400002', N'hungnvse182441@fpt.edu.vn', NULL, N'hungnvse182441@fpt.edu.vn', N'Nguyen Viet Hoang', N'0325849564 ', N'123 Nguyen Van Tang, Quan 9, TP Thu Duc', CAST(N'2000-06-20' AS Date), 1, NULL, N'111790070927900086354', N'hungnvse182441@fpt.edu.vn', 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400003', N'tuannguyen', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'nguyentuan@gmail.com', N'Nguyen Anh Tuan', N'0744894956 ', N'4/2 Lê Van Viê?t', CAST(N'1999-07-15' AS Date), 1, NULL, NULL, NULL, 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400004', N'kiity', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'krixi@gmail.com', N'Hoang Phuong Ly', N'0912479597 ', N'123 Quang Trung, Go` Vâ´p', CAST(N'2000-10-11' AS Date), 0, NULL, NULL, NULL, 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400005', N'cr7', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'cr7.football@gmail.com', N'Ronaldo Nguyen', N'0358472596 ', N'92 Nguyen Trung Truc', CAST(N'1970-12-24' AS Date), 1, NULL, NULL, NULL, 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400006', N'lyly11', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'nguenLy@gmail.com', N'Ða?ng Phuong Ly', N'0862574813 ', N'11 Phan Huy I´ch', CAST(N'2000-03-12' AS Date), 0, NULL, NULL, NULL, 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'CUS2400007', N'linhHoang@', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'linhCute@gmail.com', N'Luong Thuy Linh', N'0168433121 ', N'22/32 Kha Va?n Cân', CAST(N'1998-05-07' AS Date), 0, NULL, NULL, NULL, 0, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'DEN2400001', N'bs-nphuc11111001', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'nphuc11111@gmail.com', N'Nguyễn Hoàng Phúc', N'0707268418 ', N'172/1 Lê Văn Việt', CAST(N'2024-07-25' AS Date), 1, N'CT1.jpg', NULL, NULL, 1, 0, 1)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'OWN2400001', N'hungAdmin', N'993f2322f02ec3ce3d7849391b6f3668124130e83d32b96074bfa29c15d051b8', N'abc@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 0, NULL)
INSERT [dbo].[ACCOUNT] ([accountID], [username], [password], [email], [fullName], [phone], [address], [dob], [gender], [image], [googleID], [googleName], [roleID], [status], [clinicID]) VALUES (N'STA2400001', N'nv-nqbao113001', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'nqbao113@gmail.com', N'Nguyễn Quốc Bảo', N'0904976757 ', N'221/3 Đường Vườn Lài, Tân Phú', NULL, NULL, NULL, NULL, NULL, 2, 0, 1)
GO
INSERT [dbo].[BOOKING] ([bookingID], [createDay], [appointmentDay], [status], [price], [deposit], [serviceID], [slotID], [customerID], [dentistID], [clinicID]) VALUES (N'BK24061101', CAST(N'2024-01-11' AS Date), CAST(N'2024-01-12' AS Date), 2, 800000.0000, 160000.0000, 5, 1, N'CUS2400005', N'DEN2400001', 1)
INSERT [dbo].[BOOKING] ([bookingID], [createDay], [appointmentDay], [status], [price], [deposit], [serviceID], [slotID], [customerID], [dentistID], [clinicID]) VALUES (N'BK24061102', CAST(N'2024-01-05' AS Date), CAST(N'2024-01-20' AS Date), 2, 1000000.0000, 200000.0000, 5, 1, N'CUS2400003', NULL, 1)
INSERT [dbo].[BOOKING] ([bookingID], [createDay], [appointmentDay], [status], [price], [deposit], [serviceID], [slotID], [customerID], [dentistID], [clinicID]) VALUES (N'BK24061103', CAST(N'2024-02-10' AS Date), CAST(N'2024-02-15' AS Date), 2, 1200000.0000, 240000.0000, 6, 2, N'CUS2400004', NULL, 1)
INSERT [dbo].[BOOKING] ([bookingID], [createDay], [appointmentDay], [status], [price], [deposit], [serviceID], [slotID], [customerID], [dentistID], [clinicID]) VALUES (N'BK24061104', CAST(N'2024-03-01' AS Date), CAST(N'2024-03-10' AS Date), 2, 900000.0000, 180000.0000, 7, 3, N'CUS2400005', NULL, 1)
INSERT [dbo].[BOOKING] ([bookingID], [createDay], [appointmentDay], [status], [price], [deposit], [serviceID], [slotID], [customerID], [dentistID], [clinicID]) VALUES (N'BK24061105', CAST(N'2024-04-15' AS Date), CAST(N'2024-04-25' AS Date), 2, 1100000.0000, 220000.0000, 8, 0, N'CUS2400006', NULL, 1)
INSERT [dbo].[BOOKING] ([bookingID], [createDay], [appointmentDay], [status], [price], [deposit], [serviceID], [slotID], [customerID], [dentistID], [clinicID]) VALUES (N'BK24072106', CAST(N'2024-07-21' AS Date), CAST(N'2024-07-22' AS Date), 0, 2000000.0000, 400000.0000, 7, 1, N'CUS2400001', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[CLINIC] ON 

INSERT [dbo].[CLINIC] ([clinicID], [clinicName], [clinicAddress], [city], [hotline]) VALUES (1, N'DentaCare Chi Nhánh Thủ Đức', N'Lô E2a-7, Đường D1, Đ. D1, Long Thạnh Mỹ', N'TP Thủ Đức, TP Hồ Chí Minh', N'0707268418 ')
INSERT [dbo].[CLINIC] ([clinicID], [clinicName], [clinicAddress], [city], [hotline]) VALUES (2, N'DentaCare Chi Nhánh Quận 9', N'157/1 Tân Lập 2, phường Hiệp Phú', N'Quận 9, TP Hồ Chí Minh', N'0961792119 ')
SET IDENTITY_INSERT [dbo].[CLINIC] OFF
GO
SET IDENTITY_INSERT [dbo].[DENTISTSCHEDULE] ON 

INSERT [dbo].[DENTISTSCHEDULE] ([dentistScheduleID], [accountID], [workingDate]) VALUES (34, N'DEN2400001', CAST(N'2024-07-22' AS Date))
SET IDENTITY_INSERT [dbo].[DENTISTSCHEDULE] OFF
GO
INSERT [dbo].[MAJOR] ([majorID], [majorName], [majorDescription]) VALUES (N'1', N'Teeth', N'About teeth and mouth')
GO
INSERT [dbo].[PAYMENT] ([paymentID], [amount], [orderInfo], [responseCode], [transactionNo], [bankCode], [paymentDay], [bookingID]) VALUES (N'70778102', 400000.0000, N'2024-07-22 2000000 1 7 1', 0, N'14523595', N'NCB  ', CAST(N'2024-07-21T00:00:00.000' AS DateTime), N'BK24072106')
GO
SET IDENTITY_INSERT [dbo].[ROLE] ON 

INSERT [dbo].[ROLE] ([roleID], [roleName]) VALUES (0, N'Customer')
INSERT [dbo].[ROLE] ([roleID], [roleName]) VALUES (1, N'Dentist')
INSERT [dbo].[ROLE] ([roleID], [roleName]) VALUES (2, N'Staff')
INSERT [dbo].[ROLE] ([roleID], [roleName]) VALUES (3, N'Clinic Owner')
SET IDENTITY_INSERT [dbo].[ROLE] OFF
GO
SET IDENTITY_INSERT [dbo].[SERVICE] ON 

INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (0, N'Teeth Cleaning', N'Caring Process', N'Professional cleaning to remove plaque, tartar, and stains from teeth, promoting oral health and preventing gum disease.', 200000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (1, N'Dental Sealants', N'Caring Process', N'Application of a protective coating on the chewing surfaces of back teeth to prevent cavities.', 400000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (2, N'Fluoride Treatment', N'Treatment Process', N' Fluoride application to strengthen tooth enamel and prevent decay.', 500000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (3, N'Composite Fillings', N'Treatment Process', N'Tooth-colored fillings used to repair cavities and restore damaged teeth.', 500000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (4, N'Tooth Extraction', N'Caring Process', N'Radiographic images used to diagnose dental issues not visible during a regular exam.', 200000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (5, N'Teeth Whitening', N'Caring Process', N'Professional teeth whitening treatment to remove stains and discoloration, resulting in a brighter smile.', 800000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (6, N'Dental Veneers', N'Caring Process', N'Thin, custom-made shells designed to cover the front surface of teeth to improve appearance.', 400000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (7, N'Root Canal Treatment', N'Treatment Process', N'Procedure to remove infected pulp from inside the tooth, clean and disinfect the root canals, and seal them to prevent further infection.', 2000000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (8, N'Orthodontic Consultation', N'Caring Process', N'Initial consultation to evaluate orthodontic needs and discuss treatment options such as braces or aligners.', 250000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (9, N'Dental X-Rays', N'Caring Process', N'Radiographic images used to diagnose dental issues not visible during a regular exam.', 800000.0000, 0)
INSERT [dbo].[SERVICE] ([serviceID], [serviceName], [serviceType], [description], [price], [status]) VALUES (10, N'Braces', N'Treatment Process', N'Orthodontic treatment involving the use of brackets and wires to align and straighten teeth, correct gaps, and address bite issues.', 20000000.0000, 0)
SET IDENTITY_INSERT [dbo].[SERVICE] OFF
GO
INSERT [dbo].[SETTING] ([depositPercent], [limitBooking]) VALUES (20, 2)
GO
SET IDENTITY_INSERT [dbo].[TIMESLOT] ON 

INSERT [dbo].[TIMESLOT] ([slotID], [timePeriod]) VALUES (0, N'07:00 - 09:00')
INSERT [dbo].[TIMESLOT] ([slotID], [timePeriod]) VALUES (1, N'09:00 - 11:00')
INSERT [dbo].[TIMESLOT] ([slotID], [timePeriod]) VALUES (2, N'13:00 - 15:00')
INSERT [dbo].[TIMESLOT] ([slotID], [timePeriod]) VALUES (3, N'15:00 - 17:00')
SET IDENTITY_INSERT [dbo].[TIMESLOT] OFF
GO
ALTER TABLE [dbo].[ACCOUNT]  WITH CHECK ADD  CONSTRAINT [FK_clinicID1] FOREIGN KEY([clinicID])
REFERENCES [dbo].[CLINIC] ([clinicID])
GO
ALTER TABLE [dbo].[ACCOUNT] CHECK CONSTRAINT [FK_clinicID1]
GO
ALTER TABLE [dbo].[ACCOUNT]  WITH CHECK ADD  CONSTRAINT [FK_roleID1] FOREIGN KEY([roleID])
REFERENCES [dbo].[ROLE] ([roleID])
GO
ALTER TABLE [dbo].[ACCOUNT] CHECK CONSTRAINT [FK_roleID1]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_accountID4] FOREIGN KEY([customerID])
REFERENCES [dbo].[ACCOUNT] ([accountID])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_accountID4]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_accountID5] FOREIGN KEY([dentistID])
REFERENCES [dbo].[ACCOUNT] ([accountID])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_accountID5]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_clinicID3] FOREIGN KEY([clinicID])
REFERENCES [dbo].[CLINIC] ([clinicID])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_clinicID3]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_serviceID1] FOREIGN KEY([serviceID])
REFERENCES [dbo].[SERVICE] ([serviceID])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_serviceID1]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_slotID1] FOREIGN KEY([slotID])
REFERENCES [dbo].[TIMESLOT] ([slotID])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_slotID1]
GO
ALTER TABLE [dbo].[DAYOFFSCHEDULE]  WITH CHECK ADD  CONSTRAINT [FK_clinicID2] FOREIGN KEY([clinicID])
REFERENCES [dbo].[CLINIC] ([clinicID])
GO
ALTER TABLE [dbo].[DAYOFFSCHEDULE] CHECK CONSTRAINT [FK_clinicID2]
GO
ALTER TABLE [dbo].[DENTISTSCHEDULE]  WITH CHECK ADD  CONSTRAINT [FK_accountID1] FOREIGN KEY([accountID])
REFERENCES [dbo].[ACCOUNT] ([accountID])
GO
ALTER TABLE [dbo].[DENTISTSCHEDULE] CHECK CONSTRAINT [FK_accountID1]
GO
ALTER TABLE [dbo].[FEEDBACK]  WITH CHECK ADD  CONSTRAINT [FK_accountID3] FOREIGN KEY([accountID])
REFERENCES [dbo].[ACCOUNT] ([accountID])
GO
ALTER TABLE [dbo].[FEEDBACK] CHECK CONSTRAINT [FK_accountID3]
GO
ALTER TABLE [dbo].[FEEDBACK]  WITH CHECK ADD  CONSTRAINT [fk_bookingID] FOREIGN KEY([bookingID])
REFERENCES [dbo].[BOOKING] ([bookingID])
GO
ALTER TABLE [dbo].[FEEDBACK] CHECK CONSTRAINT [fk_bookingID]
GO
ALTER TABLE [dbo].[INVOICE]  WITH CHECK ADD  CONSTRAINT [FK_bookingID3] FOREIGN KEY([bookingID])
REFERENCES [dbo].[BOOKING] ([bookingID])
GO
ALTER TABLE [dbo].[INVOICE] CHECK CONSTRAINT [FK_bookingID3]
GO
ALTER TABLE [dbo].[MAJORDETAIL]  WITH CHECK ADD  CONSTRAINT [FK_accountID2] FOREIGN KEY([accountID])
REFERENCES [dbo].[ACCOUNT] ([accountID])
GO
ALTER TABLE [dbo].[MAJORDETAIL] CHECK CONSTRAINT [FK_accountID2]
GO
ALTER TABLE [dbo].[MAJORDETAIL]  WITH CHECK ADD  CONSTRAINT [FK_majorID1] FOREIGN KEY([majorID])
REFERENCES [dbo].[MAJOR] ([majorID])
GO
ALTER TABLE [dbo].[MAJORDETAIL] CHECK CONSTRAINT [FK_majorID1]
GO
ALTER TABLE [dbo].[MEDIICALRECORDS]  WITH CHECK ADD  CONSTRAINT [FK_bookingID1] FOREIGN KEY([bookingID])
REFERENCES [dbo].[BOOKING] ([bookingID])
GO
ALTER TABLE [dbo].[MEDIICALRECORDS] CHECK CONSTRAINT [FK_bookingID1]
GO
ALTER TABLE [dbo].[PAYMENT]  WITH CHECK ADD  CONSTRAINT [FK_bookingID2] FOREIGN KEY([bookingID])
REFERENCES [dbo].[BOOKING] ([bookingID])
GO
ALTER TABLE [dbo].[PAYMENT] CHECK CONSTRAINT [FK_bookingID2]
GO
