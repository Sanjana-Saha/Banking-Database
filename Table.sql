create database Bank
go
use Bank

create table CreateSavingsAccount(ReferenceId int Identity(101,1) unique,
 UserId AS 'LTI' + RIGHT('00000' + CAST(ReferenceId AS VARCHAR(5)), 5) PERSISTED primary key not null,
Title varchar(5) not null,FirstName varchar(20) Not Null,MiddleName varchar(20),LastName varchar(20) Not Null
,FatherName varchar(25) Not null,MobileNumber Bigint Not Null,EmailId varchar(30),AadharNumber bigint not null,
DateOfBirth date not null,ResAddress1 varchar(100) not null,ResAddress2 varchar(100) not null,
ResLandmark varchar(100),ResCity varchar(20) not null,ResState varchar(30) not null,ResPincode bigint not null,
PerAddress1 varchar(100) not null,PerAddress2 varchar(100) not null,
PerLandmark varchar(100),PerCity varchar(20) not null,PerState varchar(30) not null,PerPincode bigint not null,
OccupationType varchar(20) not null,SourceIncome varchar(20) not null,GrossIncome Decimal(20) not null,
DebitcardOpted bit default 0,AccountStatus bit default 0,AccountRejected bit default 0)

create table AdminLogin (AdminId varchar(20) primary key,AdminPassword varchar(20) not null)


create table AdminDesicion(ApprovalNumber int identity(101,1) primary key,
AdminId varchar(20) not null Foreign key references AdminLogin(AdminId),
UserId varchar(8) not null Foreign key references CreateSavingsAccount(UserId),
ApprovalGiven bit default 0,ApprovalDate date default (Getdate()))

create table DebitCard(DebitCardNumber bigint identity(1000000000,4) primary key,
UserId varchar(8) not null Foreign key references CreateSavingsAccount(UserId)
,cvv as RIGHT('000' + CAST(DebitCardNumber AS VARCHAR(3)), 1) PERSISTED not null ,
ExpiryDate date default ('28-12-2030'),CardStatus bit default 0)

create table SavingsAccountDetails(AccountNumber bigint identity(59000000,1) primary key,
UserId varchar(8) not null Foreign key references CreateSavingsAccount(UserId),
AvailableBalance Decimal(20) not null default 0,
UserPass AS 'Pass' + RIGHT('0000000000' + CAST(AccountNumber AS VARCHAR(8)), 5) PERSISTED not null,
UserTransactionpass AS 'TransPass' + RIGHT('0000000000' + CAST(AccountNumber AS VARCHAR(8)), 5) PERSISTED not null,
LockAccount bit default 0
)
create table AddBeneficiary(BeneficiaryAccountNumber bigint primary key,BeneficiaryName varchar(20),Nickname varchar(10))

create table Transactions(TransactionId bigint identity(10000000,3) primary key,
UserId varchar(8) not null Foreign key references CreateSavingsAccount(UserId),
FromAccountNumber bigint not null Foreign key references SavingsAccountDetails(AccountNumber),
ToAccountNumber bigint not null Foreign key references AddBeneficiary(BeneficiaryAccountNumber),
AmountTransferred decimal(20) not null,AvailableBalance decimal(20) not null,
TransactionDate date default (Getdate()),TransactionType varchar(10) not null check(TransactionType in('NEFT','IMPS','RTGS')),
TransactionStatus bit default 1
)