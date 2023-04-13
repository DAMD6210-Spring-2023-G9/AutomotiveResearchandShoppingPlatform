# DAMG6210  AutomotiveResearchandShoppingPlatform

#### Team members
- Zongyao Li
- Fangyu Wu
- Ming Cheng

This project has finnaly gone to this step! It now has more views and packages for better monitoring/modifying the data!

File "G9_G9_Create_Packages.sql" and files that start with "G9_G9_pkg_" and followed by a table name, are source files that used for creating the packages.
File names are self-explainatory.

Other files that starts with our name are for developing and testing purpose.

## Instruction for running the scripts:
_____
0. The wallet .zip folder is the entrance to our Oracle SQL database.
1. First connect to our database as ADMIN, password is <b>G9IsTheBestTeam</b>
2. Secondly, run the script for creating users which automatically detects if a user exists [G9_ADMIN.sql](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_ADMIN.sql)
3. Connect to the database as operator "G9" password is <b>Team9IsTheBestTeam</b> (this role creates table for convenience since it has a short schema name, and it grants all permissions to developers). To create tables and insert data, run the script under this role: [G9_G9_For_Creating_Tables.sql](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_G9_For_Creating_Tables.sql)
4. After creating the required table, it's time to create [Views(G9_G9_For_Creating_Views.sql)](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_G9_For_Creating_Views.sql) and [Triggers(G9_G9_triggers.sql)](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_G9_triggers.sql)
5. Then, still as "G9", run the script [G9_Authorization Sheet.sql](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_Authorization%20Sheet.sql) for granting permissions on tables to other roles (developer). (Authorization for Views are embedded in the Views' creating files)
6. Run the "pkg_" files to create packages for fun!
7. There are some test scripts for test purpose or playing around!

