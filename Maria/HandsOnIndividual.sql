Hands On1

select E1.name,W1.d#
from emp E1,WorksOn W1
where p#=2
and
E1.ssn=W1.ssn
and
E1.ssn in
(Select ssn
from salaried
where 
salary<30000
)
and
E1.d# in
(select D2.d#
from dept D2,emp E2
where 
E2.ssn=D2.ssn
and
lower(E2.name)='johnson'
)
)
and
E1.SupervisorSSN =
(select E4.ssn
from emp E4
where exists
(
select E5.SupervisorSSN from emp E5
where
lower(name)='jones'
and
E4.ssn=E5.SupervisorSSN
)
);



HANDS_ON 2
select a#,bal
from account,person
where 
account.ssn=person.ssn
and
person.ssn
in
(
select ssn
from customer,person
where customer.ssn=person.ssn
and
empSSN=
(select ssn from 
emp,person
where sal>50000
and
supervisorSSN=
(select ssn from person
where lower(name)='john'
and
emp.supervisorssn=person.ssn
)
);


Hands_On 3

select distinct account.cname as Customer_Name
from account,loan,branch
where lower(bcity)='edina'
and
account.cname=loan.cname
and
account.cname
not in
(
select account.cname
from account,loan
where
account.cname=loan.cname
and
account.bname=loan.bname
);

CUSTOMER_NAME
---------------
James
Tomczak
 
 or
 
select a1.cname,a1.bname
from account a1,branch,loan
where 
lower(bcity)='edina'
and
a1.bname=branch.bname
and
a1.cname=loan.cname
and
not exists
(
select a2.cname
from account a2
where 
a1.cname=a2.cname
and
(a2.cname,a2.bname)
in
(
select cname,loan.bname
from loan,branch
where lower(bcity)='edina'
and
loan.bname=branch.bname
)
);

CNAME           BNAME
--------------- ---------------
Tomczak         York
James           York

--Try not joining 3 tables
select distinct account.cname as Customer_Name
from account,loan
where 
account.cname=loan.cname
and
account.cname
not in
(
select account.cname
from account,loan
where
account.cname=loan.cname
and
account.bname=loan.bname
)
and
account.bname
in
(
select bname
from branch
where lower(bcity)='edina'
);

--Q4
select
case
when exists(select cname,bname
from account
where (cname,bname)
not in
(select cname,bname
from loan
))
then
(
select  account.cname as Customer_Account
from account
left join
loan
on
loan.cname is null
)
when exists(select cname,bname
from loan
where (cname,bname)
not in
(select cname,bname
from account
))
then
(
select  loan.cname as Loan_Accts
from account
right join
loan
on
account.cname is null
)
end
from account,loan;
 
 or
 
 --A customer who has account and loan using the in and not join
 
select cname,bname
from account
where (cname,bname)
in
(
select cname,bname
from loan
where account.bname=loan.bname
)
and
(cname,bname) in
(
select loan.cname as LoanCust,loan.bname
from loan
left join account
on loan.cname=account.cname
and
loan.cname is null
);

order by cname,bname;
CNAME           BNAME
--------------- ---------------
Cook            France
Cook            Main
Cook            York
Jones           France
Jones           York
Rahimi          Southdale
Rahimi          York
Woods           France

8 rows selected.

select cname,bname
from account
where (cname,bname)
not in
(select cname,bname
from loan
)
order by cname,bname;

CNAME           BNAME
--------------- ---------------
Cook            Ridgedale
Cook            Second
James           York
Love            France
Love            Main
Tomczak         York
Woods           Southdale
Woods           York

select cname,bname
from loan
where (cname,bname)
not in
(select cname,bname
from account
)
order by cname,bname;

CNAME           BNAME
--------------- ---------------
James           France
Jones           Southdale
Melcher         France
Rahimi          France
Tomczak         France


Solution

select customer.cname as Cust_Name,account.bname as Branch
from account
full outer join
customer
on
account.cname=customer.cname
union
select  customer.cname as Cust_Name,loan.bname
from loan
full outer join
customer
on
loan.cname=customer.cname;


CUST_NAME       BRANCH
--------------- ---------------
Baba
Cook            France
Cook            Main
Cook            Ridgedale
Cook            Second
Cook            York
Erickson
Ireland
James           France
James           York
Janzen

CUST_NAME       BRANCH
--------------- ---------------
Johnson
Jones           France
Jones           Southdale
Jones           York
Love            France
Love            Main
Love
Melcher         France
Melcher
Rahimi          France
Rahimi          Southdale

CUST_NAME       BRANCH
--------------- ---------------
Rahimi          York
Tomcat
Tomczak         France
Tomczak         York
Tones
Woods           France
Woods           Southdale
Woods           York