create database Adventure;
-- 1
SELECT
    ProductKey,
    CustomerKey,
    OrderDateKey,
    OrderQuantity,
    UnitPrice,
    Discountamount
FROM FactInternetSales

UNION ALL

SELECT
    ProductKey,
    CustomerKey,
    OrderDateKey,
    OrderQuantity,
    UnitPrice,
    Discountamount
    
FROM Fact_Internet_Sales_New;
-- 2
SELECT
    f.*,
    p.EnglishProductName AS ProductName
FROM FactInternetSales f
JOIN DimProduct p
    ON f.ProductKey = p.ProductKey;
SHOW COLUMNS FROM DimProduct;
SELECT
    f.*,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerFullName,
    p.ListPrice AS UnitPrice
FROM FactInternetSales f
JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
JOIN DimProduct p
    ON f.ProductKey = p.ProductKey;
SELECT
    OrderDateKey,
    STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d') AS OrderDate
FROM FactInternetSales;
-- 3
SELECT
    f.OrderDateKey,

    -- Create Date
    STR_TO_DATE(f.OrderDateKey, '%Y%m%d') AS OrderDate,

    -- A. Year
    YEAR(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) AS Year,

    -- B. Month Number
    MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) AS MonthNo,

    -- C. Month Full Name
    MONTHNAME(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) AS MonthFullName,

    -- D. Quarter
    CONCAT('Q', QUARTER(STR_TO_DATE(f.OrderDateKey, '%Y%m%d'))) AS Quarter,

    -- E. Year-Month (YYYY-MMM)
    DATE_FORMAT(STR_TO_DATE(f.OrderDateKey, '%Y%m%d'), '%Y-%b') AS YearMonth,

    -- F. Weekday Number
    DAYOFWEEK(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) AS WeekdayNo,

    -- G. Weekday Name
    DAYNAME(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) AS WeekdayName,

    -- H. Financial Month (Apr–Mar)
    CASE
        WHEN MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) >= 4
        THEN MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) - 3
        ELSE MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) + 9
    END AS FinancialMonth,

    -- I. Financial Quarter (India)
    CASE
        WHEN MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(STR_TO_DATE(f.OrderDateKey, '%Y%m%d')) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter

FROM FactInternetSales f;
-- 4
SELECT
    OrderQuantity,
    UnitPrice,
    DiscountAmount,
    (UnitPrice * OrderQuantity) - DiscountAmount AS SalesAmount
FROM FactInternetSales;
-- 5
SELECT
    OrderQuantity,
    UnitPrice,
    (Unitprice * OrderQuantity) AS ProductionCost
FROM FactInternetSales;
-- 6

SHOW COLUMNS FROM FactInternetSales;
SELECT
    OrderQuantity,
    SalesAmount,
    TotalProductCost,
    (SalesAmount - TotalProductCost) AS Profit
FROM FactInternetSales;