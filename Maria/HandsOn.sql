--HANDS_ON -1

/*Display the names of the customers in MPLS 
with an account bal more than 1200 
in any branch other than france branch
or customers who live in Edina and have only one loan in frnace branch*/

--Solution
1.1)Print tha names of customers in MPLS who have account with bal>1200
select customer.cname,bal,account.bname
from customer,account
where lower(ccity)='mpls'
and
bal>1200
and
customer.cname=account.cname;

CNAME                  BAL BNAME
--------------- ---------- ---------------
Cook                  6690 France
Cook                 10000 York
Cook                  3338 Main
Jones                 5678 France

--1.3)customers who live in Edina 
SQL> select customer.cname
  2  from customer
  3  where lower(ccity)='edina';

CNAME
---------------
James
Janzen


1.4)--And have loan in france branch
select customer.cname,bname
from customer,loan
where lower(ccity)='edina'
and
lower(bname)='france'
and
customer.cname=loan.cname;

CNAME           BNAME
--------------- ---------------
James           France
1.5)--Have only one loan.
 select cname
 from loan
 group by cname
 having count(*)=1;
 
 1.6)/*Combining 1.3 to 1.5
     Customers who live in Edina and have only one loan in frnace branch*/
 
 select customer.cname,bname,amt
 from customer,loan
 where lower(ccity)='edina'
 and
 lower(bname)='france'
 and
 customer.cname=loan.cname
 and
 customer.cname in
 (
 select cname
 from loan
 group by cname
having count(*)=1);

CNAME           BNAME                  AMT
--------------- --------------- ----------
Woods           France                4450
James           France               12300
Tomczak         France               34560
 1.7)/*Combining 1.2 and 1.7
Display (the names of the customers in MPLS 
with an account bal more than 1200 
in any branch other than france branch)
or (customers who live in Edina and have only one loan in frnace branch)*/

Solution 1:
select customer.cname
from customer,account
where lower(ccity)='mpls'
and
bal>1200
and
customer.cname=account.cname
and
lower(bname)<>'france'
union
select customer.cname
from customer,loan
where lower(ccity)='edina'
and
lower(bname)='france'
and
customer.cname=loan.cname
and
customer.cname in
(
select cname
from loan
group by cname
having count(*)=1);

CNAME
---------------
Cook
James

--Solution 2
/*Display the names of the customers in MPLS 
with an account bal more than 1200 
in any branch (other than france branch
or customers who live in Edina and have only one loan in frnace branch)*/
 select distinct customer.cname
 from customer,account
 where lower(ccity)='mpls'
 and
 bal>1200
 and
 customer.cname=account.cname
 and
 account.cname
 not in
 (
  select customer.cname
  from customer,loan
  where lower(ccity)='edina'
  and
  lower(bname)='france'
  and
  customer.cname=loan.cname
  and
  customer.cname in
  (
  select cname
  from loan
  group by cname
 having count(*)=1)
 union
 select customer.cname
 from customer,account
 where lower(ccity)='edina'
 and
lower(bname)<>'france'
and
 customer.cname=account.cname);

 CNAME
---------------
Cook
Jones
 
 
 HANDS_ON 2
select name,bal
from person,account,emp
where sal>50000
and
lower(supervisor_name)='jonh';


Hands_On 3

Names of customers who have loans in Edina branches(southdale,York,France)
SQL>  select cname,bname
  2   from loan
  3   where bname in
  4   ( select bname
  5   from branch
  6   where lower(bcity)='edina')
  7  order by cname;

CNAME           BNAME
--------------- ---------------
Cook            York
Cook            France
James           France
Jones           Southdale
Jones           France
Jones           York
Melcher         France
Rahimi          Southdale
Rahimi          York
Rahimi          France
Tomczak         France

CNAME           BNAME
--------------- ---------------
Woods           France

Names of customers who have accounts in Edina branches(southdale,York,France)
SQL> select cname,bname
  2  from account
  3    where bname in
  4    ( select bname
  5    from branch
  6    where lower(bcity)='edina')
  7   order by cname;

CNAME           BNAME
--------------- ---------------
Cook            York
Cook            France
James           York
Jones           France
Jones           York
Love            France
Rahimi          York
Rahimi          Southdale
Rahimi          France
Tomczak         York
Tomczak         France

CNAME           BNAME
--------------- ---------------
Woods           France
Woods           Southdale
Woods           York


James and Tomzc are the answers
select cname
from account
where bname in(
select bname
from branch
where lower(bcity)='edina')
and
cname in(
select account.cname,loan.cname
from
account,loan
where account.cname=loan.cname);


 select account.cname,account.bname,loan.cname,loan.bname
 from account,loan,branch
 where account.cname=loan.cname
 and
 (account.bname,loan.bname) in
 (select bname
 from branch
 where lower(bcity)='edina');
 
 
 
 
 
 
 
 
 Group Prject 1
 
 The names of customers in MPLS who have account with bal>1200
 in any branch except france branch.
 
select distinct account.cname,bname
from account,customer
where
bal>1200
and
lower(ccity)='mpls'
and
lower(account.bname)<>'france'


CNAME           BNAME
--------------- ---------------
Cook            Main
Cook            York
 
 Or the customers who live in edina and have one loan account in france
 select distinct loan.cname,loan.bname
 from loan,customer
 where lower(ccity)='edina'
 and
 lower(bname)='france'
 order by loan.cname;
 CNAME           BNAME
--------------- ---------------
Cook            France
James           France
Jones           France
Melcher         France
Rahimi          France
Tomczak         France
Woods           France

7 rows selected.

2)
SQL>  select cname
  2   from account
  3   where bal>1800
  4  and
  5  exists
  6   (select cname
  7   from loan
  8   where amt=800);

no rows selected

3)
Display the branch name and the aasset name of all branches that
have the assets greater than any asset in edina
select bcity,bname,assets
from branch
where assets > any
(
select assets
from branch
where lower(bcity)='edina')

BCITY           BNAME               ASSETS
--------------- --------------- ----------
Edina           Southdale           750000
MPLS            Eight Street        450000
Eagan           Airport             446000
MPLS            Northtown           347000
Edina           York                300000
Minnetonka      Ridgedale           150000

6 rows selected.

7 rows selected.
Display the customer who live in minnetonka
and have account balance >400
select distinct account.bname
from account,customer
where lower(ccity)='minnetonka'
group by(account.bname)
having avg(bal)>400

CNAME             AVG(BAL)
--------------- ----------
Jones                 3067
Rahimi          907.333333
Cook                3506.5
Woods                 1000
Tomczak             436.75


Final Answer
SQL> select bcity,bname,assets
  2  from branch
  3  where assets > any
  4  (
  5  select assets
  6  from branch
  7  where lower(bcity)='edina')
  8  and bname in
  9  (
 10  select distinct account.bname
 11  from account,customer
 12  where lower(ccity)='minnetonka'
 13  group by(account.bname)
 14  having avg(bal)>400);

BCITY           BNAME               ASSETS
--------------- --------------- ----------
Edina           York                300000
Edina           Southdale           750000

4)