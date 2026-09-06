
----------------------AdventureWorks2012-----------------------
---------------------------------------------------------------
--1.Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales schema)
--to show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’
select SalesOrderID , ShipDate 
from [Sales].[SalesOrderHeader]
where OrderDate between '7/28/2002' and '7/29/2014'


---------------------------------------------------------------
--2.Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
select ProductID , [Production].[Product].[Name]  
from [Production].[Product]
where StandardCost < 110


---------------------------------------------------------------
--3.Display ProductID, Name if its weight is unknown
select ProductID , [Production].[Product].[Name]  
from [Production].[Product]
where [Weight] is null 


---------------------------------------------------------------
--4.Display all Products with a Silver, Black, or Red Color
select ProductID , [Production].[Product].[Name] , ThumbnailPhotoFileName as describtion   
from [Production].[Product] , [Production].[ProductPhoto]
where ThumbnailPhotoFileName like '%silver%' or ThumbnailPhotoFileName like '%black%' 
or ThumbnailPhotoFileName like '%red%'


-----------------------------------------------------------------
--5.Display any Product with a Name starting with the letter B
select [Product].[Name]  
from [Production].[Product]
where [Product].[Name] like 'B%'


-----------------------------------------------------------------
--6.write a query that displays any Product description with underscore value in its description.
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select [ProductDescription].[Description]
from [Production].[ProductDescription]
where [ProductDescription].[Description] like '%!_%' escape '!'


-----------------------------------------------------------------
--7.Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period between  '7/1/2001' and '7/31/2014'
select OrderDate , sum(TotalDue) as SumTotalDue
from [Sales].[SalesOrderHeader] 
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate
order by OrderDate


-----------------------------------------------------------------
--8.Display the Employees HireDate (note no repeated values are allowed)
select distinct HireDate 
from [HumanResources].[Employee]


-----------------------------------------------------------------
--9.Calculate the average of the unique ListPrices in the Product table
select avg(distinct ListPrice) as Avg_prices 
from [Production].[Product]


-----------------------------------------------------------------
--10.Display the Product Name and its ListPrice within the values of 100 and 120 
--the list should has the following format "The [product name] is only! [List price]" 
select CONCAT('The ',[Production].[Product].[Name],' is only! ',ListPrice) as Product_discribe 
from [Production].[Product]
where ListPrice > 100 and ListPrice < 120


-----------------------------------------------------------------
--11.(a)Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?
create table store_Archive (
cop_rowguid uniqueidentifier,
Store_name varchar(100),
cop_SalesPersonID int,
cop_demograghics xml
);

insert into  store_Archive (cop_rowguid , Store_name , cop_SalesPersonID, cop_demograghics) 
SELECT rowguid , [Sales].[Store].[Name] ,SalesPersonID, Demographics 
FROM [Sales].[Store]


-----------------------------------------------------------------
--11.(b)Try the previous query but without transferring the data? 
SELECT cop_rowguid , Store_name , cop_SalesPersonID, cop_demograghics 
FROM store_Archive


-----------------------------------------------------------------
--12.Using union statement, retrieve the today’s date in different styles using convert or format funtion.
select 'Style 1 (mm/dd/yyyy)' as Date_Style, convert(varchar(30), getdate(),101) as today_Date
union all
select 'Style 2 (dd/mm/yyyy)',convert(varchar(30), getdate(),103) 
union all
select 'Style 3 (yyyy.MM.dd)',  format(getdate(), 'yyyy.MM.dd')
union all
select 'Style 4 (yyyy-dd-mm)',  format(getdate(), 'yyyy_dd_mm')
union all
select 'Style 5 (yyyy/mm/dd)', convert(varchar(30), getdate(),111) 
union all
select 'Style 6 (yyyy-mm-dd hh:mi:ss)', convert(varchar(30), getdate(),120) ;
