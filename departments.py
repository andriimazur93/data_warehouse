import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_departments(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        cursor.execute("""INSERT INTO [dbo].[st_departments] (
            	            [department_id],
                            [department_name],
                            [manager_id],
                            [location_id])
                        values(?,?,?,?)""", 
                row.department_id, row.department_name, row.manager_id, row.location_id)
    cnxt.commit()
    cursor.close()
    cnxt.close()
