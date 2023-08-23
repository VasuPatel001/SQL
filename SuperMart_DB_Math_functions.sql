/* Mathematical functions
*/
/* CEIL, FLOOR function
*/
select * 
from public.sales;

select 
	order_line,
	sales,
	ceil(sales),  -- column name will be name of the function used, so column name here will be ceil.
	floor(sales) -- column name will be name of the function used, so column name here will be floor.
from public.sales;

/* RANDOM function returns a random value between [0, 1)
Random DECIMAL values between range of values [a, b) is given by:
select random() * (b-a) + a

Random INTEGER values between range of values [a, b) is given by:
select FLOOR(random() * (b-a+1)) + a
*/
select 
	random() as random_0_1, 
	random() * (50-10) + 10 as random_10_50, 
	floor(random()*(50-10+1)) + 10 as random_10_50_int;
	
/* SETSEED: If we set the seed by calling the setseed function, then the random function will 
return a repeatable sequence of random number that is derived from the seed.
Note: seed value is in the range of [-1.0, 1.0]
*/
select setseed(0.5);
select random(); -- 0.9851677175347999
select random(); -- 0.825301858027981
select random(); -- 0.12974610012450416

/* ROUND function rounds the number to certain number of decimal places.
*/
select
	sales,
	round(sales)
from public.sales

/* POWER function returns m raised to nth power
*/
select
	age,
	power(age, 2)
from public.customer;

/* Assignment 14
*/
select 
	customer_id,
	random() as rand_n -- Top 5 lucky customers
from public.customer
order by rand_n desc
limit 5;

select
	sum(sales) as actual_total_sales,
	sum(floor(sales)) as lower,
	sum(ceil(sales)) as higher,
	sum(round(sales)) as round
from public.sales;

	
/* Date-Time functions
	CURRENT_DATE returns current date
	CURRENT_TIME returns current time with time zone
	CURRENT_TIMESTAMP returns curent date, time and time zone
*/
select current_date; -- 2023-04-05 in YYYY-MM-DD format
select current_time; -- 11:15:39.656088-05:00 in HH:MM:SS.GMT+TZ format
select current_time(1); -- 11:16:39-05:00 used to set precision to 1 decimal value
select current_time(3); -- 11:17:01.362000-05:00
select current_timestamp; -- 2023-04-05 11:17:16.925477-05 in YYYY-MM-DD HH:MM:SS.GMT+TZ format

/* AGE function for date-time
*/
select
	order_line,
	order_date,
	ship_date,
	age(ship_date, order_date) as ship_time
from public.sales
order by ship_time desc;

/* EXTRACT 
*/
select current_date; -- 2023-04-05
select extract(day from current_date); -- 5
select extract(month from current_date); -- 4
select extract(year from current_date); -- 2023

select current_time; -- 11:26:29.238003-05:00
select extract(min from current_time); -- 26

select
	order_line,
	ship_date,
	order_date,
	age(ship_date, order_date) as age_time,
	extract (epoch from (ship_date - order_date)) as epoch_time -- this gives error
from public.sales;

select
	order_line,
	ship_date,
	order_date,
	age(ship_date, order_date) as age_time,
	extract (epoch from (ship_date)) - extract (epoch from (order_date)) as sec_time 
from public.sales
order by sec_time desc;

/* Assignment 15
*/
select 
	current_date,
	'1939-04-06' as batman_birth,
	age(current_date, '1939-04-06');

select * from sales;

select -- IMP assignment
	extract(month from order_date) as order_month,
	sum(sales)
from public.sales
where product_id in
	(select product_id
	 from public.product
	 where sub_category = 'Chairs'
	)
group by order_month
order by order_month;

/* PATTERN Matching
*/
select *
from public.customer;

select *
from public.customer
where customer_name ~* '^a+[a-z\s]+$';

select *
from public.customer
where customer_name ~* '^(a|b|c|d)+[a-z\s]+$';

select *
from public.customer
where customer_name ~* '^(a|b|c|d)[a-z]{3}\s[a-z]{4}$';

select *
from public.user
where email ~* '^[a-z0-9\.\-\_]+@[a-z0-9\-]+\.[a-z]{2,5}$'; -- used to look for a valid email address

/* Assignment 16
*/
select customer_name
from public.customer
where customer_name ~* '^[a-z]{5}\s(a|b|c|d)[a-z]{4}$';

create table zipcode (
	zipcode varchar(20)
);

insert into zipcode 
values (234432), (23345), ('sdfe4'), ('123&3'), (67424), (78953432), (12312); 

select * from public.zipcode;

select *
from public.zipcode
where zipcode ~ '^[0-9]{5,6}$';
