USE [master]
GO
/****** Object:  Database [JerseyZoneDB]    Script Date: 28/06/2020 8:47:09 PM ******/
CREATE DATABASE [JerseyZoneDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JerseyZoneDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.INFT3050SERVER\MSSQL\DATA\JerseyZoneDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'JerseyZoneDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.INFT3050SERVER\MSSQL\DATA\JerseyZoneDB_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [JerseyZoneDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JerseyZoneDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JerseyZoneDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JerseyZoneDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JerseyZoneDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [JerseyZoneDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JerseyZoneDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET RECOVERY FULL 
GO
ALTER DATABASE [JerseyZoneDB] SET  MULTI_USER 
GO
ALTER DATABASE [JerseyZoneDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JerseyZoneDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JerseyZoneDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JerseyZoneDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [JerseyZoneDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'JerseyZoneDB', N'ON'
GO
ALTER DATABASE [JerseyZoneDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [JerseyZoneDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = ALL, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [JerseyZoneDB]
GO
/****** Object:  User [INFT3050]    Script Date: 28/06/2020 8:47:09 PM ******/
CREATE USER [INFT3050] FOR LOGIN [INFT3050] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [INFT3050]
GO
/****** Object:  UserDefinedTableType [dbo].[MYITEMS]    Script Date: 28/06/2020 8:47:09 PM ******/
CREATE TYPE [dbo].[MYITEMS] AS TABLE(
	[MYITEMS_userID] [int] NOT NULL,
	[MYITEMS_productVendorUID] [varchar](10) NOT NULL,
	[MYITEMS_cartQuantity] [int] NULL,
	[MYITEMS_cartItemPrice] [money] NULL,
	[MYITEMS_cartTotalPrice] [money] NULL,
	PRIMARY KEY CLUSTERED 
(
	[MYITEMS_userID] ASC,
	[MYITEMS_productVendorUID] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[AdminAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminAccount](
	[adminID] [int] IDENTITY(10000,1) NOT NULL,
	[adminFirstName] [varchar](200) NOT NULL,
	[adminLastName] [varchar](200) NOT NULL,
	[adminEmail] [varchar](255) NOT NULL,
	[adminPassword] [varchar](100) NOT NULL,
	[adminIsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[adminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditCard]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCard](
	[cardName] [varchar](250) NULL,
	[cardNumber] [varchar](16) NOT NULL,
	[cardCVV] [varchar](3) NOT NULL,
	[cardExpiry] [date] NOT NULL,
	[FK_orderID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[orderDate] [date] NOT NULL,
	[orderCost] [money] NOT NULL,
	[orderTotalCost] [money] NOT NULL,
	[orderIsPaid] [bit] NOT NULL,
	[FK_postageID] [int] NOT NULL,
	[FK_userID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[playerID] [int] IDENTITY(1,1) NOT NULL,
	[playerFirstName] [varchar](100) NOT NULL,
	[playerLastName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[playerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostageAddress]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostageAddress](
	[addressID] [int] IDENTITY(1,1) NOT NULL,
	[addressStreet] [varchar](300) NOT NULL,
	[addressPostal] [varchar](300) NOT NULL,
	[addressCity] [varchar](300) NOT NULL,
	[addressCountry] [varchar](300) NOT NULL,
	[addressState] [varchar](3) NOT NULL,
	[addressPostCode] [int] NOT NULL,
	[FK_userID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[addressID] ASC,
	[FK_userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostageOption]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostageOption](
	[postageID] [int] IDENTITY(1,1) NOT NULL,
	[postageType] [varchar](100) NULL,
	[postageDays] [int] NULL,
	[postageCost] [money] NULL,
	[postageIsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[postageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productID] [int] IDENTITY(1,1) NOT NULL,
	[productVendorUID]  AS (CONVERT([varchar](10),([FK_teamID]+replicate('0',(7)-len([productID])))+CONVERT([varchar],[productID]))) PERSISTED NOT NULL,
	[productDescription] [varchar](250) NOT NULL,
	[productPrice] [money] NOT NULL,
	[productImage] [varchar](250) NOT NULL,
	[productIsActive] [bit] NOT NULL,
	[FK_playerID] [int] NOT NULL,
	[FK_teamID] [char](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[productVendorUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[FK_userID] [int] NOT NULL,
	[FK_orderID] [int] NOT NULL,
	[FK_productVendorUID] [varchar](10) NOT NULL,
	[cartItemPrice] [money] NOT NULL,
	[cartQuantity] [int] NOT NULL,
	[cartTotalPrice] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FK_userID] ASC,
	[FK_productVendorUID] ASC,
	[FK_orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[teamID] [char](3) NOT NULL,
	[teamLocation] [varchar](50) NOT NULL,
	[teamName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[teamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccount](
	[userID] [int] IDENTITY(10000,1) NOT NULL,
	[userFirstName] [varchar](200) NOT NULL,
	[userLastName] [varchar](200) NOT NULL,
	[userEmail] [varchar](200) NOT NULL,
	[userPassword] [varchar](200) NOT NULL,
	[userPhone] [varchar](10) NOT NULL,
	[userIsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdminAccount] ON 

INSERT [dbo].[AdminAccount] ([adminID], [adminFirstName], [adminLastName], [adminEmail], [adminPassword], [adminIsActive]) VALUES (10004, N'Mr', N'Metikur', N'admin1@gmail.com', N'ce984e371064cb800024129a5596f529', 1)
INSERT [dbo].[AdminAccount] ([adminID], [adminFirstName], [adminLastName], [adminEmail], [adminPassword], [adminIsActive]) VALUES (10005, N'Nick', N'Browning', N'admin2@gmail.com', N'c30f8803a865d0064dca4c353e8316c0', 1)
SET IDENTITY_INSERT [dbo].[AdminAccount] OFF
GO
INSERT [dbo].[CreditCard] ([cardName], [cardNumber], [cardCVV], [cardExpiry], [FK_orderID]) VALUES (N'arthur anderson', N'4444333322221111', N'123', CAST(N'2020-01-11' AS Date), 17)
INSERT [dbo].[CreditCard] ([cardName], [cardNumber], [cardCVV], [cardExpiry], [FK_orderID]) VALUES (N'arthur anderson', N'4444333322221111', N'123', CAST(N'2020-01-11' AS Date), 18)
INSERT [dbo].[CreditCard] ([cardName], [cardNumber], [cardCVV], [cardExpiry], [FK_orderID]) VALUES (N'arthur anderson', N'4444333322221111', N'123', CAST(N'2020-01-11' AS Date), 19)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([orderID], [orderDate], [orderCost], [orderTotalCost], [orderIsPaid], [FK_postageID], [FK_userID]) VALUES (17, CAST(N'2020-06-28' AS Date), 480.0000, 480.0000, 1, 1, 10009)
INSERT [dbo].[Orders] ([orderID], [orderDate], [orderCost], [orderTotalCost], [orderIsPaid], [FK_postageID], [FK_userID]) VALUES (18, CAST(N'2020-06-28' AS Date), 160.0000, 170.0000, 1, 3, 10009)
INSERT [dbo].[Orders] ([orderID], [orderDate], [orderCost], [orderTotalCost], [orderIsPaid], [FK_postageID], [FK_userID]) VALUES (19, CAST(N'2020-06-28' AS Date), 160.0000, 160.0000, 1, 1, 10009)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 

INSERT [dbo].[Player] ([playerID], [playerFirstName], [playerLastName]) VALUES (1, N'Kyler', N'Murray')
INSERT [dbo].[Player] ([playerID], [playerFirstName], [playerLastName]) VALUES (2, N'Julio', N'Jones')
INSERT [dbo].[Player] ([playerID], [playerFirstName], [playerLastName]) VALUES (3, N'Khalil', N'Mack')
INSERT [dbo].[Player] ([playerID], [playerFirstName], [playerLastName]) VALUES (4, N'Myles', N'Garrett')
INSERT [dbo].[Player] ([playerID], [playerFirstName], [playerLastName]) VALUES (5, N'Tom', N'Brady')
INSERT [dbo].[Player] ([playerID], [playerFirstName], [playerLastName]) VALUES (6, N'Aaron', N'Donald')
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[PostageAddress] ON 

INSERT [dbo].[PostageAddress] ([addressID], [addressStreet], [addressPostal], [addressCity], [addressCountry], [addressState], [addressPostCode], [FK_userID]) VALUES (9, N'24 James Street', N'PO Box 192', N'Horseshoe Bend', N'AU', N'NSW', 2320, 10009)
SET IDENTITY_INSERT [dbo].[PostageAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[PostageOption] ON 

INSERT [dbo].[PostageOption] ([postageID], [postageType], [postageDays], [postageCost], [postageIsActive]) VALUES (1, N'Normal', 3, 0.0000, 1)
INSERT [dbo].[PostageOption] ([postageID], [postageType], [postageDays], [postageCost], [postageIsActive]) VALUES (3, N'Express', 2, 10.0000, 1)
SET IDENTITY_INSERT [dbo].[PostageOption] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([productID], [productDescription], [productPrice], [productImage], [productIsActive], [FK_playerID], [FK_teamID]) VALUES (1, N'Kyles Murray Jersey', 160.0000, N'1-kyler-murray.png', 1, 1, N'ARI')
INSERT [dbo].[Product] ([productID], [productDescription], [productPrice], [productImage], [productIsActive], [FK_playerID], [FK_teamID]) VALUES (2, N'Julio Jones Jersey', 160.0000, N'12-julio-jones-alt.png', 1, 2, N'ATL')
INSERT [dbo].[Product] ([productID], [productDescription], [productPrice], [productImage], [productIsActive], [FK_playerID], [FK_teamID]) VALUES (3, N'Khalil Mack Jersey', 160.0000, N'52-khalil-mack.png', 1, 3, N'CHI')
INSERT [dbo].[Product] ([productID], [productDescription], [productPrice], [productImage], [productIsActive], [FK_playerID], [FK_teamID]) VALUES (4, N'Myles Garrett Jersey Edit', 160.0000, N'95-myles-garrett.png', 0, 4, N'CLE')
INSERT [dbo].[Product] ([productID], [productDescription], [productPrice], [productImage], [productIsActive], [FK_playerID], [FK_teamID]) VALUES (6, N'Aaron Donald Jersey', 160.0000, N'99-aaron-donald.png', 1, 6, N'LAR')
INSERT [dbo].[Product] ([productID], [productDescription], [productPrice], [productImage], [productIsActive], [FK_playerID], [FK_teamID]) VALUES (5, N'Tom Brady Jersey', 160.0000, N'12-tom-brady.png', 1, 5, N'TAM')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[ShoppingCart] ([FK_userID], [FK_orderID], [FK_productVendorUID], [cartItemPrice], [cartQuantity], [cartTotalPrice]) VALUES (10009, 17, N'ARI0000001', 160.0000, 3, 480.0000)
INSERT [dbo].[ShoppingCart] ([FK_userID], [FK_orderID], [FK_productVendorUID], [cartItemPrice], [cartQuantity], [cartTotalPrice]) VALUES (10009, 18, N'ATL0000002', 160.0000, 1, 160.0000)
INSERT [dbo].[ShoppingCart] ([FK_userID], [FK_orderID], [FK_productVendorUID], [cartItemPrice], [cartQuantity], [cartTotalPrice]) VALUES (10009, 19, N'LAR0000006', 160.0000, 1, 160.0000)
GO
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'ARI', N'Arizona', N'Cardinals')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'ATL', N'Atlanta', N'Falcons')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'BAL', N'Baltimore', N'Ravens')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'BUF', N'Buffalo', N'Bills')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'CAR', N'Carolina', N'Panthers')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'CHI', N'Chicago', N'Bears')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'CIN', N'Cincinnati', N'Bengals')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'CLE', N'Cleveland', N'Browns')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'DAL', N'Dallas', N'Cowboys')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'DEN', N'Denver', N'Broncos')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'DET', N'Detriot', N'Lions')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'GRE', N'Green Bay', N'Packers')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'HOU', N'Houston', N'Texans')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'IND', N'Indianapolis', N'Colts')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'JAX', N'Jacksonville', N'Jaquars')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'KAN', N'Kansas City', N'Chiefs')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'LVR', N'Las Vegas', N'Raiders')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'LAC', N'Los Angeles', N'Chargers')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'LAR', N'Los Angeles', N'Rams')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'MIA', N'Miami', N'Dolphins')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'MIN', N'Minnesota', N'Vikings')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'NPT', N'New England', N'Patriots')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'NOR', N'New Orleans', N'Saints')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'NYG', N'New York', N'Giants')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'NYJ', N'New York', N'Jets')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'PHI', N'Philadelphia', N'Eagles')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'PIT', N'Pittsburgh', N'Steelers')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'SAN', N'San Francisco', N'49ers')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'SEA', N'Seattle', N'Seahawks')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'TAM', N'Tampa Bay', N'Buccaneers')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'TEN', N'Tennessee', N'Titans')
INSERT [dbo].[Team] ([teamID], [teamLocation], [teamName]) VALUES (N'WAS', N'Washington', N'Redskins')
GO
SET IDENTITY_INSERT [dbo].[UserAccount] ON 

INSERT [dbo].[UserAccount] ([userID], [userFirstName], [userLastName], [userEmail], [userPassword], [userPhone], [userIsActive]) VALUES (10009, N'Nick', N'Browning', N'user1@gmail.com', N'2fc2e64c0a064c560b230b0b67fa721f', N'0409787662', 1)
INSERT [dbo].[UserAccount] ([userID], [userFirstName], [userLastName], [userEmail], [userPassword], [userPhone], [userIsActive]) VALUES (10010, N'Mike', N'Evans', N'user2@gmail.com', N'2fc2e64c0a064c560b230b0b67fa721f', N'0494898243', 0)
INSERT [dbo].[UserAccount] ([userID], [userFirstName], [userLastName], [userEmail], [userPassword], [userPhone], [userIsActive]) VALUES (10011, N'Tom', N'Brady', N'user3@gmail.com', N'2fc2e64c0a064c560b230b0b67fa721f', N'0492890883', 0)
SET IDENTITY_INSERT [dbo].[UserAccount] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__AdminAcc__9A3ED53F598C774D]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[AdminAccount] ADD UNIQUE NONCLUSTERED 
(
	[adminEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CreditCa__2E968F4E2A3A70D3]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[CreditCard] ADD UNIQUE NONCLUSTERED 
(
	[cardName] ASC,
	[FK_orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Orders__8056CD178D29FA9D]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[Orders] ADD UNIQUE NONCLUSTERED 
(
	[orderID] ASC,
	[FK_userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Player__CA1144951780BBD0]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[Player] ADD UNIQUE NONCLUSTERED 
(
	[playerID] ASC,
	[playerFirstName] ASC,
	[playerLastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PostageA__8E9EADBFBDC9FC58]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[PostageAddress] ADD UNIQUE NONCLUSTERED 
(
	[addressStreet] ASC,
	[addressPostal] ASC,
	[addressCity] ASC,
	[addressCountry] ASC,
	[addressState] ASC,
	[addressPostCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PostageO__EEE5F9231D352C88]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[PostageOption] ADD UNIQUE NONCLUSTERED 
(
	[postageType] ASC,
	[postageDays] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Product__CE7DE03E904DA902]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[Product] ADD UNIQUE NONCLUSTERED 
(
	[FK_playerID] ASC,
	[FK_teamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Team__99C8ACCA8CC67422]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[Team] ADD UNIQUE NONCLUSTERED 
(
	[teamLocation] ASC,
	[teamName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserAcco__D54ADF556F52E640]    Script Date: 28/06/2020 8:47:09 PM ******/
ALTER TABLE [dbo].[UserAccount] ADD UNIQUE NONCLUSTERED 
(
	[userEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminAccount] ADD  DEFAULT ((1)) FOR [adminIsActive]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [orderIsPaid]
GO
ALTER TABLE [dbo].[PostageOption] ADD  DEFAULT ((1)) FOR [postageIsActive]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1)) FOR [productIsActive]
GO
ALTER TABLE [dbo].[UserAccount] ADD  DEFAULT ((1)) FOR [userIsActive]
GO
ALTER TABLE [dbo].[CreditCard]  WITH CHECK ADD FOREIGN KEY([FK_orderID])
REFERENCES [dbo].[Orders] ([orderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([FK_postageID])
REFERENCES [dbo].[PostageOption] ([postageID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([FK_userID])
REFERENCES [dbo].[UserAccount] ([userID])
GO
ALTER TABLE [dbo].[PostageAddress]  WITH CHECK ADD FOREIGN KEY([FK_userID])
REFERENCES [dbo].[UserAccount] ([userID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([FK_playerID])
REFERENCES [dbo].[Player] ([playerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([FK_teamID])
REFERENCES [dbo].[Team] ([teamID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD FOREIGN KEY([FK_orderID])
REFERENCES [dbo].[Orders] ([orderID])
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD FOREIGN KEY([FK_productVendorUID])
REFERENCES [dbo].[Product] ([productVendorUID])
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD FOREIGN KEY([FK_userID])
REFERENCES [dbo].[UserAccount] ([userID])
GO
/****** Object:  StoredProcedure [dbo].[uspAddAdminAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddAdminAccount]
    @adminFirstName VARCHAR(200),
    @adminLastName VARCHAR(200),
    @adminEmail VARCHAR(200),
	@adminPassword VARCHAR(100),
	@adminIsActive BIT
AS
BEGIN TRANSACTION
    INSERT INTO AdminAccount(adminFirstName, adminLastName, adminEmail, adminPassword, adminIsActive)
        VALUES (@adminFirstName, @adminLastName, @adminEmail, @adminPassword, @adminIsActive)
    DECLARE @adminID INT
    SET @adminID = SCOPE_IDENTITY()
    
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddNewCreditCard]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddNewCreditCard]
    -- card
	@cardName VARCHAR(250),
    @cardNumber VARCHAR(16),
    @cardExpiry DATE,
	@orderID INT
AS
BEGIN TRANSACTION
    INSERT INTO CreditCard(cardName, cardNumber, cardExpiry, FK_orderID)
        VALUES (@cardName, @cardNumber, @cardExpiry, @orderID)


COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddNewItems]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddNewItems]
    @orderID INT,
	@myItems MYITEMS READONLY
AS
BEGIN TRANSACTION

    INSERT INTO ShoppingCart(FK_userID, FK_productVendorUID, FK_orderID, cartItemPrice, cartQuantity, cartTotalPrice)
        SELECT MYITEMS_userID, MYITEMS_productVendorUID, @orderID, MYITEMS_cartItemPrice, MYITEMS_cartQuantity, MYITEMS_cartTotalPrice FROM @myItems

COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddNewOrder]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddNewOrder]
    -- order
	@orderCost MONEY,
    @orderTotalCost MONEY,
    @orderIsPaid BIT,
    @postageID INT,
    @userID INT,

	-- credit card
    @cardName VARCHAR(250),
    @cardNumber VARCHAR(16),
	@cardCCV VARCHAR(3),
    @cardExpiry DATE,

	-- cart
    @myItems MYITEMS READONLY
AS
BEGIN TRANSACTION
    DECLARE @orderID INT
    INSERT INTO Orders(orderCost, orderTotalCost, orderIsPaid, FK_postageID, FK_userID)
        VALUES (@orderCost, @orderTotalCost, @orderIsPaid, @postageID, @userID)
    SET @orderID = SCOPE_IDENTITY()

    INSERT INTO CreditCard(cardName, cardNumber, cardCVV, cardExpiry, FK_orderID)
        VALUES (@cardName, @cardNumber, @cardCCV, @cardExpiry, @orderID)

    INSERT INTO ShoppingCart(FK_userID, FK_productVendorUID, FK_orderID, cartItemPrice, cartQuantity, cartTotalPrice)
        SELECT MYITEMS_userID, MYITEMS_productVendorUID, @orderID, MYITEMS_cartItemPrice, MYITEMS_cartQuantity, MYITEMS_cartTotalPrice FROM @myItems

COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddPostageAddress]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddPostageAddress]
	@addressStreet VARCHAR(100),
	@addressPostal VARCHAR(300),
	@addressCity VARCHAR(300),
	@addressCountry VARCHAR(20),
	@addressState VARCHAR(3),
	@addressPostCode INT,
	@FK_userID INT
AS
BEGIN TRANSACTION
	IF NOT exists(SELECT * FROM PostageAddress WHERE @addressStreet = addressStreet AND @addressPostal = addressPostal AND @addressCity = addressCity AND @addressCountry = addressCountry AND @addressState = addressState AND @addressPostCode = addressPostCode AND @FK_userID = FK_userID)
        BEGIN
            INSERT INTO PostageAddress(addressStreet, addressPostal, addressCity, addressCountry, addressState, addressPostCode, FK_userID)
                VALUES (@addressStreet, @addressPostal, @addressCity, @addressCountry, @addressState, @addressPostCode, @FK_userID);
			DECLARE @addressID INT
			SET @addressID = SCOPE_IDENTITY()
		END
    ELSE
		BEGIN
			SELECT @addressID = addressID FROM PostageAddress WHERE @addressStreet = addressStreet AND @addressPostal = addressPostal AND @addressCity = addressCity AND @addressCountry = addressCountry AND @addressState = addressState AND @addressPostCode = addressPostCode AND @FK_userID = FK_userID
		END
		
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddPostageOption]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddPostageOption]
	@postageType VARCHAR(100),
	@postageDays INT,
	@postageCost MONEY
AS
BEGIN TRANSACTION
	IF NOT exists(SELECT postageID FROM PostageOption WHERE postageType = @postageType)
        BEGIN
            INSERT INTO PostageOption(postageType, postageDays, postageCost)
                VALUES (@postageType, @postageDays, @postageCost);
        END
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddProduct]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAddProduct]
	-- player
    @playerFirstName VARCHAR(100),
	@playerLastName VARCHAR(100),

	-- team
	@teamID CHAR(3),

	-- product
	@productDescription VARCHAR(250),
	@productPrice MONEY,
	@productImage VARCHAR(250)
AS
BEGIN TRANSACTION
	-- playerID
    DECLARE @playerID INT
    IF NOT exists(SELECT playerID FROM Player WHERE playerFirstName = @playerFirstName AND playerLastName = @playerLastName)
        BEGIN
            INSERT INTO Player(playerFirstName, playerLastName)
                VALUES (@playerFirstName, @playerLastName)
            SET @playerID = SCOPE_IDENTITY()
        END
    ELSE
        BEGIN
            SELECT @playerID = playerID FROM Player WHERE playerFirstName = @playerFirstName AND playerLastName = @playerLastName
        END
    
	-- productUID
    DECLARE @productVendorUID VARCHAR(10)
    IF NOT exists(SELECT * FROM Product prod WHERE prod.FK_teamID = @teamID AND prod.FK_playerID = @playerID)
        BEGIN
            INSERT INTO Product(productDescription, productPrice, productImage, FK_playerID, FK_teamID)
                VALUES (@productDescription, @productPrice, @productImage, @playerID, @teamID);
            SELECT @productVendorUID = @productVendorUID
            FROM Product
            WHERE productID = SCOPE_IDENTITY()
        END
    
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspAddUserAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- add user account
CREATE PROCEDURE [dbo].[uspAddUserAccount]
    @userFirstName VARCHAR(200),
    @userLastName VARCHAR(200),
    @userEmail VARCHAR(200),
	@userPassword VARCHAR(100),
    @userPhone VARCHAR(10),
    @userIsActive BIT
AS
BEGIN TRANSACTION
    INSERT INTO UserAccount(userFirstName, userLastName, userEmail, userPassword, userPhone, userIsActive)
        VALUES (@userFirstName, @userLastName, @userEmail, @userPassword, @userPhone, @userIsActive)
    DECLARE @userID INT
    SET @userID = SCOPE_IDENTITY()
    
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspChangeAdminPassword]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspChangeAdminPassword]
    @adminEmail VARCHAR(255),
    @adminPassword VARCHAR(255)
AS
BEGIN
    UPDATE AdminAccount
    SET adminPassword = @adminPassword
    WHERE adminEmail = @adminEmail
END
GO
/****** Object:  StoredProcedure [dbo].[uspChangeUserPassword]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspChangeUserPassword]
    @userEmail VARCHAR(255),
    @userPassword VARCHAR(255)
AS
BEGIN
    UPDATE UserAccount
    SET userPassword = @userPassword
    WHERE userEmail = @userEmail
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetAdminAccount]
	@adminAccount VARCHAR(200), 
	@adminResult BIT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT adminEmail FROM AdminAccount WHERE @adminAccount = adminEmail)
		BEGIN
			SET @adminResult = 1
			SELECT * FROM AdminAccount
			WHERE adminEmail = @adminAccount
		END
	ELSE
		BEGIN
			SET @adminResult = 0
		END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminAccountByEmail]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetAdminAccountByEmail]
    @adminEmail VARCHAR(250)
AS
BEGIN
    SELECT *
    FROM AdminAccount
    WHERE adminEmail = @adminEmail
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminAccounts]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[uspGetAdminAccounts]
AS
BEGIN
    SELECT * FROM AdminAccount
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAdminID]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetAdminID]
    @adminAccount INT
AS
BEGIN
    SELECT *
    FROM AdminAccount
    WHERE adminID = @adminAccount
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAllProducts]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetAllProducts]
AS
BEGIN
    SELECT prod.productVendorUID, prod.productDescription, prod.productPrice, prod.productImage, prod.productIsActive, t.teamID, t.teamLocation, t.teamName, play.playerFirstName, play.playerLastName
    FROM Product prod, Team t, Player play
    WHERE prod.FK_teamID = t.teamID AND prod.FK_playerID = play.playerID
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAvailableProducts]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetAvailableProducts]
AS
BEGIN
    SELECT prod.productVendorUID, prod.productDescription, prod.productPrice, prod.productImage, prod.productIsActive, t.teamID, t.teamLocation, t.teamName, play.playerFirstName, play.playerLastName
    FROM Product prod, Team t, Player play
    WHERE prod.FK_teamID = t.teamID AND prod.FK_playerID = play.playerID AND prod.productIsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetOrderedProducts]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetOrderedProducts]
    @orderID INT
AS
BEGIN
    SELECT cart.FK_productVendorUID, cart.cartQuantity, play.playerFirstName, play.playerLastName, prod.productDescription, cart.cartItemPrice
    FROM Orders ord, ShoppingCart cart, UserAccount us, Product prod, Player play
    WHERE ord.orderID = @orderID AND ord.FK_userID = us.userID AND cart.FK_orderID = ord.orderID AND cart.FK_productVendorUID = prod.productVendorUID AND prod.FK_playerID = play.playerID
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPostageOptionInformation]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetPostageOptionInformation]
    @postageID INT
AS
BEGIN
    SELECT * FROM PostageOption WHERE postageID = @postageID
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPostageOptions]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetPostageOptions]
AS
BEGIN
	SELECT * FROM PostageOption
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPostageOptionSet]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetPostageOptionSet]
AS
BEGIN
    SELECT postageID, concat(postageType, ': ' + cast(postageDays AS VARCHAR(3)) + ' days' + ' $' + cast(postageCost AS VARCHAR(8))) AS postageMethod FROM PostageOption WHERE postageIsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetSingleOrder]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetSingleOrder]
    @orderID INT
AS
BEGIN
    SELECT * FROM Orders WHERE orderID = @orderID
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTeams]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetTeams]
AS
BEGIN
    SELECT teamID, concat(teamLocation, ' ' + teamName) AS teamFullName FROM Team
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetUserAccount]
	@userAccount VARCHAR(200), 
	@userResult BIT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT userEmail FROM UserAccount WHERE @userAccount = userEmail)
		BEGIN
			SET @userResult = 1
			SELECT * FROM UserAccount
			WHERE userEmail = @userAccount
		END
	ELSE
		BEGIN
			SET @userResult = 0
		END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserAccountByEmail]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetUserAccountByEmail]
    @userEmail VARCHAR(200)
AS
BEGIN
    SELECT *
    FROM UserAccount
    WHERE userEmail = @userEmail
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserAccounts]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[uspGetUserAccounts]
AS
BEGIN
    SELECT * FROM UserAccount
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserID]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetUserID]
    @userID INT
AS
BEGIN
    SELECT *
    FROM UserAccount
    WHERE userID = @userID
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserTransaction]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetUserTransaction]
    @userID INT
AS
BEGIN
    SELECT * FROM Orders WHERE FK_userID = @userID;
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserTransactions]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[uspGetUserTransactions]
AS
BEGIN
    SELECT * FROM Orders 
END
GO
/****** Object:  StoredProcedure [dbo].[uspSelectProduct]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[uspSelectProduct]
    @productVendorUID VARCHAR(10)
AS
BEGIN
    SELECT prod.productVendorUID, prod.productDescription, prod.productPrice, prod.productImage, prod.productIsActive, t.teamID, t.teamLocation, t.teamName, play.playerFirstName, play.playerLastName
    FROM Product prod, Team t, Player play
    WHERE prod.FK_teamID = t.teamID AND prod.FK_playerID = play.playerID AND prod.productVendorUID = @productVendorUID
END
GO
/****** Object:  StoredProcedure [dbo].[uspToggleAdminActivity]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspToggleAdminActivity]
    @adminID INT
AS
BEGIN
    IF (SELECT adminIsActive FROM AdminAccount WHERE adminID = @adminID) = 1
        BEGIN
            UPDATE AdminAccount
            SET adminIsActive = 0
            WHERE adminID = @adminID
        END
    ELSE
        BEGIN
            UPDATE AdminAccount
            SET adminIsActive = 1
            WHERE adminID = @adminID
        END
END
GO
/****** Object:  StoredProcedure [dbo].[uspTogglePostageOptionActivity]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspTogglePostageOptionActivity]
    @postageID INT
AS
BEGIN
    IF (SELECT postageIsActive FROM PostageOption WHERE postageID = @postageID) = 1
        BEGIN
            UPDATE PostageOption
            SET postageIsActive = 0
            WHERE postageID = @postageID
        END
    ELSE
        BEGIN
            UPDATE PostageOption
            SET postageIsActive = 1
            WHERE postageID = @postageID
        END
END
GO
/****** Object:  StoredProcedure [dbo].[uspToggleProductActivity]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspToggleProductActivity]
    @productVendorUID VARCHAR(10)
AS
BEGIN
    IF (SELECT productIsActive FROM Product WHERE productVendorUID = @productVendorUID) = 1
        BEGIN
            UPDATE Product
            SET productIsActive = 0
            WHERE productVendorUID = @productVendorUID
        END
    ELSE
        BEGIN
            UPDATE Product
            SET productIsActive = 1
            WHERE productVendorUID = @productVendorUID
        END
END
GO
/****** Object:  StoredProcedure [dbo].[uspToggleUserActivity]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspToggleUserActivity]
    @userID INT
AS
BEGIN
    IF (SELECT userIsActive FROM UserAccount WHERE userID = @userID) = 1
        BEGIN
            UPDATE UserAccount
            SET userIsActive = 0
            WHERE userID = @userID
        END
    ELSE
        BEGIN
            UPDATE UserAccount
            SET userIsActive = 1
            WHERE userID = @userID
        END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateProduct]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspUpdateProduct]
    @productVendorUID VARCHAR(10),
    @productDescription VARCHAR(250),
    @productPrice MONEY,
	@productImage VARCHAR(250)
AS
BEGIN TRANSACTION
    UPDATE Product
    SET productDescription = @productDescription, productPrice = @productPrice, productImage = @productImage
    WHERE productVendorUID = @productVendorUID
COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateUserAccount]    Script Date: 28/06/2020 8:47:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspUpdateUserAccount]
    @userID INT,
    @userFirstName VARCHAR(200),
    @userLastName VARCHAR(200),
    @userEmail VARCHAR(255),
    @userPhone CHAR(10)
AS
BEGIN TRANSACTION
    UPDATE UserAccount
    SET userFirstName = @userFirstName, userLastName = @userLastName, userEmail = @userEmail, userPhone = @userPhone
    WHERE userID = @userID
COMMIT TRANSACTION
GO
USE [master]
GO
ALTER DATABASE [JerseyZoneDB] SET  READ_WRITE 
GO
