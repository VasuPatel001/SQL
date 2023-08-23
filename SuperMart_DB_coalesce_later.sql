/* COALESCE function - coalesce will find first NOT NULL entry in columns under consideration and keep 
*/
create table emp_name (
	s_no int,
	first_name varchar(255),
	middle_name varchar(255),
	last_name varchar(255)
);

truncate table emp_name;

insert into emp_name (s_no, first_name, middle_name, last_name) values (1, 'aa', 'bb', 'cc');
insert into emp_name (s_no, first_name,             last_name) values (2, 'dd', 'ee');
insert into emp_name (s_no,            middle_name, last_name) values (3, 'ff', 'gg');
insert into emp_name (s_no, first_name,             last_name) values (4, 'hh', 'ii');
insert into emp_name (s_no,                         last_name) values (5, 'jj');
insert into emp_name (s_no, first_name, middle_name, last_name) values (6, 'kk', 'll', 'mm');

select * from emp_name;

select
	*,
	coalesce(first_name, middle_name, last_name) as name_corr
from emp_name;

/* DATA TYPE conversion
*/
select 
	sales,
	'sale for this transaction is ' || to_char(sales, '$9,999.99')
from public.sales;

select
	order_date,
	to_char(order_date, 'DD-MM-YYYY')
from public.sales;

select
	order_date,
	to_char(order_date, 'Month DD, YYYY')
from public.sales;

select to_date('2019/12/31', 'YYYY/MM/DD'); --to_date()
select to_date('12212017', 'MMDDYYYY'); --to_date()

select to_number('713.54', '999.99'); --to_number()
select to_number('$1,713.54', 'L9,999.99'); --to_number()

/* User access control function
*/
create user vasup
valid until 'Apr 6, 2023';

grant select, update, insert, delete 
on public.product -- 'on' is used for describing table_name
to vasup;

revoke delete on public.product from vasup; -- Note: difference of 'from' instead of 'to' in grant command
revoke all on product from vasup;
drop user vasup; -- need to revoke all privileges on the user before dropping it.

select usename from pg_user; -- shows current user name
select * from pg_user; --displays all details of existing users

select distinct usename
from pg_stat_activity;

select distinct *
from pg_stat_activity;
