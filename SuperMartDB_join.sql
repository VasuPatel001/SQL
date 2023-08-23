/*JOINS are used to retrieve data from two or more table.
*/
create table sales_2015 as
select *
from public.sales
where ship_date between '2015-01-01' and '2015-12-31';

create table customer_20_60 as 
select *
from public.customer
where age between 20 and 60;

select count(*) 
from public.sales_2015;

select count(distinct customer_id)
from public.sales_2015;

/*INNER JOIN compares each row of table 1 and table 2 to find all pairs of rows which satisfy the join-predicate.
When satisfied, column values for each matched pair of rows A & B are combined into a result row.
*/
select
	a.order_line,
	a.product_id,
	a.customer_id,
	a.sales,
	b.customer_name,
	b.age
from public.sales_2015 as a
inner join public.customer_20_60 as b --inner join
on a.customer_id = b.customer_id
order by customer_id;

/*  LEFT JOIN example
	AA-10315 NOT present in customer_20_60 table
	AA-10375 present in both tables
	AA-10480 NOT present in sales_2015 table
*/
select
	a.order_line,
	a.product_id,
	a.customer_id,
	a.sales,
	b.customer_name,
	b.age
from public.sales_2015 as a
left join public.customer_20_60 as b --left join will show AA-10315 customer id and NULL for its name, age.
on a.customer_id = b.customer_id
order by customer_id;

/*  RIGHT JOIN example
	AA-10315 NOT present in customer_20_60 table
	AA-10375 present in both tables
	AA-10480 NOT present in sales_2015 table
*/
select
	a.order_line,
	a.product_id,
	b.customer_id,
	a.sales,
	b.customer_name,
	b.age
from public.sales_2015 as a
right join public.customer_20_60 as b --right join will show AA-10480 customer id and NULL for its order_line, product_id
on a.customer_id = b.customer_id
order by customer_id;

/*  FULL JOIN example
	AA-10315 not present in customer_20_60 table
	AA-10375 present in both tables
	AA-10480 present in sales_2015 table
*/
select
	a.order_line,
	a.product_id,
	a.customer_id as a_customer_id,
	a.sales,
	b.customer_name,
	b.age,
	b.customer_id as b_customer_id
from public.sales_2015 as a
full join public.customer_20_60 as b --full join will show AA-10480 and AA-10315 with NULL values for non-existing in either values.
on a.customer_id = b.customer_id
order by a.customer_id, b.customer_id;

/* CROSS JOIN creates a cartesian product between two sets of data.
*/
create table month_values (MM int);
create table year_values (YYYY int);

insert into month_values values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);
insert into year_values values (2011), (2012), (2013), (2014), (2015), (2016), (2017), (2018), (2019);

-- Example of cross join
select
	a.YYYY, b.MM
from 
	year_values as a, -- NOTE: we don't write CROSS JOIN in from statement unlike we did in inner/left/right/full join
	month_values as b;

/* Combining Queries are used to combine results of two select queries.
*/
-- Intersect
-- Note: Intersect all and Union all allows duplicates in the result.
select customer_id 
from sales_2015
intersect
select customer_id 
from customer_20_60;

/* EXCEPT operator is used to return all rows in the FIRST SELECT statement which are NOT present in the 
SECOND SELECT statement.
*/
/*  Except operator example
	AA-10315 not present in customer_20_60 table
	AA-10375 present in both tables
	AA-10480 present in sales_2015 table
*/
select customer_id 
from sales_2015
except
select customer_id
from customer_20_60
order by customer_id;


/* UNION operator is used to combine results from 2 or more SELECT statements. It removes duplicate rows 
between various SELECT statements.
*/
/*  Union operator example
	AA-10315 not present in customer_20_60 table
	AA-10375 present in both tables
	AA-10480 present in sales_2015 table
*/
select customer_id 
from sales_2015
union
select customer_id
from customer_20_60
order by customer_id;

/*Assignment
*/
select 
	b.state,
	sum(a.sales)
from  public.sales_2015 as a
inner join public.customer_20_60 as b
on a.customer_id = b.customer_id
group by b.state;

select
	a.product_id,
	b.product_name,
	b.category,
	sum(a.sales) as total_sales,
	sum(a.quantity) as total_qty_sold
from public.sales_2015 as a
inner join public.product as b
on a.product_id = b.product_id
group by a.product_id;

	