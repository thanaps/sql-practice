SELECT patient_id, weight, height, 
case when weight/power(height/100.0, 2) >= 30 then 1 else 0 end as isObese
from patients

select patient_id, p.first_name, p.last_name, specialty
from patients p
inner join admissions a using(patient_id)
inner join doctors d on a.attending_doctor_id = d.doctor_id
where diagnosis = "Epilepsy"
and d.first_name = "Lisa"

select patient_id, concat(patient_id, len(last_name), year(birth_date)) as temp_password 
from patients p
inner join admissions a using(patient_id)
group by  patient_id


select has_insurance, 
		case when has_insurance = "Yes" then total*10 else total*50 end 
        as cost_after_insurance
from
(
select case when patient_id%2 = 0 then "Yes" else "No" end as  has_insurance,
	  count(*) as total
from admissions
group by has_insurance
)

select province_name
from
(
select province_name, gender, count(*), 
		rank() over (partition by province_name order by count(*) desc) as rank
from patients
inner join province_names using(province_id)
group by province_name, gender
order by province_name, count(*) desc
)
where gender = "M" and rank = 1 

select *
from patients
where first_name like "__r%"
and gender = "F"
and month(birth_date) in (02,05, 12)
and weight between 60 and 80
and patient_id%2 =1
and city = "Kingston"

select 
	concat(round((SUM(gender = 'M')/cast(count(*) as float))*100, 2), '%') as total
from patients 

select 
	admission_date,
    count(*) as admission_day,
    count(*) - lag(count(*), 1) over() as change
from admissions
group by admission_date

select 
	province_name
from province_names
order by province_name <> 'Ontario' asc

select 
	doctor_id, 
    concat(first_name, ' ', last_name) as doctor_full_name, 
    specialty, 
    year(admission_date), 
    count(*) as total_admissions
from admissions a
inner join doctors d on a.attending_doctor_id = d.doctor_id
group by doctor_id, year(admission_date)



