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


create table Admin_Login (Admin_Id varchar(20) primary key,Admin_Password varchar(20) not null)


create table Admin_Desicion(Approval_Number int identity(101,1) primary key,
Admin_Id varchar(20) not null Foreign key references Admin_Login(Admin_Id),
User_Id varchar(8) not null Foreign key references Create_Savings_Account(User_Id),
Approval_Given bit default 0,Approval_Date date default (Getdate()))

create table Debit_Card(Debitcard_number bigint identity(1000000000,4) primary key,
User_Id varchar(8) not null Foreign key references Create_Savings_Account(User_Id)
,cvv as RIGHT('000' + CAST(Debitcard_number AS VARCHAR(3)), 1) PERSISTED not null ,
Expiry_Date date default ('28-12-2030'),card_status bit default 0)

create table Savings_Account_Details(Account_Number bigint identity(59000000,1) primary key,
User_Id varchar(8) not null Foreign key references Create_Savings_Account(User_Id),
Available_Balance Decimal(20) not null default 0,
User_pass AS 'Pass' + RIGHT('0000000000' + CAST(Account_Number AS VARCHAR(8)), 5) PERSISTED not null,
User_Transaction_pass AS 'TransPass' + RIGHT('0000000000' + CAST(Account_Number AS VARCHAR(8)), 5) PERSISTED not null,
Lock_Account bit default 0
)
create table AddBeneficiary(Beneficiary_Account_Number bigint primary key,Beneficiary_Name varchar(20),Nickname varchar(10))

create table Transactions(Transaction_Id bigint identity(10000000,3) primary key,
User_Id varchar(8) not null Foreign key references Create_Savings_Account(User_Id),
From_Account_Number bigint not null Foreign key references Savings_Account_Details(Account_Number),
To_Account_Number bigint not null Foreign key references AddBeneficiary(Beneficiary_Account_Number),
Amount_Transferred decimal(20) not null,Available_Balance decimal(20) not null,
Transaction_Date date default (Getdate()),Transaction_Type varchar(10) not null check(Transaction_Type in('NEFT','IMPS','RTGS')),
Transaction_Status bit default 1
)