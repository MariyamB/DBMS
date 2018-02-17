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
insert into attr_type values ('SSN', 'n');
insert into attr_type values ('DOB', 'n');
insert into attr_type values ('Street', 'y');
insert into attr_type values('City','y');
insert into attr_type values('Zip','y');
insert into attr_type values('State','y');
insert into attr_type values('age','n');
insert into attr_type values('Name','y');
insert into attr_type values('FName','n');
insert into attr_type values('LName','n');
insert into attr_type values('Minit','n');
insert into attr_type values('Salary','y');
insert into attr_type values('Is_Tenured','y');
insert into attr_type values('Date','n');
insert into attr_type values('Title','n');
insert into attr_type values('Amt','n');
insert into attr_type values('Dname','y');
insert into attr_type values('No_Of_Faculty','y');
insert into attr_type values('C#','n');
insert into attr_type values('CName','n');
insert into attr_type values('rm','n');
insert into attr_type values('Date','n');
insert into attr_type values('Sec#','n');
insert into attr_type values('Degree','y');
insert into attr_type values('Date','y');
insert into attr_type values('Grade','y');

--DERIVES TABLE
insert into derives values('FName','Name','char');
insert into derives values('LName','Name','char');
insert into derives values('Minit','Name','char');
insert into derives values('age','DOB','char');

--CONTAINS TABLE
--Person
insert into contains values('Street','person','char','N','attribute');
insert into contains values('City','person','varchar','N','attribute');
insert into contains values('State','person','varchar','N','attribute');
insert into contains values('Zip','person','int','N','attribute');
insert into contains values('SSN','person','int','Y','primary');
insert into contains values('DOB','person','varchar','N','attribute');
insert into contains values('age','person','int','N','derived');
insert into contains values('Name','person','varchar','N','attribute');
insert into contains values('FName','person','varchar','N','contained');
insert into contains values('Minit','person','varchar','N','contained');
insert into contains values('LName','person','varchar','N','contained');
--faculty
insert into contains values('Salary','faculty','char','N','attribute');
insert into contains values('Is_Tenured','faculty','varchar','N','attribute');
--student
insert into contains values('Degree','student','varchar','N','attribute');
--section
insert into contains values('Dare','Section','int','N','attribute');
insert into contains values('Sec#','Section','int','Y','primary');
--room
insert into contains values('rm','Room','varchar','N','attribute');
--course
insert into contains values('C#','Course','int','N','derived');
insert into contains values('CName','Course','varchar','N','attribute');
--department
insert into contains values('Dname','Department','varchar','N','contained');
insert into contains values('No_Of_Faculty','Department','varchar','N','contained');
--grant
insert into contains values('Date','Grant','varchar','N','contained');
insert into contains values('Title','Grant','varchar','N','contained');
insert into contains values('Amt','Grant','varchar','N','contained');
--resgisters for
insert into contains values('Date','reg_for','varchar','N','contained');
insert into contains values('Grade','reg_for','varchar','N','contained');
 
--RELATES TABLE
insert into relates (rname, ename, role) values ('advices', 'person', '1`');
insert into relates (rname, ename, role) values ('advices', 'grad_student', 'M');
insert into relates (rname, ename, role) values ('advices', 'Grant', 'M');
insert into relates (rname, ename, role) values ('teaches', 'faculty', '1');
insert into relates (rname, ename, role) values ('advices', 'Course', 'M');
insert into relates (rname, ename, role) values ('chairs', 'faculty', '1');
insert into relates (rname, ename, role) values ('chairs', 'Department', '1');
insert into relates (rname, ename, role) values ('works_in', 'faculty', 'M');
insert into relates (rname, ename, role) values ('works_in', 'Department', '1');
insert into relates (rname, ename, role) values ('offers', 'Department', 'M');
insert into relates (rname, ename, role) values ('offers', 'Course', 'M');
insert into relates (rname, ename, role) values ('has', 'Course', '1');
insert into relates (rname, ename, role) values ('has', 'Section', 'M');
insert into relates (rname, ename, role) values ('is_held_in', 'Section', 'M');
insert into relates (rname, ename, role) values ('is_held_in', 'Room', '1');
insert into relates (rname, ename, role) values ('registers_for', 'Student', 'M');
insert into relates (rname, ename, role) values ('registers_for', 'Section', 'M');
insert into relates (rname, ename, role) values ('contains', 'Grant', 'M');
insert into relates (rname, ename, role) values ('contains', 'Grant', '1');

--IS_USED_BY
insert into is_used_by values('advices','Salary','char');
insert into is_used_by values('advices','Is_tentured','char');
insert into is_used_by values('advices','Date','char');
insert into is_used_by values('advices','Ttile','char');
insert into is_used_by values('advices','Amt','char');
insert into is_used_by values('chairs','Salary','char');
insert into is_used_by values('chairs','Is_Tenured','char');
insert into is_used_by values('chairs','Dname','char');
insert into is_used_by values('chairs','No_Of_Faculty','char');
insert into is_used_by values('works_in','Salary','char');
insert into is_used_by values('works_in','Is_tentured','char');
insert into is_used_by values('works_in','Dname','char');
insert into is_used_by values('works_in','No_Of_Faculty','char');
insert into is_used_by values('teaches','Salary','char');
insert into is_used_by values('teaches','Is_tentured','char');
insert into is_used_by values('teaches','C#','char');
insert into is_used_by values('teaches','CName','char');
insert into is_used_by values('offers','Dname','char');
insert into is_used_by values('offers','No_Of_Faculty','char');
insert into is_used_by values('offers','C#','char');
insert into is_used_by values('offers','CName','char');
insert into is_used_by values('has','C#','char');
insert into is_used_by values('has','CName','char');
insert into is_used_by values('has','Sec#','char');
insert into is_used_by values('has','Date','char');
insert into is_used_by values('is_held_in','Sec#','char');
insert into is_used_by values('is_held_in','Date','char');
insert into is_used_by values('is_held_in','rm','char');
insert into is_used_by values('registers_for','Sec#','char');
insert into is_used_by values('registers_for','Date','char');
insert into is_used_by values('registers_for','Degree','char');

--IS_IN TABLE
insert into is_in values('FName','Name','char');
insert into is_in values('LName','Name','char');
insert into is_in values('Minit','Name','char');

 --ENTITY TYPE
insert into entity_type values ('person', 'p');
insert into entity_type values ('faculty', 'p');
insert into entity_type values ('student', 'p');
insert into entity_type values ('grad_student', 'p');
insert into entity_type values ('UG_student', 'p');
insert into entity_type values ('Grant', 'p');
insert into entity_type values ('department', 'p');
insert into entity_type values ('Room', 'p');
insert into entity_type values ('Section', 'p');
insert into entity_type values ('Course', 'p');

--REL_TYPE
insert into rel_type values ('advices','3');
insert into rel_type values ('owns','2');
insert into rel_type values ('teaches','2');
insert into rel_type values ('chairs','2');
insert into rel_type values ('works_in','2');
insert into rel_type values ('offers','2');
insert into rel_type values ('consists','2');
insert into rel_type values ('has','2');
insert into rel_type values ('is_held_in','2');
insert into rel_type values ('registers_for','2');
insert into rel_type values ('contains', '2');

--SPECIALIZATION TABLE
INSERT INTO SPECIALIZATION VALUES('ISA','person','Y','Y');
  INSERT INTO SPECIALIZATION values('must_be','student','Y','Y');

--SUB TABLE
insert into sub values('faculty','ISA');
insert into sub values('student','ISA');
insert into sub values('grad_student','must_be');
insert into sub values('UG_student','must_be');


update contains
set data_type='numer(5)'
where aname='No_Of_Faculty';
 


 No_of_Faculty number(5),




 rm number(3)
 );