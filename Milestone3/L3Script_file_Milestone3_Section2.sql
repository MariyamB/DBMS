-- capture the results into a text file to print later
--
spool C:\Users\kochu\Downloads\Steps\Steps\resultsSec2.txt

-- setup the width and height of the page to print
--
set linesize 80;
set pagesize 64;

-- Set echo on so that you can see the input as well in the spool file
set echo on;

--
-- Team Number: 4
-- Team Members: Zolboo Tsogbayar, Mariyam George, Helai Li
-- Milestone 2
--

--
-- reduce the widths of column being printed
-- column cname format A10;
-- column bname format A15;
--
--Q1:Print the contents of the ents_2hops view. 
select * from ents_2hops;

--Q2:Print the contents of the ents_2hops_attr view.
select * from ents_2hops_attr;

--Q3:Print the contents of the rel_2ent view.
select * from  Rel_2Ent;
 
--Q4: Print the contents of the spec_super_ent view.
select * from Spec_Super_Ent;

--Q5: Print the contents of the spec_super_ents view.
select * from Spec_Sub_Ents

--
--
-- Close the spool file
spool off;

