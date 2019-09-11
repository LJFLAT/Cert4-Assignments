-- This query links all the tables to provide a complete list of the data which was imported from the Antiques spreadsheet.
-- It can be compared to this on a row by row basis.

SELECT Customers.CustomerID, Customers.CategoryID, Categories.Category, Customers.FirstName, Customers.LastName, Customers.Address, Customers.Suburb,
		Customers.State, Customers.Postcode, Customers.SendNewsletter, Sales.SaleDate, Sales.SaleID, SaleItems.ItemID, Items.MaterialID, Materials.MaterialName,
		Items.StyleID, Styles.StyleName, Items.GroupID, Groups.GroupName, Items.Year, Items.Price, Items.Gender, Items.InStock
FROM SaleItems JOIN Sales ON SaleItems.SaleID = Sales.SaleID
				JOIN Customers ON Sales.CustomerID = Customers.CustomerID
				JOIN Categories ON Customers.CategoryID = Categories.CategoryID
				JOIN Items ON SaleItems.ItemID = Items.ItemID
				JOIN Materials ON Items.MaterialID = Materials.MaterialID
				JOIN Styles ON Items.StyleID = Styles.StyleID
				JOIN Groups ON Items.GroupID = Groups.GroupID
ORDER BY Sales.SaleDate, Customers.LastName
