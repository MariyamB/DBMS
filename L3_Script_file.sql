-- capture the results into a text file to print later
spool C:\Users\kochu\Downloads\Steps\Steps\myresults.txt

-- setup the width and height of the page to print
--
set linesize 80;
set pagesize 64;

-- Set echo on so that you can see the input as well in the spool file
set echo on;

--
-- Team Number: 4
-- Team Members: Mariyam Rajeev George
-- My SQL Statements
--

--
-- reduce the widths of column being printed
-- column cname format A10;
-- column bname format A15;
--
--Q1:
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

-- Q2:
--Display the customers whos loans in any branch that Jones and Cook do not have loans in.

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

--Q3:
--Print the names of all customers who have one or more account
--in any branch that Jones has an account in and these customers have ac account in every branch
--that has an account holders living in Edina but not loan holders.
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
 
 

-- Close the spool file
spool off;
