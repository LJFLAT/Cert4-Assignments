-- Task 4.1 - Create a Function

-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lance Flatman>
-- Create date: <26 July 2017>
-- Description:	<Return the GST portion of a price passed to the function>
-- =============================================
CREATE FUNCTION fn_GSTAmount
(
	-- Add the parameters for the function here
	@Price money
)
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @GST money

	-- Add the T-SQL statements to compute the return value here
	SET @GST = (@Price * 0.10)

	-- Return the result of the function
	RETURN @GST

END
GO


-- Create a view statement

SELECT        ItemID, Price, dbo.fn_GSTAmount(Price) AS GSTAmount
FROM            dbo.Items


-- Task 4.2
-- I have utilised my Item Description and Item Type Functions within this query

SELECT        dbo.SaleItems.SaleID, dbo.Sales.SaleDate, dbo.Customers.FirstName, dbo.Customers.LastName, dbo.Categories.Category, 
				dbo.fn_ItemShortDescription(dbo.Items.ItemID) AS ItemDescription, dbo.fn_ItemType(dbo.Items.ItemID) 
                AS ItemType, dbo.Items.Price, dbo.fn_GSTAmount(dbo.Items.Price) AS GSTAmount, 
				dbo.Items.Price + dbo.fn_GSTAmount(dbo.Items.Price) AS TotalPriceInc
FROM            dbo.Items INNER JOIN
                         dbo.SaleItems ON dbo.Items.ItemID = dbo.SaleItems.ItemID INNER JOIN
                         dbo.Sales INNER JOIN
                         dbo.Customers ON dbo.Sales.CustomerID = dbo.Customers.CustomerID INNER JOIN
                         dbo.Categories ON dbo.Customers.CategoryID = dbo.Categories.CategoryID ON dbo.SaleItems.SaleID = dbo.Sales.SaleID
