use JerseyZoneDB

DROP TABLE CartItem
DROP TABLE Size
DROP TABLE Product
DROP TABLE CreditCard
DROP TABLE Orders
DROP TABLE Player
DROP TABLE Team
DROP TABLE ShoppingCart
-- DROP TABLE UserAccount
DROP TABLE ShippingMethod
DROP TABLE ShippingAddress
DROP TABLE AdminAccount

-- tables

-- stores user/customer accounts
/*CREATE TABLE UserAccount 
(
	userID INT IDENTITY(10000,1) PRIMARY KEY,
	userFirstName VARCHAR(200) NOT NULL,
	userLastName VARCHAR(200) NOT NULL,
	userEmail VARCHAR(200) UNIQUE NOT NULL,
	userPassword VARCHAR(200) NOT NULL,
	userPhone VARCHAR(10) NOT NULL,
	userIsActive BIT DEFAULT 1 NOT NULL
)
GO*/

-- stores admin accounts
CREATE TABLE AdminAccount
(
	adminID INT IDENTITY(10000,1) PRIMARY KEY,
	adminFirstName VARCHAR(200) NOT NULL,
	adminLastName VARCHAR(200) NOT NULL,
	adminEmail VARCHAR(255) UNIQUE NOT NULL,
	adminPassword VARCHAR(255) NOT NULL,
	adminPhone VARCHAR(10) NOT NULL,
	adminIsActive BIT DEFAULT 1 NOT NULL
)
GO

-- stores player information
CREATE TABLE Player
(
	playerID INT IDENTITY PRIMARY KEY,
    playerFirstName VARCHAR(30) NOT NULL,
    playerLastName VARCHAR(30) NOT NULL,
    UNIQUE (playerID, playerFirstName, playerLastName)
)
GO

-- stores team information
CREATE TABLE Team
(
	teamID CHAR(3) PRIMARY KEY,
    teamLocation VARCHAR(50) NOT NULL,
    teamName VARCHAR(50) NOT NULL,
    UNIQUE (teamLocation, teamName)
)
GO

-- stores product information
CREATE TABLE Product
(
	productID INT PRIMARY KEY IDENTITY(100, 1),
	productDescription VARCHAR(250) NOT NULL,
	productPrice MONEY NOT NULL,
	productImage VARCHAR(250) NOT NULL,
	productIsActive BIT DEFAULT 1 NOT NULL,
	FK_playerID INT NOT NULL,
	FK_teamID CHAR(3) NOT NULL,
	UNIQUE (FK_playerID, FK_teamID),
	FOREIGN KEY (FK_teamID) REFERENCES Team(teamID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FK_playerID) REFERENCES Player(playerID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

-- stores what sizes are available for a product
CREATE TABLE Size
(
	sizeID VARCHAR(3) PRIMARY KEY NOT NULL,
	sizeStock INT NOT NULL DEFAULT 0,
    FK_productID INT NOT NULL,
    FOREIGN KEY (FK_productID) REFERENCES Product(productID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

-- stores shipping method information
CREATE TABLE ShippingMethod
(
	shippingID INT IDENTITY(1,1) PRIMARY KEY,
	shippingType VARCHAR(100),
	shippingDays INT,
	shippingCost MONEY,
	shippingIsActive BIT NOT NULL DEFAULT 1,
	UNIQUE (shippingType, shippingDays)
)
GO

-- stores shipping address
CREATE TABLE ShippingAddress
(
	addressID INT IDENTITY PRIMARY KEY,
	addressStreet VARCHAR(200) NOT NULL, 
	addressPostal VARCHAR(200) NOT NULL,
	addressCity VARCHAR(200) NOT NULL,
	addressCountry VARCHAR(200) NOT NULL,
	addressState VARCHAR(3) NOT NULL,
	addressPostCode INT NOT NULL,
	UNIQUE (addressStreet, addressCity, addressCountry, addressState, addressPostCode)
)
GO

-- shopping cart that is connected to the user
CREATE TABLE ShoppingCart
(
	cartID INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	FK_userID INT NOT NULL,
	UNIQUE (cartID),
	FOREIGN KEY (FK_userID) REFERENCES UserAccount(userID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

-- stores order information
CREATE TABLE Orders
(
	orderID INT PRIMARY KEY IDENTITY(100, 1),
	orderDate DATE NOT NULL,
	orderCost MONEY NOT NULL,
	orderTotalCost MONEY NOT NULL,
	orderIsPaid BIT DEFAULT 0 NOT NULL,
	FK_shippingID INT NOT NULL, 
	FK_addressID INT NOT NULL,
	FK_cartID INT NOT NULL,
	FOREIGN KEY (FK_shippingID) REFERENCES ShippingMethod(shippingID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (FK_addressID) REFERENCES ShippingAddress(addressID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (FK_cartID) REFERENCES ShoppingCart(cartID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

-- allows multiple items to be added to the cart and order
CREATE TABLE CartItem
(
	FK_cartID INT NOT NULL,
	FK_productID INT NOT NULL,
	FK_orderID INT,
	FK_sizeID VARCHAR(3) NOT NULL,
	cartItemPrice MONEY NOT NULL,
	cartQuantity INT NOT NULL,
	cartTotalPrice MONEY NOT NULL,
	FOREIGN KEY (FK_cartID) REFERENCES ShoppingCart(cartID) ON DELETE NO ACTION,
	FOREIGN KEY (FK_productID) REFERENCES Product(productID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (FK_orderID) REFERENCES Orders(orderID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (FK_sizeID) REFERENCES Size(sizeID) ON DELETE NO ACTION
)
GO

-- stores card payment details
CREATE TABLE CreditCard
(
	cardName VARCHAR(250) PRIMARY KEY,
	cardNumber VARCHAR(16) NOT NULL,
	cardType VARCHAR(50) NOT NULL,
	cardExpiry DATE NOT NULL,
	cardCVV INT NOT NULL,
	FK_orderID INT NOT NULL,
	FOREIGN KEY (FK_orderID) REFERENCES Orders(orderID) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

-- procedures/types
-- creates a shopping cart for the user
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspCreateShoppingCart') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspCreateShoppingCart]
GO

CREATE PROCEDURE uspCreateShoppingCart
    @userID INT
AS
BEGIN TRANSACTION
    INSERT INTO ShoppingCart(FK_userID)
        VALUES (@userID)
    DECLARE @cartID INT
    SET @cartID = SCOPE_IDENTITY()
    
COMMIT TRANSACTION
GO

-- gets all the products that are either active and/or inactive
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetAllProducts') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetAllProducts]
GO

create PROCEDURE [dbo].[uspGetAllProducts]
AS
BEGIN
    SELECT prod.productID, prod.productDescription, prod.productPrice, prod.productIsActive, prod.productImage, t.teamID, t.teamLocation, t.teamName, pl.playerFirstName, pl.playerLastName
    FROM Product prod, Team t, Player pl
    WHERE prod.FK_teamID = t.teamID AND prod.FK_playerID = pl.playerID
END
GO

-- returns only active products
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetProducts') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetProducts]
GO

create PROCEDURE [dbo].[uspGetProducts]
AS
BEGIN
    SELECT prod.productID, prod.productDescription, prod.productPrice, prod.productImage, prod.productIsActive, t.teamID, t.teamLocation, t.teamName, pl.playerFirstName, pl.playerLastName
    FROM Product prod, Team t, Player pl
    WHERE prod.FK_teamID = t.teamID AND prod.FK_playerID = pl.playerID AND prod.productIsActive = 1
END
GO

-- returns a product when selected
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspSelectProduct') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspSelectProduct]
GO

create PROCEDURE [dbo].[uspSelectProduct]
	@productID INT
AS
BEGIN
    SELECT prod.productID, prod.productDescription, prod.productPrice, prod.productImage, prod.productIsActive, t.teamID, t.teamLocation, t.teamName, pl.playerFirstName, pl.playerLastName
    FROM Product prod, Team t, Player pl
    WHERE prod.FK_teamID = t.teamID AND prod.FK_playerID = pl.playerID AND prod.productID = @productID
END
GO

-- returns all users
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetUsers') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetUsers]
GO

create PROCEDURE [dbo].[uspGetUsers]
AS
BEGIN
    SELECT * FROM UserAccount
END
GO

-- returns user with a exisiting email address
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetUser') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetUser]
GO

CREATE PROCEDURE [dbo].[uspGetUser]
	@userAccount VARCHAR(250), 
	@result BIT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT userEmail FROM UserAccount WHERE @userAccount = userEmail)
		BEGIN
			SET @result = 1
			SELECT * FROM UserAccount
			WHERE userEmail = @userAccount
		END
	ELSE
		BEGIN
			SET @result = 0
		END
END
GO

-- returns a user via their ID
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetSingleUser') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetSingleUser]
GO

CREATE PROCEDURE uspGetSingleUser
    @userAccount INT
AS
BEGIN
    SELECT *
    FROM UserAccount
    WHERE userID =@userAccount
END
GO

-- returns a user via their email
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetUserByEmail') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetUserByEmail]
GO

CREATE PROCEDURE uspGetUserByEmail
    @emailUser VARCHAR(250)
AS
BEGIN
    SELECT *
    FROM UserAccount
    WHERE userEmail = @emailUser
END
GO

-- returns all admin accounts
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetAdminAccounts') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetAdminAccounts]
GO

CREATE PROCEDURE [dbo].[uspGetAdminAccounts]
AS
BEGIN
    SELECT * FROM AdminAccount
END
GO

-- returns admin with a exisiting email address
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetAdmin') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetAdmin]
GO

CREATE PROCEDURE [dbo].[uspGetAdmin]
	@adminAccount VARCHAR(250), @result BIT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT adminEmail FROM AdminAccount WHERE @adminAccount = adminEmail)
		BEGIN
			SET @result = 1
			SELECT * FROM AdminAccount
			WHERE adminEmail = @adminAccount
		END
	ELSE
		BEGIN
			SET @result = 0
		END
END
GO

-- returns admin via ID
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetSingleAdmin') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetSingleAdmin]
GO

CREATE PROCEDURE uspGetSingleAdmin
    @adminAccount INT
AS
BEGIN
    SELECT *
    FROM AdminAccount
    WHERE adminID =@adminAccount
END
GO

-- returns admin via email
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetAdminByEmail') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetAdminByEmail]
GO

CREATE PROCEDURE uspGetAdminByEmail
    @emailAdmin VARCHAR(250)
AS
BEGIN
    SELECT *
    FROM AdminAccount
    WHERE adminEmail = @emailAdmin
END
GO

-- add user to the database
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspAddUserAccount') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspAddUserAccount]
GO

CREATE PROCEDURE uspAddUserAccount
    @userFirstName VARCHAR(250),
    @userLastName VARCHAR(250),
    @userEmail VARCHAR(250),
	@userPassword VARCHAR(255),
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

-- add admin to the database
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspAddAdminAccount') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspAddAdminAccount]
GO

CREATE PROCEDURE uspAddAdminAccount
    @adminFirstName VARCHAR(250),
    @adminLastName VARCHAR(250),
    @adminEmail VARCHAR(250),
	@adminPassword VARCHAR(255),
	@adminPhone VARCHAR(10),
    @adminIsActive BIT
AS
BEGIN TRANSACTION
    INSERT INTO AdminAccount(adminFirstName, adminLastName, adminEmail, adminPassword, adminPhone, adminIsActive)
        VALUES (@adminFirstName, @adminLastName, @adminEmail, @adminPassword, @adminPhone, @adminIsActive)
    DECLARE @adminID INT
    SET @adminID = SCOPE_IDENTITY()
    
COMMIT TRANSACTION
GO

-- updates an exisiting user
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspUpdateUserAccount') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspUpdateUserAccount]
GO

CREATE PROCEDURE uspUpdateUserAccount
    @userID INT,
    @userFirstName VARCHAR(250),
    @userLastName VARCHAR(250),
    @userEmail VARCHAR(250),
    @userPhone VARCHAR(10)
AS
BEGIN TRANSACTION
    UPDATE UserAccount
    SET userFirstName = @userFirstName, userLastName = @userLastName, userEmail = @userEmail, userPhone = @userPhone
    WHERE userID = @userID
    
COMMIT TRANSACTION
GO

-- toggles admin activity
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspToggleUserActivity') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspToggleUserActivity]
GO

CREATE PROCEDURE uspToggleUserActivity
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

-- updates an exisiting admin
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspUpdateAdminAccount') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspUpdateAdminAccount]
GO

CREATE PROCEDURE uspUpdateAdminAccount
    @adminID INT,
    @adminFirstName VARCHAR(250),
    @adminLastName VARCHAR(250),
    @adminEmail VARCHAR(250),
    @adminPhone VARCHAR(10)
AS
BEGIN TRANSACTION
    UPDATE AdminAccount
    SET adminFirstName = @adminFirstName, adminLastName = @adminLastName, adminEmail = @adminEmail, adminPhone = @adminPhone
    WHERE adminID = @adminID
    
COMMIT TRANSACTION
GO

-- toggles admin activity
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspToggleAdminActivity') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspToggleAdminActivity]
GO

CREATE PROCEDURE uspToggleAdminActivity
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

-- changes user password
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspChangePassword') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspChangePassword]
GO

CREATE PROCEDURE uspChangePassword
    @userEmail VARCHAR(255),
    @userPassword VARCHAR(255)
AS
BEGIN
    UPDATE UserAccount
    SET userPassword = @userPassword
    WHERE userEmail = @userEmail
END
GO

-- changes admin password
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspAdminPassword') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspAdminPassword]
GO

CREATE PROCEDURE uspAdminPassword
    @adminEmail VARCHAR(255),
    @adminPassword VARCHAR(255)
AS
BEGIN
    UPDATE AdminAccount
    SET adminPassword = @adminPassword
    WHERE adminEmail = @adminEmail
END
GO

-- returns all teams
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetTeams') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetTeams]
GO

CREATE PROCEDURE uspGetTeams
AS
BEGIN
    SELECT teamID, concat(teamLocation, ' ' + teamName) AS teamFullName FROM Team
END
GO

-- returns a shipping method as a sentence
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetShippingMethod') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetShippingMethod]
GO

CREATE PROCEDURE uspGetShippingMethod
AS
BEGIN
    SELECT shippingID, concat(shippingType, ' ' + cast(shippingDays AS INT) + ' days' + ' $' + cast(shippingCost AS MONEY)) AS shippingItem FROM ShippingMethod WHERE shippingIsActive = 1
END
GO

-- gets all shipping methods
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetAllShippingMethods') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetAllShippingMethods]
GO

CREATE PROCEDURE uspGetAllShippingMethods
AS
BEGIN
	SELECT * FROM ShippingMethod
END
GO 

-- returns a shipping method
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetShippingMethodDetails') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetShippingMethodDetails]
GO

CREATE PROCEDURE uspGetShippingMethodDetails
    @shippingID INT
AS
BEGIN
    SELECT * FROM ShippingMethod WHERE shippingID = @shippingID
END
GO

-- returns how many items are remaining of the product in all sizes
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetProductQuantity') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetProductQuantity]
GO

CREATE PROCEDURE uspGetProductQuantity
	@productID INT
AS 
BEGIN
	SELECT sizeStock
	FROM Size
	WHERE FK_productID = @productID
	ORDER BY CASE
		WHEN sizeID = 'S' THEN '1'
        WHEN sizeID = 'M' THEN '2'
        WHEN sizeID = 'L' THEN '3'
        WHEN sizeID = 'XL' THEN '4'
        WHEN sizeID = '2XL' THEN '5'
		WHEN sizeID = '3XL' THEN '6'
		ELSE sizeID END
END
GO

-- add a new product to the database
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspAddProduct') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspAddProduct]
GO

CREATE PROCEDURE uspAddProduct
    @playerFirstName VARCHAR(250),
	@playerLastName VARCHAR(250),
	@teamID CHAR(3),
	@productDescription TEXT,
	@productPrice MONEY,
	@imageProduct VARCHAR(250),
	@sStock INT,
	@mStock INT,
	@lStock INT,
	@xlStock INT,
	@2xlStock INT,
	@3xlStock INT
AS
BEGIN TRANSACTION
    DECLARE @playerID INT
    IF NOT exists(SELECT playerID FROM Player WHERE playerFirstName = @playerFirstName AND playerLastName = @playerLastName)
        BEGIN
            INSERT INTO Player(playerFirstName, playerLastName)
                VALUES (@playerFirstName, @playerLastName)
            SET @playerID = SCOPE_IDENTITY()
        END
    ELSE
        BEGIN
            SELECT @playerID = playerID FROM Player WHERE playerFirstName = @playerFirstName AND @playerLastName = @playerLastName
        END
    
	DECLARE @productID INT
    IF NOT exists(SELECT * FROM Product prod)
        BEGIN
            INSERT INTO Product(productDescription, productPrice, productImage, FK_playerID, FK_teamID)
                VALUES (@productDescription, @productPrice, @imageProduct, @playerID, @teamID);
            
			SET @productID = SCOPE_IDENTITY()

        END
    INSERT INTO Size(sizeID, sizeStock, FK_productID)
        VALUES ('S', @sStock, @productID),
               ('M', @mStock, @productID),
               ('L', @lStock, @productID),
               ('XL', @xlStock, @productID),
               ('2XL', @2xlStock, @productID),
			   ('3XL', @3xlStock, @productID)
COMMIT TRANSACTION
GO

-- updates stock when product is updated
-- commented out for the time due to a glitch, the wizard will solve that issue for me
/*IF EXISTS (SELECT 1 FROM systypes st WHERE st.name = N'SizeStock')
BEGIN
   EXEC sp_droptype 'SizeStock';
END

CREATE TYPE SizeStock AS TABLE
(
    sizeID VARCHAR(3) PRIMARY KEY,
    sizeStock INT
)
GO*/

--  updates a product
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspUpdateProduct') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspUpdateProduct]
GO

CREATE PROCEDURE uspUpdateProduct
    @productID INT,
	@prodDescription TEXT,
    @productPrice MONEY,
    @imageProduct VARCHAR(250),
	@sizeStockType SizeStock READONLY
AS
BEGIN TRANSACTION
    UPDATE Product
    SET productDescription = @prodDescription, productPrice = @productPrice, productImage = @imageProduct
    WHERE productID = @productID

	UPDATE Size
    SET sizeStock = s.sizeStock
    FROM @sizeStockType s WHERE @productID = Size.FK_productID AND s.sizeID = Size.sizeID
COMMIT TRANSACTION
GO

-- toggles activity of a product
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspToggleProductActivity') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspToggleProductActivity]
GO

CREATE PROCEDURE uspToggleProductActivity
    @productID INT
AS
BEGIN
    IF (SELECT productIsActive FROM Product WHERE productID = @productID) = 1
        BEGIN
            UPDATE Product
            SET productIsActive = 0
            WHERE productID = @productID
        END
    ELSE
        BEGIN
            UPDATE Product
            SET productIsActive = 1
            WHERE productID = @productID
        END
END
GO

-- adds shipping option
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspAddShippingMethod') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspAddShippingMethod]
GO

CREATE PROCEDURE uspAddShippingMethod
	@shippingType VARCHAR(100),
	@shippingDays INT,
	@shippingCost MONEY
AS
BEGIN TRANSACTION
	IF NOT exists(SELECT shippingID FROM ShippingMethod WHERE shippingType = @shippingType)
        BEGIN
            INSERT INTO ShippingMethod(shippingType, shippingDays, shippingCost)
                VALUES (@shippingType, @shippingDays, @shippingCost);
        END
COMMIT TRANSACTION
GO

-- toggles shipping activity
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspToggleShippingMethodActivity') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspToggleShippingMethodActivity]
GO

CREATE PROCEDURE uspToggleShippingMethodActivity
    @shippingID INT
AS
BEGIN
    IF (SELECT shippingIsActive FROM ShippingMethod WHERE shippingID = @shippingID) = 1
        BEGIN
            UPDATE ShippingMethod
            SET shippingIsActive = 0
            WHERE shippingID = @shippingID
        END
    ELSE
        BEGIN
            UPDATE ShippingMethod
            SET shippingIsActive = 1
            WHERE shippingID = @shippingID
        END
END
GO

-- returns all the orders a user has made
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetUserCartOrders') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetUserCartOrders]
GO

CREATE PROCEDURE uspGetUserCartOrders
    @cartID INT,
	@userID INT
AS
BEGIN
    SELECT o.orderID, o.orderDate, o.orderCost, o.orderTotalCost, o.orderIsPaid, o.FK_shippingID, o.FK_addressID, o.FK_cartID, s.FK_userID FROM Orders o, ShoppingCart s WHERE o.FK_cartID = @cartID AND s.FK_userID = @userID AND o.FK_cartID = s.cartID;
END
GO

-- returns a single order
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetSingleOrder') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetSingleOrder]
GO

CREATE PROCEDURE uspGetSingleOrder
    @orderID INT
AS
BEGIN
    SELECT * FROM Orders WHERE orderID = @orderID
END
GO

-- returns the items purchased on an order
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspGetOrderItems') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspGetOrderItems]
GO

CREATE PROCEDURE uspGetOrderItems
    @orderID INT
AS
BEGIN
    SELECT cart.FK_productID, cart.cartQuantity, pl.playerFirstName, pl.playerLastName, pr.productDescription, cart.cartItemPrice
    FROM Orders o, CartItem cart, Product pr, Player pl
    WHERE o.orderID = @orderID AND o.FK_cartID = cart.FK_cartID AND cart.FK_orderID = o.orderID AND cart.FK_productID = pr.productID AND pr.FK_playerID = pl.playerID
END
GO

-- when adding cart items
/*IF EXISTS (SELECT 1 FROM systypes st WHERE st.name = N'MyItems')
BEGIN
   EXEC sp_droptype 'MyItems';
END

CREATE TYPE MyItems AS TABLE
(
    MyItems_cartID INT,
	MyItems_productID INT,
	MyItems_sizeID VARCHAR(3),
	MyItems_cartQuantity INT,
	MyItems_cartItemPrice MONEY,
	MyItems_cartTotalPrice MONEY
    PRIMARY KEY (MyItems_cartID, MyItems_productID)
)
GO*/

-- adds a new order to the database
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'uspAddNewOrder') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[uspAddNewOrder]
GO

CREATE PROCEDURE uspAddNewOrder
    -- order --
	@orderCost MONEY,
    @orderTotalCost MONEY,
    @orderIsPaid BIT,

	-- shipping address --
	@addressStreet VARCHAR(200),
	@addressPostal VARCHAR(200),
	@addressCity VARCHAR(200),
	@addressCountry VARCHAR(200),
	@addressState VARCHAR(3),
	@addressPostCode INT,

	-- shipping method --
    @shippingID INT,

	-- credit card --
    @cardName VARCHAR(250),
    @cardNumber VARCHAR(16),
	@cardType VARCHAR(50),
    @cardExpiry DATE,
	@cardCVV INT,

	-- cart --
	@cartID INT,
    @myItems myItems READONLY
AS
BEGIN TRANSACTION
	DECLARE @addressID INT
	INSERT INTO ShippingAddress(addressStreet, addressPostal, addressCity, addressCountry, addressState, addressPostCode)
        VALUES (@addressStreet, @addressPostal, @addressCity, @addressCountry, @addressState, @addressPostCode)
    SET @addressID = SCOPE_IDENTITY()

	DECLARE @orderID INT
    INSERT INTO Orders(orderCost, orderTotalCost, orderIsPaid, FK_shippingID, FK_addressID, FK_cartID)
        VALUES (@orderCost, @orderTotalCost, @orderIsPaid, @shippingID, @addressID, @cartID)
    SET @orderID = SCOPE_IDENTITY()

    INSERT INTO CreditCard(cardName, cardNumber,  cardType, cardExpiry, cardCVV, FK_orderID)
        VALUES (@cardName, @cardNumber,  @cardType, @cardExpiry, @cardCVV, @orderID)

    INSERT INTO CartItem (FK_cartID, FK_productID, FK_orderID, FK_sizeID, cartItemPrice, cartQuantity, cartTotalPrice)
        SELECT MyItems_cartID, MyItems_productID, @orderID, MyItems_sizeID, MyItems_cartItemPrice, MyItems_cartQuantity, MyItems_cartTotalPrice FROM @myItems
    
COMMIT TRANSACTION
GO