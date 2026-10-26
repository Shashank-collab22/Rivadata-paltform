create table if not exists rivadatapaltform.dataproduct.dim_student(
student_key BIGINT NOT NULL,
student_id STRING NOT NULL,
Student_name STRING NOT NULL,
email STRING NOT NULL,
city STRING ,
country STRING ,
phone_no STRING ,
linkedin_link STRING ,
github_link STRING ,
created_at TIMESTAMP NOT NULL,

constraint pk_dim_student primary key(student_key
)
);
 
INSERT INTO rivadatapaltform.dataproduct.dim_student (
student_key,
student_id,
Student_name,
email,
city,
country,
phone_no,
linkedin_link,
github_link,
created_at
)

SELECT
  row_number() OVER(
    ORDER BY CAST(student_id AS BIGINT)
  ) AS student_key,

  student_id,
  name,
  email,
  city,
  country,
  phone_no,
  linkedin_link,
  github_link,
  CAST(created_at AS TIMESTAMP)
FROM rivadatapaltform.landing.students;
  