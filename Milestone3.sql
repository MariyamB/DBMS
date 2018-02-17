--1.Print the name of relationships and the entities they relate for those relationships 
--that all entities they connect to have a pkey. 

select rel.RNAME,rel.ENAME 
from RELATES rel left join CONTAINS con 
on rel.ENAME=con.ENAME 
where lower(con.IS_KEY) = 'y' 
and lower(con.KEY_TYPE) = 'primary';

--2.Print the relationship name and the entities they relate for those relationships 
--that have degree 2 and both relationship links have cardinality of m.

select a.RNAME,a.ENAME 
from RELATES a right join (
select b.RNAME,b.CARDINALITY 
from RELATES b 
group by b.RNAME,b.CARDINALITY 
having count(*)=2 and b.CARDINALITY='M') c on a.RNAME=c.RNAME;

--3.
select a.RNAME,a.ROLE 
from RELATES a right join (
select b.RNAME 
from RELATES b 
group by b.RNAME,b.ENAME 
having count(*)>1) c on a.RNAME=c.RNAME;

--4.
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
where role='M'
group by ename
having count(role)>1
)
order by contains.ename;

--5.select distinct contains.ename,contains.aname
from relates,rel_type,contains
where
type=3
and
rel_type.rname=relates.rname
and
contains.ename=relates.ename
and
cardinality='M';

select con.ENAME,con.ANAME 
from CONTAINS con 
where lower(con.IS_KEY) = 'y' 
and lower(con.KEY_TYPE) = 'primary';

--6.Print the name of entities or relationships that have Date as the data type of one of their attributes

select con.ENAME as ENAME_OR_RNAME 
from CONTAINS con
where lower(con.DATA_TYPE) = 'date' 
union all 
select iub.RNAME 
from IS_USED_BY iub 
where lower(iub.DATA_TYPE) = 'date';

--7.Print the name of all composite attributes and their component attributes.

select ii.Composite_ANAME,ii.ANAME 
from IS_IN ii;

--8.Print the name of all entities that have one or more derived attributes,
--the name of all derived attributes and what they are driven from.

select con.ENAME,d.ANAME,d.Base_ANAME 
from CONTAINS con right join DERIVES d
on con.ANAME=d.ANAME;

--9.Print the entity name and entities it relates to for those entities 
--that participate as both the super type(s) or subtype(s) of specializations. 

select ename,count(aname) as AttributeCount
from contains where ename='person'
group by ename;

--10.Print the name of all specialization, their subtype entity, a
--nd the subtype entity attribute names (one line per entity and attribute combination). 
--For example, if we have specialization S1 with E2 as one subtype with attributes A3 and A4 and E3 
--as the other subtype with attribute A5, then you will print:

select spe.SNAME,con.ENAME,con.ANAME 
from SPECIALIZATION spe left join CONTAINS con 
on spe.ENAME=con.ENAME;


