SELECT patient_id, weight, height, 
case when weight/power(height/100.0, 2) >= 30 then 1 else 0 end as isObese
from patients

