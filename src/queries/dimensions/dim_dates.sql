%sql
create OR REPLACE table  rivadatapaltform.dataproduct.dim_date(
  date_key          INT   NOT NULL,
  date              DATE  NOT NULL,
  year              INT   NOT NULL,
  quarter           INT   NOT NULL,
  month             INT   NOT NULL,
  month_name        STRING NOT NULL,
  week_of_year      INT    NOT NULL,
  day               INT    NOT NULL,
  day_name          STRING NOT NULL,
  day_of_week       INT    NOT NULL,
  is_weekend        BOOLEAN NOT NULL,

constraint pk_dim_date 
  primary key(date_key)
);

 insert into rivadatapaltform.dataproduct.dim_date(
  date_key,
  date ,
  year,
  quarter,
  month,
  month_name ,
  week_of_year,
  day,
  day_name,
  day_of_week,
  is_weekend
 )





with dates as
(
    select 

    explode(
    sequence(
        to_date('2020-01-01'),
        to_date('2020-12-31'),
        interval 3 day
    )
) AS date
)
SELECT 
cast(DATE_FORMAT(date,'yyyyMMdd') as INT) as date_key,
 date,
year(date) as year,
quarter(date)as quarter,
month(date) as month,
date_format(date,'MMMM') as month_name,
WEEKOFYEAR(date) as week_of_year,
day(date) as day,
date_format(date,'EEEE') as day_name,
DAYOFWEEK(date) as day_of_week,
case
 when DAYOFWEEK(date) in (1,7)
 then TRUE 
 else FALSE
 end as is_weekend 
FROM dates


