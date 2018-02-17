
/*Q1.Display the names of customers  who dont live in mpls/edina
and have a loan amount more than 500 except france branch
 and have more accounts in france branch*/
 
select account.cname,account.bname
from account,customer
where lower(ccity) not in('mpls','edina')
and
lower(account.bname)='france'
and
account.cname=customer.cname
and account.cname
in
(
select cname
from loan
where amt>500
and
lower(bname)<>'france'
);

no rows selected

/*Q2.Display the names of customers who have only one account with a bal>1000
and one or more loan with an amount of more than 4000 in any edina branch*/

select cname
from account
where bal>1000
and
exists
(
select cname
from loan,branch
where amt>4000
and lower(bcity)='edina'
and
loan.bname=branch.bname
)
group by cname
having count(*)=1;
CNAME
---------------
Jones

/*Q3.Display the names of all customers who live in minnetonka or eden praire
have one or more accounts in any branch in edina,
and have a loan in every branch in minnetonka that have assets of less than 125000
but do not have a loan in those branches in minnetonka that have assets>=125000*/


select account.cname
from account,customer,branch
where lower(ccity) in ('minnetonka','eden praire')
and
account.cname=customer.cname
and
lower(bcity)='edina'
and
account.bname=branch.bname
and account.cname
in
(
select distinct l1.cname 
from loan l1,branch
where 
not exists
(
select bname
from branch
where lower(bcity)='minnetonka'
and 
bname 
not in
( select l2.bname
from loan l2
where l1.cname=l2.cname
)
and
assets < 125000
and 
bname 
not in
(select bname
from branch
where lower(bcity)='minnetonka'
and
assets>125000
) 
)
);

no rows selected

/*Q4.Print the branch name and the average balances of all accounts in branches
if one or more customer who live in eden prairie have accounts in the branch 
and the avg bal is more than 800.*/

select distinct bname,avg(bal) as Average_Balance
from account
where 
bname
in
(select account.bname
from account,customer
where 
lower(ccity)='eden prairie'
and
account.cname=customer.cname
group by account.bname
having avg(bal)>800)
group by bname;

BNAME           AVERAGE_BALANCE
--------------- ---------------
York                    2131.75
Southdale                1055.5
