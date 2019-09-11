-- Queries as per the Microsoft overview at: -
-- https://technet.microsoft.com/en-us/library/bb264565(v=sql.90).aspx


-- As per Task requirements I have executed each Task then left the statements commented out prior to doing the next task.

-- Task  2.1
--SELECT Customers.FirstName, Customers.LastName, Customers.Address, Customers.Suburb, Customers.State, Customers.Postcode
--FROM Customers


-- Task 2.2
--SELECT Customers.FirstName, Customers.LastName, Customers.Address, Customers.Suburb, Customers.State, Customers.Postcode, Categories.Category
--FROM Customers JOIN Categories ON Customers.CategoryID = Categories.CategoryID


-- Task 2.3
--		As mentioned before I have written a function which displays the Items Description as per my Database Design Document.
--		The first two select statements provide what this task requires.
--		The third select statement provides my additional scalar functions.
--		
--		I have 2 Functions for ItemDescriptions - fn_ItemDescription(int) and fn_ItemShortDescription(int) - where int uses the Items.ItemID reference
--			These return the description of the Item as Year / Materials / Style and Materials / Style
--		
--		There is also a function which returns the Full Gender relating to the Item. - fn_ItemGender(int) where int is the Items.ItemID reference
--		An additional function which returns the Full Gender and Item Type - fn_ItemType(int) where int is the Items.ItemID reference

--SELECT (Materials.MaterialName + ' ' + Styles.StyleName) AS ItemDescription, Items.Year, Items.Price, dbo.fn_ItemGender(Items.Gender) + ' ' + Groups.GroupName
--FROM Items JOIN Materials ON Items.MaterialID = Materials.MaterialID
--			JOIN Styles ON Items.StyleID = Styles.StyleID
--			JOIN Groups ON Items.GroupID = Groups.GroupID
--ORDER BY ItemDescription ASC

--SELECT (Materials.MaterialName + ' ' + Styles.StyleName) AS ItemDescription, Items.Year, Items.Price, dbo.fn_ItemGender(Items.Gender) + ' ' + Groups.GroupName
--FROM Items JOIN Materials ON Items.MaterialID = Materials.MaterialID
--			JOIN Styles ON Items.StyleID = Styles.StyleID
--			JOIN Groups ON Items.GroupID = Groups.GroupID
--ORDER BY Items.Year DESC

--SELECT dbo.fn_ItemShortDescription(Items.ItemID) AS ItemDescription, Items.Year, Items.Price, dbo.fn_ItemType(Items.ItemID) AS ItemType
--FROM Items JOIN Materials ON Items.MaterialID = Materials.MaterialID
--			JOIN Styles ON Items.StyleID = Styles.StyleID
--			JOIN Groups ON Items.GroupID = Groups.GroupID
--ORDER BY ItemDescription ASC


-- Task 2.4
--SELECT Customers.FirstName, Customers.LastName, Customers.Address, Customers.Suburb, Customers.State, Customers.Postcode
--FROM Customers
--WHERE Customers.SendNewsletter = 1


-- Task 2.5
-- SELECT query written using the fn_ItemShortDescription as per above details.

--SELECT dbo.fn_ItemShortDescription(Items.ItemID) AS ItemDescription, Items.Year, Items.Price, dbo.fn_ItemType(Items.ItemID) AS ItemType
--FROM Items
--WHERE Items.Year <= 1940 AND Items.Gender = 'W'
--ORDER BY ItemDescription ASC

--SELECT dbo.fn_ItemShortDescription(Items.ItemID) AS ItemDescription, Items.Year, Items.Price, dbo.fn_ItemType(Items.ItemID) AS ItemType
--FROM Items
--WHERE Items.Year <= 1940 AND Items.Gender = 'W'
--ORDER BY Items.Year DESC


-- Task 2.6
--SELECT Customers.FirstName, Customers.LastName, Customers.Address, Customers.Suburb, Customers.State, Customers.Postcode, Categories.Category
--FROM Customers JOIN Categories ON Customers.CategoryID = Categories.CategoryID
--WHERE (Categories.Category <> '50-65' AND Categories.Category <> 'Above 65') AND CHARINDEX('S', Customers.LastName) <> 0


--Task 2.7
--SELECT Customers.FirstName, Customers.LastName, Sales.SaleDate, dbo.fn_ItemDescription(SaleItems.ItemID) AS ItemDescription, Items.Price
--FROM SaleItems JOIN Sales ON SaleItems.SaleID = Sales.SaleID
--				JOIN Customers ON Sales.CustomerID = Customers.CustomerID
--				JOIN Items ON SaleItems.ItemID = Items.ItemID
--WHERE Sales.SaleDate BETWEEN '03 Jun 2016' AND '06 Jun 2016'


-- Task 2.8
--SELECT MIN(Items.Price) AS MinimumPrice, MAX(Items.Price) AS MaximumPrice, AVG(Items.Price) AS AveragePrice
--FROM Items


-- Task 2.9
--SELECT SaleItems.SaleID, Sales.SaleDate, Customers.FirstName, Customers.LastName, SUM(Items.Price) AS TotalPrice
--FROM SaleItems JOIN Items ON SaleItems.ItemID = Items.ItemID 
--				JOIN Sales ON SaleItems.SaleID = Sales.SaleID 
--				JOIN Customers ON Sales.CustomerID = Customers.CustomerID
--GROUP BY Customers.FirstName, Customers.LastName, SaleItems.SaleID, Sales.SaleDate
--ORDER BY SaleItems.SaleID


-- Task 2.10
--SELECT COUNT(*)
--FROM Sales
--WHERE Sales.SaleDate BETWEEN '03 Jun 2016' and '06 Jun 2016'


-- Task 2.11
--SELECT (LEFT(Customers.FirstName,1) + ' ' + Customers.LastName) AS CustomerName, LEN(LEFT(Customers.FirstName,1) + ' ' + Customers.LastName) AS NameLength
--FROM Customers


-- Task 2.12
--SELECT DATEDIFF(dd, MIN(Sales.SaleDate), MAX(Sales.SaleDate))
--FROM Sales

