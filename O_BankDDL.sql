/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     							                    */
/*==============================================================*/

alter table ACCOUNT
   drop constraint FK_ACCOUNT_CONTAINS_BRANCH;

alter table ACCOUNT
   drop constraint FK_ACCOUNT_OWNS_CUSTOMER;

alter table LOAN
   drop constraint FK_LOAN_HAS_CUSTOMER;

alter table LOAN
   drop constraint FK_LOAN_IS_LOCATE_BRANCH;

drop index CONTAINS_FK;

drop index OWNS_FK;

drop table ACCOUNT cascade constraints;

drop table BRANCH cascade constraints;

drop table CUSTOMER cascade constraints;

drop index IS_LOCATED_AT_FK;

drop index HAS_FK;

drop table LOAN cascade constraints;

/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT 
(
   A#                   NUMBER(6)            not null,
   CNAME                CHAR(15)             not null,
   BNAME                CHAR(15)             not null,
   BAL                  NUMBER(10,2),
   constraint PK_ACCOUNT primary key (A#)
);

/*==============================================================*/
/* Index: OWNS_FK                                               */
/*==============================================================*/
create index OWNS_FK on ACCOUNT (
   CNAME ASC
);

/*==============================================================*/
/* Index: CONTAINS_FK                                           */
/*==============================================================*/
create index CONTAINS_FK on ACCOUNT (
   BNAME ASC
);

/*==============================================================*/
/* Table: BRANCH                                                */
/*==============================================================*/
create table BRANCH 
(
   BNAME                CHAR(15)             not null,
   ASSETS               NUMBER(10,2),
   BCITY                CHAR(15),
   constraint PK_BRANCH primary key (BNAME)
);

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table CUSTOMER 
(
   CNAME                CHAR(15)             not null,
   STREET               CHAR(30),
   CCITY                CHAR(15),
   constraint PK_CUSTOMER primary key (CNAME)
);

/*==============================================================*/
/* Table: LOAN                                                  */
/*==============================================================*/
create table LOAN 
(
   L#                   NUMBER(6)            not null,
   CNAME                CHAR(15)             not null,
   BNAME                CHAR(15)             not null,
   AMT                  NUMBER(8,2),
   constraint PK_LOAN primary key (L#)
);

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/
create index HAS_FK on LOAN (
   CNAME ASC
);

/*==============================================================*/
/* Index: IS_LOCATED_AT_FK                                      */
/*==============================================================*/
create index IS_LOCATED_AT_FK on LOAN (
   BNAME ASC
);

alter table ACCOUNT
   add constraint FK_ACCOUNT_CONTAINS_BRANCH foreign key (BNAME)
      references BRANCH (BNAME);

alter table ACCOUNT
   add constraint FK_ACCOUNT_OWNS_CUSTOMER foreign key (CNAME)
      references CUSTOMER (CNAME);

alter table LOAN
   add constraint FK_LOAN_HAS_CUSTOMER foreign key (CNAME)
      references CUSTOMER (CNAME);

alter table LOAN
   add constraint FK_LOAN_IS_LOCATE_BRANCH foreign key (BNAME)
      references BRANCH (BNAME);

