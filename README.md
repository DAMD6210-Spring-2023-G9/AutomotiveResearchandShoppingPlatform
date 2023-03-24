# DAMG6210  AutomotiveResearchandShoppingPlatform

#### Team members
- Zongyao Li
- Fangyu Wu
- Ming Cheng

To test if our submission for Project 3 works, please follow the instruction to run the work.

Other files that starts with our name are for developing and testing purpose.

## Instruction for running the scripts:
_____
0. The wallet .zip folder is the entrance to our Oracle SQL database.
1. First connect to our database as ADMIN, password is <b>G9IsTheBestTeam</b>
2. Secondly, run the script for creating users which automatically detects if a user exists [G9_ADMIN.sql](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_ADMIN.sql)
3. Connect to the database as operator "G9" password is <b>Team9IsTheBestTeam</b> (this role creates table for convenience since it has a short schema name, and it grants all permissions to developers). To create tables and insert data, run the script under this role: [G9_G9_For_Creating_Tables.sql](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_G9_For_Creating_Tables.sql)
4. Then, still as "G9", run the script [G9_Authorization Sheet.sql](https://github.com/DAMD6210-Spring-2023-G9/AutomotiveResearchandShoppingPlatform/blob/main/G9_Authorization%20Sheet.sql) for granting permissions on tables to other roles (developer)

