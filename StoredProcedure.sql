use Bank

--1)Store Procedure for ACcount Lock
alter proc proc_ChangeStatus (@uid varchar(50))
as begin
update SavingsAccountDetails
set LockAccount=1
where UserId=@uid 
end

select * from SavingsAccountDetails

exec proc_ChangeStatus 'LTI00101'


--2)Store Procedure for Change Password
create proc proc_ChangePaasword(@uid varchar(50),@upass varchar(50),@newpass varchar(50))
as begin
update SavingsAccountDetails
set UserPass=@newpass
where UserId=@uid and UserPass=@upass
end
drop proc proc_ChangePaaword

exec  proc_ChangePaasword 'LTI00101','gopi12','gopi123'


--3)Created Procedure for ACcount Summary
alter proc proc_AccountSummaryGet(@uid varchar(50))
as begin
SELECT Top 1 ToAccountNumber,FromAccountNumber,AmountTransferred,TransactionType,TransactionDate,TransactionStatus
from Transactions
WHERE UserId=@uid 
ORDER BY TransactionDate Desc,TransactionId desc
end
                                              
--1)Store Procedure for Register for Net Banking
create proc proc_NetBanking @AccNumber bigint, @LoginPassword nvarchar(100), @TransactionPassword nvarchar(100)
as begin
update SavingsAccountDetails
set UserPass=@LoginPassword,UserTransactionPass=@TransactionPassword
where AccountNumber=@AccNumber
end
go
                                               





select * from Transactions group by UserId
--insert into SavingsAccountDetails(UserId,UserPass,UserTransactionPass)
--values('LTI00101','gopi12','gopitransac')






create proc proc_insert_Savings_Account_Details(@userid varchar(8),@avail decimal(20),@pass varchar(20),@trans varchar(20))
as
insert into SavingsAccountDetails (UserId,AvailableBalance,UserPass,UserTransactionPass) values(@userid,@avail,@pass,@trans)

create proc proc_insert_Admin_Decision(@admin varchar(20) ,@user varchar(8),@status bit)as
insert into AdminDesicion (AdminId,UserId,ApprovalGiven) values(@admin,@user,@status)

create proc proc_update_create_savings_account(@rejected bit,@status bit,@user varchar(8))
as
update CreateSavingsAccount set AccountRejected=@rejected,AccountStatus=@status where UserId=@user



create proc proc_update_Balance_sender(@accountnumber bigint,@available decimal(20),@amount decimal(20))
as
update SavingsAccountDetails set AvailableBalance=@available-@amount where AccountNumber=@accountnumber


create proc proc_update_transaction_table(@userid varchar(8),@from bigint, @to bigint,@amount decimal(20),
@avail decimal(20),@date date,@type varchar(10))
as
insert into Transactions (UserId,FromAccountNumber,ToAccountNumber,AmountTransferred,AvailableBalance
,TransactionDate,TransactionType)values (@userid,@from,@to,@amount,@avail,@date,@type)


create proc proc_update_Balance_receiver(@accountnumber bigint,@available decimal(20),@amount decimal(20))
as
update SavingsAccountDetails set AvailableBalance=@available+@amount where AccountNumber=@accountnumber


create proc proc_failed_transaction(@userid varchar(8),@from bigint, @to bigint,@amount decimal(20),
@avail decimal(20),@date date,@type varchar(10),@status bit)
as
insert into Transactions (UserId,FromAccountNumber,ToAccountNumber,AmountTransferred,AvailableBalance
,TransactionDate,TransactionType,TransactionStatus)values (@userid,@from,@to,@amount,@avail,@date,@type,@status)

