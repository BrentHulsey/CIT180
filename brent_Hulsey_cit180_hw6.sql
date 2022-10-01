--q1
SELECT FirstName, LastName, State
FROM redcat.Customer
WHERE State = 'MN'
ORDER BY LastName DESC;
--Margarita Barrett
--Sulaiman Al-Rafee

--q2
SELECT redcat.sale.saleid, 
    redcat.sale.saledate AS "Date of Sale", 
    (redcat.Sale.tax+redcat.Sale.shipping) AS "SUM" 
FROM redcat.SALE
WHERE redcat.Sale.SaleDate BETWEEN '20-DEC-21' AND '25-DEC-21'
GROUP BY redcat.sale.saleid, redcat.sale.saledate, (redcat.Sale.tax+redcat.Sale.shipping);
--No data. Just column headings.

--q3
SELECT E.FirstName, 
    E.LastName, 
    E.HireDate, 
    M.FirstName AS MgrFirstN, 
    M.LastName AS MgrLastN
FROM redcat.Employee E
 JOIN redcat.WageEmployee WE 
 ON E.EmployeeID = WE.EmployeeID
 JOIN Employee M 
 ON E.ManagerID = M.EmployeeID;

--q4
SELECT DISTINCT(E.EmployeeID) AS EmpID,
    E.FirstName AS EmpFirst,
    E.LastName AS EmpLast,
    M.ManufacturerID AS MfrID,
    M.Manufacturername AS MfrName
FROM Employee E
 JOIN Purchase P
 ON E.EmployeeID=P.EmployeeID
 JOIN Manufacturer M
 ON P.ManufacturerID=M.ManufacturerID
WHERE Manufacturername = 'Timberland';
--3 records

--q5
SELECT MAX(SalePrice*Quantity) AS LargestItemSale 
FROM SaleItem;
--360

--q6
SELECT Category, Color, MAX(ListPrice) AS "Maximum Price"
FROM redcat.Product
WHERE Gender = 'M'
GROUP BY Category, Color
ORDER BY Category;

--q7
SELECT ProductName, ListPrice
FROM redcat.Product
WHERE ProductID IN
    (SELECT I.ProductID
    FROM InventoryItem I, SaleItem SI, Sale S
    WHERE I.ProductID = SI.ProductID 
    AND I.ItemSize = SI.ItemSize 
    AND SI.SaleID = S.SaleID 
    AND S.Shipping > 60);

--q8
SELECT COUNT(*) AS "Number of Products"
FROM redcat.Product
WHERE ManufacturerID IN
    (SELECT ManufacturerID
    FROM Manufacturer
    WHERE State = 'CA');

--q9
CREATE OR REPLACE VIEW JerseyBoiz AS
    SELECT P.ProductName, P.Color, P.ListPrice
    FROM redcat.Product P, redcat.Manufacturer M
    WHERE P.ManufacturerID = M.ManufacturerID
    AND P.Gender = 'M'
    AND M.State = 'NJ';

--q10
SELECT ROUND(AVG(ListPrice), 2) AS AvgPrice
FROM JerseyBoiz
WHERE Color='Black';