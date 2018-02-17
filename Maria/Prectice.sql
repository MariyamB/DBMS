--Print names of all customers who have an account and loan in Minnetonka with IN
select cname,bname
from account
where 
cname
in
(
select cname
from loan,branch
where
lower(bcity)='minnetonka'
and
loan.bname=branch.bname)
order by cname,bname;
CNAME           BNAME
--------------- ---------------
Cook            France
Cook            Main
Cook            Ridgedale
Cook            Second
Cook            York
--Print names of all customers who have an account and loan in any Minnetonka branch with IN
--Note:The accuont and the loan must be in the same branch
select cname,bname
from account
where 
(cname,bname)
in
(
select cname,loan.bname
from loan,branch
where
lower(bcity)='minnetonka'
and
loan.bname=branch.bname)
order by cname,bname;

CNAME           BNAME
-----          --------
Cook            Main


--Print names of all customers who have an account and loan in Minnetonka with exists
select cname,account.bname
from account,branch
where 
lower(bcity)='minnetonka'
and
branch.bname=account.bname
and
exists
(
select cname
from loan
where account.cname=loan.cname
)
order by cname,bname;
