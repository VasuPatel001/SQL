/* String functions
*/
/* LENGTH function
*/
select
	customer_name,
	length(customer_name) as name_length --use of length(string)
from public.customer
where length(customer_name) > 10 --use of length(string)
order by length(customer_name) desc;

/* UPPER/LOWER case function
*/
select upper('Start-Tech-Academy');
select lower('Start-Tech-Academy');

/* REPLACE function
*/
select
	customer_name,
	country,
	replace(country, 'United States', 'US') as country_new -- Note: REPLACE is CASE SENSITIVE.
from customer;

/* TRIM (either beginning or end), LTRIM (from LHS), RTRIM (from RHS)
   These functions remove specified characters from the string.
*/
select trim(leading ' ' from '    start-tech academy.  ');
select trim(trailing ' ' from '    start-tech academy.  ');
select trim(both ' ' from '    start-tech academy.  ');

select ltrim('    start-tech academy.  ', ' '); --LTRIM similar to leading
select rtrim('    start-tech academy.  ', ' '); -- RTRIM similar to trailing
select trim('    start-tech academy.  '); -- when NOT specified, it trims from both sides. similar to both

/* Concat is used to concatenate two or more strings present along DIFFERENT COLUMNS.
   Concat is done using || operator.
*/
select
	customer_name,
	city || ', ' || state || ', ' || country as address
from public.customer;

/* Substring function allows you to select a substring of the main string
*/
select
	customer_id,
	customer_name,
	substring(customer_id for 2) as cust_group -- Note: when FROM is not specified, default value of FROM is 0.
from public.customer
where substring(customer_id for 2) = 'AB';

select
	customer_id,
	customer_name,
	substring(customer_id from 4 for 5) as cust_number
from public.customer
where substring(customer_id for 2) = 'AB';

/* String aggregator (string_agg) used to concatenate input values into string, separated by delimiter.
   This is used to concatentate string present in the SAME COLUMN.
*/
select *
from public.sales 
order by order_id;

select 
	order_id,
	string_agg(product_id, ',')
from public.sales
group by order_id;

/* Assignment 13
*/
select * from public.product

select
	product_name,
	length(product_name)
from public.product
order by length(product_name) desc
limit 1;

select
	product_name,
	sub_category,
	category,
	product_name ||', '|| sub_category ||', '|| category as concatenate_product
from public.product;


select
	product_id,
	product_name,
	substring(product_id for 3) as product_category
from public.product
where substring(product_id for 3) = 'FUR';

select
	sub_category,
	string_agg(product_name, ', ')
from public.product
group by sub_category;
