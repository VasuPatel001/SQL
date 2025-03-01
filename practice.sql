create table table_name (
    age int,
    first_name varchar(255),
    last_name varchar(255)
);

create table students (
    id int not null unique,
    name varchar(255)
    primary key (id)
);

create table students (
    id int not null unique,
    first_name varchar(255) not null,
    constraint pk_student,
    primary key (id, first_name)
);

create table student (
    id int not null primary key,
    
);

insert into  -- insert into all columns of the input table
    public.table_name
values
    (22, 'first', 'last')

insert into -- insert into specific columns of the input table
    public.table_name (age, first_name)
values
    (20, 'abc')

copy public.cust_table
from 'path/to/file.csv'
delimeter ',';

select *
from public.table_name
where age > 5;

update public.table_name
set age = 25
where first_name = 'abc'

alter table 
    public.table_name
add column 
    first_name_1 varchar(255);

create table sales_2015 as
select *
from public.sales
where order_date between '2015-01-01' and '2015-12-31';

select *
from public.table_name
where age between 20 and 30;

select *
from public.table_name
where age not between 20 and 30;

select *
from public.sales
where customer_name like 'John%'

select *
from public.sales
where city in ('Philadelphia', 'Seattle');

select distinct
    city
from
    public.sales
where
    region in ('East', 'West');

/*Order by*/
select *
from public.customer
where city = 'California'
order by customer_name desc;

select *
from public.customer
where state = 'California'
order by
	city asc, -- order by used for 1 ascending and other for descending, this is STABLE SORT.
	customer_name desc;

select *
from public.customer
where city = 'Philadelphia'
order by age desc
limit 5;

select
    count(order_line)
from 
    public.sales
where 
    customer_id = 'CG-1234';

select
    sum(profit) as 'Total_Profit'
from 
    public.sales;

select
    count(customer_id) as 'Number_of_customer'
from
    public.cusomter
where
    region = 'North' and
    age between 20 and 30;

select
    region,
    sum(customer_id) as 'customer_count_per_region'
from public.sales
group by region;

select
    product_id,
    sum(quantity) as qty_sold
from
    public.customer
group by product_id
order by qty_sold desc;

select
    customer_id,
    sum(profit) as total_sales,
    avg(profit) as avg_profit
from
    public.sales
group by customer_id
order by total_sales desc
limit 5;

select 
    country,
    count(student_id) as count_student_id
from 
    public.students
group by country
having 
    country != 'India' and
    count(student_id) > 100
limit 5;

select
    *,
    case
        when age < 30 then 'Young',
        when age > 50 then 'Old',
        else 'Middle Age'
        end as Age_Customer
from
    public.customer;

select *
from public.sales
where customer_id in
    (
    select customer_id
    from public.customer
    where age > 20
    );

select 
    a.product_id,
    a.product_name,
    a.category,
    b.tot_qty
from public.product as a
left join 
    (
        select 
            product_id,
            sum(quantity) as tot_qty
        from public.sales
        group by product_id
    ) as b
on a.product_id = b.product_id
order by 