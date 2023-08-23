/* View, Index */

/* View: View is not a physical table, it is a virtual table created by query joining one or more table.
*/
create view logistics as -- CREATE VIEW <view name> as
select 
	a.order_line,
	a.order_id,
	b.customer_name,
	b.city,
	b.state,
	b.country
from public.sales as a
left join public.customer as b
on a.customer_id = b.customer_id
order by a.order_line;

select * from public.logistics --Display the logistics view

drop view logistics; -- DROP VIEW

/* Index is a performance-tuning method of allowing faster retrieval of records. 
An index creates an entry for each value that appears in the indexed column.

Simple index is an index on single column, while a composite index is an index on two or more columns.
*/
create index mon_idx
on month_values(mm); -- adivisable to create index on integer rather than strings.

alter index if exist mon_idx -- IF EXIST checks first if the index exist before altering/deleting.
restrict; -- RESTRICT is used to limit update/delete if requested index is currently linked to some other index as well.

drop index if exist mon_idx; 

/* Assignment 12
*/
create view daily_billing as
select	
	order_line, 
	product_id,
	sales,
	discount
from sales
where order_date in (select max(order_date) from sales);

drop view daily_billing;