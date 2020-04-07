drop sequence if exists person_person_id_seq;
create sequence person_person_id_seq start with 1;


insert into person (
person_id,                        
gender_concept_id,
year_of_birth,
month_of_birth,
day_of_birth,
birth_datetime,
race_concept_id,
ethnicity_concept_id,
location_id,
provider_id,
care_site_id,
person_source_value,
gender_source_value,
gender_source_concept_id,
race_source_value,
race_source_concept_id,
ethnicity_source_value,
ethnicity_source_concept_id
)
select
	nextval('person_person_id_seq'),   
	case upper(p.gender)
		when 'M' then 8507
		when 'F' then 8532
	end,                               
	extract(year  from p.birthdate),  
	extract(month from p.birthdate),  
	extract(day   from p.birthdate),  
	p.birthdate,                   
	case upper(p.race)             
		when 'WHITE' then 8527
		when 'BLACK' then 8516
		when 'ASIAN' then 8515
	else 0
	end,
	case 
		when upper(p.race) = 'HISPANIC'  
		then 38003563 else 0 
	end,      
	NULL,							
	NULL,                         
	NULL,                          
	id,                            
	p.gender,                      
	0,                              
	p.race,                       
	0,                        
	p.ethnicity,                 
	0                             
	from native.patients p
	where p.gender is not null;
