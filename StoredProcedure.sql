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




select * from Transactions group by UserId
--insert into SavingsAccountDetails(UserId,UserPass,UserTransactionPass)
--values('LTI00101','gopi12','gopitransac')




