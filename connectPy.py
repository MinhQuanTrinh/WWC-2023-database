import pyodbc
conn = pyodbc.connect('Driver={SQL Server};'
        'Server=v-1804-hcs-331;'
        'Database=wwcData_21049644;'
        'Trusted_Connection=yes;')
cursor=conn.cursor()
cursor.execute('SELECT * FROM Team')
for i in cursor:
    print(i)
SHOW GRANTS FOR 'me'@'localhost';
systemctl status mysql
GRANT ALL PRIVILEGES ON database_name.* TO 'me'@'localhost';
SET GLOBAL validate_password.policy = 0;
SET GLOBAL validate_password.policy=LOW;
UNINSTALL COMPONENT "file://component_validate_password";
grant all privileges on *.* to me@"%" identified by ".";
SHOW VARIABLES LIKE 'validate_password%';
SET GLOBAL sql_mode='NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES';
grant all privileges on wwcData_21049644.* to 'me'@'localhost' identified by 'myUserPassword';



