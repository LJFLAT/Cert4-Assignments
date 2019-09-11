-- Procedures below modified from Course information provided within the Sales Database.

-- Task 3.1
CREATE PROCEDURE sp_Customers_InsertCustomerDetails

	@CustomerID int,
	@CategoryID int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@Address varchar(100),
	@Suburb varchar(50),
	@State varchar(3),
	@Postcode int,
	@SendNewsletter bit,
	@NewCustomerID int OUTPUT

AS
BEGIN
	INSERT INTO [Antiques].[dbo].[Customers]
			(CustomerID,
			CategoryID,
			FirstName,
			LastName,
			Address,
			Suburb,
			State,
			Postcode,
			SendNewsletter)
	VALUES (@CustomerID,
			@CategoryID,
			@FirstName,
			@LastName,
			@Address,
			@Suburb,
			@State,
			@Postcode,
			@SendNewsletter)
	SELECT @NewCustomerID = @@IDENTITY
END
GO

-- Task 3.2
CREATE PROCEDURE sp_Customers_UpdateCustomerDetails

	@CustomerID int,
	@CategoryID int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@Address varchar(100),
	@Suburb varchar(50),
	@State varchar(3),
	@Postcode int,
	@SendNewsletter bit

AS
BEGIN
	UPDATE Customers
		SET CategoryID = @CategoryID,
			FirstName = @FirstName,
			LastName = @LastName,
			Address = @Address,
			Suburb = @Suburb,
			State = @State,
			Postcode = @Postcode,
			SendNewsletter = @SendNewsletter
	WHERE CustomerID = @CustomerID
END
GO

-- Task 3.3
CREATE PROCEDURE sp_Customers_AllowDeleteCustomer
	@CustomerID int,
	@RecordCount int OUTPUT
AS
BEGIN
	DECLARE @tmpRecordCount int

	SELECT @RecordCount = 0

	SELECT @tmpRecordCount = COUNT(*) FROM Sales WHERE CustomerID = @CustomerID
	IF @tmprecordCount > 0
		SELECT @RecordCount = 1
END
GO


-- Task 3.4
CREATE PROCEDURE sp_Customers_DeleteCustomer
	@CustomerID int
AS
BEGIN
	DELETE FROM Customers WHERE CustomerID = @CustomerID
END
GO


-- Task 3.5
CREATE PROCEDURE sp_Customers_CustomerExists
	@FirstName varchar(50),
	@LastName varchar(50),
	@Address varchar(100),
	@Suburb varchar(50),
	@State varchar(3),
	@Postcode int,
	@RecordCount INT OUTPUT
AS
BEGIN
	SELECT @RecordCount = COUNT(*)
	FROM Customers
	WHERE FirstName = @FirstName
		AND LastName = @LastName
		AND Address = @Address
		AND Suburb = @Suburb
		AND State = @State
		AND Postcode = @Postcode
END
GO


-- Task 3.6
CREATE PROCEDURE sp_Customers_DisplayCustomers
	@CustomerID int
AS
BEGIN
	If @CustomerID = 0
		BEGIN
			SELECT *
				FROM Customers
				ORDER BY LastName, FirstName
			END
	ELSE
		BEGIN
			SELECT *
				FROM Customers
				WHERE CustomerID = @CustomerID
		END
END
GO