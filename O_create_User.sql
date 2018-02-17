-- This command runs SQLPLUS using the currently logged in NT user
-- This file assumes that you have already connected to Oracle using SYSTEM/Password on
-- your laptop or SU/SuperUser_S1 if you are using machines in OSS333
-- 
-- Create the user
-- Edit XYZ to indicate your initials and choose a PASSWORD for this user. Needs to be 
-- at least 8 places. Do not include $ and/or @ symbols

create user XYZ profile default
identified by XYZpassword
default tablespace users
temporary tablespace temp
quota unlimited on users
account unlock;

commit;

-- Grant this user DBA to the database
--

GRANT connect, resource to XYZ;
GRANT create view to XYZ;




