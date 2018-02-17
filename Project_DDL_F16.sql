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