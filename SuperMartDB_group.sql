select 
	*
from
	public.customer
	
/* IN command used to replace logical OR statemnts for SELECT, UPDATE, INSERT OR DELETE 
*/
select
	*
from 
	public.customer
where
	city in ('Philadelphia', 'Seattle'); -- Used to replace logical OR

/* BETWEEN command is used to retrieve values within a RANGE of values in SELECT, UPDATE, DELETE, INSERT
*/
select
	*
from 
	public.customer
where
	age between 20 and 30; -- Used to replace logical AND

select
	*
from 
	public.customer
where
	age NOT between 20 and 30; -- Use of NOT to negate the BETWEEN statement
	
select
	*
from
	public.sales
where
	ship_date between '2015-04-01' and '2016-04-01'; -- Use of between for Date (format: YYYY-MM-DD).
	
/*LIKE condition is used to perform pattern matching using Wildcard 
Two types of Wildcard: % and _ 
*/
select
	*
from 
	public.customer
where
	customer_name LIKE 'J%'; -- anything that starts with 'J'
	
select
	*
from
	public.customer
where
	customer_name like '%Nelson%'; -- this would retrieve anything having 'Nelson' in between their name
	
select
	*
from 
	public.customer
where
	customer_name like '____ %'; --use of _ allows for any single letter charcter.
	
select distinct
	city
from
	public.customer
where
	city not like 'S%'; -- use of NOT along with LIKE condition
	
select
	*
from
	public.customer
where
	customer_name like 'J\%'; -- use of \ is for escape character, i.e. % is used as wildcard, but to find a person name with 'J%', we can use 'J\%'

select distinct
	city
from 
	public.customer
where
	region in ('East', 'North');
	
select
	sales
from
	public.sales
where
	sales between 100 and 500;
	
select
	*
from
	public.customer
where
	customer_name like '% ____'; -- Used to find customer name having 4 letter last name (any characters allowed)
	
/*ORDER BY clause is used to SORT the records in result set. 
It can ONLY be used in SELECT command
*/
select *
from public.customer
where state = 'California'
order by customer_name asc; -- Note: inserting asc or not here won't differ, because it sorts by customer name in a->z or 0->9.

select *
from public.customer
where state = 'California'
order by customer_name desc;

select *
from public.customer
where state = 'California'
order by 
	city asc, -- order by used for 1 ascending and other for descending, this is STABLE SORT.
	customer_name desc; 

select *
from public.customer
order by 2 asc; --order by column# 2(customer_name) in ascending order.

/* LIMIT used to limit the number of output results in the output screen
*/
select *
from public.customer
order by age desc
limit 5;

select *
from public.customer
where age < 25
order by age desc
limit 5;

select *
from public.sales
where discount > 0
order by discount desc
limit 10;

/* AS is used to assign ALIAS to a column name or table name
*/
select 
	customer_id as "Serial Number", 
	customer_name as name,
	age as "Customer Age" 
from
	public.customer;
	
/*COUNT function returns the count of an expression
*/
select * from sales;
select count (*) from sales; --Note: COUNT is followed by (), so if we want to count for a specific coulmn_name, enter it in ()

select
count (order_line) as "Number of Products ordered", -- counts order_line because each product ordered is a new order_line
count (distinct order_id) as "Number of Order placed" --counts distinct order_id to identify number of orders placed
from public.sales
where customer_id = 'CG-12520';

/* SUM function used to add values in a select column_name
*/
select sum(profit) as "Total Profit"
from public.sales; --Total profit generate for all products

select sum(quantity) as "Total Quantity"
from public.sales
where product_id = 'FUR-TA-10000577'; -- tota qty sold for a given product_id

/* AVERAGE function used to calculate average over a given column_name
*/
select avg(age) as "Average Customer age"
from public.customer;

select avg(sales * 0.1) as "Average Commission"
from public.sales;

/* MIN/MAX function used to calculate min/max over the input column_name
*/
select min(sales) as "Min June15 sales"
from public.sales
where order_date between '2015-06-01' and '2015-06-30';

select sum(sales) as "Total Sales value"
from public.sales;

select * from public.customer;

select count(customer_id) as "# of customer in North region between age of 20 to 30"
from public.customer
where 
	region = 'North' and
	age between 20 and 30;
	
select avg(age) 
from public.customer
where region = 'East';

select max(age) as "Max age Philadelphia"
from public.customer
where city = 'Philadelphia';

/*GROUP BY clause is used in SELECT to group results by one or more column
*/
select region, count(customer_id) as "Customer per regions" --make sure to select two columns, i.e. column along with grouping is done and other along which count/sum is done
from public.customer
group by region;

select * from public.sales

select product_id, sum(quantity) as quantity_sold
from public.sales
group by product_id
order by quantity_sold desc; --NOTE: we used alias defined above quantity_sold in the order by clause

/* Assignment
*/
select 
	customer_id,
	min(sales) as min_sales,
	max(sales) as max_sales,
	avg(sales) as avg_sales,
	sum(sales) as total_sales
from public.sales
group by
	customer_id
order by total_sales desc
limit 5;

/*HAVING condition is used in combination with the GROUP BY clause to restrict the groups of 
returned rows to only those where the condition is TRUE
*/
select region, count(customer_id) as cutomer_count
from public.customer
group by region
having count(customer_id) > 200;

select region, count(customer_id) as customer_count
from public.customer
where customer_name like 'A%' --use of WHERE is applied for each and every individual rows
group by region;

select region, count(customer_id) as customer_count
from public.customer
where customer_name like 'A%'
group by region
having count(customer_id) > 15; -- this query uses both where and having condition at the same time.

/*Assignment
*/
select * from public.sales

select product_id, sum(sales) as total_sales
from public.sales
group by product_id
order by total_sales desc;

select product_id, sum(quantity) as total_qty_sold
from public.sales
group by product_id
having sum(quantity) > 10;

select product_id, count(order_line) as num_of_orders
from public.sales
group by product_id;

/*CASE expression is a condition expression similar to if.. else condition 
*/
select 
	*,
	case
		when age < 30 then 'Young'
		when age > 60 then 'Senior Ciizen'
		else 'Middle Age'
		end as Age_Customer -- CASE statement ends with END keyword, then an alias is assigned using AS.
from public.customer;
