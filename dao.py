import configparser
import pyodbc as po
 

def get_source_connection():
    config = configparser.ConfigParser()		
    config.read("config.ini")
    login = config['LOGIN']
    server = config['SERVER']

    print(login)
    print(server)
    # Connection variables
    servername = server['servername']
    database = server['database']
    username = login['username']
    password = login['password']
    
    # Connection string
    cnxn = po.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
            servername+';DATABASE='+database+';UID='+username+';PWD=' + password)  
    cursor = cnxn.cursor()
    
    return cursor
