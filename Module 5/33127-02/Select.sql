USE Antiques
GO

-- Display all records from Categories table
SELECT *
FROM Categories

-- Display all records from Customers table
SELECT *
FROM Customers

-- Display all records from Groups table
SELECT *
FROM Groups

-- Display all records from Items table
SELECT *
FROM Items

-- Display all records from Materials table
SELECT *
FROM Materials

-- Display all records from SaleItems table
SELECT *
FROM SaleItems

-- Display all records from Sales table
SELECT *
FROM Sales

-- Display all records from Styles table
SELECT *
FROM Styles


-- Additional / Optional requirements

-- Combined SELECT JOINing all tables and displaying all information based upon the details from the Antiques.xls data provided
-- It can be compared to the spreadsheet on a row by row basis.
-- I have also included a ItemDescription example as detailed within the revised Database Design Requirements document which is a combination of 3 fields.

SELECT Customers.CustomerID, Customers.CategoryID, Categories.Category, Customers.FirstName, Customers.LastName, Customers.Address, Customers.Suburb,
		Customers.State, Customers.Postcode, Customers.SendNewsletter, Sales.SaleDate, Sales.SaleID, SaleItems.ItemID, Items.MaterialID, Materials.MaterialName,
		Items.StyleID, Styles.StyleName, (CAST(Items.Year as VARCHAR(4)) + ' ' + Materials.MaterialName + ' ' + Styles.StyleName) AS ItemDescription, Items.GroupID, Groups.GroupName, Items.Year, Items.Price, Items.Gender, Items.InStock
FROM SaleItems JOIN Sales ON SaleItems.SaleID = Sales.SaleID
				JOIN Customers ON Sales.CustomerID = Customers.CustomerID
				JOIN Categories ON Customers.CategoryID = Categories.CategoryID
				JOIN Items ON SaleItems.ItemID = Items.ItemID
				JOIN Materials ON Items.MaterialID = Materials.MaterialID
				JOIN Styles ON Items.StyleID = Styles.StyleID
				JOIN Groups ON Items.GroupID = Groups.GroupID
ORDER BY Sales.SaleDate, Customers.LastName

-- I have also enhanced the SELECT query by writing a Scalar-Valued Function which returns the ItemDescription when passed a Items.ItemID to the fn_ItemDescription function.
-- Example below to demonstrate this

SELECT Items.ItemID, dbo.fn_ItemDescription(Items.ItemID) AS ItemDescription
FROM Items