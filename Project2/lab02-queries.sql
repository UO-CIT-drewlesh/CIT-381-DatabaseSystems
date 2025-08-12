-- Drew Lesh
-- Lab 2

#1 (13 rows): Employees in offices not in the US using offices.country
-- Number, Employee, Office
-- 1102, Bondur, Gerard, France
-- 1337, Hernandez, Loui, France
-- 1370, Hernandez, Gerard, France

SELECT e.employeeNumber as Number , concat(e.lastName, ", ", e.firstName) as Employee, o.country as Office
FROM employees as e
-- INNER JOIN offices as o ON e.officeCode = o.officeCode;
INNER JOIN offices as o USING(officeCode)
WHERE o.country != "USA";


#2 (2 rows): Products and product line where MSRP > $200
-- Line, Product, Qty, MSRP, Price
-- "Classic Cars", "1952 Alpine Renault 1300", '7305', '214.30', '98.58'
-- 'Classic Cars', '2001 Ferrari Enzo', '3619', '207.80', '95.59'

SELECT p.productLine as Line, p.productName as Product, p.quantityInStock as Qty, p.MSRP as MSRP, p.buyPrice as Price
FROM products as p
INNER JOIN productlines as pl ON p.productLine = pl.productLine
WHERE p.MSRP > "200";


-- #3 (435 rows): All orders shipped within 1 day ordered by customer name then ordered by product name
-- # customerName, orderNumber, orderDate, productName, quantityOrdered, o.shippedDate - o.orderDate
-- 'Atelier graphique', '10345', '2004-11-25', '1938 Cadillac V-16 Presidential Limousine', '43', '1'
-- 'Australian Collectors, Co.', '10347', '2004-11-29', '18th Century Vintage Horse Carriage', '45', '1'
-- 'Australian Collectors, Co.', '10347', '2004-11-29', '1913 Ford Model T Speedster', '48', '1'

SELECT c.customerName, o.orderNumber, o.orderDate, p.productName, d.quantityOrdered, datediff(o.shippedDate, o.orderDate) as 'o.shippedDate - o.orderDate'
FROM orders o
INNER JOIN customers as c ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails as d ON o.orderNumber = d.orderNumber
INNER JOIN products as p ON d.productCode = p.productCode
WHERE datediff(o.shippedDate, o.orderDate) <= 1
ORDER BY c.customerName, p.productName;


-- #4 (1 row): Average, maximum, and minimum buyPrice of all products
-- # AvgPrice, MaxPrice, MinPrice
-- '54.395182', '103.42', '15.91'
SELECT avg(p.buyPrice) as AvgPrice, max(p.buyPrice) as MaxPrice, min(p.buyPrice) as MinPrice
FROM products p
INNER JOIN products pd ON p.buyPrice = pd.buyPrice;