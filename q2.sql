Q2

--Cook and Jones Branches
select cname,bname
from loan
where lower(cname) IN ('jones','cook')
order by cname,bname;

CNAME           BNAME
--------------- ---------------
Cook            France
Cook            Main
Cook            York
Jones           France
Jones           Southdale
Jones           York


select distinct l4.cname
from
loan l4
where 
lower(l4.cname) NOT IN ('cook','jones')
and
not exists
(
select
bname
from
loan
where
lower(cname) IN ('jones','cook')
and
bname
in
(
select l6.bname
from loan l6
where l4.cname=l6.cname
)
);


---Q3

Jones branches
SQL> select cname,bname
  2  from account
  3  where lower(cname)='jones';

CNAME           BNAME
--------------- ---------------
Jones           France
Jones           York

customers other than jones and their branches
select cname,bname
from account
where lower(cname) <>'jones'
group by cname,bname
order by cname;

CNAME           BNAME
--------------- ---------------
Cook            France
Cook            York
Cook            Main
Cook            Ridgedale
Cook            Second
James           York
Love            France
Love            Main
Rahimi          Southdale
Rahimi          York
Tomczak         York

CNAME           BNAME
--------------- ---------------
Woods           York
Woods           Southdale
Woods           France

14 rows selected.

--Part 1 of Q3
select distinct a1.cname
from account a1
where exists
(
select bname
from account
where
lower(cname)='jones'
and
bname
in
(
select bname
from account a2
where
lower(a2.cname)<>'jones'
and
a1.cname=a2.cname
)
)
intersect
select distinct a1.cname
 from account a1
 where not exists
(
select bname
from branch
where lower(bcity)='edina'
and
bname
not in
(
select a2.bname
from account a2,branch
where lower(bcity)='edina'
and
a2.cname
not in
(
select cname
from loan,branch
where lower(branch.bcity)='edina'
)
)
);
 
 
 
 
