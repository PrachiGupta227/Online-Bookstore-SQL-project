CREATE TABLE BOOKS(
Book_ID	INT,
Title	VARCHAR(70),
Author	VARCHAR(50),
Genre	VARCHAR(50),
Published_Year	INT,
Price	NUMERIC(10,2),
Stock	INT

);

CREATE TABLE CUSTOMERS(
Customer_ID	INT,
Name	VARCHAR(60),
Email	VARCHAR(60),
Phone	INT,
City	VARCHAR(60),
Country	VARCHAR(60)

);


CREATE TABLE ORDERS(
Order_ID	int,
Customer_ID	int,
Book_ID	int,
Order_Date	date,
Quantity	int,
Total_Amount	numeric(10,2)

);

select * from books;
select * from customers;
select * from orders;

--books in fiction genre 

select title,genre from books
where genre='Fiction';

--books published after 1950 

select title, genre, published_year from books
where published_year>=1950;

--List all customers from the Canada

select name, phone , city from customers 
where country='Canada';

--Show orders placed in November 2023

select * from orders 
where order_date between '2023-11-01' and '2023-11-30' order by order_date asc;

-- Retrieve the total stock of books available

select sum(stock) from books;

-- Find the details of the most expensive book

select max(price) from books;
select * from books 
where price=49.98;

--Show all customers who ordered more than 3 quantity of a book

select c.name, c.phone , o.quantity
from customers c 
JOIN orders o 
ON c.customer_id=o.customer_id 
where o.quantity>=3;

--Retrieve all orders where the total amount exceeds $20

select * from orders where total_amount>20;

--List all genres available in the Books table

select distinct genre from books;

--Find the book with the lowest stock

select min(stock) from books;
select title from books where stock=0;

--Calculate the total revenue generated from all orders

select sum(total_amount) as total_revenue from orders;

--Retrieve the total number of books sold for each genre:

select b.genre, sum(o.quantity) 
from books b 
join orders o 
on b.book_id=o.book_id
group by b.genre;

--Find the average price of books in the "Fantasy" genre:

select avg(price)  from books
where genre='Fantasy';

--List customers who have placed at least 2 orders:

select customer_id, count(order_id) from orders
group by customer_id
having count(order_id)>=2;

--Find the most frequently ordered book 

select book_id, count(order_id) from orders
group by book_id
order by count(order_id) desc;

--Show the top 3 most expensive books of 'Fantasy' Genre :

select title, genre, price
from books 
where genre='Fantasy' order by price desc
limit 3;

--Retrieve the total quantity of books sold by each author

select b.author, sum(o.quantity)
from books b
join 
orders o 
on b.book_id = o.book_id
group by b.author; 

--List the cities where customers who spent over $100 are located

select * from customers;

select c.city , sum(o.total_amount) 
from customers c
JOIN orders o 
on c.customer_id= o.customer_id
group by c.city
having sum(o.total_amount)>=100 

order by sum(total_amount) desc;

--Find the customer who spent the most on orders

select c.name, sum(o.total_amount)
from customers c
JOIN orders o 
on c.customer_id= o.customer_id
group by c.name
order by sum(total_amount) desc
limit 1;

--Calculate the stock remaining after fulfilling all orders

select b.book_id , coalesce(sum(o.quantity),0) as order_quantity,
b.stock - coalesce(sum(o.quantity),0) as remaining_stock
from books b 
left join orders o ON b.book_id=o.book_id 
group by b.book_id;
