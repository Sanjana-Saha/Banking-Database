use Bank

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