select bname
from branch;
/*  1.)Display the names and average balance of the all accounts of customers
who have one or more account with bal>1000* in descending order of averages*/
SQL> select cname,avg(bal) asc
  2  from account
  3  where cname in(
  4  select distinct(cname)
  5  from account
  6  where bal>1000)
  7  group by(cname);

CNAME             average
--------------- ---------
Cook              4057.80
Jones             3067.00
Rahimi            1111.00
--  1.1)In ascending order of balances

SQL> select cname,avg(bal)
  2  from account
  3  where cname in(
  4  select distinct(cname)
  5  from account
  6  where bal>1000)
  7  group by(cname)
  8  order by(avg(bal)) asc;

CNAME             average
--------------- ---------
Rahimi            1111.00
Jones             3067.00
Cook              4057.80

SQL> select * from account;

        A# CNAME           BNAME                  BAL
---------- --------------- --------------- ----------
      2222 Rahimi          Southdale             1111
      4444 Cook            France                6690
      5555 Cook            York                 10000
      6666 Cook            Main                  3338
      5000 Cook            Ridgedale              150
      5001 Cook            Second                 111
      7777 Jones           France                5678
      9999 Jones           York                   456
      1234 Tomczak         York                 123.5
      4567 Love            France                 300
      9800 Love            Main                   333
      7765 James           York                   100
      7756 Woods           York                  1000
      7757 Woods           Southdale             1000
      7758 Woods           France                1000
      3333 Rahimi          York                  1111

16 rows selected.
/*  2)Print all the branches with the associated accuont numbers irrespective of whether
they have account numbers and for which have accounts display the same*/







--  3).Print all info about branches of the bank.
select *
from branch;

--  4)Prints the string branch to the output as many branches are there
select 'Branch',bname
from branch;

--  5)Print all columns for the brach name "France"
select *
from account
where bname='France';

-- 5.5)When France is given as 'france',no rows are returned hence make all
--comparisons case-insensitive
select *
from account
where lower(bname)='france';
select *
from account
where upper(bname)='FRANCE';

--  6)Print the name of all customers with 
--an account(s) at France.
select cname
from account
where lower(bname)='france';

--  7)Print the name of all customers with 
--an loan(s) at France.
select cname
from loan
where lower(bname)='france';

--  8)Print the name of all customers who have an account 
--a loan, or both in France brance.
select cname
from account
where lower(bname)='france'
union
select cname
from loan
where lower(bname)='france';

-- 8.1)This results in incorrect number of columns
--when the select statments have different number of columns.
select cname,bname
from account
where lower(bname)='france'
union
select cname
from loan
where lower(bname)='france';
--ERROR at line 1:
--ORA-01789: query block has incorrect number of result columns

-- 8.2)When the datatypes in the select clauses are not compatible 
--this throws an error as well.
select cname,bal
from account
where lower(bname)='france'
union
select cname,bname
from loan
where lower(bname)='france';
--ERROR at line 1:
--ORA-01790: expression must have same datatype as corresponding expression

-- 8.3)To resolve the above datatype problem
select cname,bal
from account
where lower(bname)='france'
union
select cname,amt
from loan
where lower(bname)='france';
/*CNAME                  BAL
--------------- ----------
Cook                  6690
Cook                 10000
James                12300
Jones                 4500
Jones                 5678
Love                   300
Melcher               4450
Rahimi               20000
Tomczak              34560
Woods                 1000
Woods                 4450

11 rows selected.*/

-- 8.4)To not suppress the repetitions in Union OPERATOR
--use Union ALL
select cname
from account
where lower(bname)='france'
union all
select cname
from loan
where lower(bname)='france';

--  9)To know the peolple who have both the loan and account
--use intersect.
select cname
from account
where lower(bname)='france'
intersect
select cname
from loan
where lower(bname)='france';


--  10)To know people who have an account but not loan
--use Minus
select cname
from account
where lower(bname)='france'
minus
select cname
from loan
where lower(bname)='france';

--  11)To know people who have a loan but not account
--switch the tables and use minus.
select cname
from loan
where lower(bname)='france'
minus
select cname
from account
where lower(bname)='france';

--  12)Print names of customer who have an account,loan or both in france branch
--except of those who have an account with balance less than $800.
--My Solution
select cname,bal
from (select cname,bal
from account
where lower(bname)='france'
union
select cname,amt
from loan
where lower(bname)='france')
where bal>800;

/* 12.1)This does not work.Because this displays the users with the loan amounts also.*/
--Professor's Solution
select cname
from account
where lower(bname)='france'
union
select cname
from loan
where lower(bname)='france'
minus
select cname
from account
where bal<=1000;


/*Inner Join*/
----------------


--Hit Ration- % of rows that intersect in the two tables.
--for eg: the hit ratio in the customer table and the account table is 100%.
(Account is the parent table and customer is the child table
Customer name is the foriegn key in the account table)
--(Gives the intersection of the two sets)
--(Doesnt find the place where the tables don't match)

--  13)Given a customer ,find the accounts for the customer in 'Minnetonka'
--Syntax 1
select customer.cname,ccity,account.cname,bal
from customer,account
where customer.cname=account.cname
and lower(ccity)='minnetonka';
--  13.1)Non Std Join Syntax
select customer.cname,ccity,account.cname,bal
from customer inner join account
on customer.cname=account.cname
and lower(ccity)='minnetonka';



/*  14)Print the names of the customers who have accounts
in the city of minnetonka*/
SQL> select cname,A# as Account_No,account.bname,bcity
  2  from account,branch
  3  where account.bname=branch.bname
  4  and
  5  lower(bcity)='minnetonka';

CNAME           ACCOUNT_NO BNAME           BCITY
--------------- ---------- --------------- ---------------
Cook                  5000 Ridgedale       Minnetonka
Cook                  6666 Main            Minnetonka
Love                  9800 Main            Minnetonka
Cook                  5001 Second          Minnetonka


--  15)Customer who has both accounts and loans.
select account.cname,loan.cname
from account,loan
where account.cname=loan.cname;
/*
CNAME           CNAME
--------------- ------------
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
Cook            Cook
James           James
Jones           Jones
Jones           Jones
Jones           Jones
Jones           Jones
Jones           Jones
Jones           Jones
Rahimi          Rahimi
Rahimi          Rahimi
Rahimi          Rahimi
Rahimi          Rahimi
Rahimi          Rahimi
Rahimi          Rahimi
Tomczak         Tomczak
Woods           Woods
Woods           Woods
Woods           Woods*/

--  15.1)Repetition is because customer has many accounts and many loans.
-- Print the balanaces and amounts to check if there are redundancies.
select account.cname,loan.cname,bal,amt
from account,loan
where account.cname=loan.cname;
/*CNAME           CNAME                  BAL        AMT
--------------- --------------- ---------- ----------
Cook            Cook                  6690      10000
Cook            Cook                 10000      10000
Cook            Cook                  3338      10000
Cook            Cook                   150      10000
Cook            Cook                   111      10000
Rahimi          Rahimi                1111       5000
Rahimi          Rahimi                1111       5000
Cook            Cook                  6690       1000
Cook            Cook                 10000       1000
Cook            Cook                  3338       1000
Cook            Cook                   150       1000
Cook            Cook                   111       1000
Rahimi          Rahimi                1111      20000
Rahimi          Rahimi                1111      20000
Rahimi          Rahimi                1111      11000
Rahimi          Rahimi                1111      11000
Cook            Cook                  6690      30000
Cook            Cook                 10000      30000
Cook            Cook                  3338      30000
Cook            Cook                   150      30000
Cook            Cook                   111      30000
Jones           Jones                 5678       4500
Jones           Jones                  456       4500
Jones           Jones                 5678       1200
Jones           Jones                  456       1200
Jones           Jones                 5678       9000
Jones           Jones                  456       9000
Tomczak         Tomczak              123.5      34560
James           James                  100      12300
Woods           Woods                 1000       4450
Woods           Woods                 1000       4450
Woods           Woods                 1000       4450
*/

--  15.2)Use Distinct to avoid redundancies
--Distinct Applies to all columns in the select statement,so its just used once
select distinct account.cname,loan.cname
from account,loan
where account.cname=loan.cname;
/*CNAME           CNAME
--------------- ---------
James           James
Rahimi          Rahimi
Woods           Woods
Jones           Jones
Tomczak         Tomczak
Cook            Cook

6 rows selected.*/

-- 15.3)Using Inner join statement
SQL>  select distinct account.cname,loan.cname
  2   from loan
  3   inner join
  4  account
  5  on
  6  loan.cname=account.cname;

CNAME           CNAME
--------------- ---------------
James           James
Rahimi          Rahimi
Woods           Woods
Jones           Jones
Tomczak         Tomczak
Cook            Cook

6 rows selected.

----  16)Customer who has both accounts and loans in france 
select distinct account.cname,loan.cname
from account,loan
where account.cname=loan.cname and
lower(account.bname)='france' and 
lower(loan.bname)='france'
order by account.cname;

-- 16.1)Using Inner join statement
SQL> select distinct loan.cname as LoanCust,
  2  account.cname as AccountCust
  3  from loan
  4  inner join
  5  account
  6  on
  7  loan.cname=account.cname
  8  and
  9  lower(account.bname)='france'
 10  and
 11  lower(loan.bname)='france';

LOANCUST        ACCOUNTCUST
--------------- ---------------
Woods           Woods
Jones           Jones
Cook            Cook

--  17)To know who the loan owners are who do not have an account
select distinct loan.cname,account.cname
from loan left outer join account
on account.cname=loan.cname
order by loan.cname;

CNAME           CNAME
--------------- ---------------
Cook            Cook
James           James
Jones           Jones
Melcher
Rahimi          Rahimi
Tomczak         Tomczak
Woods           Woods

--  18)To know who the account owner is who does'nt have a loan
select distinct loan.cname "Loan Holder",account.cname "Account Holder"
from loan right outer join account
on account.cname=loan.cname
order by loan.cname;


Loan Holder     Account Holder
--------------- ---------------
Cook            Cook
James           James
Jones           Jones
Rahimi          Rahimi
Tomczak         Tomczak
Woods           Woods
                Love
				

-- 19)To know all loan holders,acc holders and both.
				
select distinct loan.cname "Loan Holder",account.cname "Account Holder"
from loan full outer join account
on account.cname=loan.cname
order by account.cname;

--  20)Using IN construct print the 
--customers who have both laon and account in france branch
select cname 
from loan
where lower(bname)='france' and 
cname in
(select cname
from account
where lower(bname)='france');

/*  21)Print the names of customers who have an account and a loan
in branches in minnetonka.
--Join giving account holders in branches in minnetonka*/

select cname
from account,branch
where lower(bcity)='minnetonka' and
account.bname=branch.bname;
-- 21.1)Join giving loan holders in branches in minnetonka
select cname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname;
-- 21.2)Now use the IN Construct to combine these two statements
--Join giving account holders in same branches in minnetonka. 
select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname and
loan.cname in
(select account.cname
from account,branch
where lower(bcity)='minnetonka'-->This check is being done in the 
--outer select hence not needed.So branch table is also not needed.
--This can be either way,this check can be removed from the outer select.
and
account.bname=branch.bname and
account.bname=loan.bname);
-- 21.3)Rewriting the above
select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname and
loan.cname in
(select account.cname
from account
where
account.bname=loan.bname);

/*  21.4)This makes the where condition account.bname=loan.bname redundant
*/hence remove it
select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname and
(loan.cname,loan.bname) in
(select account.cname,account.bname
from account);

/*NOTE:WHILE USING IN,INTERSECT,UNION ETC TRY TO AVOID REDUNDANCIES OF STATEMENTS
AS ABOVE*/

--  21.5)Using Inner Joins
SQL> select account.cname,account.bname
 from account
inner join
branch
on account.bname=branch.bname
inner join loan
on loan.bname=branch.bname
and
account.cname=loan.cname
and
lower(bcity)='minnetonka';

CNAME           BNAME
--------------- ---------------
Cook            Main

--  21.6)Using Joins without in condition
SQL> select account.cname,account.bname
  2  from account,branch,loan
  3  where account.bname=branch.bname
  4  and
  5  loan.bname=branch.bname
  6  and
  7  account.cname=loan.cname
  8  and
  9  lower(bcity)='minnetonka';

CNAME           BNAME
--------------- ---------------
Cook            Main

/* 22)Print the names of the customers who have a loan and an account in
       the same branch in minnetonka using intersect*/
select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname
intersect
select cname,account.bname
from account;


--  22.1)Alias
select l.cname,l.bname
from loan l,branch b
where lower(b.bcity)='minnetonka';

/*  22.2)Print the customers who have accounts in branches as Jone's Accounts*/
select cname 
from account
where bname in
(select bname
from account 
where lower(cname)='jones');

--  22.3)Using Alias
select distinct a2.cname
from account a1,account a2
where a2.bname=a1.bname and
lower(a1.cname)='jones' and
lower(a2.cname)<>'jones'--So that Jones is not displayed in the result
order by a2.cname;
-->a1 figures out the brachnes in which Jones has his accounts
-->a2 figures out the customers in jones' braches



--  22.4)My Solution
SQL> select distinct a1.cname
  2  from account a1
  3  where a1.bname in
  4  (
  5  select a2.bname
  6  from account a2
  7  where
  8  lower(a2.cname)='jones')
  9   order by a1.cname;

CNAME
---------------
Cook
James
Jones
Love
Rahimi
Tomczak
Woods

7 rows selected.
--In the above output , Jones is also returned as a customer which is wrong.
--So we include a statement saying that the cname must not be Jones below.

SQL> select distinct a1.cname
  2  from account a1
  3  where lower(a1.cname)<>'jones'
  4  and
  5  a1.bname
  6  in
  7  (
  8  select a2.bname
  9  from account a2
 10  where
 11  lower(a2.cname)='jones')
 12   order by a1.cname;

CNAME
---------------
Cook
James
Love
Rahimi
Tomczak
Woods

6 rows selected.

--  23)The person who owns the account is the person who owns the loan
select account.cname
from account, branch
where lower(branch.bcity) = 'minnetonka' AND
branch.bname = account.bname AND
EXISTS
(select loan.cname
from loan , branch
where lower(branch.bcity) ='minnetonka' AND
branch.bname = loan.bname AND
loan.cname = account.cname);

--Exists Keyword???
select unique account.cname
from account,branchwhere 
lower(branch.bcity)='minnetonka' and
branch.bname=account.bname and 
exists
(select 2
)

--Find all Branches that have assets greater
--than assets at all Branches in Edina
select bname
from Branch
where assets > all
(select assets
from Branch
where lower(bcity) = 'edina');

--Find all Branches that have assets greater
--than assets at any Branches in Edina
select bname,assets
from Branch
where assets > any
(select assets
from Branch
where lower(bcity) = 'edina');


--Find all Branches that have assets greater
--than assets at any Branches not in Edina
select bname,assets
from Branch
where lower(bcity)!='edina' and
assets > any
(select assets
from Branch
where lower(bcity) = 'edina');

select cname
from account
where lower(bname) In('southdale','frnace','york');

select cname,bname
from account
order by cname;

--To group the braches to a customer
Select distinct a1.cname from account a1
Where exists
( select a3.bname
from account a3
where a1.cname = a3.cname);
--To disqualiy a customer if there is branch in edina
-- is not one of the branches for the customer i am looking at
Select distinct a1.cname from account a1
where NOT EXISTS (
select bname from branch/*are there any branches in edina which 
are not present in the branch list 
of the current customer
*/where lower(bcity) = 'edina'
and bname NOT IN
(select a3.bname
from account a3
where a1.cname = a3.cname
)
);

--This can be done n using group by and count as well.Try it out.


/*Print the names of the customer who live in mpls
and habe branches with assets >90000
which are in minnetonka*/

--My Solution//Returns only one cook ,but there are 3 cook accounts
--so this is wrong
--The 'IN' clause considers unique values and not all values
SQL> select cname,ccity from customer
where lower(ccity)='mpls'
cname in
(
select account.cname
from account,branch
where account.bname=branch.bname
and
assets>90000
and
lower(bcity)='minnetonka'
)
;
 
 --Right solution with joins(When joining use many tables in from statement and
 --lesser nested loops)
 select customer.cname from customer,account,branch
 where lower(ccity)='mpls'
 and
 account.bname=branch.bname
 and
 assets>90000
 and lower(bcity)='minnetonka'
 and
 account.cname=customer.cname;

CNAME           STREET                         CCITY
--------------- ------------------------------ ---------------
Cook            2222 Main                      MPLS

/*Display the customers who have an account and a loan
and also the customers who have no loan.*/

















































