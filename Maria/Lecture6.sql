
--Insert Into statment.Syntax 1
insert into account
values(9732,'Rahimi','Main',1200);


--Syntax 2
insert into account(A#,cname,bname,bal)
values(9732,'Rahimi','Main',1200

-- balance not ppresent,syntax 1
insert into account(A#,cname,bname)
values(9732,'Rahimi','Main');
--syntax 2
insert into account
values(9732,'Rahimi','Main',null);

--Changing orders
insert into account(bal,a#,cname,bname)
values(null,9732,'Rahimi','Main');

--Elimintaing the values clause
insert into account
select L#,cname,bname,amt
from loan;

--Creating back ups
SQL> create table account_BK
  2  as
  3  select * from account;
  --All the loan rows are inserted to the account table.
  
  
  --rolling back
  /*rollback doesn not work here ..why???
  This is just for the tables involved in creation.The create table has to have pages
  in the disk for the database*/
  
  --Deleting the loan rows now
  SQL> delete from account
  2  where a# in(
  3  select L#
  4  from loan);

13 rows deleted.

  
 /*Create an account with balance $500 for all customers
 who have a loan with an amount $20000 or more in the bank
The values need not come from other table values as in the above copying 
example from loan.We can use the below example */
SQL> select 123,bname
  2  from branch;

       123 BNAME
---------- ---------------
       123 3rd Street
       123 Airport
       123 Eight Street
       123 France
       123 Main
       123 Northtown
       123 Ridgedale
       123 Second
       123 Southdale
       123 York

10 rows selected.
/*Create an account with balance $500 for all customers
 who have a loan with an amount $20000 or more in the bank*/
 
SQL> insert into account(bname,A#,cname,bal)
  2  select bname,L#,cname,500
  3  from loan;

13 rows created.

SQL> select * from account;

        A# CNAME           BNAME                  BAL
---------- --------------- --------------- ----------
      2222 Rahimi          Southdale             1111
      4444 Cook            France                6690
      5555 Cook            York                 10000
      6666 Cook            Main                  3338
      5000 Cook            Ridgedale              150
      5001 Cook            Second                 111
      7777 Jones           France                5678
      9999 Jones           York                   456
      1234 Tomczak         York                 123.5
      4567 Love            France                 300
      9800 Love            Main                   333

        A# CNAME           BNAME                  BAL
---------- --------------- --------------- ----------
      7765 James           York                   100
      7756 Woods           York                  1000
      7757 Woods           Southdale             1000
      7758 Woods           France                1000
      3333 Rahimi          York                  1111
      1001 Cook            France                 500
      2002 Rahimi          Southdale              500
      3003 Cook            York                   500
      4004 Rahimi          France                 500
      5005 Rahimi          York                   500
      6006 Cook            Main                   500

        A# CNAME           BNAME                  BAL
---------- --------------- --------------- ----------
      7007 Jones           France                 500
      8008 Jones           Southdale              500
      9009 Jones           York                   500
      1004 Tomczak         France                 500
      4009 James           France                 500
      9008 Melcher         France                 500
      8888 Woods           France                 500

29 rows selected.
/*Create an account with balance $500 for all customers
 who have a loan with an amount $20000 or more in the bank*/
 insert into account(bname,A#,cname,bal)
 select bname,L#,cname,500
 from loan
 where amt>=20000;
 3 rows created.

SQL> select * from account;

        A# CNAME           BNAME                  BAL
---------- --------------- --------------- ----------
      2222 Rahimi          Southdale             1111
      4444 Cook            France                6690
      5555 Cook            York                 10000
      6666 Cook            Main                  3338
      5000 Cook            Ridgedale              150
      5001 Cook            Second                 111
      7777 Jones           France                5678
      9999 Jones           York                   456
      1234 Tomczak         York                 123.5
      4567 Love            France                 300
      9800 Love            Main                   333

        A# CNAME           BNAME                  BAL
---------- --------------- --------------- ----------
      7765 James           York                   100
      7756 Woods           York                  1000
      7757 Woods           Southdale             1000
      7758 Woods           France                1000
      3333 Rahimi          York                  1111
      4004 Rahimi          France                 500
      6006 Cook            Main                   500
      1004 Tomczak         France                 500

	  19 rows created.
	 
	 
	 /*Case statement
	 Same questions as above with amount >20000 and account bal <30000 will be 500
	 if the customer has a loan with amount <30000 and account bal 750*/
insert into account(bname,A#,cname,bal)
 select bname,L#,cname,
 case
 when amt>=20000 and amt<30000 then 500
 when amt>=30000 then 750
 end as bal
 from loan
 where amt>=20000;
 
 /*Inline View-temoprary table created in the select statmenet with an alias
 eg :*/
 select distinct a.cname,l.loanholder
 from account a,
 (Select cname loanholder,amt amount
 from loan
 where lower(bname)='france')l
 where lower(a.bname)='france' and
 l.loanholder=a.cname;
 
 --Table table-Tells you what tables you have in the user
 
 select 'select * from',tname,';'from tab';
 
'SELECT*FROM' TNAME                          '
------------- ------------------------------ -
select * from ACCOUNT                        ;
select * from ACCOUNT_BK                     ;
select * from BRANCH                         ;
select * from CUSTOMER                       ;
select * from LOAN                           ;
 
SQL> select 'drop table',tname,'cascade constraints;',from tab;
select 'drop table',tname,'cascade constraints;',from tab
                                                 *
ERROR at line 1:
ORA-00936: missing expression


SQL> select 'drop table',tname,'cascade constraints;' from tab;

'DROPTABLE TNAME                          'CASCADECONSTRAINTS;
---------- ------------------------------ --------------------
drop table ACCOUNT                        cascade constraints;
drop table BIN$hdiH+Vd0Tdu523qPPQTGww==$0 cascade constraints;
drop table BRANCH                         cascade constraints;
drop table CUSTOMER                       cascade constraints;
drop table LOAN                           cascade constraints;

/*Update ROWS
Updates one more table based on th where ckuase.Where cluase is optional.
set clause is required.
If where is not there ,all rows get updated.
Syntax:
Updat table name
set<attribute list>
where cluase;
 
 1.Display the customer list who has two or more loans with average amount >5000.
 
 
 Delete clause.
 Requires to delete the parent row as well as the children rows.
 On Delete Cascade constarint does allow the above and On delete restrict constraints,what happens is 
 when the parent is deleted the children don't get deleted.
 When we have a hierarchy like below
 t1---->t2---->t3
 t1 is parent to t2 which is parent to t3.In this case use either cascade everywhere
 or restrict delete based on what you want.
 
*/

-------AGGREGATE FUNCTIONS-----
/*THIS APPLIES TO GROUP OF ROWS HENCE USED WITH GROUP BY CLAUSE
	
Column Commands
*/

column avg(bal) heading average;
column avg(bal) format 99999.99;
SQL> select bname ,avg(bal) from account where bal>500
  2  group by bname;

BNAME             average
--------------- ---------
France            3529.50
Main              2044.00
Southdale         1055.50
York              4037.00

--SQL plus as a report writer for beautification

--Display the customers who each have an account in all branches in Edina.(SOuthdale,York,france)

select distinct a.cname
from account a
where a.bname in(select bname from branch
where lower(bcity)='edina'
)
group by a.cname
having count(distinct a.bname)= (select count(bname)
from branch
where lower(bcity)='edina');


--VIEWS(CONTROL ACCESS)


 
 
 
 
 
	 
 
 