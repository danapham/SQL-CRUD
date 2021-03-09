DECLARE @Size int = 3
DECLARE @Type varchar(40) = 'Honey Wheat'
DECLARE @Price decimal(18,2) = 2.50
DECLARE @WeightInOunces int = 24

--Adding data is done via insert
INSERT INTO Loaves(Size,[Type],Price,WeightInOunces)
OUTPUT inserted.Id --output has access to the fully resolved inserted data
VALUES (@Size,@Type,@Price,@WeightInOunces) -- order is important here, needs to match the insert column order

--safety measure can undo changes inside of a transaction with a rollback
BEGIN TRANSACTION
--updating data

DECLARE @Id int = 6

UPDATE Loaves
   SET WeightInOunces = 16, --column name = value
	   Size = 2,
	   Type = 'Monkey Bread'
OUTPUT inserted.*, deleted.* --inserted contains the new values, deleted contains the old values
WHERE  Id = @Id -- always always always be specific

select * from Loaves WHERE Id = @Id

ROLLBACK --undoes the changes in the transaction
--commit --commits the changes in the transaction

--deleting data
DELETE
FROM Loaves
WHERE Id = @Id


--this is a bad idea usually, it removes all the data in your table
--truncate table Loaves