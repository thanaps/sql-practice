select 
	first_name,
    last_name,
    count(*) as num_orders,
    case when shipped_date < required_date then "On Time" else "Late" end as shipped 
from employees e 
inner join orders o using(employee_id)
group by employee_id, shipped 
order by last_name, first_name, num_orders desc
