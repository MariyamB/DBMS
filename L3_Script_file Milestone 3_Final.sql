

--1.Print the name of relationships and the entities they relate for those relationships 
--that all entities they connect to have a pkey. 

select rel1.RNAME,rel1.ename
from RELATES rel1 left join CONTAINS con1
on rel1.ENAME=con1.ENAME
where lower(con1.IS_KEY) = 'y'
and lower(con1.KEY_TYPE) = 'primary'
and rel1.rname
not in
(
select rel.RNAME
from RELATES rel left join CONTAINS con
on rel.ENAME=con.ENAME
where lower(con.IS_KEY) = 'y'
and lower(con.KEY_TYPE) = 'primary'
group by rel.rname
having count(rel.rname)!=2
);


--2.Print the relationship name and the entities they relate for those relationships 
--tthat have degreee 3.
select distinct contains.ename,aname,r1.rname
from contains,relates r1
where r1.rname
in
(
select rname from
relates
group by rname
having count(rname)=3)
and
r1.ename=contains.ename;

 
--3.

select distinct e2h.ent2
from ents_2hops e2h
join contains c
on e2h.related_entity=c.ename
join attr_type a
where lower(e2h.ent1)='course'
and lower(a.multi_valued)='y'
or lower(c.data_type)='date');

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

--5.
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
--and the subtype entity attribute names (one line per entity and attribute combination). 

select spe.SNAME,con.ENAME,con.ANAME 
from sub spe left join CONTAINS con 
on spe.ENAME=con.ENAME;

--Surbhi's Solution
Create view Ents_2hops_attr as
select distinct e2,e4,aname
from (select distinct e2,e4,contains.aname
from (select distinct e2,e4 from
(select r1.ename as e1,r2.ename as e2 from relates
r1,relates r2
where r1.rname=r2.rname
and
r1.ename!=r2.ename)
inner join
(select r3.ename as e3,r4.ename as e4
from relates r3,relates r4
where r3.rname=r4.rname
and
r3.ename!=r4.ename)
on  e1=e3
where e2<e4
order by e2)
left outer join
contains
on
contains.ename=e2
or contains.ename=e4
order by e2);

Create view Ents_2hops as
select distinct e2,e4
from (select distinct e2,e4 from
(select r1.ename as e1,r2.ename as e2 from relates
r1,relates r2
where r1.rname=r2.rname
and
r1.ename!=r2.ename)
inner join
(select r3.ename as e3,r4.ename as e4
from relates r3,relates r4
where r3.rname=r4.rname
and
r3.ename!=r4.ename)
on  e1=e3
where e2<e4
order by e2);





