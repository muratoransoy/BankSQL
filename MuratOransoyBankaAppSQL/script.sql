USE [bankApp]
GO
/****** Object:  UserDefinedFunction [dbo].[SubeGetir]    Script Date: 6.12.2022 23:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[SubeGetir](@KategoriID int)
Returns int
As
Begin
Declare @count int
Select @count = COUNT(l.loan_amount) From branch b
Inner Join loan l On b.bid = l.bid
Where l.bid=@KategoriID
Return @count
End
GO
/****** Object:  UserDefinedFunction [dbo].[ToplamaYap]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[ToplamaYap](@sayi1 int,@sayi2 int)
Returns int
As
Begin
Declare @toplam int
Set @toplam = @sayi1+ @sayi2
return @toplam
End
GO
/****** Object:  UserDefinedFunction [dbo].[YasHesapla]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[YasHesapla](@tarih Date)
Returns int
As
Begin
Declare @sonuc int
Set @sonuc = DATEDIFF(Year,@tarih,GETDATE())
Return @sonuc
End
GO
/****** Object:  UserDefinedFunction [dbo].[YatırılanparaHesapla]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[YatırılanparaHesapla](@ID int)
Returns int
As
Begin
Declare @adet int
Select @adet = SUM(t.transaction_amount) From customer c
Inner Join account a On a.custid=c.custid
Inner Join trandetails t On t.acnumber = a.acnumber
Where c.custid=@ID
Group By c.custid
Return @adet
End
GO
/****** Object:  Table [dbo].[customer]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[custid] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](30) NULL,
	[mname] [varchar](30) NULL,
	[ltname] [varchar](30) NULL,
	[city] [varchar](15) NULL,
	[mobileno] [varchar](10) NULL,
	[occupation] [varchar](10) NULL,
	[dob] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loan]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loan](
	[custid] [int] NULL,
	[bid] [int] NULL,
	[loan_amount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[borcagoreisimgetir]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[borcagoreisimgetir]
as
select top 100 percent  c.ltname,loan_amount from loan l inner join customer c on l.custid=c.custid order by loan_amount desc
GO
/****** Object:  View [dbo].[borcagoregetir]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[borcagoregetir]
as
select top 100 percent  custid,loan_amount from loan order by loan_amount desc
GO
/****** Object:  Table [dbo].[branch]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[branch](
	[bid] [int] IDENTITY(1,1) NOT NULL,
	[bname] [varchar](30) NULL,
	[bcity] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Istanbullular]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[Istanbullular]
as
select b.bname,b.bcity,o.loan_amount
from branch b inner join loan o
on b.bid=o.bid
where b.bcity='Istanbul'
GO
/****** Object:  Table [dbo].[account]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[acnumber] [int] IDENTITY(1,1) NOT NULL,
	[custid] [int] NULL,
	[bid] [int] NULL,
	[opening_balance] [int] NULL,
	[aod] [date] NULL,
	[atype] [varchar](10) NULL,
	[astatus] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[acnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerYedek]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerYedek](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Custid] [int] NULL,
	[Eklenenfname] [nvarchar](20) NULL,
	[EklenenYazarlname] [nvarchar](20) NULL,
	[islemAd] [nvarchar](20) NULL,
	[tarih] [date] NULL,
	[Islemturu] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trandetails]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trandetails](
	[tnumber] [int] IDENTITY(1,1) NOT NULL,
	[acnumber] [int] NULL,
	[dot] [date] NULL,
	[medium_of_transaction] [varchar](20) NULL,
	[transaction_type] [varchar](20) NULL,
	[transaction_amount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[tnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[account] ON 

INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (20, 1, 1, 1000, CAST(N'2012-12-15' AS Date), N'Saving', N'Active')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (21, 2, 2, 1000, CAST(N'2012-06-12' AS Date), N'Saving', N'Active')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (22, 3, 3, 1000, CAST(N'2012-05-17' AS Date), N'Saving', N'Terminated')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (23, 4, 4, 1000, CAST(N'2013-01-27' AS Date), N'Saving', N'Active')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (24, 5, 5, 1000, CAST(N'2012-12-17' AS Date), N'Saving', N'Active')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (25, 6, 6, 1000, CAST(N'2010-08-12' AS Date), N'Saving', N'Suspended')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (26, 7, 7, 1000, CAST(N'2012-10-02' AS Date), N'Saving', N'Active')
INSERT [dbo].[account] ([acnumber], [custid], [bid], [opening_balance], [aod], [atype], [astatus]) VALUES (27, 8, 8, 1000, CAST(N'2009-11-09' AS Date), N'Saving', N'Terminated')
SET IDENTITY_INSERT [dbo].[account] OFF
GO
SET IDENTITY_INSERT [dbo].[branch] ON 

INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (1, N'Balat', N'Istanbul')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (2, N'Delhi cantt', N'Istanbul')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (3, N'Cihangir', N'Istanbul')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (4, N'Barbaros', N'Çanakkale')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (5, N'Cevatpasa', N'Çanakkale')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (6, N'Kepez', N'Çanakkale')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (7, N'Dilaverbey ', N'Edirne')
INSERT [dbo].[branch] ([bid], [bname], [bcity]) VALUES (8, N'Karaagaç', N'Edirne')
SET IDENTITY_INSERT [dbo].[branch] OFF
GO
SET IDENTITY_INSERT [dbo].[customer] ON 

INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (1, N'Ramesh', N'Chandra', N'Sharma', N'Istanbul', N'9543198345', N'Hizmet', CAST(N'1976-12-06' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (2, N'Avinash', N'Sunder', N'Minha', N'Istanbul', N'9876532109', N'Hizmet', CAST(N'1974-10-16' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (3, N'Rahul', NULL, N'Rastogi', N'Istanbul', N'9765178901', N'Ögrenci', CAST(N'1981-09-26' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (4, N'Parul', NULL, N'Gandhi', N'Çanakkale', N'9876532109', N'Ev Hanimi', CAST(N'1976-11-03' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (5, N'Naveen', N'Chandra', N'Aedekar', N'Edirne', N'8976523190', N'Hizmet', CAST(N'1976-09-19' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (6, N'Chitresh', NULL, N'Barwe', N'Edirne', N'7651298321', N'Ögrenci', CAST(N'1992-11-06' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (7, N'Amit', N'Kumar', N'Borkar', N'Izmir', N'9875189761', N'Ögrenci', CAST(N'1981-09-06' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (8, N'Nisha', NULL, N'Damle', N'Edirne', N'7954198761', N'Hizmet', CAST(N'1975-12-03' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (9, N'Abhishek', NULL, N'Dutta', N'Çanakkale', N'9856198761', N'Hizmet', CAST(N'1973-05-22' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (10, N'Shankar', NULL, N'Nair', N'Izmir', N'8765489076', N'Hizmet', CAST(N'1976-07-12' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (11, N'Murat', NULL, N'Oransoy', N'Edirne', N'5428467654', N'Yazilimci', CAST(N'2001-09-15' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (13, N'fatma', NULL, N'öztürk', N'çanakkale', N'5428467123', N'Yazilimci', CAST(N'1993-09-15' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (14, N'fatma', NULL, N'öztürk', N'çanakkale', N'5428467123', N'Yazilimci', CAST(N'1993-09-15' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (15, N'engin', NULL, N'yilmaz', N'çanakkale', N'5428467123', N'Yazilimci', CAST(N'1993-09-15' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (16, N'engin', NULL, N'yilmaz', N'çanakkale', N'5428467123', N'Yazilimci', CAST(N'1993-09-15' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (17, N'damla', NULL, N'yilmaz', N'çanakkale', N'5428467123', N'Yazilimci', CAST(N'1993-09-15' AS Date))
INSERT [dbo].[customer] ([custid], [fname], [mname], [ltname], [city], [mobileno], [occupation], [dob]) VALUES (18, N'damla', NULL, N'yilmaz', N'çanakkale', N'5428467123', N'Yazilimci', CAST(N'1993-09-15' AS Date))
SET IDENTITY_INSERT [dbo].[customer] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerYedek] ON 

INSERT [dbo].[CustomerYedek] ([Id], [Custid], [Eklenenfname], [EklenenYazarlname], [islemAd], [tarih], [Islemturu]) VALUES (1, 13, N'fatma', N'öztürk', N'sa', CAST(N'2022-12-06' AS Date), N'Ekleme')
INSERT [dbo].[CustomerYedek] ([Id], [Custid], [Eklenenfname], [EklenenYazarlname], [islemAd], [tarih], [Islemturu]) VALUES (2, 14, N'fatma', N'öztürk', N'sa', CAST(N'2022-12-06' AS Date), N'Ekleme')
INSERT [dbo].[CustomerYedek] ([Id], [Custid], [Eklenenfname], [EklenenYazarlname], [islemAd], [tarih], [Islemturu]) VALUES (3, 15, N'engin', N'yilmaz', N'sa', CAST(N'2022-12-06' AS Date), N'Ekleme')
INSERT [dbo].[CustomerYedek] ([Id], [Custid], [Eklenenfname], [EklenenYazarlname], [islemAd], [tarih], [Islemturu]) VALUES (4, 16, N'engin', N'yilmaz', N'sa', CAST(N'2022-12-06' AS Date), N'Ekleme')
INSERT [dbo].[CustomerYedek] ([Id], [Custid], [Eklenenfname], [EklenenYazarlname], [islemAd], [tarih], [Islemturu]) VALUES (5, 17, N'damla', N'yilmaz', N'sa', CAST(N'2022-12-06' AS Date), N'Ekleme')
INSERT [dbo].[CustomerYedek] ([Id], [Custid], [Eklenenfname], [EklenenYazarlname], [islemAd], [tarih], [Islemturu]) VALUES (6, 18, N'damla', N'yilmaz', N'sa', CAST(N'2022-12-06' AS Date), N'Ekleme')
SET IDENTITY_INSERT [dbo].[CustomerYedek] OFF
GO
INSERT [dbo].[loan] ([custid], [bid], [loan_amount]) VALUES (1, 1, 100000)
INSERT [dbo].[loan] ([custid], [bid], [loan_amount]) VALUES (2, 2, 200000)
INSERT [dbo].[loan] ([custid], [bid], [loan_amount]) VALUES (9, 8, 400000)
INSERT [dbo].[loan] ([custid], [bid], [loan_amount]) VALUES (7, 3, 600000)
INSERT [dbo].[loan] ([custid], [bid], [loan_amount]) VALUES (5, 1, 600000)
INSERT [dbo].[loan] ([custid], [bid], [loan_amount]) VALUES (10, 5, 500000)
GO
SET IDENTITY_INSERT [dbo].[trandetails] ON 

INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (27, 20, CAST(N'2013-01-01' AS Date), N'Cheque', N'Withdrawal', 2000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (28, 20, CAST(N'2013-02-01' AS Date), N'Cash', N'Withdrawal', 1000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (29, 21, CAST(N'2013-01-01' AS Date), N'Cash', N'Withdrawal', 2000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (30, 21, CAST(N'2013-02-01' AS Date), N'Cash', N'Withdrawal', 3000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (31, 26, CAST(N'2013-01-11' AS Date), N'Cash', N'Withdrawal', 7000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (32, 26, CAST(N'2013-01-13' AS Date), N'Cash', N'Withdrawal', 9000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (33, 23, CAST(N'2013-03-13' AS Date), N'Cash', N'Withdrawal', 4000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (34, 27, CAST(N'2013-03-14' AS Date), N'Cheque', N'Withdrawal', 3000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (35, 24, CAST(N'2013-03-21' AS Date), N'Cash', N'Withdrawal', 9000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (36, 25, CAST(N'2013-03-22' AS Date), N'Cash', N'Withdrawal', 2000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (37, 22, CAST(N'2013-03-25' AS Date), N'Cash', N'Withdrawal', 7000)
INSERT [dbo].[trandetails] ([tnumber], [acnumber], [dot], [medium_of_transaction], [transaction_type], [transaction_amount]) VALUES (38, 27, CAST(N'2013-03-26' AS Date), N'Cash', N'Withdrawal', 2000)
SET IDENTITY_INSERT [dbo].[trandetails] OFF
GO
ALTER TABLE [dbo].[account]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[branch] ([bid])
GO
ALTER TABLE [dbo].[account]  WITH CHECK ADD FOREIGN KEY([custid])
REFERENCES [dbo].[customer] ([custid])
GO
ALTER TABLE [dbo].[loan]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[branch] ([bid])
GO
ALTER TABLE [dbo].[loan]  WITH CHECK ADD FOREIGN KEY([custid])
REFERENCES [dbo].[customer] ([custid])
GO
ALTER TABLE [dbo].[trandetails]  WITH CHECK ADD FOREIGN KEY([acnumber])
REFERENCES [dbo].[account] ([acnumber])
GO
/****** Object:  StoredProcedure [dbo].[bilancogetir]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[bilancogetir]
 (@getir nvarchar(20))
 as select a.opening_balance,a.atype from customer c inner join account a on
 a.custid=c.custid where fname=@getir
GO
/****** Object:  StoredProcedure [dbo].[Getir]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[Getir](@getirUrun int,@a nvarchar(20),@b nvarchar(20))
 as select * from customer c inner join account a on a.custid= c.custid
 where opening_balance= @getirUrun and fname between @a and @b
GO
/****** Object:  StoredProcedure [dbo].[MusteriSehir]    Script Date: 6.12.2022 23:16:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MusteriSehir] 
AS 
BEGIN 
SELECT city, COUNT(city) FROM dbo.customer 
GROUP BY city 
ORDER BY COUNT(city) DESC 
END
GO
