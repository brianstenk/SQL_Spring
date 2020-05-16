-- HARDER QUERIES
/*
BankAccount (accountNbr, balance, clientID)
Client (clientID, name)  
Deposits (accountNbr, amount, date) –for 1 day
Withdrawals (accountNbr, amount, date)–1 day
Note that date is really dateTime.  
For the red tables, could have three deposits in one day, for example,
   1,   $50,  today at 10 a.m.
   1,   $20,  today at 1 p.m.
   1,   $80,  today at 3 p.m.
------------------------------------------------------
Do the following :
1)  Add all deposits to the balance.  Get a total balance per account.
2)  Subtract all withdrawals from the balance.  Get a total balance per account.
3)  Add the daily interest to the account.  Assume  2%  interest per year.  So, the daily interest is  balance * (0.02/365)  
Note that in the  Update SQL statement
You can have a  ‘From’  clause (in T-SQL)!

*/

- 
--Get the total withdraws for the day
  
  SELECT INTO #DaysDeposits
   AccountBra, SUM (*) AS Deposits
   FROM Deposits d INNER JOIN Accounts ac
   ON d.accntNbr = ac.accntNbr
   GROUP BY accntNbr


--Get the total deposits for the day

 1)

   SELECT INTO #DaysDeposits
   AccountNbr, SUM (d.amount) AS Deposits
   FROM Deposits d INNER JOIN Accounts ac
   ON d.accntNbr = ac.accntNbr
   GROUP BY accntNbr

   UPDATE BankAccount 
   SET balance = balance + 
	 (
	       SELECT Deposits 
		   FROM #DaysDeposits dd JOIN accountNbr ac
           ON  dd.accountNbr = ac.accountNbr

	 )

2)
   SELECT INTO #DaysWithdraws
   AccountNbr, SUM (wd.amount) AS Withdraws
   FROM Withdraws wd INNER JOIN Accounts ac
   ON wd.accntNbr = ac.accntNbr
   GROUP BY AccountNbr
   
   UPDATE BankAccount 
   SET balance = balance - 
	 (
	     SELECT Withdraws 
		   FROM #DaysWithdraws dw JOIN BankAccount b
           ON dw.accountNbr = b.accountNbr

	 )

3)
UPDATE BankAccount b
   SET balance = balance + 
	 (
	     SELECT b.balance * (0.02/365)
		   FROM BankAccount
         

	 )