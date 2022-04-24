import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_employees(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        try:
            cursor.execute("""INSERT INTO [dbo].[st_employees] (
                                [employee_id],
                                [first_name],
                                [last_name],
                                [email],
                                [phone_number],
                                [hire_date],
                                [job_id],
                                [salary],
                                [commission_pct],
                                [manager_id],
                                [department_id])
                            values(?,?,?,?,?,?,?,?,?,?,?)""", 
                    row.employee_id, row.first_name, row.last_name,
                    row.email, str(row.phone_number), row.hire_date,
                    row.job_id, row.salary, row.commission_pct, 
                    row.manager_id, row.department_id)

        except Exception as e:
            print(e, table_name)

    cnxt.commit()
    cursor.close()
    cnxt.close()
