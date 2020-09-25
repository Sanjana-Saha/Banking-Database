create database Bank
go
use Bank

create table Create_Savings_Account(Reference_Id int Identity(101,1) Primary key clustered,
 User_Id AS 'LTI' + RIGHT('00000' + CAST(Reference_Id AS VARCHAR(5)), 5) PERSISTED,
Title varchar(5) not null,First_Name varchar(20) Not Null,Middle_Name varchar(20),Last_Name varchar(20) Not Null
,Father_Name varchar(25) Not null,Mobile_Number Bigint Not Null,Email_Id varchar(30),Aadhar_Number bigint not null,
Date_Of_Birth date not null,Residential_Address1 varchar(100) not null,Residential_Address2 varchar(100) not null,
Residential_Landmark varchar(100),Residential_City varchar(20) not null,Residential_State varchar(30) not null,Residential_pincode bigint not null,
Permanent_Address1 varchar(100) not null,Permanent_Address2 varchar(100) not null,
Permanent_Landmark varchar(100),Permanent_City varchar(20) not null,Permanent_State varchar(30) not null,Permanent_pincode bigint not null,
Occupation_Type varchar(20) not null,Source_Of_Income varchar(20) not null,Gross_Annual_Income bigint not null,
Debitcard_Opted bit default 0,Netbanking_Opted bit default 0,Account_Status bit default 0,Account_Rejected bit default 0)

alter table Create_savings_Account
add constraint uniqueid unique(User_Id)

select * from Create_Savings_Account 