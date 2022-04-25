from dao import get_target_connection


def insert_into_job_run_summary(table_name, start_time, end_time, rows_processed, status, error_message, col_id, job_run_id):

    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    try:
        cursor.execute("""INSERT INTO [dbo].[dw_job_run_summary] (
                            [tablename],
                            [start_date_time],
                            [end_date_time],
                            [rows_processed],
                            [status],
                            [error_message],
                            [colid],
                            [job_run_id])
                        values(?,?,?,?,?,?,?,?)""", 
                table_name, start_time, end_time, rows_processed, status, error_message, col_id, job_run_id
                )

    except Exception as e:
        print(e, table_name)

    cnxt.commit()
    cursor.close()
    cnxt.close()
