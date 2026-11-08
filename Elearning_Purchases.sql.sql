--
-- Module End Assignment: Analyzing E-Learning Platform Purchases
-- ==============================================================

-- 1. DATABASE and SCHEMAS
-- ---------------------------------
Drop Database if exists elearning_db;
Create database elearning_db;
use elearning_db;

Create Table learners (
learners_id int auto_increment primary key,
Full_name varchar(200) Not null,
Country varchar(100)
);

 Create Table Courses (
 Course_id int auto_increment primary key,
 course_name varchar (150) Not null,
 Category varchar(200) not null,
 unit_price decimal(10,2) not null
 );

show tables;
Describe learners;
Describe courses;

Create Table Purchases (
purchase_id int auto_increment primary key,
learners_id int not null,
course_id int not null,
Quantity int not null,
purchase_date date not null,
 constraint fk_purchases_learners 
 Foreign Key (learners_id) 
 References learners (learners_id),
 constraint fk_purchases_course
 Foreign Key (course_id) 
 References courses (course_id)
 );
 
 -- ------------------------------
 -- Creating 1.Sample Data ----
 -- ------------------------------
 INSERT INTO learners (Full_name, Country) VALUES
('Anwar Basha', 'India'),
('Cindy Joseph', 'USA'),
('Andrea Fox', 'Brazil'),
('Sara Khan', 'UAE'),
('Christian Birch', 'Canada'),
('Kelly Brown', 'UK');

Insert into courses (Course_name, category, unit_price) values
('SQL for Beginners',  'Data Analytics', 89.99),
('PowerBi for Beginners',  'Data Analytics', 79.99),
('Python Basics', 'Programming', 99.99),
('UI Design Fundamentals', 'Designs', 60.00),
('Business Excel Essentials', 'Business', 49.00);

Insert into purchases (learners_id, course_id, quantity, purchase_date) values
(1, 1, 1, '2025-01-05'),
(1, 3, 2, '2025-01-20'),
(2, 2, 1, '2025-02-11'),
(3, 4, 1, '2025-02-25'),
(4, 1, 3, '2025-03-03'),
(2, 1, 1, '2025-03-14'),
(5, 3, 1, '2025-04-02'),
(3, 2, 2, '2025-04-18');

-- ----------------------------------
-- 2. DATA EXPOLARATION USING JOINS
-- ----------------------------------
-- 2a. Inner Join: Each purcahse with learner, course and the amount
 Select l.Full_name,
		c.course_name,
        c.Category,
        p.quantity,
        round(p.quantity *c.unit_price, 2) as total_amount,
        p.purchase_date
 From purchases as p
 Inner join learners as l on p.learners_id = l.learners_id
 Inner join courses as c on p.course_id = c.course_id
 order by total_amount desc;
 
 -- 2b. Left Join: every learner, including with those no purchases
 Select l.full_name,
		l.country,
        Count(p.purchase_id) As purchases_count
From learners as l
Left join purchases as p on l.learners_id = P.learners_id
Group by l.learners_id, l.full_name, l.country
Order by purchases_count desc;

-- 2c. Right Join: every course, including those never purchased
Select c.course_name,
       c.category,
       Count(p.purchase_id) as times_purchased
From purchases As p
Right join courses as c on p.course_id = c.course_id
Group by c.course_id, c.course_name, c.category
Order by times_purchased desc;

-- -----------------------
-- 3.Analytical Queries
-- -----------------------

-- Q1. To display each leaners total spending and money
Select l.full_name,
       l.country,
       Round(coalesce(sum(p.quantity * c.unit_price), 0), 2) as total_spent
From learners as l
Left join purchases as p on l.learners_id = p.learners_id
Left join courses as c on p.course_id = c.course_id
Group by l.learners_id, l.full_name, l.country
Order by total_spent desc;

-- Q2. Find the Top 3 most purchased courses by total quantity sold
 SELECT c.course_name, 
        SUM(p.quantity) AS total_quantity_sold
FROM purchases AS p
INNER JOIN courses AS c ON p.course_id = c.course_id
GROUP BY c.course_id , c.course_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- Q3. Need to display Total revenue and number of unique learners per category
 Select c.category,
        Round(sum(p.quantity * c.unit_price), 2) as total_revenue,
        count(distinct p.learners_id) as unique_leaners
FROM purchases AS p
Inner join courses AS c ON p.course_id = c.course_id
Group by c.category
Order by total_revenue desc;

-- Q4. Learners who purchased from more than one category
Select l.full_name,
       l.country,
       count(distinct c.category) as categories_purchased
From Learners as l
Inner join purchases as p on l.learners_id = p.learners_id
Inner join courses as c on p.course_id = c.course_id
Group by l.learners_id, l.full_name, l.country
Having count(distinct c.category) >1
Order by categories_purchased desc;

-- Q5. Courses that have been never purchased 
Select c.category,
       c.course_name,
       c.unit_price
From courses as c
LEFT JOIN purchases AS p ON c.course_id = p.course_id
where purchase_id is null;



        
 