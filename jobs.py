import pandas as pd
import numpy as np
from datetime import datetime

from dao import get_target_connection
from dw_job_run_summary import insert_into_job_run_summary


def insert_into_jobs(table_name):

    start_time = datetime.now()
    rows_processed = 0
    status = "Success"
    error_message = ""
    error_col_id = ""

    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        rows_processed += 1

        try:
            cursor.execute("""INSERT INTO [dbo].[st_jobs] (
                                [job_id],
                                [job_title],
                                [min_salary],
                                [max_salary])
                            values(?,?,?,?)""", 
                    row.job_id, row.job_title, row.min_salary, row.max_salary)
        except Exception as e:
            status = "Fail"
            error_message = str(e)
            error_col_id = row.employee_id
            print(error_message)

            insert_into_job_run_summary(table_name, start_time, end_time=datetime.now(), rows_processed=rows_processed, 
                                        status=status, error_message=error_message, col_id=error_col_id, job_run_id=0)
    
    if status == "Success":
        insert_into_job_run_summary(table_name, start_time, end_time=datetime.now(), rows_processed=rows_processed, 
                                    status=status, error_message=error_message, col_id=error_col_id, job_run_id=0)

    cnxt.commit()
    cursor.close()
    cnxt.close()
