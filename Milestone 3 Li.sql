--Section 1

--Entity Type
SQL> select * from entity_type;

ENAME                          TYPE
------------------------------ --------------------
faculty                        p
student                        p
grad_student                   p
UG_student                     p
Section                        p
Room                           p
person                         p
Course                         p
Department                     p
Grant                          p
reg_for                        p

--Attribute type
SQL> select * from attr_type;

ANAME                          M
------------------------------ -
SSN                            N
DOB                            N
Street                         Y
City                           Y
State                          Y
Zip                            Y
Salary                         N
Is_Tenured                     N
Degree                         Y
Grade                          Y
Sec#                           Y

ANAME                          M
------------------------------ -
C#                             Y
CName                          Y
No_Of_Faculty                  Y
Dname                          Y
Date                           n
Title                          n
Amt                            n
Name                           y
FName                          n
LName                          n
Minit                          n

ANAME                          M
------------------------------ -
age                            n
rm                             n

24 rows selected.

--REl_type
SQL> select * from rel_type;

RNAME                          TYPE
------------------------------ --------------------
advices                        3
owns                           2
teaches                        2
chairs                         2
works_in                       2
offers                         2
consists                       2
has                            2
is_held_in                     2
registers_for                  2

10 rows selected.

--RELATES
SQL> select * from relates;

RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
advices                        faculty                        faculty
1

owns                           faculty                        faculty
M

teaches                        Course                         Course
M


RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
consists                       Grant                          CG
M

consists                       Grant                          PG
1

advices                        grad_student                   grad
M


RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
teaches                        faculty                        faculty
1

chairs                         faculty                        faculty
1

works_in                       faculty                        faculty
M


RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
registers_for                  student                        student
M

advices                        Grant                          Grant
M

chairs                         Department                     Department
1


RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
works_in                       Department                     Department
1

offers                         Department                     Department
M

offers                         Course                         Course
M


RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
has                            Course                         Course
1

has                            Section                        Section
M

is_held_in                     Section                        Section
M


RNAME                          ENAME                          ROLE
------------------------------ ------------------------------ ----------
CARDINALIT   MIN_CARD   MAX_CARD
---------- ---------- ----------
is_held_in                     Room                           Room
1

registers_for                  Section                        Section
M


20 rows selected.

--CONTAINS
SQL> select * from contains;

ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
City                           person
varchar(10)                    N attribute

State                          person
char(2)                        N attribute

Zip                            person
number(5)                      N attribute


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
SSN                            person
number(9)                      Y primary

DOB                            person
Date                           N attribute

Street                         person
varchar(10)                    N attribute


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
Name                           person
varchar(21)                    N attribute

Minit                          person
char(1)                        N contained

LName                          person
varchar(10)                    N contained


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
FName                          person
varchar(10)                    N contained

Salary                         faculty
decimal(10,2)                  N attribute

Is_Tenured                     faculty
boolean                        N attribute


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
Degree                         student
char(3)                        N attribute

Date                           Section
Date                           N attribute

C#                             Course
char(5)                        Y derived


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
CName                          Course
varchar(10)                    N attribute

Dname                          Department
varchar(10)                    Y contained

No_Of_Faculty                  Department
numer(5)                       N contained


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
Date                           Grant
Date                           N contained

Title                          Grant
char(100)                      Y contained

Amt                            Grant
decimal(20,2)                  N contained


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
Date                           reg_for
Date                           N contained

Grade                          reg_for
varchar                        N contained

age                            person
number(4)                      N derived


ANAME                          ENAME
------------------------------ ------------------------------
DATA_TYPE                      I KEY_TYPE
------------------------------ - ----------
Sec#                           Section
char(7)                        Y primary

rm                             Room
numer(3)                       N attribute


26 rows selected.
--Derives
SQL> select * from derives;

ANAME                          BASE_ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
No_Of_Faculty                  Name
number(5)

age                            DOB
char
--IS_IN
SQL> select * from is_in;

ANAME                          COMPOSITE_ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
FName                          Name
varchar(10)

LName                          Name
varchar(10)

Minit                          Name
char(1)
--IS_USED_BY
SQL> select * from is_used_by;

RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
advices                        Is_Tenured
char(10)

advices                        Title
char(10)

teaches                        Is_Tenured
char(10)


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
works_in                       Title
char(10)

advices                        Salary
char

advices                        Date
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
advices                        Amt
char

chairs                         Salary
char

chairs                         Dname
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
chairs                         No_Of_Faculty
char

works_in                       Salary
char

works_in                       Dname
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
works_in                       No_Of_Faculty
char

teaches                        Salary
char

teaches                        C#
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
teaches                        CName
char

offers                         Dname
char

offers                         No_Of_Faculty
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
offers                         C#
char

offers                         CName
char

has                            C#
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
has                            CName
char

has                            Sec#
char

has                            Date
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
is_held_in                     Sec#
char

is_held_in                     Date
char

chairs                         Is_Tenured
char


RNAME                          ANAME
------------------------------ ------------------------------
DATA_TYPE
------------------------------
is_held_in                     rm
char


28 rows selected.
--SUB
SQL> select * from sub;

ENAME                          SNAME
------------------------------ ------------------------------
UG_student                     must_be
faculty                        ISA
grad_student                   must_be
student                        ISA
--SPECIALIZATION
SQL> select * from specialization;

SNAME                          ENAME                          T O
------------------------------ ------------------------------ - -
ISA                            person                         n Y
must_be                        student                        n N


--Section 2

SQL> select * from ents_2hops;

E2                             E4
------------------------------ ------------------------------
Course                         Grant
Grant                          grad_student
Course                         Department
Department                     Section
Section                        faculty
Course                         faculty
Department                     grad_student
Course                         grad_student
faculty                        grad_student
Course                         Room
Department                     faculty

E2                             E4
------------------------------ ------------------------------
Department                     Grant
Grant                          faculty

SQL> select * from ents_2hops_attr;

E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
faculty                        grad_student
Is_Tenured

Course                         faculty
C#

Section                        faculty
Date


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
faculty                        grad_student
Salary

Department                     Grant
Amt

Course                         Grant
Date


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Course                         Department
C#

Department                     Section
Dname

Department                     grad_student
Dname


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Department                     grad_student
No_Of_Faculty

Department                     Section
No_Of_Faculty

Department                     faculty
No_Of_Faculty


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Department                     Grant
Date

Department                     Grant
No_Of_Faculty

Department                     Grant
Title


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Course                         grad_student
C#

Course                         Grant
CName

Grant                          faculty
Date


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Grant                          faculty
Is_Tenured

Grant                          faculty
Title

Course                         Department
CName


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Department                     Section
Sec#

Course                         Room
C#

Course                         Room
rm


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Department                     faculty
Dname

Department                     faculty
Is_Tenured

Department                     faculty
Salary


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Course                         Grant
C#

Course                         faculty
Is_Tenured

Course                         Department
No_Of_Faculty


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Section                        faculty
Is_Tenured

Department                     Grant
Dname

Course                         Grant
Title


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Grant                          grad_student
Amt

Course                         faculty
Salary

Course                         Room
CName


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Course                         Grant
Amt

Course                         Department
Dname

Department                     Section
Date


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Section                        faculty
Sec#

Course                         grad_student
CName

Grant                          grad_student
Date


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Grant                          grad_student
Title

Grant                          faculty
Amt

Grant                          faculty
Salary


E2                             E4
------------------------------ ------------------------------
ANAME
------------------------------
Course                         faculty
CName

Section                        faculty
Salary


47 rows selected.


--Section 3


--1.Print the name of relationships and the entities they relate for those relationships 
--2 of the entities they connect to have a pkey. 


select rel.rname,rel.ename
from relates left outer join contains con
on rel.ename=con.ename
where lower(con.is_key) = 'y'
and lower(con.keytype) = 'primary'
group by ename
having count role=2;
 

--2.Print the entity names and the attributes of the entities that they are connected to relationships
--that have degree 3. 

select con.ename,con.aname 
from contains right outer join (
select rname
from relates
group by rname
having count(aname)=3); 

--3.



--4.Print the name of an entity and its attribute names if the entry has two attributes
-- and the enity oarticipates with cardinality of m in 2 of the relationships it connects to.
select distinct ename,aname
from contains
where
contains.ename in
(
select ename
from contains
group by ename
having count(aname)=2
intersect
select ename
from relates
where cardinality='M'
group by ename
having count(role)>1
)
order by contains.ename;

--5. Print the name of each entity and the attributes of the entities that participate in 
--exactly 3 relationships with cardinality of 'M'
select distinct contains.ename,contains.aname
from relates,rel_type,contains
where
type=3
and
rel_type.rname=relates.rname
and
contains.ename=relates.ename
and
cardinality='M';


--6.Print the name of entities or relationships that have Date as the data type of one of one or more 
--of their attributes

select con.ENAME as ENAME_OR_RNAME 
from CONTAINS con
where lower(con.DATA_TYPE) = 'date' 
union all 
select iub.RNAME 
from IS_USED_BY iub 
where lower(iub.DATA_TYPE) = 'date';

--7.Print the name of all entities that have one or more derived attributes,
--the name of all derived attributes and what they are driven from.

select con.ENAME,d.ANAME,d.Base_ANAME 
from CONTAINS con right join DERIVES d
on con.ANAME=d.ANAME;

--8.Print the name of all composite attributes and their component attributes.

select ii.Composite_ANAME,ii.ANAME 
from IS_IN ii;



--9. Print the number of attributes the entity Person has?  

select ename,count(aname) as AttributeCount
from contains where ename='person'
group by ename;

--10.Print the name of all specialization, their subtype entity, a
--nd the subtype entity attribute names (one line per entity and attribute combination). 


select spe.SNAME,con.ENAME,con.ANAME 
from sub spe left join CONTAINS con 
on spe.ENAME=con.ENAME;



