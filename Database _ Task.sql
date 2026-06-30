-- 1. Create Tables Section

-- Create Employees Table
CREATE TABLE Employees (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Salary DECIMAL(18,2) NOT NULL
);
GO

-- Create EmployeeLog Table
CREATE TABLE EmployeeLog (
    Id INT PRIMARY KEY IDENTITY(1,1),
    EmployeeId INT,
    Action VARCHAR(100),
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP
);
GO


-- 2. Stored Procedures Section (Part 1)

-- SP 1: GetAllEmployees
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, FirstName, LastName, Salary 
    FROM Employees;
END;
GO

-- SP 2: GetHighSalaryEmployees
CREATE PROCEDURE GetHighSalaryEmployees
    @MinSalary DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Id, FirstName, LastName, Salary 
    FROM Employees
    WHERE Salary > @MinSalary;
END;
GO

-- SP 3: AddEmployee
CREATE PROCEDURE AddEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Salary DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Employees (FirstName, LastName, Salary)
    VALUES (@FirstName, @LastName, @Salary);
END;
GO


-- 3. Trigger Section (Part 2)

-- Create AFTER INSERT Trigger on Employees Table
CREATE TRIGGER AfterEmployeeInsert
ON Employees
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EmployeeLog (EmployeeId, Action, ActionDate)
    SELECT Id, 'A new employee has been added.', GETDATE()
    FROM inserted;
END;
GO