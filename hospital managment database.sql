use hospital_Managenemt
go
        -- Table Create 
create table patient_info(
    patient_id int PRIMARY KEY,
    [ patient name] NVARCHAR(50),
    [contact number] int ,
    e_mail NVARCHAR(150),
    [ patient address] nvarchar(150),
    gender char(20),
    [ patient entry date] date
)

    -- some alter on table
alter table patient_info
alter COLUMN [contact number] bigint

alter table patient_info
alter COLUMN [ patient entry date] nvarchar(100)



create table doctor_info(
    [doctor id] int PRIMARY key,
    [doctor name] nvarchar(50),
    [doctor contact_No] bigint
)

CREATE TABLE PatientsAttendbydoc(
    patient_id int,
    [doctor id] int ,
    disease_detect NVARCHAR(50),
    check_date DATE,
    ckeck_day  VARCHAR(20)
    FOREIGN key (patient_id) REFERENCES patient_info(patient_id),
    FOREIGN key ([doctor id]) REFERENCES doctor_info([doctor id])
)

create table start_treatment_of_pateient(
    start_check date,
    patient_id int,
    [doctor id] int ,
    tretment_start date,
    complete_treatment date,
    FOREIGN key (patient_id) REFERENCES patient_info(patient_id),
    FOREIGN key ([doctor id]) REFERENCES doctor_info([doctor id])
)


create  table patteint_discharge_info(
    discharge_date date,
    [ patient name] NVARCHAR(50),
     patient_id int,
FOREIGN key (patient_id) REFERENCES patient_info(patient_id)
)

              ---INSERT VALUES
insert into patient_info( patient_id ,[ patient name],[contact number],e_mail,[ patient address],gender ,[ patient entry date] )

VALUES(6821,'surya',8823123423,'surya23@gmail.com','wz-d-65 nagli najafghar,delhi','male','25-01-2014'),
(5821,'seeta',6823123423,'seeta@gmail.com','wz-d-61 dawarka ,delhi','female','01-02-2014'),
(6453,'geet',4523123423,'geet23@gmail.com','wz-d-61 najafghar,delhi','male','12-01-2014')

select * from patient_info

update patient_info  set gender ='female' where patient_id=6453


insert into doctor_info VALUES(2132,'Dr Rakesh',9821074705)
insert into doctor_info VALUES(2154,'Dr mohit',8210734305)
insert into doctor_info VALUES(2111,'Dr Preeti',2210734305)
insert into doctor_info VALUES(2122,'Dr srya',5621073435)

select * from doctor_info
select * from patient_info
select *from PatientsAttendbydoc
insert  into PatientsAttendbydoc(patient_id ,[doctor id]  ,disease_detect ,check_date ,ckeck_day) 
values(6453,2111,'fever','2014-01-12','friday'),
(6821,2111,'losse motion','2014-01-25','mondat'),
(5821,2122,'cancer','2014-02-02','friday'),
(9821,2154,'losse motion','2014-01-25','wednesday')



insert into start_treatment_of_pateient(start_check,patient_id,[doctor id],tretment_start,complete_treatment) 
values
('2014-01-12',6453,2111,'2014-01-12','2014-01-15'),
('2014-01-25',6821,2111,'2014-01-25','2014-01-29'),
('2014-01-25',5821,2122,'2014-02-10','2015-01-12'),
('2014-01-25',9821,2154,'2014-01-25','2014-01-28')


---SELECT QUERY
select * from doctor_info
select * from patient_info
select *from PatientsAttendbydoc
select*from start_treatment_of_pateient

-----Stored procedure for patient infornation
create PROCEDURE sp_patient_info
@patient_id INT
as
begin
    select*from patient_info where patient_id=@patient_id
end

 sp_patient_info 5821


    --Stored procedure for check disease by patient id
create PROCEDURE sp_patient_disease_ckeck
@patient_id INT
as
begin
    select*from PatientsAttendbydoc where patient_id=@patient_id
end

sp_patient_disease_ckeck 6453 



------stored procedure for check doc detail by doc  id
create proc sp_doc_detail
@doc_id INT
as
begin
  select *from doctor_info where [doctor id]=@doc_id
end

sp_patient_disease_ckeck 6453
sp_doc_detail 2111


------ Stored procedure with give all information about doc ,patient,disease
alter proc sp_all_detail
@patient_id INT
with encryption
as
begin
 select * from PatientsAttendbydoc 
 join doctor_info
 on doctor_info.[doctor id]=PatientsAttendbydoc.[doctor id] where patient_id=@patient_id
end

sp_all_detail 6821

----create table for trigger

CREATE table new_patient_infomation(
    id int identity,
    Audit_Info NVARCHAR(200)
)


_---update query

update patient_info set patient_id=8712 where patient_id=2212


----INSERT TRIGGER ON PATINT AUTO mATICALLY ENTER THE DATA IN ANOTHER TABLe
create TRIGGER tr_enter_new_info
on patient_info
for INSERT
AS BEGIN
       declare @id INT
       select @id=patient_id from inserted
       insert into new_patient_infomation values('new patient with patient_number='+ CAST(@id as nvarchar(5))+'is added at'+ cast(GETDATE() as nvarchar(20)))
end


-- insert into patient_info( patient_id ,[ patient name],[contact number],e_mail,[ patient address],gender ,[ patient entry date] )

-- VALUES(2212,'rohan',8823212345,'rohan23@gmail.com','wz-d-65 nagli najafghar,delhi','male','21-01-2014')


-- new patient with patient_number=2212is added atJun 25 2023  5:20PM

select *from doctor_info
select * from  new_doctor_infomation


CREATE table new_doctor_infomation(
    id int identity,
    Audit_Info NVARCHAR(200)
)

CREATE table leave_doctor_infomation(
    id int identity,
    Audit_Info NVARCHAR(200)
)


-----create insert triggrer
create TRIGGER new_doc_info
on doctor_info
for insert 
as BEGIN
  DECLARE @id INT
  SELECT @id= [doctor id] from inserted
  INSERT into new_doctor_infomation values('new doctor id =' + cast(@id as nvarchar(5)) + 'on date is ' + cast(GETDATE() as nvarchar(20)))

end

insert into doctor_info values(2229,'Dr vipul',12343134455)

---doctor leave firm delete trigger
alter TRIGGER leave_firm_doc_info
on doctor_info
for delete 
as BEGIN
  DECLARE @id INT
  SELECT @id= [doctor id] from deleted
  INSERT into leave_doctor_infomation values('new doctor id = ' + cast(@id as nvarchar(5))  + ' leave on date is ' +  cast(GETDATE() as nvarchar(20)))

end



select *from doctor_info
select * from  new_doctor_infomation
select * from leave_doctor_infomation







