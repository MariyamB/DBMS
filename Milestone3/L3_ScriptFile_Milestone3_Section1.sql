-- capture the results into a text file to print later
--
spool C:\Users\kochu\Downloads\Steps\Steps\Milestone3_Section1_results.txt

-- setup the width and height of the page to print
--
set linesize 80;
set pagesize 64;

-- Set echo on so that you can see the input as well in the spool file
set echo on;

--
-- Team Number: 4
-- Team Members: Zolboo Tsogbayar, Mariyam George, Helai Li
-- Milestone 3_Section1
--
--1.Print the contensts of the entity table.
select * from entity_type;



--2.Print the contensts of the attribute table.
select * from attr_type;

 
--3.Print the contensts of the relates table.
select * from relates;
--4.Print the contensts of the contains table.
select * from contains;
--5.Print the contensts of the derives table.
select * from derives;

--6.Print the contensts of the rel_type table.
select * from rel_type;
--7.Print the contensts of the is_in table.
select * from is_in;

--8.Print the contensts of the is_used_by table.
select * from is_used_by;


--9.Print the contensts of the specialization table.
select * from specialization;

--10.Print the contensts of the sub table.

select * from sub;
--
-- reduce the widths of column being printed
-- column cname format A10;
-- column bname format A15;
--
--
-- Close the spool file
spool off;

