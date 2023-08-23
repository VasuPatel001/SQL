/* Windows function
*/
select * 
from public.customer
limit 10;

select
	a.*,
	count(distinct(b.order_id)) as order_num,
	sum(sales) as sales_tot,
	sum(quantity) as quantity_tot,
	sum(profit) as profit_tot
from public.customer as a
left join public.sales as b
on a.customer_id = b.customer_id
group by a.customer_id;


create table customer_order as (
select
	a.*,
	count(distinct(b.order_id)) as order_num,
	sum(sales) as sales_tot,
	sum(quantity) as quantity_tot,
	sum(profit) as profit_tot
from public.customer as a
left join public.sales as b
on a.customer_id = b.customer_id
group by a.customer_id
);

select * from customer_order;

/* ROW NUMBER()
*/
select 
	customer_id,
	customer_name,
	state,
	order_num,
	row_number () over(
		partition by state
		order by order_num desc
		) as row_n
from customer_order;

select * 
from(
		select 
			customer_id,
			customer_name,
			state,
			order_num,
			row_number () over(
				partition by state
				order by order_num desc
				) as row_n
		from customer_order
	) as a
where a.row_n < 4;

/* ROW_NUMBER, RANK and DENSE_RANK
*/
select 
	customer_id,
	customer_name,
	state,
	order_num,
	row_number() over(
		partition by state
		order by order_num desc
		) as row_n,
	rank() over(
		partition by state
		order by order_num desc
		) as rank_n,
	dense_rank() over(
		partition by state
		order by order_num desc
		) as d_rank_n
from customer_order;

/* NTILE
*/
select 
	customer_id,
	customer_name,
	state,
	order_num,
	row_number() over(
		partition by state
		order by order_num desc
		) as row_n,
	rank() over(
		partition by state
		order by order_num desc
		) as rank_n,
	dense_rank() over(
		partition by state
		order by order_num desc
		) as d_rank_n,
	ntile(5) over(
		partition by state
		order by order_num desc
		) as n_tile
from customer_order;

/* AVERAGE
*/
select * from customer_order;

select 
	customer_id,
	customer_name,
	state,
	sales_tot as revenue,
	avg(sales_tot) over(
			partition by state
		) as avg_r
from customer_order;

-- select customer buying lesss than average of state sales
select * 
from (
	select 
		customer_id,
		customer_name,
		state,
		sales_tot as revenue,
		avg(sales_tot) over(
				partition by state
			) as avg_r
	from customer_order
	) as a
where a.revenue < a.avg_r;

/* COUNT
*/
select 
	customer_id,
	customer_name,
	state,
	count(customer_id) over(
		partition by state
		) as count_state
from customer_order;

/* SUM to find the total value
*/
create table order_rollup as (
	select
		order_id,
		max(order_date) as order_date,
		max(customer_id) as customer_id,
		sum(sales) as sales
	from public.sales
	group by order_id
);

create table order_rollup_state as (
	select
		a.*,
		b.state
	from public.order_rollup as a
	left join public.customer as b
	on a.customer_id = b.customer_id
);

select * from public.order_rollup_state;

select
	*,
	sum(sales) over(partition by state) as sales_state_total
from order_rollup_state;

/* SUM to find the RUNNING total value
*/
select
	*,
	sum(sales) over(partition by state) as sales_state_total, -- total using sum()
	sum(sales) over(partition by state order by order_date) as running_total --running total using order by
from order_rollup_state;

/* LAG
*/
select
	customer_id,
	order_id,
	sales,
	lag(sales,1) over(partition by customer_id order by order_date) as previous_sales,
	lag(order_id,1) over(partition by customer_id order by order_date) as previous_order_id
from order_rollup_state;

/* LEAD
*/
select
	customer_id,
	order_id,
	sales,
	lead(sales,1) over(partition by customer_id order by order_date) as previous_sales,
	lead(order_id,1) over(partition by customer_id order by order_date) as previous_order_id
from order_rollup_state;