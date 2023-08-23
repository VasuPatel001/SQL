/* CREATE TABLE statement
*/
create table cust_table ( -- Create a table
	cust_id int,
	first_name varchar(255),
	last_name varchar(255),
	age int,
	email_id varchar(255)
);

/* INSERT INTO statement
*/
insert into public.cust_table -- Insert all column values
values
(3, 'dd', 'ee', 9, 'abc@gmail.com'),
(4, 'ff', 'gg', 10, 'fgh@gmail.com');

insert into public.cust_table (cust_id, last_name, email_id) -- Insert some column values instead of all
values
(3, 'ee', 'abc@gmail.com'),
(4, 'gg', 'fgh@gmail.com');

/* COPY statement
*/
copy public.customer_table -- Copy table values from a csv/txt file.
from '/Applications/PostgreSQL 15/Data/Customer.csv' 
delimiter ',' csv header;

copy public.cust_table 
from '/Applications/PostgreSQL 15/Data/copy.csv'
delimiter ',' csv header;

copy public.cust_table -- Copy table values from a txt file.
from '/Applications/PostgreSQL 15/Data/copytext.txt'
delimiter ',';

/* SELECT statement
*/
select *
from public.customer_table;

select
	 customer_name, customer_id
from 
	public.customer_table;
	
select
	*
from
	public.customer_table;
	
select distinct
	segment
from
	public.customer_table;
	
select distinct
	city, state
from 
	public.customer_table;
	
select distinct
	*
from
	public.customer_table;
	
select
	*
from
	public.customer_table
where
	age > 25;
	
select
	*
from
	public.customer_table
where
	age > 20 and age < 30;
	
select
	*
from 
	public.customer_table
where
	not age > 20; -- Note: use of not is for individual conditions
	
select
	*
from 
	public.customer_table
where 
	not age = 20 and -- Use of 'AND' conditions in where statement
	not customer_name = 'Brosina Hoffman'; -- Note: use of not is for individual conditions
	
select
	*
from
	public.cust_table
where
	cust_id = 2; -- Use of where to find a specific row value.

/* UPDATE statement
*/
update
	public.cust_table -- Note: In update clause, first we mention the table_name
set
	last_name = 'de', -- Then we change the column(s) value using 'set' clause
	age = 25
where
	cust_id = 2; -- define the target row using where condition

/* DELETE statement
*/
delete -- Note: delete is used to remove specific rows of the table, where drop is used to remove column(s) of the table.
from
	public.cust_table
where
	cust_id = 2;

delete -- This statement deletes all rows of the 'cust_table' table.
from 
	public.cust_table;

/* ALTER statement: used to add/drop/modify/rename/alter a column.
*/
alter table
	public.cust_table
add column -- ADD COLUMN
	test varchar(255);
	
alter table
	public.cust_table
drop column -- DROP COLUMN; Note: earlier DELETE was used to delete row(s), however DROP is used to drop entire column.
	test;

alter table
	public.cust_table
alter column -- MODIFY COLUMN variable type
	age TYPE varchar(255); -- NOTE: TYPE is used to set/change data-type of the column

alter table
	public.cust_table
rename column -- RENAME CLOUMN to change the name
	email_id to email_ids;
	
alter table
	public.cust_table
alter column -- ALTER CLOUMN to alter its constraints
	cust_id SET NOT NULL; -- To add a constraint use 'SET'

insert into 
	public.cust_table (first_name, last_name) 
	values ('aa', 'bb');

alter table
	public.cust_table
alter column
	cust_id DROP NOT null; -- To remove a constraint use 'DROP'
	
alter table
	public.cust_table
add constraint -- ADD CONSTRAINT used to check if the entered value(s) meet specific requirements.
	cust_id CHECK (cust_id > 0); -- Note: when using CHECK, add condition in ().
	
insert into 
	public.cust_table (cust_id, first_name)
	values (-1, 'aa');
