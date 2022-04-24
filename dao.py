import configparser
import pyodbc as po
 

def get_source_connection():
    config = configparser.ConfigParser()		
    config.read("config.ini")
    db_source_config = config['DB_SOURCE']
    server = db_source_config['server']
    database = db_source_config['database']
    username = db_source_config['username']
    password = db_source_config['password']
    
    # Connection string
    cnxn = po.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
            server+';DATABASE='+database+';UID='+username+';PWD=' + password)  
    
    return cnxn


def get_target_connection():
    config = configparser.ConfigParser()		
    config.read("config.ini")
    db_source_config = config['DB_TARGET']
    server = db_source_config['server']
    database = db_source_config['database']
    username = db_source_config['username']
    password = db_source_config['password']
    
    # Connection string
    cnxn = po.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
            server+';DATABASE='+database+';UID='+username+';PWD=' + password)  
    
    return cnxn