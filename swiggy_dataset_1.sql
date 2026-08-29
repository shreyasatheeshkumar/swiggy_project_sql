# Part 1 – Swiggy Delivery Management System

# Step 1: Create Database

-- =============================================
-- SWIGGY DELIVERY MANAGEMENT SYSTEM
-- PART 1 : DATABASE CREATION
-- MySQL 8.0
-- =============================================

DROP DATABASE IF EXISTS SwiggyDB;

CREATE DATABASE SwiggyDB;

USE SwiggyDB;

# Step 2: Customers Table

CREATE TABLE Customers
(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Gender ENUM('Male','Female','Other'),
    MobileNo VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE,
    RegistrationDate DATE NOT NULL,
    City VARCHAR(50),
    Area VARCHAR(100)
);


# Step 3: Restaurants

CREATE TABLE Restaurants
(
    RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantName VARCHAR(100) NOT NULL,
    Cuisine VARCHAR(50),
    City VARCHAR(50),
    Area VARCHAR(100),
    Rating DECIMAL(2,1),
    OpeningTime TIME,
    ClosingTime TIME
);

# Step 4: Menu Categories
CREATE TABLE MenuCategories
(
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

# Step 5: Menu Items
CREATE TABLE MenuItems
(
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    CategoryID INT,
    ItemName VARCHAR(100) NOT NULL,
    Price DECIMAL(8,2) NOT NULL,
    IsVeg BOOLEAN,
    Available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(RestaurantID)
        REFERENCES Restaurants(RestaurantID),
    FOREIGN KEY(CategoryID)
        REFERENCES MenuCategories(CategoryID)
);


# Step 6: Orders

CREATE TABLE Orders
(
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    RestaurantID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    EstimatedDelivery DATETIME,
    OrderStatus
    ENUM
    (
        'Placed',
        'Preparing',
        'Picked Up',
        'Delivered',
        'Cancelled'
    )
    DEFAULT 'Placed',
    DeliveryAddress VARCHAR(200),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY(CustomerID)
        REFERENCES Customers(CustomerID),
    FOREIGN KEY(RestaurantID)
        REFERENCES Restaurants(RestaurantID)
);

# Step 8: Delivery Partners

CREATE TABLE DeliveryPartners
(
    PartnerID INT AUTO_INCREMENT PRIMARY KEY,
    PartnerName VARCHAR(100),
	Gender ENUM('Male','Female','Other'),
    MobileNo VARCHAR(15) UNIQUE,
	city varchar(30),
    VehicleType
    ENUM
    (
        'Bike',
        'Scooter',
        'Cycle'
    ),
    JoiningDate DATE,
    Rating DECIMAL(2,1),
	PartnerStatus varchar(30)
);

# Step 9: Delivery

CREATE TABLE Delivery
(
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
    PartnerID INT,
    AssignedTime DATETIME,
    PickupTime DATETIME,
    DeliveryTime DATETIME,
    DeliveryStatus varchar(30),
    DeliveryRating int,
    FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID),
    FOREIGN KEY(PartnerID)
        REFERENCES DeliveryPartners(PartnerID)
);

# Step 10: Payments

CREATE TABLE Payments
(
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
    PaymentMethod
    ENUM
    (
        'UPI',
        'Credit Card',
        'Debit Card',
        'Cash',
        'Net Banking',
        'Cash on Delivery',
        'Wallet'
    ),
    PaymentStatus
    ENUM
    (
        'Success',
        'Failed',
        'Pending'
    ),
    PaymentDate DATETIME,
    Amount numeric(10,2),
    TransactionID varchar(10),
    FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID)
);


# Step 11: Reviews

CREATE TABLE Reviews
(
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT UNIQUE,
	CustomerID INT,
	RestaurantID INT,
	ReviewDate DATE,
    FoodRating INT CHECK(FoodRating BETWEEN 1 AND 5),
    DeliveryRating INT CHECK(DeliveryRating BETWEEN 1 AND 5),
    ReviewComment VARCHAR(300),

    FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID)
);


# Step 12: Useful Indexes

CREATE INDEX idx_customer_city
ON Customers(City);

CREATE INDEX idx_restaurant_city
ON Restaurants(City);

CREATE INDEX idx_order_date
ON Orders(OrderDate);

CREATE INDEX idx_delivery_time
ON Delivery(DeliveryTime);

-- =====================================================
-- Swiggy Delivery Management System
-- File : 02_Insert_Customers.sql
-- Records : 1 - 20
-- =====================================================

USE SwiggyDB;

INSERT INTO Customers
(FirstName, LastName, Gender, MobileNo, Email, DateOfBirth, RegistrationDate, City, Area)
VALUES
('Arun','Kumar','Male','9876501001','arun.kumar@gmail.com','1994-03-15','2024-01-10','Coimbatore','RS Puram'),
('Priya','Shankar','Female','9876501002','priya.shankar@gmail.com','1997-07-21','2024-01-12','Coimbatore','Saibaba Colony'),
('Karthik','Raman','Male','9876501003','karthik.raman@gmail.com','1992-11-08','2024-01-15','Chennai','Anna Nagar'),
('Divya','Krishnan','Female','9876501004','divya.krishnan@gmail.com','1998-04-18','2024-01-18','Chennai','Velachery'),
('Vignesh','Mohan','Male','9876501005','vignesh.mohan@gmail.com','1995-09-30','2024-01-20','Bengaluru','Indiranagar'),
('Sneha','Iyer','Female','9876501006','sneha.iyer@gmail.com','1999-06-05','2024-01-22','Bengaluru','Whitefield'),
('Harish','Narayanan','Male','9876501007','harish.n@gmail.com','1991-01-11','2024-01-25','Hyderabad','Gachibowli'),
('Meena','Subramanian','Female','9876501008','meena.s@gmail.com','1996-10-24','2024-01-27','Hyderabad','Madhapur'),
('Rahul','Prasad','Male','9876501009','rahul.prasad@gmail.com','1993-08-13','2024-02-01','Madurai','Anna Nagar'),
('Keerthana','Raj','Female','9876501010','keerthana.raj@gmail.com','2000-02-09','2024-02-03','Madurai','KK Nagar'),
('Sanjay','Babu','Male','9876501011','sanjay.babu@gmail.com','1994-12-02','2024-02-06','Salem','Fairlands'),
('Nandhini','Selvam','Female','9876501012','nandhini.selvam@gmail.com','1997-05-28','2024-02-08','Salem','Hasthampatti'),
('Praveen','Rajendran','Male','9876501013','praveen.r@gmail.com','1990-09-19','2024-02-11','Tiruppur','Avinashi Road'),
('Aishwarya','Balaji','Female','9876501014','aishwarya.b@gmail.com','1998-01-30','2024-02-15','Tiruppur','Kangeyam Road'),
('Lokesh','Srinivasan','Male','9876501015','lokesh.s@gmail.com','1995-07-12','2024-02-18','Erode','Perundurai Road'),
('Pavithra','Murugan','Female','9876501016','pavithra.m@gmail.com','1996-03-25','2024-02-20','Erode','Surampatti'),
('Ajith','Velan','Male','9876501017','ajith.velan@gmail.com','1993-06-14','2024-02-23','Kochi','Edappally'),
('Anitha','Ravi','Female','9876501018','anitha.ravi@gmail.com','1999-09-17','2024-02-25','Kochi','Kakkanad'),
('Suresh','Ganesh','Male','9876501019','suresh.g@gmail.com','1991-11-29','2024-02-27','Mysuru','Vijayanagar'),
('Lakshmi','Narayan','Female','9876501020','lakshmi.n@gmail.com','1997-04-06','2024-03-01','Mysuru','Gokulam'),
('Manoj','Kannan','Male','9876501021','manoj.kannan@gmail.com','1993-02-18','2024-03-03','Coimbatore','Peelamedu'),
('Deepika','Ramesh','Female','9876501022','deepika.ramesh@gmail.com','1998-07-29','2024-03-05','Coimbatore','Singanallur'),
('Ashwin','Karthikeyan','Male','9876501023','ashwin.k@gmail.com','1994-10-16','2024-03-08','Chennai','Tambaram'),
('Ramya','Senthil','Female','9876501024','ramya.senthil@gmail.com','1996-12-03','2024-03-10','Chennai','Porur'),
('Dinesh','Kumar','Male','9876501025','dinesh.kumar@gmail.com','1991-05-22','2024-03-12','Bengaluru','Jayanagar'),
('Swathi','Prakash','Female','9876501026','swathi.prakash@gmail.com','1999-09-14','2024-03-15','Bengaluru','BTM Layout'),
('Naveen','Raj','Male','9876501027','naveen.raj@gmail.com','1992-11-27','2024-03-18','Hyderabad','Kondapur'),
('Bhavani','Suresh','Female','9876501028','bhavani.suresh@gmail.com','1997-04-09','2024-03-20','Hyderabad','Hitech City'),
('Saravanan','Murali','Male','9876501029','saravanan.m@gmail.com','1990-08-11','2024-03-22','Madurai','Thirunagar'),
('Gayathri','Venkatesh','Female','9876501030','gayathri.v@gmail.com','1998-01-20','2024-03-25','Madurai','Simmakkal'),
('Kishore','Balan','Male','9876501031','kishore.balan@gmail.com','1995-06-13','2024-03-28','Salem','Ammapet'),
('Revathi','Mohan','Female','9876501032','revathi.mohan@gmail.com','1996-11-05','2024-03-30','Salem','Alagapuram'),
('Sathish','Ravi','Male','9876501033','sathish.ravi@gmail.com','1993-03-08','2024-04-02','Tiruppur','PN Road'),
('Janani','Karthik','Female','9876501034','janani.karthik@gmail.com','1999-08-18','2024-04-05','Tiruppur','Velampalayam'),
('Vinoth','Sankar','Male','9876501035','vinoth.sankar@gmail.com','1992-09-25','2024-04-08','Erode','Veerappanchatram'),
('Hemalatha','R','Female','9876501036','hemalatha.r@gmail.com','1997-02-07','2024-04-10','Erode','Thindal'),
('Aravind','Krishna','Male','9876501037','aravind.krishna@gmail.com','1994-05-16','2024-04-12','Kochi','Kaloor'),
('Shalini','Nair','Female','9876501038','shalini.nair@gmail.com','1998-10-30','2024-04-15','Kochi','Palarivattom'),
('Rohit','Sharma','Male','9876501039','rohit.sharma@gmail.com','1991-01-12','2024-04-18','Mysuru','Hebbal'),
('Pooja','Menon','Female','9876501040','pooja.menon@gmail.com','1999-07-06','2024-04-20','Mysuru','Nazarbad'),
('Balaji','Sundaram','Male','9876501041','balaji.sundaram@gmail.com','1993-04-12','2024-04-23','Coimbatore','Ganapathy'),
('Nivetha','R','Female','9876501042','nivetha.r@gmail.com','1998-11-27','2024-04-25','Coimbatore','Saravanampatti'),
('Gokul','Prabhakaran','Male','9876501043','gokul.prabhakaran@gmail.com','1994-08-15','2024-04-28','Chennai','Adyar'),
('Harini','Srinivasan','Female','9876501044','harini.s@gmail.com','1999-06-09','2024-05-01','Chennai','T. Nagar'),
('Madhan','Kumar','Male','9876501045','madhan.kumar@gmail.com','1992-01-31','2024-05-03','Bengaluru','Koramangala'),
('Keerthi','Rao','Female','9876501046','keerthi.rao@gmail.com','1997-09-18','2024-05-05','Bengaluru','Marathahalli'),
('Ramesh','Babu','Male','9876501047','ramesh.babu@gmail.com','1991-07-24','2024-05-08','Hyderabad','Begumpet'),
('Anjali','Reddy','Female','9876501048','anjali.reddy@gmail.com','1998-02-14','2024-05-10','Hyderabad','Banjara Hills'),
('Kiran','Murugan','Male','9876501049','kiran.murugan@gmail.com','1995-12-05','2024-05-13','Madurai','Bibikulam'),
('Sowmya','Lakshmi','Female','9876501050','sowmya.lakshmi@gmail.com','1999-04-20','2024-05-15','Madurai','Tallakulam'),
('Ashok','Rajan','Male','9876501051','ashok.rajan@gmail.com','1990-10-16','2024-05-18','Salem','Yercaud Main Road'),
('Dhivya','Baskar','Female','9876501052','dhivya.baskar@gmail.com','1997-03-11','2024-05-20','Salem','Gugai'),
('Senthil','Nathan','Male','9876501053','senthil.nathan@gmail.com','1993-05-07','2024-05-23','Tiruppur','Mangalam Road'),
('Preethi','Arun','Female','9876501054','preethi.arun@gmail.com','1998-12-28','2024-05-25','Tiruppur','College Road'),
('Muthukumar','Velu','Male','9876501055','muthukumar.velu@gmail.com','1992-08-09','2024-05-28','Erode','Karungalpalayam'),
('Kavitha','Mani','Female','9876501056','kavitha.mani@gmail.com','1996-06-02','2024-05-30','Erode','Teachers Colony'),
('Nikhil','Nair','Male','9876501057','nikhil.nair@gmail.com','1994-09-13','2024-06-02','Kochi','Vyttila'),
('Aparna','Pillai','Female','9876501058','aparna.pillai@gmail.com','1999-01-22','2024-06-05','Kochi','Thrippunithura'),
('Mahesh','Gowda','Male','9876501059','mahesh.gowda@gmail.com','1991-11-18','2024-06-08','Mysuru','Kuvempu Nagar'),
('Sindhu','Prasad','Female','9876501060','sindhu.prasad@gmail.com','1998-05-04','2024-06-10','Mysuru','Lakshmipuram'),
('Prakash','Narayanan','Male','9876501061','prakash.narayanan@gmail.com','1992-02-14','2024-06-12','Coimbatore','Vadavalli'),
('Monisha','Rajendran','Female','9876501062','monisha.raj@gmail.com','1998-09-05','2024-06-14','Coimbatore','Sundarapuram'),
('Raghav','Krishnan','Male','9876501063','raghav.krishnan@gmail.com','1994-01-18','2024-06-17','Chennai','Nungambakkam'),
('Vaishnavi','S','Female','9876501064','vaishnavi.s@gmail.com','1999-07-30','2024-06-20','Chennai','Kodambakkam'),
('Bharath','Ramesh','Male','9876501065','bharath.ramesh@gmail.com','1993-05-27','2024-06-23','Bengaluru','HSR Layout'),
('Haritha','Prabhu','Female','9876501066','haritha.prabhu@gmail.com','1997-11-10','2024-06-25','Bengaluru','Electronic City'),
('Sai','Kiran','Male','9876501067','sai.kiran@gmail.com','1995-04-08','2024-06-28','Hyderabad','Kukatpally'),
('Lavanya','Rao','Female','9876501068','lavanya.rao@gmail.com','1998-12-19','2024-07-01','Hyderabad','Jubilee Hills'),
('Murali','Dharan','Male','9876501069','murali.dharan@gmail.com','1991-08-16','2024-07-03','Madurai','Arasaradi'),
('Abinaya','R','Female','9876501070','abinaya.r@gmail.com','1999-02-26','2024-07-05','Madurai','Pasumalai'),
('Karthikeyan','Velmurugan','Male','9876501071','karthikeyan.v@gmail.com','1992-10-12','2024-07-08','Salem','Johnsonpet'),
('Renuka','Devi','Female','9876501072','renuka.devi@gmail.com','1996-06-21','2024-07-10','Salem','Shevapet'),
('Yogesh','Chandran','Male','9876501073','yogesh.chandran@gmail.com','1994-03-09','2024-07-13','Tiruppur','Rakkiyapalayam'),
('Mahalakshmi','S','Female','9876501074','mahalakshmi.s@gmail.com','1998-08-14','2024-07-16','Tiruppur','Nallur'),
('Ganesh','K','Male','9876501075','ganesh.k@gmail.com','1990-12-01','2024-07-18','Erode','Nasiyanur'),
('Shobana','Ravi','Female','9876501076','shobana.ravi@gmail.com','1997-04-24','2024-07-20','Erode','Sathy Road'),
('Arjun','Menon','Male','9876501077','arjun.menon@gmail.com','1993-09-15','2024-07-23','Kochi','Marine Drive'),
('Neethu','Joseph','Female','9876501078','neethu.joseph@gmail.com','1999-01-29','2024-07-25','Kochi','Aluva'),
('Darshan','Shetty','Male','9876501079','darshan.shetty@gmail.com','1992-07-11','2024-07-28','Mysuru','Jayalakshmipuram'),
('Shruthi','Hegde','Female','9876501080','shruthi.hegde@gmail.com','1998-05-17','2024-07-30','Mysuru','Saraswathipuram'),
('Vasanth','Kumar','Male','9876501081','vasanth.kumar@gmail.com','1993-06-18','2024-08-02','Coimbatore','Race Course'),
('Anupriya','Mohan','Female','9876501082','anupriya.mohan@gmail.com','1998-02-11','2024-08-04','Coimbatore','Kovaipudur'),
('Sriram','Iyer','Male','9876501083','sriram.iyer@gmail.com','1991-09-23','2024-08-07','Chennai','Mylapore'),
('Nithya','Balasubramanian','Female','9876501084','nithya.b@gmail.com','1997-12-05','2024-08-10','Chennai','Perungudi'),
('Abhishek','Rao','Male','9876501085','abhishek.rao@gmail.com','1994-05-17','2024-08-12','Bengaluru','Rajajinagar'),
('Pavithra','Krishna','Female','9876501086','pavithra.krishna@gmail.com','1999-08-26','2024-08-15','Bengaluru','Malleshwaram'),
('Tejas','Varma','Male','9876501087','tejas.varma@gmail.com','1992-10-08','2024-08-18','Hyderabad','Ameerpet'),
('Sushmitha','Reddy','Female','9876501088','sushmitha.reddy@gmail.com','1998-03-14','2024-08-20','Hyderabad','Secunderabad'),
('Aravindan','Pandi','Male','9876501089','aravindan.pandi@gmail.com','1991-07-29','2024-08-22','Madurai','Villapuram'),
('Kavya','Muthu','Female','9876501090','kavya.muthu@gmail.com','1998-11-02','2024-08-24','Madurai','Goripalayam'),
('Pranav','Sankar','Male','9876501091','pranav.sankar@gmail.com','1993-01-19','2024-08-27','Salem','Kondalampatti'),
('Rajalakshmi','K','Female','9876501092','rajalakshmi.k@gmail.com','1997-04-30','2024-08-29','Salem','Omalur'),
('Hariharan','Subash','Male','9876501093','hariharan.subash@gmail.com','1995-09-10','2024-09-02','Tiruppur','Amarjothi Garden'),
('Anusha','Priyan','Female','9876501094','anusha.priyan@gmail.com','1999-01-27','2024-09-05','Tiruppur','Dharapuram Road'),
('Ravichandran','Manohar','Male','9876501095','ravichandran.m@gmail.com','1992-12-16','2024-09-08','Erode','Brough Road'),
('Deepa','Sivakumar','Female','9876501096','deepa.sivakumar@gmail.com','1998-06-13','2024-09-10','Erode','Solar'),
('Adarsh','Nambiar','Male','9876501097','adarsh.nambiar@gmail.com','1994-04-21','2024-09-13','Kochi','Fort Kochi'),
('Arya','Menon','Female','9876501098','arya.menon@gmail.com','1999-09-09','2024-09-16','Kochi','Panampilly Nagar'),
('Manjunath','Rao','Male','9876501099','manjunath.rao@gmail.com','1991-11-07','2024-09-18','Mysuru','Chamundi Hill Road'),
('Bhavana','Shenoy','Female','9876501100','bhavana.shenoy@gmail.com','1998-05-28','2024-09-20','Mysuru','Yadavagiri');

-- =====================================================
-- Swiggy Delivery Management System
-- File : 03_Insert_Restaurants.sql
-- Records : 20
-- =====================================================

USE SwiggyDB;

INSERT INTO Restaurants
(RestaurantName, Cuisine, City, Area, Rating, OpeningTime, ClosingTime)
VALUES
('Annapoorna Veg Restaurant','South Indian','Coimbatore','RS Puram',4.7,'07:00:00','22:30:00'),
('Kovai Biryani House','Biryani','Coimbatore','Peelamedu',4.5,'11:00:00','23:00:00'),
('Madras Dosa Corner','South Indian','Chennai','Anna Nagar',4.6,'06:30:00','22:00:00'),
('Marina Seafood Grill','Seafood','Chennai','Velachery',4.4,'11:30:00','23:00:00'),
('Silicon Spice Kitchen','North Indian','Bengaluru','Indiranagar',4.5,'10:30:00','22:30:00'),
('Pizza Fiesta','Italian','Bengaluru','Whitefield',4.3,'11:00:00','23:30:00'),
('Hyderabad Dum Biryani','Biryani','Hyderabad','Gachibowli',4.8,'11:00:00','23:30:00'),
('Charminar Kabab House','Mughlai','Hyderabad','Madhapur',4.6,'12:00:00','23:30:00'),
('Temple City Meals','South Indian','Madurai','KK Nagar',4.4,'07:00:00','22:00:00'),
('Chettinad Spice','Chettinad','Madurai','Anna Nagar',4.5,'11:00:00','22:30:00'),
('Salem Grill House','Barbecue','Salem','Fairlands',4.3,'12:00:00','23:00:00'),
('Kongu Kitchen','Kongu','Salem','Hasthampatti',4.6,'07:30:00','22:30:00'),
('Tiruppur Tiffin Centre','South Indian','Tiruppur','Avinashi Road',4.5,'06:30:00','21:30:00'),
('Cotton City Café','Multi Cuisine','Tiruppur','College Road',4.2,'09:00:00','22:00:00'),
('Erode Veg Delight','Vegetarian','Erode','Surampatti',4.5,'07:00:00','22:00:00'),
('Kaveri Family Restaurant','North Indian','Erode','Perundurai Road',4.4,'11:00:00','22:30:00'),
('Malabar Food Court','Kerala','Kochi','Edappally',4.7,'08:00:00','23:00:00'),
('Cochin Seafood Kitchen','Seafood','Kochi','Kakkanad',4.6,'11:30:00','23:00:00'),
('Mysore Palace Restaurant','South Indian','Mysuru','Vijayanagar',4.5,'07:00:00','22:00:00'),
('Royal Mysore Café','Multi Cuisine','Mysuru','Gokulam',4.4,'08:00:00','22:30:00');

-- =====================================================
-- Swiggy Delivery Management System
-- File : 04_Insert_MenuCategories.sql
-- Records : 8
-- =====================================================

USE SwiggyDB;

INSERT INTO MenuCategories
(CategoryName)
VALUES
('Breakfast'),
('Lunch'),
('Dinner'),
('Snacks'),
('Beverages'),
('Desserts'),
('Fast Food'),
('Biryani');

INSERT INTO MenuItems
(RestaurantID, CategoryID, ItemName, Price, IsVeg, Available)
VALUES
/*
---------------------------------------------------------
-- Restaurant 1 : Annapoorna Veg Restaurant
---------------------------------------------------------
*/
(1,1,'Idli (2 Nos)',45.00,TRUE,TRUE),
(1,1,'Ghee Roast Dosa',110.00,TRUE,TRUE),
(1,1,'Ven Pongal',85.00,TRUE,TRUE),
(1,2,'South Indian Meals',180.00,TRUE,TRUE),
(1,2,'Mini Meals',130.00,TRUE,TRUE),
(1,5,'Filter Coffee',35.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 2 : Kovai Biryani House
---------------------------------------------------------
*/
(2,8,'Chicken Biryani',240.00,FALSE,TRUE),
(2,8,'Mutton Biryani',320.00,FALSE,TRUE),
(2,8,'Egg Biryani',180.00,FALSE,TRUE),
(2,8,'Veg Biryani',170.00,TRUE,TRUE),
(2,4,'Chicken 65',210.00,FALSE,TRUE),
(2,5,'Fresh Lime Soda',60.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 3 : Madras Dosa Corner
---------------------------------------------------------
*/
(3,1,'Plain Dosa',60.00,TRUE,TRUE),
(3,1,'Masala Dosa',90.00,TRUE,TRUE),
(3,1,'Rava Dosa',100.00,TRUE,TRUE),
(3,1,'Onion Uttapam',95.00,TRUE,TRUE),
(3,4,'Medu Vada',55.00,TRUE,TRUE),
(3,5,'Badam Milk',65.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 4 : Marina Seafood Grill
---------------------------------------------------------
*/
(4,2,'Fish Meals',290.00,FALSE,TRUE),
(4,2,'Prawn Fried Rice',260.00,FALSE,TRUE),
(4,3,'Grilled Fish',340.00,FALSE,TRUE),
(4,3,'Butter Garlic Prawns',380.00,FALSE,TRUE),
(4,4,'Calamari Fry',250.00,FALSE,TRUE),
(4,5,'Fresh Watermelon Juice',80.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 5 : Silicon Spice Kitchen
---------------------------------------------------------
*/
(5,2,'Butter Naan',45.00,TRUE,TRUE),
(5,2,'Paneer Butter Masala',220.00,TRUE,TRUE),
(5,2,'Veg Fried Rice',180.00,TRUE,TRUE),
(5,3,'Chicken Butter Masala',280.00,FALSE,TRUE),
(5,3,'Jeera Rice',140.00,TRUE,TRUE),
(5,5,'Sweet Lassi',75.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 6 : Pizza Fiesta
---------------------------------------------------------
*/
(6,7,'Margherita Pizza',249.00,TRUE,TRUE),
(6,7,'Veg Supreme Pizza',349.00,TRUE,TRUE),
(6,7,'Farmhouse Pizza',379.00,TRUE,TRUE),
(6,7,'Garlic Bread',149.00,TRUE,TRUE),
(6,7,'White Sauce Pasta',229.00,TRUE,TRUE),
(6,6,'Chocolate Brownie',129.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 7 : Hyderabad Dum Biryani
---------------------------------------------------------
*/
(7,8,'Hyderabadi Chicken Dum Biryani',299.00,FALSE,TRUE),
(7,8,'Hyderabadi Mutton Dum Biryani',379.00,FALSE,TRUE),
(7,8,'Paneer Dum Biryani',249.00,TRUE,TRUE),
(7,8,'Egg Dum Biryani',219.00,FALSE,TRUE),
(7,4,'Chicken 65',229.00,FALSE,TRUE),
(7,5,'Rose Milk',69.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 8 : Charminar Kabab House
---------------------------------------------------------
*/
(8,2,'Butter Chicken',299.00,FALSE,TRUE),
(8,2,'Chicken Tikka Masala',319.00,FALSE,TRUE),
(8,3,'Mutton Seekh Kabab',349.00,FALSE,TRUE),
(8,3,'Tandoori Roti',35.00,TRUE,TRUE),
(8,3,'Paneer Tikka',239.00,TRUE,TRUE),
(8,5,'Sweet Lime Juice',79.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 9 : Temple City Meals
---------------------------------------------------------
*/
(9,1,'Mini Tiffin',149.00,TRUE,TRUE),
(9,1,'Idiyappam with Coconut Milk',119.00,TRUE,TRUE),
(9,2,'Temple Special Meals',199.00,TRUE,TRUE),
(9,2,'Curd Rice',99.00,TRUE,TRUE),
(9,4,'Banana Bajji',69.00,TRUE,TRUE),
(9,5,'Jigarthanda',89.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 10 : Chettinad Spice
---------------------------------------------------------
*/
(10,2,'Chettinad Chicken Curry',299.00,FALSE,TRUE),
(10,2,'Chettinad Veg Meals',189.00,TRUE,TRUE),
(10,3,'Pepper Chicken',289.00,FALSE,TRUE),
(10,3,'Kothu Parotta',199.00,FALSE,TRUE),
(10,4,'Egg Kalaki',99.00,FALSE,TRUE),
(10,5,'Fresh Lime Juice',59.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 11 : Salem Grill House
---------------------------------------------------------
*/
(11,3,'Grilled Chicken',325.00,FALSE,TRUE),
(11,3,'Chicken BBQ Wings',285.00,FALSE,TRUE),
(11,3,'Mutton Grill',420.00,FALSE,TRUE),
(11,2,'Chicken Fried Rice',210.00,FALSE,TRUE),
(11,4,'French Fries',120.00,TRUE,TRUE),
(11,5,'Mint Lime Cooler',75.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 12 : Kongu Kitchen
---------------------------------------------------------
*/
(12,2,'Kongu Veg Meals',185.00,TRUE,TRUE),
(12,2,'Kongu Chicken Curry',295.00,FALSE,TRUE),
(12,2,'Ragi Kali with Chicken Curry',275.00,FALSE,TRUE),
(12,3,'Mutton Chukka',345.00,FALSE,TRUE),
(12,4,'Kambu Kozhukattai',95.00,TRUE,TRUE),
(12,5,'Buttermilk',40.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 13 : Tiruppur Tiffin Centre
---------------------------------------------------------
*/
(13,1,'Mini Idli',70.00,TRUE,TRUE),
(13,1,'Poori Masala',95.00,TRUE,TRUE),
(13,1,'Set Dosa',85.00,TRUE,TRUE),
(13,1,'Rava Upma',80.00,TRUE,TRUE),
(13,4,'Masala Vada',40.00,TRUE,TRUE),
(13,5,'Filter Coffee',35.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 14 : Cotton City Café
---------------------------------------------------------
*/
(14,7,'Veg Burger',145.00,TRUE,TRUE),
(14,7,'Chicken Burger',185.00,FALSE,TRUE),
(14,7,'Veg Sandwich',130.00,TRUE,TRUE),
(14,7,'Chicken Wrap',210.00,FALSE,TRUE),
(14,6,'Vanilla Ice Cream',95.00,TRUE,TRUE),
(14,5,'Cold Coffee',110.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 15 : Erode Veg Delight
---------------------------------------------------------
*/
(15,1,'Ghee Pongal',95.00,TRUE,TRUE),
(15,2,'Vegetable Meals',175.00,TRUE,TRUE),
(15,2,'Curd Meals',145.00,TRUE,TRUE),
(15,4,'Samosa',30.00,TRUE,TRUE),
(15,6,'Gulab Jamun',65.00,TRUE,TRUE),
(15,5,'Fresh Lime Juice',55.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 16 : Kaveri Family Restaurant
---------------------------------------------------------
*/
(16,2,'Veg Meals',185.00,TRUE,TRUE),
(16,2,'Paneer Butter Masala',235.00,TRUE,TRUE),
(16,2,'Butter Naan',45.00,TRUE,TRUE),
(16,3,'Chicken Curry',275.00,FALSE,TRUE),
(16,3,'Jeera Rice',145.00,TRUE,TRUE),
(16,5,'Sweet Lassi',85.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 17 : Malabar Food Court
---------------------------------------------------------
*/
(17,1,'Puttu with Kadala Curry',135.00,TRUE,TRUE),
(17,1,'Appam with Vegetable Stew',145.00,TRUE,TRUE),
(17,2,'Kerala Meals',215.00,TRUE,TRUE),
(17,3,'Malabar Chicken Curry',295.00,FALSE,TRUE),
(17,3,'Parotta (2 Nos)',60.00,TRUE,TRUE),
(17,5,'Tender Coconut Water',70.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 18 : Cochin Seafood Kitchen
---------------------------------------------------------
*/
(18,2,'Fish Curry Meals',315.00,FALSE,TRUE),
(18,2,'Prawn Biryani',365.00,FALSE,TRUE),
(18,3,'Karimeen Pollichathu',420.00,FALSE,TRUE),
(18,3,'Crab Masala',395.00,FALSE,TRUE),
(18,4,'Fish Fingers',225.00,FALSE,TRUE),
(18,5,'Pineapple Juice',95.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 19 : Mysore Palace Restaurant
---------------------------------------------------------
*/
(19,1,'Mysore Masala Dosa',110.00,TRUE,TRUE),
(19,1,'Kesari Bath',85.00,TRUE,TRUE),
(19,2,'South Indian Meals',195.00,TRUE,TRUE),
(19,4,'Bonda',45.00,TRUE,TRUE),
(19,6,'Mysore Pak',80.00,TRUE,TRUE),
(19,5,'Filter Coffee',40.00,TRUE,TRUE),
/*
---------------------------------------------------------
-- Restaurant 20 : Royal Mysore Café
---------------------------------------------------------
*/
(20,7,'Veg Club Sandwich',175.00,TRUE,TRUE),
(20,7,'Paneer Burger',195.00,TRUE,TRUE),
(20,7,'French Fries',125.00,TRUE,TRUE),
(20,6,'Chocolate Sundae',155.00,TRUE,TRUE),
(20,6,'Fruit Salad with Ice Cream',165.00,TRUE,TRUE),
(20,5,'Cold Chocolate Milkshake',145.00,TRUE,TRUE);