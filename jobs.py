import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_jobs(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        cursor.execute("""INSERT INTO [dbo].[st_jobs] (
                            [job_id],
                            [job_title],
                            [min_salary],
                            [max_salary])
                        values(?,?,?,?)""", 
                row.job_id, row.job_title, row.min_salary, row.max_salary)
    cnxt.commit()
    cursor.close()
    cnxt.close()
