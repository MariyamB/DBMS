Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.
--CONNECTING TO SQL PLUS AS DBA
C:\Users\kochu>sysplus sys/oracle as sysdba
'sysplus' is not recognized as an internal or external command,
operable program or batch file.

C:\Users\kochu>sqlplus sys/oracle as sysdba
SQL*Plus: Release 11.2.0.1.0 Production on Thu Oct 27 12:26:15 20
Copyright (c) 1982, 2010, Oracle.  All rights reserved.
Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
With the Partitioning, OLAP, Data Mining and Real Application Tes

--DISPLAYING CURRENT USER
SQL> show user;
USER is "SYS"

--DISLPAYING THE DATABASE
SQL> select name from v$database;
NAME
---------
ORCL

--DISPLAYING THE USERNAME MARIA
SQL> select username from dba_users where username=maria;
ORA-01756: quoted string not properly terminated

SQL> select username from dba_users where username='maria';
no rows selected

--Displaying the tables for a particluar user(MARIA)

SQL> desc tab;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------

 TNAME                                     NOT NULL VARCHAR2(30)
 TABTYPE                                            VARCHAR2(7)
 CLUSTERID                                          NUMBER

SQL> select tname from tab;

TNAME
------------------------------
ACCOUNT
BRANCH
CUSTOMER
LOAN


--DISPLAYING ALL USER NAME FROM DBA USERS
SQL> select username from dba_users;
USERNAME
------------------------------
MGMT_VIEW
SYS
SYSTEM
DBSNMP
SYSMAN
XYZ
HR
MARIA
OUTLN
FLOWS_FILES
MDSYS

USERNAME
------------------------------
ORDSYS
EXFSYS
WMSYS
APPQOSSYS
APEX_030200
OWBSYS_AUDIT
ORDDATA
CTXSYS
ANONYMOUS
XDB
ORDPLUGINS

USERNAME
------------------------------
OWBSYS
SI_INFORMTN_SCHEMA
OLAPSYS
SCOTT
ORACLE_OCM
XS$NULL
BI
PM
MDDATA
IX
SH

USERNAME
------------------------------
DIP
OE
APEX_PUBLIC_USER
SPATIAL_CSW_ADMIN_USR
SPATIAL_WFS_ADMIN_USR

38 rows selected.

--DISPLAYING USER NAME 'MARIA' IN THE DBA USERS TABLE
SQL> select username from dba_users where username='MARIA';

USERNAME
------------------------------
MARIA
--Changing password of MARIA through DBA User
SQL> password maria;
Changing password for maria
New password:
Retype new password:
Password changed
SQL> quit
Disconnected from Oracle Database 11g Enterprise Edition Release
bit Production
With the Partitioning, OLAP, Data Mining and Real Application Tes

--CONNECTING TO MARIA WITH NEW PASSWORD
C:\Users\kochu>sqlplus maria;
SQL*Plus: Release 11.2.0.1.0 Production on Thu Oct 27 12:30:08 20
Copyright (c) 1982, 2010, Oracle.  All rights reserved.

Enter user-name: maria
Enter password:
Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
With the Partitioning, OLAP, Data Mining and Real Application Tes

--DISPLAYING CURRENT USER
SQL> show user;
USER is "MARIA"
SQL> quit
Disconnected from Oracle Database 11g Enterprise Edition Release
bit Production
With the Partitioning, OLAP, Data Mining and Real Application Tes

--USING THE ALTER COMMAND TO CHANGE PASSWORD
C:\Users\kochu>sqlplus sys/oracle as sysdba;
SQL*Plus: Release 11.2.0.1.0 Production on Thu Oct 27 12:30:57 20
Copyright (c) 1982, 2010, Oracle.  All rights reserved.
Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
With the Partitioning, OLAP, Data Mining and Real Application Tes

SQL> show user;
USER is "SYS"
SQL> alter user maria identified by maria;
User altered.

SQL> quit
Disconnected from Oracle Database 11g Enterprise Edition Release
bit Production
With the Partitioning, OLAP, Data Mining and Real Application Tes

C:\Users\kochu>sqlplus maria;
SQL*Plus: Release 11.2.0.1.0 Production on Thu Oct 27 12:32:01 20
Copyright (c) 1982, 2010, Oracle.  All rights reserved.
Enter user-name: maria
Enter password:
Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
With the Partitioning, OLAP, Data Mining and Real Application Tes

SQL> show user;
USER is "MARIA"
SQL> quit;
Disconnected from Oracle Database 11g Enterprise Edition Release
bit Production
With the Partitioning, OLAP, Data Mining and Real Application Tes

C:\Users\kochu>sqlplus sys/oracle as sysdba;
SQL*Plus: Release 11.2.0.1.0 Production on Thu Oct 27 12:33:27 20
Copyright (c) 1982, 2010, Oracle.  All rights reserved.
Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit
With the Partitioning, OLAP, Data Mining and Real Application Tes--

--DISPLAYING THE PASSWORD OF THE USER MARIA IN THE DBA TABLE
SQL> select password from dba
  2  _user where username='MARIA';
_user where username='MARIA'
*
ERROR at line 2:
ORA-00911: invalid character


SQL> select password from dba_users where username='MARIA';

PASSWORD
------------------------------  --PASSWORDS ARE NOT STORED IN THIS TABLE.
--THEY ARE MOVED TO THE USERS TABLE IN ORACLE 11g


SQL> select password from user$ where user='MARIA';

no rows selected

SQL> select password from user$ where name='MARIA';

PASSWORD
------------------------------
61A1596F2950843E

--CHANGING PASSWORD AFTER LOGGING INTO THE USER MARIA
C:\Users\kochu>sqlplus maria;
SQL*Plus: Release 11.2.0.1.0 Production on Thu Oct 27 12:39:30 2016
Copyright (c) 1982, 2010, Oracle.  All rights reserved.
Enter user-name: maria
Enter password:
Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> password maria;
Changing password for maria
Old password:
New password:
Retype new password:
Password changed
