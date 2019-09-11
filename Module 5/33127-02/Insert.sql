-- INSERT statement as per the documentation from: -
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/insert-transact-sql

USE Antiques
GO

-- I found an issue when inserting data into the tables.
--		Msg 544, Level 16, State 1, Line 14
--		Cannot insert explicit value for identity column in table 'Categories' when IDENTITY_INSERT is set to OFF.
-- I needed to turn off the IDENTITY_INSERT option. I found the solution at: -
-- https://blog.sqlauthority.com/2007/05/30/sql-server-fix-error-server-msg-544-level-16-state-1-line-1-cannot-insert-explicit-value-for-identity-column-in-table/


-- Categories table data
SET IDENTITY_INSERT [dbo].[Categories] ON
GO

INSERT INTO [Antiques].[dbo].[Categories]
		([CategoryID],
		[Category])
VALUES (1, 'Under 19'),
		(2, '19-25'),
		(3, '26-29'),
		(4, '30-39'),
		(5, '40-49'),
		(6, '50-65'),
		(7, 'Above 65')
GO

SET IDENTITY_INSERT [dbo].[Categories] OFF
GO

-- Groups table data
SET IDENTITY_INSERT [dbo].[Groups] ON
GO

INSERT INTO [Antiques].[dbo].[Groups]
		([GroupID],
		[GroupName])
VALUES (1, 'Jewellery'),
		(2, 'Watch')
GO

SET IDENTITY_INSERT [dbo].[Groups] OFF
GO

-- Materials table data
SET IDENTITY_INSERT [dbo].[Materials] ON
GO

INSERT INTO [Antiques].[dbo].[Materials]
		([MaterialID],
		[MaterialName])
VALUES (1, 'Diamond'),
		(2, 'Gold'),
		(3, 'Pearl'),
		(4, 'Ruby'),
		(5, 'Silver')
GO

SET IDENTITY_INSERT [dbo].[Materials] OFF
GO

-- Styles table data
SET IDENTITY_INSERT [dbo].[Styles] ON
GO

INSERT INTO [Antiques].[dbo].[Styles]
		([StyleID],
		[StyleName])
VALUES (1, 'Bracelet'),
		(2, 'Broach'),
		(3, 'Earrings'),
		(4, 'Necklace'),
		(5, 'Ring'),
		(6, 'Watch')
GO

SET IDENTITY_INSERT [dbo].[Styles] OFF
GO

-- Items table data
SET IDENTITY_INSERT [dbo].[Items] ON
GO

INSERT INTO [Antiques].[dbo].[Items]
		([ItemID],
		[MaterialID],
		[StyleID],
		[GroupID],
		[Year],
		[Price],
		[Gender],
		[InStock])
VALUES (1, 2, 4, 1, 1925, 250, 'M', 0),
		(2, 1, 5, 1, 1898, 1250, 'W', 0),
		(3, 2, 6, 2, 1905, 560, 'M', 0),
		(4, 2, 5, 1, 1889, 340, 'W', 0),
		(5, 5, 4, 1, 1876, 275, 'W', 0),
		(6, 5, 1, 1, 1946, 245, 'W', 0),
		(7, 2, 2, 1, 1901, 570, 'W', 0),
		(8, 2, 1, 1, 1914, 375, 'M', 0),
		(9, 2, 2, 1, 1949, 250, 'W', 0),
		(10, 1, 5, 1, 1952, 2300, 'W', 0),
		(11, 1, 3, 1, 1924, 2500, 'W', 0),
		(12, 3, 3, 1, 1936, 460, 'W', 0),
		(13, 4, 5, 1, 1915, 550, 'W', 0),
		(14, 3, 4, 1, 1939, 780, 'W', 0),
		(15, 2, 3, 1, 1939, 280, 'W', 0),
		(16, 5, 6, 2, 1936, 780, 'M', 0)
GO

SET IDENTITY_INSERT [dbo].[Items] OFF
GO

-- Customers table data
SET IDENTITY_INSERT [dbo].[Customers] ON
GO

INSERT INTO [Antiques].[dbo].[Customers]
		([CustomerID],
		[CategoryID],
		[FirstName],
		[LastName],
		[Address],
		[Suburb],
		[State],
		[Postcode],
		[SendNewsletter])
VALUES (1, 3, 'Mary', 'Jones', '15 Victoria Road', 'Ryde', 'NSW', 2013, 1),
		(2, 2, 'Sandra', 'Kindale', '7/36 Chiefly Ave', 'Surry Hills', 'NSW', 2030, 1),
		(3, 7, 'Tracy', 'Monahan', '23 Premier St', 'Kogarah', 'NSW', 2045, 0),
		(4, 4, 'John', 'Smith', '1 Sunnydale St', 'Sunnydale  ', 'NSW', 2011, 1),
		(5, 5, 'John', 'Smith', '72 Parramatta Rd', 'Liechhardt', 'NSW', 2089, 0),
		(6, 6, 'Rick', 'Spanner', '6/4 Burns Bay Rd', 'Lane Cove', 'NSW', 2066, 1),
		(7, 5, 'Margaret', 'Wilson', '6 Fouveau St', 'Surry Hills  ', 'NSW', 2022, 1)
GO

SET IDENTITY_INSERT [dbo].[Customers] OFF
GO

-- Sales table data
SET IDENTITY_INSERT [dbo].[Sales] ON
GO

INSERT INTO [Antiques].[dbo].[Sales]
		([SaleID],
		[CustomerID],
		[SaleDate])
VALUES (1, 4, '02 Jun 2016'),
		(2, 1, '02 Jun 2016'),
		(3, 6, '03 Jun 2016'),
		(4, 4, '04 Jun 2016'),
		(5, 3, '04 Jun 2016'),
		(6, 1, '06 Jun 2016'),
		(7, 5, '07 Jun 2016'),
		(8, 2, '07 Jun 2016'),
		(9, 7, '08 Jun 2016')
GO

SET IDENTITY_INSERT [dbo].[Sales] OFF
GO

-- SaleItems table data
INSERT INTO [Antiques].[dbo].[SaleItems]
		([SaleID],
		[ItemID])
VALUES (1, 1),
		(1, 2),
		(2, 3),
		(3, 4),
		(3, 5),
		(3, 6),
		(4, 7),
		(5, 8),
		(5, 9),
		(6, 10),
		(6, 11),
		(7, 12),
		(7, 13),
		(8, 14),
		(9, 15),
		(9, 16)
GO
