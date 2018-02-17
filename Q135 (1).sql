Q1 

select customer.cname 
from customer, account
where lower (ccity)='mpls'
and bal>1200 and 
lower (bname)<>'france'and 
account.cname=customer.cname
minus 
(
select loan.cname 
from customer, loan 
where lower (ccity)='edina' 
and lower (bname)='france'
group by loan.cname
having count (loan.cname)=1); 


Q3 
select bname, assets 
from branch 
where assets>any 
(select assets 
from branch 
where lower (bcity)='edina') 
and bname in 
(select account.bname 
from customer, account
where lower (ccity)='minnetonka' 
and customer.cname=account.cname 
group by account.bname 
having avg(bal)>400); 


Q5 
select customer.cname 
from customer,account
where lower (ccity)='minnetonka' 
and lower (bname)='edina' 
and customer.cname=account.cname 
intersect 
(select a1.cname 
from loan a1 
where not exists
(select bname 
from branch 
where lower (bname)='edina' 
and bname not in (
select a3.bname 
from loan a3 
where a1.cname=a3.cname
and assets<100000))); 