-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT CustomerId, FirstName, LastName, Country
FROM Customer
WHERE NOT Country="USA" 

-- Provide a query only showing the Customers from Brazil.
SELECT CustomerId, FirstName, LastName, Country
FROM Customer
WHERE Country="Brazil" 

-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT Invoice.InvoiceId "Invoice_ID", Customer.FirstName "First_Name", Customer.LastName "Last_Name", Invoice.InvoiceDate "Invoice_Date", Invoice.BillingCountry "Billing_Country"
FROM Customer
LEFT JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
WHERE Invoice.BillingCountry="Brazil" 
GROUP BY Invoice.InvoiceId

-- Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee
WHERE Title = "Sales Support Agent"

-- Provide a query showing a unique list of billing countries from the Invoice table.
SELECT BillingCountry "Billing Countries"
FROM Invoice
GROUP BY BillingCountry

-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT Invoice.InvoiceId "Invoice_ID", Employee.FirstName "First_Name", Employee.LastName "Last_Name", Invoice.InvoiceDate "Invoice_Date", Invoice.Total "Total"
FROM Employee
LEFT JOIN Customer ON Employee.EmployeeId = Customer.SupportRepId
LEFT JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
WHERE Employee.Title = "Sales Support Agent"
GROUP BY Invoice.InvoiceId

-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT Invoice.InvoiceId AS "InvoiceId", Invoice.Total "Total", Customer.FirstName "First_Name", Customer.LastName "Last_Name", Employee.FirstName "Sales_First_Name", Employee.LastName "Sales_Last_Name", Invoice.BillingCountry "Country of Billing"
FROM Invoice
LEFT JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
LEFT JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
GROUP BY Invoice.InvoiceId

-- How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT COUNT(InvoiceId) "Invoices Per Year", SUM(Total) "Total Sales", SUBSTR(InvoiceDate, 0, 5) "Year"
FROM Invoice
WHERE SUBSTR(InvoiceDate, 0, 5) IN ("2009", "2011")
GROUP BY SUBSTR(InvoiceDate, 0, 5)

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(InvoiceId) "Tracks on Invoice"
FROM InvoiceLine
WHERE InvoiceId = 37

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT InvoiceId "Invoice Number", COUNT(InvoiceId) "Tracks on Invoice"
FROM InvoiceLine
GROUP BY InvoiceId

-- Provide a query that includes the track name with each invoice line item.
SELECT InvoiceLine.InvoiceLineId "Invoice Line", InvoiceLine.InvoiceId "Invoice Number", InvoiceLine.TrackId "Track ID", Track.Name "Song"
FROM InvoiceLine
LEFT JOIN Track ON InvoiceLine.TrackId = Track.TrackId
GROUP BY InvoiceLine.InvoiceLineId

-- Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT InvoiceLine.InvoiceLineId "Invoice Line", InvoiceLine.InvoiceId "Invoice Number", InvoiceLine.TrackId "Track ID", Track.Name "Song", Artist.Name "Artist"
FROM InvoiceLine
LEFT JOIN Track ON InvoiceLine.TrackId = Track.TrackId
LEFT JOIN Album ON Track.AlbumId = Album.AlbumId
LEFT JOIN Artist ON Album.ArtistId = Artist.ArtistId
GROUP BY InvoiceLine.InvoiceLineId

-- Provide a query that shows the # of invoices per country. HINT: GROUP BY
Select COUNT(InvoiceId) "Number of Invoices", BillingCountry "Country"
FROM Invoice
GROUP BY BillingCountry

-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.
SELECT COUNT(PlaylistTrack.TrackId) "Track Count", Playlist.Name
FROM PlaylistTrack
LEFT JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
GROUP BY(PlaylistTrack.PlaylistId)

-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT Track.Name "Song", Album.Title "Album", Genre.Name "Genre", MediaType.Name "File Type"
FROM Track
LEFT JOIN Album ON Track.AlbumId = Album.AlbumId
LEFT JOIN Genre ON Track.GenreId = Genre.GenreId
LEFT JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId

-- Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT Invoice.InvoiceId "Invoice#", COUNT(InvoiceLine.InvoiceLineId) "#Tracks Purchased"
FROM Invoice
LEFT JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
GROUP BY Invoice.InvoiceId

-- Provide a query that shows total sales made by each sales agent.
Select Employee.FirstName || ' ' || Employee.LastName "Employee", COUNT(Invoice.CustomerId) "Total Invoices"
FROM Employee
LEFT JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
LEFT JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE Employee.Title = "Sales Support Agent"
GROUP BY Employee.EmployeeId


-- Which sales agent made the most in sales in 2009?
Select Employee.FirstName || ' ' || Employee.LastName "Employee: Most Sales", COUNT(Invoice.CustomerId) "Total Invoices"
FROM Employee
LEFT JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
LEFT JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE Employee.Title = "Sales Support Agent"
AND Invoice.InvoiceDate LIKE "2009%"
GROUP BY Employee.EmployeeId
ORDER BY COUNT(Invoice.CustomerId) DESC
LIMIT 1

-- Which sales agent made the most in sales in 2010?
Select Employee.FirstName || ' ' || Employee.LastName "Employee: Most Sales", COUNT(Invoice.CustomerId) "Total Invoices"
FROM Employee
LEFT JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
LEFT JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE Employee.Title = "Sales Support Agent"
AND Invoice.InvoiceDate LIKE "2010%"
GROUP BY Employee.EmployeeId
ORDER BY COUNT(Invoice.CustomerId) DESC
LIMIT 1

-- Which sales agent made the most in sales over all?
Select Employee.FirstName || ' ' || Employee.LastName "Employee: Most Sales", COUNT(Invoice.CustomerId) "Total Invoices"
FROM Employee
LEFT JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
LEFT JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
WHERE Employee.Title = "Sales Support Agent"
GROUP BY Employee.EmployeeId
ORDER BY COUNT(Invoice.CustomerId) DESC
LIMIT 1

-- Provide a query that shows the # of customers assigned to each sales agent.
Select Employee.FirstName || ' ' || Employee.LastName "Employee", COUNT(Customer.CustomerId) "Total Invoices"
FROM Employee
LEFT JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
WHERE Employee.Title = "Sales Support Agent"
GROUP BY Employee.EmployeeId


-- Provide a query that shows the total sales per country. Which country's customers spent the most?
SELECT BillingCountry "Country", COUNT(InvoiceId) "# of Sales"
FROM Invoice
GROUP BY Country
ORDER BY COUNT(InvoiceId) DESC

-- Provide a query that shows the most purchased track of 2013.
SELECT Track.Name "Song", COUNT(InvoiceLine.InvoiceLineId) "Number of Sales in 2013"
FROM Track
LEFT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
LEFT JOIN Invoice ON Invoice.InvoiceId = InvoiceLine.InvoiceId
WHERE Invoice.InvoiceDate LIKE "2013%"
GROUP BY Track.TrackId
ORDER BY COUNT(InvoiceLine.InvoiceLineId) DESC
LIMIT 1

-- Provide a query that shows the top 5 most purchased tracks over all.
SELECT Track.Name "Song", COUNT(InvoiceLine.InvoiceLineId) "Number of Sales"
FROM Track
LEFT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Track.TrackId
ORDER BY COUNT(InvoiceLine.InvoiceLineId) DESC
LIMIT 5 

-- Provide a query that shows the top 3 best selling artists.
SELECT Artist.Name "Artist", COUNT(InvoiceLine.InvoiceLineId) "Number of Sales"
FROM Artist
LEFT JOIN Album ON Album.ArtistId = Artist.ArtistId
LEFT JOIN Track ON Track.AlbumId = Album.AlbumId
LEFT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Artist.ArtistId
ORDER BY COUNT(InvoiceLine.InvoiceLineId) DESC
LIMIT 3

-- Provide a query that shows the most purchased Media Type.
SELECT MediaType.Name "Media Format", COUNT(InvoiceLine.InvoiceLineId) "Number of Sales"
FROM MediaType
LEFT JOIN Track ON Track.MediaTypeId = MediaType.MediaTypeId
LEFT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY MediaType.MediaTypeId
ORDER BY COUNT(InvoiceLine.InvoiceLineId) DESC
LIMIT 1


-- Provide a query that shows the number tracks purchased in all invoices that contain more than one genre.
SELECT Invoice.InvoiceId "Invoice#", Count(Genre.GenreId) "Genre Count"
FROM Invoice
LEFT JOIN InvoiceLine ON InvoiceLine.InvoiceId = Invoice.InvoiceId
LEFT JOIN Track ON Track.TrackId = InvoiceLine.TrackId
LEFT JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Invoice.InvoiceId
HAVING Count(Genre.GenreId) > 1
ORDER BY "Genre Count" DESC
