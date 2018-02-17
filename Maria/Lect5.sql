select bname
from branch;

--1.Print all info about branches of the bank.
select *
from branch;

--2.Prints the string branch to the output as many branches are there
select 'Branch',bname
from branch;

--3.Print all columns for the brach name "France"
select *
from account
where bname='France';

--4.When France is given as 'france',no rows are returned hence make all
--comparisons case-insensitive
select *
from account
where lower(bname)='france';
select *
from account
where upper(bname)='FRANCE';

--5.Print the name of all customers with 
--an account(s) at France.
select cname
from account
where lower(bname)='france';

--6.Print the name of all customers with 
--an loan(s) at France.
select cname
from loan
where lower(bname)='france';

--7.Print the name of all customers who have an account 
--a loan, or both in France brance.
select cname
from account
where lower(bname)='france'
union
select cname
from loan
where lower(bname)='france';

--This results in incorrect number of columns
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

--When the datatypes in the select clauses are not compatible 
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

--To resolve the above datatype problem
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

--To not suppress the repetitions in Union OPERATOR
--use Union ALL
select cname
from account
where lower(bname)='france'
union all
select cname
from loan
where lower(bname)='france';

--To know the peolple who have both the loan and account
--use intersect.
select cname
from account
where lower(bname)='france'
intersect
select cname
from loan
where lower(bname)='france';


--To know people who have an account but not loan
--use Minus
select cname
from account
where lower(bname)='france'
minus
select cname
from loan
where lower(bname)='france';

--To know people who have a loan but not account
--switch the tables and use minus.
select cname
from loan
where lower(bname)='france'
minus
select cname
from account
where lower(bname)='france';

--8.Print names of customer whohave an account,loan or both in france branch
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
/*
This does not work.Because this displays the users with the loan amounts also.
*/
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


select * from branch,customer;
--Inner Join
--Hit Ration- % of rows that intersect in the two tables.
--for eg: the hit ratio in the customer table and the account table is 100%.
--Because the foriegn key the customer name 
--must be related to all rows the parent table.
--(Gives the intersection of the two sets)
--(Doesnt find the place where the tables don't match)
--Given a customer ,find the accounts for the customer in 'Minnetonka'
--Syntax 1
select customer.cname,ccity,account.cname,bal
from customer,account
where customer.cname=account.cname
and lower(ccity)='minnetonka';
--Non Std Join Syntax
select customer.cname,ccity,account.cname,bal
from customer inner join account
where customer.cname=account.cname

--Customer who has both accounts and loans.
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

--Repetition is because customer has many accounts and many loans.

--Print the balanaces and amounts to check if there are redundancies.
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

--Use Distinct to avoid redundancies
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

----Customer who has both accounts and loans in france 
select distinct account.cname,loan.cname
from account,loan
where account.cname=loan.cname and
lower(account.bname)='france' and 
lower(loan.bname)='france'
order by account.cname;

--To know who the loan owners are 
--who do not have an account
select distinct loan.cname,account.cname
from loan left outer join account
on account.cname=loan.cname
order by loan.cname;

--To know who the account owner is
-- who does'nt have a loan
select distinct loan.cname "Loan Holder",account.cname "Account Holder"
from loan right outer join account
on account.cname=loan.cname
order by loan.cname;

select distinct loan.cname "Loan Holder",account.cname "Account Holder"
from loan full outer join account
on account.cname=loan.cname
order by account.cname;

--Using IN construct print the 
--customers who have both laon and account in france branch
select cname 
from loan
where lower(bname)='france' and 
cname in
(select cname
from account
where lower(bname)='france');

--Print the names of customers 
--who have an account and a loan
--in branches in minnetonka.
--Join giving account holders in branches in minnetonka
select cname
from account,branch
where lower(bcity)='minnetonka' and
account.bname=branch.bname;
--Join giving loan holders in branches in minnetonka
select cname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname;
--Now use the IN Construct to combine these two statements
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
--Rewriting the above
select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname and
loan.cname in
(select account.cname
from account
where
account.bname=loan.bname);


select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname and
(loan.cname,loan.bname) in
(select account.cname,account.bname-->This makes the where condition 
--account.bname=loan.bname redundant
--hence remove it
from account);

--Print the names of the customers who have a loan and an account in
--the same branch in minnetonka using intersect
select cname,loan.bname
from loan,branch
where lower(bcity)='minnetonka' and
loan.bname=branch.bname
intersect
select cname,account.bname
from account;


--Alias
select l.cname,l.bname
from loan l,branch b
where lower(b.bcity)='minnetonka';

--Print the customers who have accounts 
--in branches as Jone's Accounts
select cname 
from account
where bname in
(select bname
from account 
where lower(cname)='jones');

--Using Alias
select distinct a2.cname
from account a1,account a2
where a2.bname=a1.bname and
lower(a1.cname)='jones' and
lower(a2.cname)<>'jones'
order by a2.cname;
-->a1 figures out the brachnes in which Jones has his accounts
-->a2 figures out the customers in jones' braches

--The person who owns the account is the person who owns the loan
select account.cname
from account, branch
where lower(branch.bcity) = 'minnetonka' AND
branch.bname = account.bname AND
EXISTS
(select loan.cname
from loan , branch
where lower(branch.bcity) ='minnetonka' AND
branch.bname = loan.bname AND
loan.cname = account.cname;

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


--Hands On--
--1--
--Show the names of customers in mpls who have account have balance more than 1200
 select account.cname,bal,ccity
 from account,customer
 where bal>1200 and
 lower(ccity)='mpls' and
 account.cname=customer.cname;
 --Output
 /*CNAME                  BAL CCITY
--------------- ---------- ---------------
Cook                  6690 MPLS
Cook                 10000 MPLS
Cook                  3338 MPLS
Jones                 5678 MPLS*/
--In any branch except the france branch
 select account.cname,bal,ccity
 from account,customer,branch
 where bal>1200 and
 lower(ccity)='mpls' and
 account.cname=customer.cname and
lower(branch.bname)=(
select bname 
from branch 
where lower(bname)<>'france');

 








































































