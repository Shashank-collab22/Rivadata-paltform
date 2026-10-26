-- Creating Attendance Table
CREATE TABLE IF NOT EXISTS rivadatapaltform.dataproduct.fact_attendance (

attendance_id	STRING	Not Null,
student_key	BIGINT	Not Null,
class_key	BIGINT	Not Null,
batch_key	BIGINT	Not Null,
date_key	INT	Not Null,
attendance_status	STRING	Not Null,
joined_at	TIMESTAMP,
remarks	STRING,
attendance_count	INT	Not Null,
present_flag	INT	Not Null,
absent_flag	INT	Not Null,
late_flag	INT	Not Null,

CONSTRAINT pk_fact_attendance PRIMARY KEY (attendance_id)

);

-- Inserting Data into Attendance Table
INSERT INTO rivadatapaltform.dataproduct.fact_attendance (

    attendance_id,
    student_key,
    class_key,
    batch_key,
    date_key,
    attendance_status,
    joined_at,
    remarks,
    attendance_count,
    present_flag,
    absent_flag,
    late_flag

)


select 
a.attendance_id,
ds.student_key,
dc.class_key,
db.batch_key,
COALESCE(dd.date_key, cast(DATE_FORMAT(dc.class_date, 'yyyyMMdd') as INT)) as date_key,
a.attendance_status,
try_cast(a.joined_at as timestamp) as joined_at,
a.remarks,
case
    when a.attendance_status = 'Present' then 1
    else 0
    end as attendance_count,

case 
    when a.attendance_status = 'Present' then 1
    else 0
    end as present_flag,

case
    when a.attendance_status = 'Absent' then 1
    else 0
    end as absent_flag,

case 
    when a.attendance_status = 'Late' then 1
    else 0
    end as late_flag

from rivadatapaltform.landing.attendance a

left join rivadatapaltform.dataproduct.dim_student ds
on a.student_id = ds.student_id

left join rivadatapaltform.dataproduct.dim_class dc
on a.class_id = dc.class_id

left join rivadatapaltform.dataproduct.dim_batch db 
on dc.batch_id = db.batch_id

left join rivadatapaltform.dataproduct.dim_date dd
on dc.class_date = dd.date;