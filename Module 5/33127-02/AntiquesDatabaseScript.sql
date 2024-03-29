USE [master]
GO
/****** Object:  Database [Antiques]    Script Date: 26/07/2017 4:13:51 PM ******/
CREATE DATABASE [Antiques]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Antiques', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Antiques.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Antiques_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Antiques_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Antiques] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Antiques].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Antiques] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Antiques] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Antiques] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Antiques] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Antiques] SET ARITHABORT OFF 
GO
ALTER DATABASE [Antiques] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Antiques] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Antiques] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Antiques] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Antiques] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Antiques] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Antiques] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Antiques] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Antiques] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Antiques] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Antiques] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Antiques] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Antiques] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Antiques] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Antiques] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Antiques] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Antiques] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Antiques] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Antiques] SET  MULTI_USER 
GO
ALTER DATABASE [Antiques] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Antiques] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Antiques] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Antiques] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Antiques] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Antiques]
GO
/****** Object:  User [Carlotta]    Script Date: 26/07/2017 4:13:51 PM ******/
CREATE USER [Carlotta] FOR LOGIN [Carlotta] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [Admin]    Script Date: 26/07/2017 4:13:51 PM ******/
CREATE ROLE [Admin]
GO
ALTER ROLE [Admin] ADD MEMBER [Carlotta]
GO
GRANT CONNECT TO [Carlotta] AS [dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemDescription]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses an Items.ItemID reference to combine various tables to return an ItemDescription>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemDescription] 
(
	-- Add the parameters for the function here
	@ItemID INT
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemDescription varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SET @ItemDescription = (SELECT (CAST(Items.Year AS varchar(4)) + ' ' + Materials.MaterialName + ' ' + Styles.StyleName)
							FROM Items JOIN Materials ON Items.MaterialID = Materials.MaterialID
							JOIN Styles ON Items.StyleID = Styles.StyleID
							WHERE Items.ItemID = @ItemID)

	-- Return the result of the function
	RETURN @ItemDescription

END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemGender]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses the Items.Gender field to return the full Gender name relevant to the Item>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemGender]
(
	-- Add the parameters for the function here
	@ItemGender varchar(1)
)
RETURNS varchar(6)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @GenderName varchar(6)

	IF @ItemGender = 'M'
		SET @GenderName = 'Males'
	IF @ItemGender = 'W'
		SET @GenderName = 'Womens'

	-- This option might be used later if expanding range and requires a Unisex option.
	IF @ItemGender = 'U'
		SET @GenderName = 'Unisex'

	RETURN @GenderName

END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemShortDescription]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses the Items.ItemID reference to return a ShortDescription based upon Material and Style of Item>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemShortDescription] 
(
	-- Add the parameters for the function here
	@ItemID INT
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemDescription varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SET @ItemDescription = (SELECT Materials.MaterialName + ' ' + Styles.StyleName
							FROM Items JOIN Materials ON Items.MaterialID = Materials.MaterialID
							JOIN Styles ON Items.StyleID = Styles.StyleID
							WHERE Items.ItemID = @ItemID)

	-- Return the result of the function
	RETURN @ItemDescription

END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_ItemType]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Uses the Items.ItemID reference to return the Full Gender description along with the Group the Item belongs to>
-- =============================================
CREATE FUNCTION [dbo].[fn_ItemType]
(
	-- Add the parameters for the function here
	@ItemID int
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ItemType varchar(100)

	-- Add the T-SQL statements to compute the return value here
	SET @ItemType = (SELECT (dbo.fn_ItemGender(Items.Gender) + ' ' + Groups.GroupName)
					FROM Items JOIN Groups ON Items.GroupID = Groups.GroupID
					WHERE Items.ItemID = @ItemID)

	-- Return the result of the function
	RETURN @ItemType

END

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
GRANT DELETE ON [dbo].[Categories] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[Categories] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[Categories] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Categories] TO [Admin] AS [dbo]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[Suburb] [varchar](50) NOT NULL,
	[State] [varchar](3) NOT NULL,
	[Postcode] [int] NOT NULL,
	[SendNewsletter] [bit] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
GRANT DELETE ON [dbo].[Customers] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[Customers] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[Customers] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Customers] TO [Admin] AS [dbo]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
GRANT DELETE ON [dbo].[Groups] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[Groups] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[Groups] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Groups] TO [Admin] AS [dbo]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialID] [int] NOT NULL,
	[StyleID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Gender] [varchar](1) NOT NULL,
	[InStock] [bit] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materials]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Materials](
	[MaterialID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Materials] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
GRANT DELETE ON [dbo].[Materials] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[Materials] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[Materials] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Materials] TO [Admin] AS [dbo]
GO
/****** Object:  Table [dbo].[SaleItems]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleItems](
	[SaleID] [int] NOT NULL,
	[ItemID] [int] NOT NULL
) ON [PRIMARY]

GO
GRANT DELETE ON [dbo].[SaleItems] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[SaleItems] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[SaleItems] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[SaleItems] TO [Admin] AS [dbo]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SaleDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
GRANT DELETE ON [dbo].[Sales] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[Sales] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[Sales] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Sales] TO [Admin] AS [dbo]
GO
/****** Object:  Table [dbo].[Styles]    Script Date: 26/07/2017 4:13:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Styles](
	[StyleID] [int] IDENTITY(1,1) NOT NULL,
	[StyleName] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Styles] PRIMARY KEY CLUSTERED 
(
	[StyleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
GRANT DELETE ON [dbo].[Styles] TO [Admin] AS [dbo]
GO
GRANT INSERT ON [dbo].[Styles] TO [Admin] AS [dbo]
GO
GRANT SELECT ON [dbo].[Styles] TO [Admin] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Styles] TO [Admin] AS [dbo]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Categories]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Groups]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Materials] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[Materials] ([MaterialID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Materials]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Styles] FOREIGN KEY([StyleID])
REFERENCES [dbo].[Styles] ([StyleID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Styles]
GO
ALTER TABLE [dbo].[SaleItems]  WITH CHECK ADD  CONSTRAINT [FK_SaleItems_Items] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ItemID])
GO
ALTER TABLE [dbo].[SaleItems] CHECK CONSTRAINT [FK_SaleItems_Items]
GO
ALTER TABLE [dbo].[SaleItems]  WITH CHECK ADD  CONSTRAINT [FK_SaleItems_Sales] FOREIGN KEY([SaleID])
REFERENCES [dbo].[Sales] ([SaleID])
GO
ALTER TABLE [dbo].[SaleItems] CHECK CONSTRAINT [FK_SaleItems_Sales]
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Customers]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key of the Categories table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Categories', @level2type=N'COLUMN',@level2name=N'CategoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer category - e.g. 20-29, 30-39, 40-49' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Categories', @level2type=N'COLUMN',@level2name=N'Category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key for the Customer table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key for the Categories table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'CategoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer''s first name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer''s last name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer suburb' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'Suburb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer state' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer postcode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'Postcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determines if a newsletter has been requested (True/1) or (False/0)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Customers', @level2type=N'COLUMN',@level2name=N'SendNewsletter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key for the Groups table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Groups', @level2type=N'COLUMN',@level2name=N'GroupID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the group the item belongs to - e.g. jewellery, watch' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Groups', @level2type=N'COLUMN',@level2name=N'GroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key for the Items table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'ItemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key for the Materials table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key for the Styles table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'StyleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key for the Groups table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'GroupID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year the item was crafted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'Year'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Price of the item in $' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Gender target market - (M)ales, (W)omens - Allow for the possibility for a (U)nisex option' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Determines if the item is in stock (True/1) or sold (False/0)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Items', @level2type=N'COLUMN',@level2name=N'InStock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key for the Materials table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Materials', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Majority type of material the product is made from - e.g. gold, silver, pearl, diamond' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Materials', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to link into Sales table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SaleItems', @level2type=N'COLUMN',@level2name=N'SaleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to link into the Items table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SaleItems', @level2type=N'COLUMN',@level2name=N'ItemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key for the Sales table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sales', @level2type=N'COLUMN',@level2name=N'SaleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key used to link into the Customers table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sales', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date of sale' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sales', @level2type=N'COLUMN',@level2name=N'SaleDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Key for the Styles table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Styles', @level2type=N'COLUMN',@level2name=N'StyleID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Style of the item - e.g. earring, ring, watch, bracelet' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Styles', @level2type=N'COLUMN',@level2name=N'StyleName'
GO
USE [master]
GO
ALTER DATABASE [Antiques] SET  READ_WRITE 
GO
