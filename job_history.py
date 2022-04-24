import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_job_history(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        cursor.execute("""INSERT INTO [dbo].[st_job_history] (
            	            [employee_id],
                            [start_date],
                            [end_date],
                            [job_id],
                            [department_id])
                        values(?,?,?,?,?)""", 
                row.employee_id, row.start_date, row.end_date,
                row.job_id, row.department_id)
    cnxt.commit()
    cursor.close()
    cnxt.close()
