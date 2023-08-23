/* Subquery is a query within a query. These sub-query can reside within a WHERE, SELECT or FROM clause.
*/
select *
from public.sales
where customer_id in -- Subquery in WHERE clause
	(select customer_id
	 from public.customer -- Note: we use customer table to identify age > 60
	 where age > 60
	);
	 
select 
	a.product_id,
	a.product_name,
	a.category,
	b.quantity
from public.product as a -- Subquery in FROM clause
left join 
	(select 
		sum(quantity) as quantity,
		product_id
	 from public.sales
	 group by product_id
	) as b
on a.product_id = b.product_id
order by b.quantity desc;

select  -- Subquery in SELECT clause
	customer_id,
	order_line,
	(select customer_name
	 from public.customer
	 where sales.customer_id = customer.customer_id
	)
from public.sales
order by customer_id;


/* Assignment 11 -- IMPORTANT ASSIGNMENT
*/ 
select
	c.customer_name,
	c.age,
	sp.*
from customer as c
right join 
	(select 
		s.*,
		p.product_name,
		p.category
	 from sales as s
	 left join product as p
	 on s.product_id = p.product_id
	 ) as sp
on c.customer_id = sp.customer_id;

