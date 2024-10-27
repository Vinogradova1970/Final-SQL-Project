SELECT * 
FROM chinook;

1.Show Customers (their full names, customer ID, and country) who are not in the US. (Hint: != or <> can be used to say "is not equal to").
SELECT FirstName,LastName,Customerid,Country
FROM Customers
WHERE Country != 'USA';

2.Show only the Customers from Brazil
SELECT FirstName,LastName,Country
FROM Customers
WHERE Country  ='Brazil';

3.Find the Invoices of customers who are from Brazil. The resulting table should show the customer's full name, Invoice ID, Date of the invoice, and billing country.
SELECT inv.InvoiceId, inv.InvoiceDate, inv.BillingCountry, cu.FirstName ||" "|| cu.LastName AS FullName
FROM invoices inv
LEFT JOIN customers cu
ON cu.CustomerId = inv.CustomerId
WHERE inv.BillingCountry = "Brazil";

4.Show the Employees who are Sales Agents
SELECT *
FROM employees
WHERE Title LIKE "%Agent%;

5.Find a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT(BillingCountry) AS Country
FROM invoices;

6.Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT inv.InvoiceId, em.FirstName ||" "|| em.LastName AS AgentName
FROM invoices inv, employees em, customers cu
WHERE cu.SupportRepId = em.EmployeeId
AND cu.CustomerId = inv.CustomerId;


7.Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT inv.InvoiceId, cu.FirstName ||" "|| cu.LastName AS CustomerName, cu.Country, em.FirstName ||" "|| em.LastName AS AgentName, inv.Total
FROM invoices inv, customers cu, employees em
WHERE cu.SupportRepId = em.EmployeeId
AND cu.CustomerId = inv.CustomerId;


8.How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT strftime('%Y', InvoiceDate) AS Year, COUNT(*) AS TotalInvoices, ROUND(SUM(Total)) AS TotalSales
FROM invoices
WHERE InvoiceDate LIKE "2009%"
OR InvoiceDate LIKE "2011%"
GROUP BY Year;

9.What are the total sales for 2009?
SELECT COUNT(*) AS TotalSales
FROM invoices
WHERE InvoiceDate >= '2009-01-01' AND InvoiceDate <= '2009-12-31';


10.Provide a query that includes the track name with each invoice line ID.
SELECT inv.InvoiceId, tr.Name
FROM invoice_items inv
LEFT JOIN tracks tr
ON tr.TrackId = inv.TrackId

11.Provide a query that includes the purchased track name AND artist name with each invoice line ID.
SELECT inv.InvoiceId, tr.Name AS TrackName, ar.Name as Artist
FROM invoice_items inv
LEFT JOIN tracks tr
ON tr.TrackId = inv.TrackId
LEFT JOIN albums al
ON tr.AlbumId = al.AlbumId
LEFT JOIN artists ar
ON al.ArtistId = ar.ArtistId;

12.Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT tr.Name AS Track, 
al.Title AS Album, mt.Name AS MediaType, ge.Name AS Genre
FROM tracks tr
JOIN albums al ON tr.AlbumId = al.AlbumId
JOIN media_types mt ON tr.MediaTypeId = mt.MediaTypeId
JOIN genres ge ON tr.GenreId = ge.GenreId;


13.Provide a query that shows total sales made by each sales agent.
SELECT em.EmployeeId, SUM(inv.Total) AS TotalSales
FROM (SELECT EmployeeId
      FROM employees
      WHERE Title LIKE "%Agent%") em
LEFT JOIN customers cu
ON cu.SupportRepId = em.EmployeeId
LEFT JOIN invoices inv
ON inv.CustomerId = cu.CustomerId
GROUP BY em.EmployeeId;

14. Which sales agent made the most in sales in 2009?
SELECT em.SalesAgent AS Agent, MAX(TotalSales) AS Sales
FROM (SELECT em.FirstName ||" "|| em.LastName AS SalesAgent, SUM(inv.Total) AS TotalSales
      FROM employees em
      LEFT JOIN customers cu
      ON cu.SupportRepId = em.EmployeeId
      LEFT JOIN invoices inv
      ON inv.CustomerId = cu.CustomerId
      WHERE inv.InvoiceDate LIKE "2009%"
      GROUP BY em.EmployeeId);






