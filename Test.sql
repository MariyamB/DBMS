
--Half done-Need to do the distinct branches

select cname
from account
where bname
in
(
select account.bname
from
account,branch
where cname
in 
(
select cname
from account
group by cname
having count(cname)=2
)
and
lower(bcity)='edina'
and
account.bname=branch.bname
)
group by cname
having count(distinct(bname))=2;


--having count(distinct(bname)=2);


select count(distinct(bname))
from account
group by cname
having count(distinct(bname))=2;
