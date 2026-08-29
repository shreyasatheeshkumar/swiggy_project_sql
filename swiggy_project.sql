# PART A – Beginner SQL (Questions 1–40)

# Basic SQL Statements

-- 1.Display all customer details.

select * from Customers;
 
-- 2.Display Customer ID, Customer Name, and City. 

select CustomerID,  FirstName, City
from Customers;

-- 3.Display customers from Chennai.

Select * from Customers 
where City = "Chennai"; 
 
-- 4.Display customers from Coimbatore. 

Select * from Customers 
where City = "Coimbatore"; 

-- 5.Display the list of unique customer cities. 

select distinct City
from Customers;

-- 6.Display customers in alphabetical order. 

select * from Customers
order by FirstName ASC; 

-- 7.Display customers in reverse alphabetical order.

select * from Customers
order by FirstName DESC;
 
-- 8.Display the first 10 customer records. 

select * from Customers
limit 10;

-- 9.Display the first five restaurants.

select * from Restaurants
limit 5;
 
-- 10.Display restaurants located in Bengaluru. 

select * from Restaurants
where City = "Bengaluru";

-- 11.Display all menu items.

select * from Menuitems;
 
-- 12.Display only vegetarian menu items. 

select * from Menuitems
where IsVeg = 1;

-- 13.Display only non-vegetarian menu items.

select * from Menuitems
where IsVeg = 0;
 
-- 14.Display menu items costing more than ₹300. 

select * from Menuitems
where Price > 300;

-- 15.Display menu items costing less than ₹200.

select * from Menuitems
where Price < 200;
 
-- 16.Display menu items priced between ₹200 and ₹400.

select * from Menuitems
where Price between 200 and 400;
 
-- 17.Display the ten most expensive menu items. 

select * from Menuitems
order by Price DESC limit 10;

-- 18.Display the ten least expensive menu items. 

select * from Menuitems
order by Price ASC limit 10;

-- 19.Display customers whose names begin with the letter 'A'. 

select * from Customers
where FirstName like "A%";

-- 20.Display customers whose names end with "Kumar". 

select * from Customers
where LastName like "%Kumar";

-- Pattern Matching & Conditions

-- 21.Display menu items containing the word "Chicken".

select * from Menuitems
where ItemName like "%Chicken%";
 
-- 22.Display customers from Chennai, Coimbatore, and Madurai. 

select * from Customers
where City in ("Chennai", "Coimbatore", "Madurai");

-- 23.Display customers who are not from Chennai.

select * from CUstomers
where City != "Chennai";   -- [where city not in ("Chennai");] 
 
-- 24.Display deliveries where the delivery rating is not available.

select * from Delivery 
where DeliveryRating is NULL;
 
-- 25.Display deliveries that have received ratings. 

select * from Delivery 
where DeliveryRating is not NULL;

-- Orders, Payments & Reviews

-- 26.Display all orders.

select * from Orders;
 
-- 27.Display delivered orders. 

select * from Orders
where OrderStatus = "Delivered";

-- 28.Display cancelled orders.

select * from Orders
where OrderStatus = "Cancelled";
 
-- 29.Display pending orders.

select * from Orders
where OrderStatus = "Preparing";
 
-- 30.Display completed payments. 

select * from Payments
where PaymentStatus = "Success";

-- 31.Display failed payments.

select * from Payments
where PaymentStatus = "Failed";
 
-- 32.Display refunded payments. 

select * from Payments
where PaymentStatus = "Refunded";

-- 33.Display the ten highest payment amounts.

select * from Payments
order by Amount DESC limit 10;
 
-- 34.Display the ten lowest payment amounts. 

select * from Payments
order by Amount ASC limit 10;

-- 35.Display all five-star reviews.

select * from Reviews
where FoodRating = 5;

-- 36.Display reviews with ratings less than three. 

select * from Reviews 
where DeliveryRating < 3;

-- 37.Display customer names using the alias "Customer".

select FirstName as Customer
from Customers;
			# or #      
SELECT Concat(FirstName, ' ',LastName) AS Customer
FROM Customers;
 
-- 38.Display menu item names using the alias "Food Item". 

select ItemName as Food_Item 
from MenuItems;

-- 39.Display menu prices after adding a 5% service charge.

select Price * 1.05 as New_Price
From MenuItems;
 
-- 40.Display the latest ten registered customers. 

select * from Customers
order by RegistrationDate limit 10;

-- PART B – Aggregate Functions (Questions 41–60)

-- 41.Display the total number of registered customers.

select count(*) as RegisteredCustomers
from Customers;
 
-- 42.Display the total number of restaurants.

select count(*) as Total_Restaurants
from Customers;
 
-- 43.Display the total number of customer orders. 

select count(*) as Total_Number_of_Orders
from Orders;

-- 44.Display the total number of completed payments. 

select count(*) as Completed_Payments
from Payments
where PaymentStatus = "Success";

-- 45.Display the total revenue generated through completed payments. 

select sum(Amount) as Total_Revenue
from Payments
where PaymentStatus = "Success";

-- 46.Display the average order amount. 

select avg(TotalAmount) as Avg_order_Amt
from Orders;

-- 47.Display the highest order amount.

select max(TotalAmount) as Max_order_Amt
from Orders;

-- 48.Display the lowest order amount. 

select min(TotalAmount) AS Min_Order_Amt
from Orders;

-- 49.Display the average customer review rating. 

select avg(FoodRating) as Customer_rating
from Reviews;

-- 50.Display the average review rating rounded to two decimal places.

select round(avg(FoodRating),2) as Avg_Review_Rating 
from Reviews;

-- 51.Display the number of customers in each city. 

select City, count(*) as Total_City from Customers
group by City;

-- 52.Display the number of restaurants in each city.

select City, count(*) as Total_City from Restaurants
group by City;
 
-- 53.Display the total revenue generated by each payment method.

select sum(Amount) as Sum_Amt, PaymentMethod from Payments
group by PaymentMethod;
 
-- 54.Display the number of transactions for each payment method.

select count(TransactionID) as Count_TransactionID, 
PaymentMethod from Payments
group by PaymentMethod;
 
-- 55.Display the number of reviews for each rating. 

select count(ReviewID) as Count_ReviewID, FoodRating
from Reviews
group by FoodRating;

-- 56.Display the number of menu items in each food category. 

select count(ItemName) as Count_ItemName, CategoryID
from MenuItems
group by CategoryID;

-- 57.Display cities having more than five registered customers. 

select count(CustomerID) as Count_CustomerID, City
from Customers
group by City
having count(CustomerID) > 5;

-- 58.Display payment methods generating revenue greater than ₹20,000. 

select sum(Amount) as Sum_Amount, PaymentMethod
from Payments
group by PaymentMethod
having sum(Amount) > 20000;

-- 59.Display the average menu price for each food category. 

select avg(Price) as Avg_Price, CategoryID
from MenuItems
group by CategoryID;

-- 60.Display payment-method-wise transaction count, total revenue, average payment, highest payment, and lowest payment. 

select PaymentMethod, 
	count(TransactionID) as  Count_TransactionID,
    sum(Amount) as Sum_Amt, 
    avg(Amount) as Avg_Amt, 
    max(Amount) as Max_Amt, 
    min(Amount) as Min_Amt
from Payments
group by PaymentMethod;

-- PART C – JOIN Queries (Questions 61–90)

-- 61. Display customer name, order ID, order date, and total amount. 
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT 
    o.OrderID,
    r.RestaurantName,
    o.OrderDate,
    o.TotalAmount
FROM Orders o
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID;

-- 63. Display menu item name, category name, and price. 
SELECT 
    mi.ItemName,
    mc.CategoryName,
    mi.Price
FROM MenuItems mi
JOIN MenuCategories mc
ON mi.CategoryID = mc.CategoryID;

-- 64. Display order ID, payment amount, payment method, and payment status. 
SELECT 
    o.OrderID,
    p.Amount AS PaymentAmount,
    p.PaymentMethod,
    p.PaymentStatus
FROM Orders o
JOIN Payments p
ON o.OrderID = p.OrderID;

-- 65. Display order ID, delivery partner name, and delivery status. 
SELECT 
    d.OrderID,
    dp.PartnerName,
    d.DeliveryStatus
FROM Delivery d
JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

-- 66. Display customer name, review rating, and review comment. 
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.FoodRating,
    r.ReviewComment
FROM Reviews r
JOIN Customers c
ON r.CustomerID = c.CustomerID;

-- 67. Display restaurant name, review rating, and review comment. 
SELECT 
    res.RestaurantName,
    r.FoodRating,
    r.ReviewComment
FROM Reviews r
JOIN Restaurants res
ON r.RestaurantID = res.RestaurantID;

-- 68. Display restaurant name, menu item, and menu price. 
SELECT 
    r.RestaurantName,
    m.ItemName,
    m.Price
FROM Restaurants r
JOIN MenuItems m
ON r.RestaurantID = m.RestaurantID;

-- 69. Display all customers along with their orders, including customers who have not placed any orders. 
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- 70. Display all restaurants along with their menu items. 
SELECT 
    r.RestaurantName,
    m.ItemName
FROM Restaurants r
LEFT JOIN MenuItems m
ON r.RestaurantID = m.RestaurantID;

-- 71. Display all orders with their payment details, including unpaid orders. 
SELECT 
    o.OrderID,
    p.PaymentMethod,
    p.PaymentStatus,
    p.Amount
FROM Orders o
LEFT JOIN Payments p
ON o.OrderID = p.OrderID;

-- 72. Display all orders with delivery information, including undelivered orders. 
SELECT 
    o.OrderID,
    d.DeliveryStatus,
    d.AssignedTime,
    d.DeliveryTime
FROM Orders o
LEFT JOIN Delivery d
ON o.OrderID = d.OrderID;

-- 73. Display all restaurants along with their customer reviews. 
SELECT 
    res.RestaurantName,
    rev.FoodRating,
    rev.ReviewComment
FROM Restaurants res
LEFT JOIN Reviews rev
ON res.RestaurantID = rev.RestaurantID;

-- 74. Display all menu categories along with their menu items.
SELECT 
    mc.CategoryName,
    mi.ItemName
FROM MenuCategories mc
LEFT JOIN MenuItems mi
ON mc.CategoryID = mi.CategoryID;
 
-- 75. Display all payment records with their corresponding orders.
SELECT 
    p.PaymentID,
    p.OrderID,
    o.OrderDate,
    p.Amount,
    p.PaymentMethod,
    p.PaymentStatus
FROM Payments p
JOIN Orders o
ON p.OrderID = o.OrderID;
 
-- 76. Display all reviews with restaurant details. 
SELECT 
    r.ReviewID,
    res.RestaurantName,
    res.City,
    r.FoodRating,
    r.DeliveryRating,
    r.ReviewComment
FROM Reviews r
JOIN Restaurants res
ON r.RestaurantID = res.RestaurantID;

-- 77. Display all delivery records with delivery partner details. 
SELECT 
    d.DeliveryID,
    d.OrderID,
    dp.PartnerName,
    dp.MobileNo,
    dp.VehicleType,
    d.DeliveryStatus
FROM Delivery d
JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

-- 78. Display customer name, restaurant name, order amount, and payment status. 
SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    o.TotalAmount,
    p.PaymentStatus
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
JOIN Payments p
ON o.OrderID = p.OrderID;
-- 79. Display customer name, restaurant name, delivery partner name, and delivery status. 
SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    dp.PartnerName,
    d.DeliveryStatus
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
JOIN Delivery d
ON o.OrderID = d.OrderID
JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

-- 80. Display customer name, restaurant name, payment amount, payment method, and review rating. 
SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    p.Amount,
    p.PaymentMethod,
    rev.FoodRating
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
JOIN Payments p
ON o.OrderID = p.OrderID
JOIN Reviews rev
ON o.OrderID = rev.OrderID;

-- 81. Display each customer's total number of orders. 
SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 82. Display each restaurant's total number of orders received. 
SELECT
    r.RestaurantName,
    COUNT(o.OrderID) AS TotalOrders
FROM Restaurants r
LEFT JOIN Orders o
ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName;

-- 83. Display the total revenue generated by each restaurant. 
SELECT
    r.RestaurantName,
    SUM(o.TotalAmount) AS TotalRevenue
FROM Restaurants r
JOIN Orders o
ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName;

-- 84. Display the average customer rating for each restaurant. 
SELECT
    r.RestaurantName,
    AVG(rev.FoodRating) AS AverageRating
FROM Restaurants r
LEFT JOIN Reviews rev
ON r.RestaurantID = rev.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName;

-- 85. Display the total number of deliveries handled by each delivery partner. 
SELECT
    dp.PartnerName,
    COUNT(d.DeliveryID) AS TotalDeliveries
FROM DeliveryPartners dp
LEFT JOIN Delivery d
ON dp.PartnerID = d.PartnerID
GROUP BY dp.PartnerID, dp.PartnerName;

-- 86. Display the total payment collected through each payment method. 
SELECT
    PaymentMethod,
    SUM(Amount) AS TotalPayment
FROM Payments
GROUP BY PaymentMethod;

-- 87. Display customers along with the restaurants they reviewed.
SELECT
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName
FROM Reviews rev
JOIN Customers c
ON rev.CustomerID = c.CustomerID
JOIN Restaurants r
ON rev.RestaurantID = r.RestaurantID;
 
-- 88. Display restaurant name, city, and average menu price. 
SELECT
    r.RestaurantName,
    r.City,
    AVG(m.Price) AS AverageMenuPrice
FROM Restaurants r
JOIN MenuItems m
ON r.RestaurantID = m.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName, r.City;

-- 89. Display each food category with the number of menu items. 
SELECT
    mc.CategoryName,
    COUNT(mi.ItemID) AS NumberOfItems
FROM MenuCategories mc
LEFT JOIN MenuItems mi
ON mc.CategoryID = mi.CategoryID
GROUP BY mc.CategoryID, mc.CategoryName;

-- 90. Prepare a consolidated order report containing customer, restaurant, payment, and delivery details. 
SELECT
    o.OrderID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    r.RestaurantName,
    o.TotalAmount,
    p.PaymentMethod,
    p.PaymentStatus,
    dp.PartnerName,
    d.DeliveryStatus
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
LEFT JOIN Payments p
ON o.OrderID = p.OrderID
LEFT JOIN Delivery d
ON o.OrderID = d.OrderID
LEFT JOIN DeliveryPartners dp
ON d.PartnerID = dp.PartnerID;

-- PART D – Date Functions (Questions 91–120)
-- 91. Display the current system date. 
SELECT CURDATE() AS CurrentDate;

-- 92. Display the current system time. 
SELECT CURTIME() AS CurrentTime;

-- 93. Display the current date and time. 
SELECT NOW() AS CurrentDateTime;

-- 94. Display the system timestamp. 
SELECT CURRENT_TIMESTAMP() AS SystemTimestamp;

-- 95. Display today's date using the CURRENT_DATE() function. 
SELECT CURRENT_DATE() AS TodayDate;

-- 96. Display the current timestamp using CURRENT_TIMESTAMP(). 
SELECT CURRENT_TIMESTAMP() AS CurrentTimestamp;

-- 97. Display the order year for every order. 
SELECT 
    OrderID,
    YEAR(OrderDate) AS OrderYear
FROM Orders;

-- 98. Display the order month for every order.
SELECT 
    OrderID,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;
 
-- 99. Display the month name for every order. 
SELECT 
    OrderID,
    MONTHNAME(OrderDate) AS MonthName
FROM Orders;

-- 100. Display the day of the month for every order.
SELECT 
    OrderID,
    DAY(OrderDate) AS DayOfMonth
FROM Orders;
 
-- 101. Display the weekday name for every order. 
SELECT 
    OrderID,
    DAYNAME(OrderDate) AS WeekdayName
FROM Orders;

-- 102. Display the weekday number for every order. 
SELECT 
    OrderID,
    DAYOFWEEK(OrderDate) AS WeekdayNumber
FROM Orders;

-- 103. Display the week number for every order. 
SELECT 
    OrderID,
    WEEK(OrderDate) AS WeekNumber
FROM Orders;

-- 104. Display the quarter for every order. 
SELECT 
    OrderID,
    QUARTER(OrderDate) AS QuarterNumber
FROM Orders;

-- 105. Display the day number within the year for every order.
SELECT 
    OrderID,
    DAYOFYEAR(OrderDate) AS DayOfYear
FROM Orders;
 
-- 106. Calculate the number of days between the order date and delivery date. 
SELECT 
    OrderID,
    DATEDIFF(DeliveryDate, OrderDate) AS DeliveryDays
FROM Orders;

-- 107. Calculate the delivery duration in minutes.
SELECT 
    OrderID,
    TIMESTAMPDIFF(MINUTE, OrderDate, DeliveryDate) AS DeliveryDurationMinutes
FROM Orders;
 
-- 108. Display the expected delivery date by adding two days to the order date. 
SELECT 
    OrderID,
    DATE_ADD(OrderDate, INTERVAL 2 DAY) AS ExpectedDeliveryDate
FROM Orders;

-- 109. Display a reminder date three days before the order date.
SELECT 
    OrderID,
    DATE_SUB(OrderDate, INTERVAL 3 DAY) AS ReminderDate
FROM Orders;
 
-- 110. Add seven days to each order date. 
SELECT 
    OrderID,
    DATE_ADD(OrderDate, INTERVAL 7 DAY) AS NewOrderDate
FROM Orders;

-- 111.Subtract five days from each order date. 
SELECT 
    OrderID,
    DATE_SUB(OrderDate, INTERVAL 5 DAY) AS NewOrderDate
FROM Orders;

-- 112. Display all orders placed during the last thirty days. 
SELECT *
FROM Orders
WHERE OrderDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);

-- 113. Display the order date in DD-MM-YYYY format. 
SELECT 
    OrderID,
    DATE_FORMAT(OrderDate, '%d-%m-%Y') AS FormattedOrderDate
FROM Orders;

-- 114. Display the order month and year in "Month YYYY" format. 
SELECT 
    OrderID,
    DATE_FORMAT(OrderDate, '%M %Y') AS MonthYear
FROM Orders;

#115.	Display monthly revenue generated from completed payments. 
SELECT 
    DATE_FORMAT(o.OrderDate, '%M %Y') AS MonthYear,
    SUM(o.TotalAmount) AS MonthlyRevenue
FROM Orders o
JOIN Payments p
    ON o.OrderID = p.OrderID
WHERE p.PaymentStatus = 'Paid'
GROUP BY DATE_FORMAT(o.OrderDate, '%M %Y')
ORDER BY MIN(o.OrderDate);

#116.	Display the daily order count. 
SELECT 
    DATE(OrderDate) AS OrderDate,
    COUNT(*) AS OrderCount
FROM Orders
GROUP BY DATE(OrderDate)
ORDER BY DATE(OrderDate);

#117.	Display the total number of orders placed each month. 
SELECT 
    DATE_FORMAT(OrderDate, '%M %Y') AS MonthYear,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DATE_FORMAT(OrderDate, '%M %Y')
ORDER BY MIN(OrderDate);

#118.	Display the total number of orders placed on each weekday. 
SELECT 
    DAYNAME(OrderDate) AS WeekdayName,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY WEEKDAY(OrderDate), DAYNAME(OrderDate)
ORDER BY WEEKDAY(OrderDate);

#119.	Display the average delivery time in minutes. 
SELECT 
    AVG(TIMESTAMPDIFF(MINUTE, PickupTime, DeliveryTime)) 
        AS AverageDeliveryTimeMinutes
FROM Delivery;

#120.	Prepare a monthly business summary showing total orders, revenue, and average order value. 
SELECT 
    DATE_FORMAT(o.OrderDate, '%M %Y') AS MonthYear,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS Revenue,
    AVG(o.TotalAmount) AS AverageOrderValue
FROM Orders o
GROUP BY DATE_FORMAT(o.OrderDate, '%M %Y')
ORDER BY MIN(o.OrderDate);

-- PART E – Advanced SQL (Questions 121–150)
-- 121. Display all customers with a row number based on their total spending. 
SELECT 
    CustomerName,
    TotalSpending,
    ROW_NUMBER() OVER (ORDER BY TotalSpending DESC) AS RowNumber
FROM (
    SELECT 
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        COALESCE(SUM(o.TotalAmount), 0) AS TotalSpending
    FROM Customers c
    LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
) AS CustomerSpending;

-- 122. Rank restaurants according to total revenue. 
SELECT 
    RestaurantName,
    TotalRevenue,
    RANK() OVER (ORDER BY TotalRevenue DESC) AS RevenueRank
FROM (
    SELECT 
        r.RestaurantID,
        r.RestaurantName,
        COALESCE(SUM(o.TotalAmount), 0) AS TotalRevenue
    FROM Restaurants r
    LEFT JOIN Orders o
    ON r.RestaurantID = o.RestaurantID
    GROUP BY r.RestaurantID, r.RestaurantName
) AS RestaurantRevenue;

-- 123. Assign a dense rank to customers based on lifetime spending. 
SELECT 
    CustomerName,
    LifetimeSpending,
    DENSE_RANK() OVER (ORDER BY LifetimeSpending DESC) AS SpendingRank
FROM (
    SELECT 
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        COALESCE(SUM(o.TotalAmount), 0) AS LifetimeSpending
    FROM Customers c
    LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
) AS CustomerSpending;

-- 124. Divide customers into four spending groups using NTILE(). 
SELECT
    ntile(4) OVER (ORDER BY SUM(o.TotalAmount) DESC) AS spending_group,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(o.TotalAmount) AS total_Spending
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 125. Display each payment along with the previous payment amount. 
SELECT
    PaymentID,
    PaymentDate,
    Amount,
    LAG(Amount) OVER (
        ORDER BY PaymentDate, PaymentID
    ) AS Previous_Amount
FROM Payments;

-- 126. Display each payment along with the next payment amount. 
SELECT
    PaymentID,
    PaymentDate,
    Amount,
    LEAD(Amount) OVER (
        ORDER BY PaymentDate, PaymentID
    ) AS Next_Amount
FROM Payments;

-- 127. Calculate the running total of completed payments. 
SELECT
    PaymentID,
    PaymentDate,
    Amount,
    SUM(Amount) OVER (
        ORDER BY PaymentDate, PaymentID
    ) AS Running_Total
FROM Payments
WHERE PaymentStatus = 'Success';

-- 128. Calculate the moving average of payment amounts. 
SELECT
    PaymentID,
    PaymentDate,
    Amount,
    AVG(Amount) OVER (
        ORDER BY PaymentDate, PaymentID
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAverage
FROM Payments;

-- 129. Using a Common Table Expression (CTE), display restaurants with revenue greater than ₹20,000. 
with RestaurantRevenue as (
select 
	r.RestaurantID,
	r.RestaurantName,
    sum(o.TotalAmount) as Total_revenue
FROM Restaurants r
inner join Orders o 
on r.RestaurantID = o.RestaurantID 
group by r.RestaurantID,r.RestaurantName)
select * from RestaurantRevenue
where Total_revenue > 20000;

-- 130. Using a Common Table Expression (CTE), display customer-wise total spending. 
with customer_total_spending as(
SELECT
	c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(o.TotalAmount) AS total_spending
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName)
select * from customer_total_spending
order by total_spending desc ;

-- 131. Display customers whose total spending is greater than the average customer spending. 
with customer_total_spending as(
SELECT
	c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(o.TotalAmount) AS total_spending
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName)
select * from customer_total_spending
where total_spending > (select avg(total_spending)from customer_total_spending) ;

-- 132.Display orders whose value is greater than the average order value of the same restaurant. 
SELECT
	OrderID,
    RestaurantID,
    TotalAmount
    FROM Orders o 
    WHERE TotalAmount >
    (SELECT AVG(TotalAmount) from Orders 
    WHERE RestaurantID= o.RestaurantID);

-- 133.Categorize orders as Low, Medium, or High value using the CASE statement. 
SELECT
	OrderID,
	TotalAmount,
	CASE 
		WHEN TotalAmount <  500 THEN "low"
		WHEN TotalAmount BETWEEN  500 and 1000 THEN "medium"
        ELSE "high"
	END AS order_value
    FROM  Orders;
    
-- 134.Display the total number of completed, pending, failed, and refunded payments using conditional aggregation. 
SELECT
    SUM(CASE WHEN PaymentStatus = 'Success' THEN 1 ELSE 0 END) AS Completed,
    SUM(CASE WHEN PaymentStatus = 'Pending' THEN 1 ELSE 0 END) AS Pending,
    SUM(CASE WHEN PaymentStatus = 'Failed' THEN 1 ELSE 0 END) AS Failed,
    SUM(CASE WHEN PaymentStatus = 'Refunded' THEN 1 ELSE 0 END) AS Refunded
FROM Payments;

-- 135.Display customers who have placed at least one order. 
SELECT 
	c.CustomerID,
	c.FirstName AS customer_name
    FROM Customers c
    WHERE EXISTS (SELECT 1 FROM  Orders o WHERE o.CustomerID=c.CustomerID);

-- 136.Display customers who have never placed any order. 
SELECT 
	c.CustomerID,
	c.FirstName AS customer_name
    FROM Customers c
    WHERE NOT EXISTS (SELECT 1 FROM  Orders o WHERE o.CustomerID=c.CustomerID);

-- 137.Display the top five restaurants based on revenue. 
SELECT
    r.RestaurantName,
    SUM(o.TotalAmount) AS Revenue
FROM Restaurants r
JOIN Orders o
    ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName
ORDER BY Revenue DESC
LIMIT 5;
    
-- 138.Display the top ten customers based on lifetime spending. 
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(o.TotalAmount) AS lifetime_Spending
FROM Customers c
inner join Orders o 
on  c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
order by lifetime_Spending desc limit 10;

-- 139.Display restaurants having an average customer rating greater than 4.5. 
SELECT
    r.RestaurantID,
    r.RestaurantName,
    AVG(rv.FoodRating) AS Avg_Rating
FROM Restaurants r
JOIN Reviews rv
    ON r.RestaurantID = rv.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName
HAVING AVG(rv.FoodRating) > 4.5;

-- 140.Calculate the Customer Lifetime Value (CLV) for every customer. 
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(o.TotalAmount) AS CLV
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;

-- 141.Display monthly revenue generated through completed payments. 
SELECT
	MONTH(PaymentDate)AS pay_month,
    YEAR(PaymentDate)AS pay_year,
    SUM(Amount) AS Monthly_revenue
FROM  Payments
WHERE PaymentStatus = 'Success'
GROUP BY YEAR(PaymentDate),MONTH(PaymentDate);

-- 142.Display the total number of orders placed during each hour of the day. 
SELECT
	HOUR(OrderDate) AS hr_order,
	count(OrderDate)AS total_order
FROM  Orders
GROUP BY HOUR(OrderDate)
ORDER BY hr_order;

-- 143.Display the average delivery time for each delivery partner. 
SELECT
    dp.PartnerName,
    AVG(
        TIMESTAMPDIFF(
            MINUTE,
            d.PickupTime,
            d.DeliveryTime
        )
    ) AS Avg_Delivery_Time_Minutes
FROM Delivery d
JOIN DeliveryPartners dp
    ON d.PartnerID = dp.PartnerID
GROUP BY dp.PartnerID, dp.PartnerName;

-- 144.Identify the delivery partner with the lowest average delivery time. 
SELECT
    dp.PartnerName,
    AVG(
        TIMESTAMPDIFF(
            MINUTE,
            d.PickupTime,
            d.DeliveryTime
        )
    ) AS Avg_Delivery_Time_Minutes
FROM Delivery d
JOIN DeliveryPartners dp
    ON d.PartnerID = dp.PartnerID
GROUP BY dp.PartnerID, dp.PartnerName
ORDER BY Avg_Delivery_Time_Minutes ASC
LIMIT 1;

-- 145.Rank payment methods based on completed transactions. 
SELECT
    PaymentMethod,
    COUNT(PaymentID) AS completed_transactions,
    RANK() OVER (
        ORDER BY COUNT(PaymentID) DESC
    ) AS payment_rank
FROM Payments
WHERE PaymentStatus = 'Success'
GROUP BY PaymentMethod;

-- 146.Display each restaurant's revenue along with its percentage contribution to total revenue. 
SELECT
    RestaurantID,
    SUM(TotalAmount) AS revenue,
    ROUND(
        SUM(TotalAmount) * 100.0 / SUM(SUM(TotalAmount)) OVER (),
        2
    ) AS revenue_percentage
FROM Orders
GROUP BY RestaurantID;

-- 147.Display customers who have placed more than five orders. 
SELECT 
	CustomerID,
    COUNT(OrderID) AS Place_order
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(OrderID) >5;
	
-- 148.Display customers who have ordered from more than one restaurant. 
SELECT 
	CustomerID,
    count(DISTINCT RestaurantID) AS Place_order
    FROM Orders
    GROUP BY CustomerID
    HAVING  count(DISTINCT RestaurantID) >1;

-- 149.Prepare a KPI dashboard showing total customers, restaurants, orders, completed payments, and reviews.
SELECT
    (SELECT COUNT(*) FROM Customers) AS total_customers,
    (SELECT COUNT(*) FROM Restaurants) AS total_restaurants,
    (SELECT COUNT(*) FROM Orders) AS total_orders,
    (SELECT COUNT(*) 
     FROM Payments
     WHERE PaymentStatus = 'Success') AS completed_payments,
    (SELECT COUNT(*) FROM Reviews) AS total_reviews;

# 150.Prepare an executive business report showing restaurant name, total orders, total revenue, average customer rating, and average delivery time.
SELECT R.RESTAURANTNAME,
	   ( SELECT COUNT(*) 
        FROM ORDERS AS O
        WHERE R.RESTAURANTID = O.RESTAURANTID) AS TOTAL_ORDERS,
	   (SELECT SUM(O.TOTALAMOUNT)
        FROM ORDERS AS O
		WHERE O.RESTAURANTID = R.RESTAURANTID) AS TOTAL_REVENUE,
       ( SELECT AVG(RW.FOODRATING) 
        FROM REVIEWS AS RW
		WHERE RW.RESTAURANTID = R.RESTAURANTId ) AS AVG_CUSTOMER_RATING,
       (SELECT AVG(TIMESTAMPDIFF(MINUTE, D.PICKUPTIME, D.DELIVERYTIME))
        FROM DELIVERY AS D
        INNER JOIN ORDERS AS O
          ON D.ORDERID = O.ORDERID
        WHERE O.RESTAURANTID = R.RESTAURANTID) AS AVG_DELIVERY_TIME
FROM RESTAURANTS AS R;




select * from Delivery;
select * from Orders;
select * from Delivery;
select * from Restaurants;
select * from Customers;
select * from Reviews;
select * from DeliveryPartners;
select * from Payments;
select * from MenuCategories;
select * from MenuItems;