/*==============================================================*/
/* Database name:  PROJECT                                      */
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     6/5/2016 12:48:42 PM                         */
/*==============================================================*/


drop index CONTAINS2_FK
/


drop index CONTAINS_FK
/


drop index DERIVES2_FK
/


drop index DERIVES_FK
/


drop index IS_IN2_FK
/


drop index IS_IN_FK
/


drop index IS_USED_BY2_FK
/


drop index IS_USED_BY_FK
/


drop index RELATES2_FK
/


drop index RELATES_FK
/


drop index SUPER_FK
/


drop index SUB2_FK
/


drop index SUB_FK
/


drop table RELATES cascade constraints
/


drop table IS_USED_BY cascade constraints
/


drop table CONTAINS cascade constraints
/


drop table SUB cascade constraints
/


drop table SPECIALIZATION cascade constraints
/


drop table REL_TYPE cascade constraints
/


drop table IS_IN cascade constraints
/


drop table ENTITY_TYPE cascade constraints
/


drop table DERIVES cascade constraints
/


drop table ATTR_TYPE cascade constraints
/


/*==============================================================*/
/* Table : ATTR_TYPE                                            */
/*==============================================================*/


create table ATTR_TYPE  (
   ANAME                CHAR(30)                         not null,
   MULTI_VALUED         CHAR(1),
   constraint PK_ATTR_TYPE primary key (ANAME)
)
/


/*==============================================================*/
/* Table : DERIVES                                              */
/*==============================================================*/


create table DERIVES  (
   ANAME                CHAR(30)                         not null,
   Base_ANAME           CHAR(30)                         not null,
   DATA_TYPE            CHAR(30)                         not null,
   constraint PK_DERIVES primary key (ANAME, Base_ANAME)
)
/


/*==============================================================*/
/* Index: DERIVES_FK                                            */
/*==============================================================*/
create index DERIVES_FK on DERIVES (
   ANAME ASC
)
/


/*==============================================================*/
/* Index: DERIVES2_FK                                           */
/*==============================================================*/
create index DERIVES2_FK on DERIVES (
   Base_ANAME ASC
)
/


/*==============================================================*/
/* Table : ENTITY_TYPE                                          */
/*==============================================================*/


create table ENTITY_TYPE  (
   ENAME                CHAR(30)                         not null,
   TYPE					CHAR(20),
   constraint PK_ENTITY_TYPE primary key (ENAME)
)
/


/*==============================================================*/
/* Table : IS_IN                                                */
/*==============================================================*/


create table IS_IN  (
   ANAME                CHAR(30)                         not null,
   Composite_ANAME      CHAR(30)                         not null,
   DATA_TYPE            CHAR(30)                         not null,
   constraint PK_IS_IN primary key (ANAME, Composite_ANAME)
)
/


/*==============================================================*/
/* Index: IS_IN_FK                                              */
/*==============================================================*/
create index IS_IN_FK on IS_IN (
   ANAME ASC
)
/


/*==============================================================*/
/* Index: IS_IN2_FK                                             */
/*==============================================================*/
create index IS_IN2_FK on IS_IN (
   Composite_ANAME ASC
)
/


/*==============================================================*/
/* Table : REL_TYPE                                             */
/*==============================================================*/


create table REL_TYPE  (
   RNAME                CHAR(30)                         not null,
   TYPE                 CHAR(20),
   constraint PK_REL_TYPE primary key (RNAME)
)
/


/*==============================================================*/
/* Table : SPECIALIZATION                                       */
/*==============================================================*/


create table SPECIALIZATION  (
   SNAME                CHAR(30)                         not null,
   ENAME                CHAR(30)                         not null,
   TOTAL                CHAR(1),
   OVERLAPPING          CHAR(1),
   constraint PK_SPECIALIZATION primary key (SNAME)
)
/


/*==============================================================*/
/* Index: SUPER_FK                                              */
/*==============================================================*/
create index SUPER_FK on SPECIALIZATION (
   ENAME ASC
)
/


/*==============================================================*/
/* Table : SUB                                                  */
/*==============================================================*/


create table SUB  (
   ENAME                CHAR(30)                         not null,
   SNAME                CHAR(30)                         not null,
   constraint PK_SUB primary key (ENAME, SNAME)
)
/


/*==============================================================*/
/* Index: SUB_FK                                                */
/*==============================================================*/
create index SUB_FK on SUB (
   ENAME ASC
)
/


/*==============================================================*/
/* Index: SUB2_FK                                               */
/*==============================================================*/
create index SUB2_FK on SUB (
   SNAME ASC
)
/


/*==============================================================*/
/* Table : CONTAINS                                             */
/*==============================================================*/


create table CONTAINS  (
   ANAME                CHAR(30)                         not null,
   ENAME                CHAR(30)                         not null,
   DATA_TYPE            CHAR(30)                         not null,
   IS_KEY               CHAR(1),
   KEY_TYPE             CHAR(10),
   constraint PK_CONTAINS primary key (ANAME, ENAME)
)
/


/*==============================================================*/
/* Index: CONTAINS_FK                                           */
/*==============================================================*/
create index CONTAINS_FK on CONTAINS (
   ANAME ASC
)
/


/*==============================================================*/
/* Index: CONTAINS2_FK                                          */
/*==============================================================*/
create index CONTAINS2_FK on CONTAINS (
   ENAME ASC
)
/


/*==============================================================*/
/* Table : IS_USED_BY                                           */
/*==============================================================*/


create table IS_USED_BY  (
   RNAME                CHAR(30)                         not null,
   ANAME                CHAR(30)                         not null,
   DATA_TYPE            CHAR(30)                         not null,
   constraint PK_IS_USED_BY primary key (RNAME, ANAME)
)
/


/*==============================================================*/
/* Index: IS_USED_BY_FK                                         */
/*==============================================================*/
create index IS_USED_BY_FK on IS_USED_BY (
   RNAME ASC
)
/


/*==============================================================*/
/* Index: IS_USED_BY2_FK                                        */
/*==============================================================*/
create index IS_USED_BY2_FK on IS_USED_BY (
   ANAME ASC
)
/


/*==============================================================*/
/* Table : RELATES                                              */
/*==============================================================*/


create table RELATES  (
   RNAME                CHAR(30)                         not null,
   ENAME                CHAR(30)                         not null,
   ROLE                 CHAR(10)                         not null,
   CARDINALITY          CHAR(1),
   MIN_CARD             NUMBER(2),
   MAX_CARD             NUMBER(2),
   constraint PK_RELATES primary key (RNAME, ENAME, ROLE)
)
/


/*==============================================================*/
/* Index: RELATES_FK                                            */
/*==============================================================*/
create index RELATES_FK on RELATES (
   RNAME ASC
)
/


/*==============================================================*/
/* Index: RELATES2_FK                                           */
/*==============================================================*/
create index RELATES2_FK on RELATES (
   ENAME ASC
)
/
Alter table DERIVES
add constraint FK_DERIVES_DERIVES_ATTR_TYP foreign key (ANAME)
         references ATTR_TYPE (ANAME);
Alter table DERIVES
add constraint FK_DERIVES_DERIVES2_ATTR_TYP foreign key (Base_ANAME)
         references ATTR_TYPE (ANAME);

Alter table IS_IN
add constraint FK_IS_IN_IS_IN_ATTR_TYP foreign key (ANAME)
         references ATTR_TYPE (ANAME);
Alter table IS_IN
add constraint FK_IS_IN_IS_IN2_ATTR_TYP foreign key (Composite_ANAME)
         references ATTR_TYPE (ANAME);

Alter table SPECIALIZATION
add constraint FK_SPECIALI_SUPER_ENTITY_T foreign key (ENAME)
         references ENTITY_TYPE (ENAME);
Alter table SUB
add constraint FK_SUB_SUB_ENTITY_T foreign key (ENAME)
         references ENTITY_TYPE (ENAME);
Alter table SUB
add constraint FK_SUB_SUB2_SPECIALI foreign key (SNAME)
         references SPECIALIZATION (SNAME);	 
Alter table CONTAINS
add constraint FK_CONTAINS_CONTAINS_ATTR_TYP foreign key (ANAME)
         references ATTR_TYPE (ANAME);
Alter table CONTAINS
add constraint FK_CONTAINS_CONTAINS2_ENTITY_T foreign key (ENAME)
         references ENTITY_TYPE (ENAME);
Alter table IS_USED_BY
add constraint FK_IS_USED__IS_USED_B_REL_TYPE foreign key (RNAME)
         references REL_TYPE (RNAME);
Alter table IS_USED_BY
add constraint FK_IS_USED__IS_USED_B_ATTR_TYP foreign key (ANAME)
         references ATTR_TYPE (ANAME);
Alter table RELATES
add constraint FK_RELATES_RELATES_REL_TYPE foreign key (RNAME)
         references REL_TYPE (RNAME);
Alter table RELATES
add constraint FK_RELATES_RELATES2_ENTITY_T foreign key (ENAME)
         references ENTITY_TYPE (ENAME);
	

--ATTRIBUTE TYPE TABLE	
insert into attr_type values ('a', 'y');
insert into attr_type values ('d', 'y');
insert into attr_type values ('b', 'y');
insert into attr_type values('f','y');
insert into attr_type values('k','y');
insert into attr_type values('c','y');
insert into attr_type values('m','y');
insert into attr_type values('n','y');
insert into attr_type values('g','y');
insert into attr_type values('j','y');

select * from attr_type;
ANAME                          M
------------------------------ -
a                              y
d                              y
b                              y
f                              y
k                              y
m                              y
n                              y
g                              y
j                              y
7 rows selected.

--DERIVES TABLE
insert into derives values('k','f','char');
 select * from derives;
ANAME                          BASE_ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
k                              f
char

--CONTAINS TABLE
insert into contains values('a','e1','char','y','primary');
insert into contains values('d','e2','char','y','primary');
insert into contains values('b','e3','char','y','primary');
insert into contains values('f','e4','char','y','primary');
insert into contains values('c','e3','char','N','derived');
insert into contains values('k','e4','char','N','derived');
insert into contains values('g','e5','char','N','child');
insert into contains values('j','e6','char','N','child');
insert into contains values('m','e3','char','N','contained');
insert into contains values('n','e3','char','N','contained');
 
 
 select * from contains; 
 ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
n                              e3
char                           N contained

m                              e3
char                           N contained


--RELATES TABLE
insert into relates (rname, ename, role) values ('r1', 'e1', 'AD');
insert into relates (rname, ename, role) values ('r1', 'e2', 'DE');
insert into relates (rname, ename, role) values ('r2', 'e2', 'MO');
insert into relates (rname, ename, role) values ('r3', 'e2', 'e2');
insert into relates (rname, ename, role) values ('r3', 'e4', 'e4');
insert into relates (rname, ename, role) values ('r2', 'e3', 'e3');

SELECT * FROM RELATES;

RNAME                          ENAME                          ROLE       C
------------------------------ ------------------------------ ---------- -
  MIN_CARD   MAX_CARD
---------- ----------
r2                             e3                             e3


r3                             e4                             e4


r1                             e1                             AD


r1                             e2                             DE


r2                             e2                             MO


r3                             e2                             e2


--IS_USED_BY
insert into is_used_by values('r1','a','char');
insert into is_used_by values('r1','d','char');
insert into is_used_by values('r2','d','char');
insert into is_used_by values('r2','b','char');
insert into is_used_by values('r2','c','char');
insert into is_used_by values('r3','d','char');
insert into is_used_by values('r3','f','char');
insert into is_used_by values('r3','k','char');

SELECT * FROM IS_USED_BY;

RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
r1                             a
char

r1                             d
char

r2                             d
char

r2                             b
char

r2                             c
char

r3                             d
char

r3                             f
char

r3                             k
char


8 rows selected.
 
--IS_IN TABLE
insert into is_in values('m','c','char');
insert into is_in values('n','c','char');

SELECT * FROM IS_IN;

ANAME                          COMPOSITE_ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
g                              a
char

j                              a
char 
 --ENTITY TYPE
insert into entity_type values ('e1', 'p');
insert into entity_type values ('e2', 'p');
insert into entity_type values ('e3', 'p');
insert into entity_type values ('e4', 'p');
insert into entity_type values ('e5', 'p');
insert into entity_type values ('e6', 'p');

select * from entity_type; 
ENAME                          TYPE
------------------------------ --------------------
e1                             p
e2                             p
e3                             p
e4                             p
e5                             c
e6                             c

6 rows selected.

--REL_TYPE

insert into rel_type values ('r2','2');
insert into rel_type values ('r1','2');
insert into rel_type values ('r3','2');

SELECT * FROM REL_TYPE;

RNAME                          TYPE
------------------------------ --------------------
r2                             2
r1                             2
r3                             2

--SPECIALIZATION TABLE
INSERT INTO SPECIALIZATION VALUES('ISA','e1','Y','Y');
  
 SQL> SELECT * FROM SPECIALIZATION;

SNAME                          ENAME                          T O
------------------------------ ------------------------------ - -
ISA                            e1                             Y Y


--SUB TABLE
insert into sub values('e5','ISA');
insert into sub values('e6','ISA');

SQL> SELECT * FROM SUB;

ENAME                          SNAME
------------------------------ ------------------------------
e5                             ISA
e6                             ISA

--My Solution
select listagg(r3.ename,',')
within group(order by r3.rname) as Entities
from relates r3 inner join relates r4
on r3.rname=r4.rname
and
exists
( 
select distinct r1.rname,r1.ename
from relates r1,relates r2
where r1.ename=r2.ename
)
and
r3.ename<>r4.ename
group by r3.rname;

--Surbhi's Solution

select distinct entity2,entity4
from
(
select r1.rname as Rel1,r1.ename as Entity1,r2.ename as Entity2
from relates r1,relates r2
where r1.rname=r2.rname
and
r1.ename!=r2.ename)
join
(
select r3.rname as rel3,r3.ename as entity3,r4.ename as entity4
from relates r3,relates r4
where r3.rname=r4.rname
and
r3.ename!=r4.ename)
on entity1!=entity3
where entity2!=entity4;

--Query 4
 SQL> select sname,s.ename,c.aname
  2  from specialization s,contains c
  3   where c.ename=s.ename;

SNAME                          ENAME                          ANAME
------------------------------ ------------------------------ -----------------
------------
ISA                            e1                             a

--Query 5
SQL>  select sname,s.ename,c.aname
  2   from sub s,contains c
  3   where c.ename=s.ename;

SNAME                          ENAME                          ANAME
------------------------------ ------------------------------ ------------------
------------
ISA                            e5                             g
ISA                            e6                             j
 
--Query 3

 select distinct r.rname,c.ename
 from relates r,contains c,rel_type r1
 where c.ename
 in
 (
 select ename
 from contains 
 where r.ename=contains.ename
 group by ename
 having count(ename)>2
 )
 and type=2;

RNAME                          ENAME
------------------------------ ------------------------------
r2                             e3
 

--Query 1
select distinct r1.ename as Ename1,r4.ename as ename2
from relates r1
inner join
relates r2
on
r1.rname=r2.rname
inner join
relates r3
on r2.ename=r3.ename
inner join
relates r4
on
r3.rname=r4.rname
where r3.ename<r2.ename;