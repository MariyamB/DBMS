--HANDS_ON -1

/*Display THE NAMES OF THE CUSTOMERS IN MPLS 
WITH AN ACCOUNT BAL MORE THAN 1200 
IN ANY BRANCH OTHER THAN FRANCE BRANCH)
or CUSTOMERS WHO LIVE IN EDINA AND HAVE ONLY ONE LOAN IN FRNACE BRANCH*/

Solution 1:
select c1.cname
from customer c1,account a1
where lower(c1.ccity)='mpls'
and
a1.bal>1200
and
c1.cname=a1.cname
and
lower(a1.bname)<>'france'
union
select c2.cname
from customer c2,loan l2
where lower(c2.ccity)='edina'
and
lower(l2.bname)='france'
and
c2.cname=l2.cname
and
c2.cname in
(
select l3.cname
from loan l3
group by l3.cname
having count(*)=1);

CNAME
---------------
Cook
James

--Solution 2
/*Display the names of the customers in MPLS 
with an account bal more than 1200 
in any branch (OTHER THAN FRANCE BRANCH
OR CUSTOMERS WHO LIVE IN EDINA AND HAVE ONLY ONE LOAN IN FRANCE BRANCH)*/
 select a1.cname
 from customer c1,account a1
 where lower(c1.ccity)='mpls'
 and
 a1.bal>1200
 and
 c1.cname=a1.cname
 and
 not exists
(
  select l2.cname
  from loan l2
  where lower(l2.bname)='france'
  group by l2.cname
  having count(*)=1
  or
  l2.cname in
 (
    select distinct a3.cname
     from account a3
     ,customer c3
      where lower(c3.ccity)='mpls'
      and
   lower(a3.bname)='france'
  and
  c3.cname=a3.cname));

No rows selected.
 
 --HANDS_ON -2
--Display the customers who have accoutn bal>1800and loan =800.

Solution 1
select cname
from account
where bal>1800
and
exists
(select cname
from loan
where amt=800);

no rows selected

--HANDS_ON -3

/*Display the branch name and the aasset name of all branches that
have the assets greater than any asset in edina*/

Solution 1
--Without the branches in edina
select distinct branch.bname,assets
from branch 
where assets > any
(
select assets
from branch
where lower(bcity)='edina')
and lower(bcity)<>'edina'
and
bname
in
(
select account.bname
from account,customer
where
lower(ccity)='minnetonka'
and
customer.cname=account.cname
group by account.bname
having avg(bal)>400
);

no rows selected

--Solution 2
--With edina branches
select bname,assets
from branch
where assets > any
(
select assets
from branch
where lower(bcity)='edina')
and bname in
(
select distinct account.bname
from account,customer
where lower(ccity)='minnetonka'
group by(account.bname)
having avg(bal)>400)
order by  bname,assets;

BNAME               ASSETS
--------------- ----------
Southdale           750000
York                300000


--HANDS_ON -4
/*Display the names of branches in EDINA with assets more than 40000
and also have loan in eden prairie with amt more than 1000*/

select distinct branch.bname
from loan,branch,customer
where lower(bcity)='edina'
and
assets>40000
and
amt>1000
and
branch.bname=loan.bname
and
lower(ccity)='eden prairie';

BNAME
---------------
France
York
Southdale

--HANDS_ON -5
/*Display the customers who live in minnetonka
and have accounts in any branch in edina
and the names of customers who have loan accounts in all branches in EDINA
with assets less than that of 100000*/

select customer.cname
from customer,account
where lower(ccity)='minnetonka'
and
bname in
(
select bname
from branch 
where lower(bcity)='edina')
and
customer.cname=account.cname
intersect
select cname
from branch,loan
where
cname in
(
select distinct l4.cname
 from loan l4
where not exists
(
select bname
from branch
where lower(bcity)='edina'
and
bname
not in
(
select l6.bname
from loan l6
where l4.cname=l6.cname
)
)
)
and assets<100000;

no rows selected

