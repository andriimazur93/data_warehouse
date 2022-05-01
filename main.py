from traceback import TracebackException
from dao import get_source_connection, get_target_connection
import pandas as pd
import countries as con
import departments
import employees as emp
import job_history
import locations
import jobs
import regions
from dw_job_run_summary import insert_into_job_run_summary
from datetime import datetime


target_tables = [
    "countries",
    "departments",
    "employees",
    "job_history",
    "locations",
    "regions",
    "jobs",
]


def get_job_run_id():
    sql_query = "select max(job_run_id) from [DW].[dbo].[dw_job_run_summary]"
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    cursor.execute(sql_query)
    
    for row in cursor:
        job_run_id = row[0]

    if job_run_id is None:
        job_run_id = 1
    else:
        job_run_id += 1

    print(f"Value of job_run_id is {job_run_id}")

    cursor.close()
    cnxt.close()

    return job_run_id

def get_last_job_run_date(table_name):

    sql_query = f"""
        select cast(max(start_date_time) as date) as last_job_run_date
        from dw_job_run_summary
        where job_run_id in (
            select max(job_run_id) 
            from dw_job_run_summary
            where tablename = '{table_name}'
            and status = 'Success'
        )
        and tablename = '{table_name}'
        """


    print(sql_query)
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    cursor.execute(sql_query)
    
    for row in cursor:
        last_job_run_date = row[0]

    if last_job_run_date is None:
        last_job_run_date = '1900-01-01'

    print(f"Value of last_job_run_date is {last_job_run_date}")

    cursor.close()
    cnxt.close()

    return last_job_run_date


def truncate_table(table_name):
    sql_query = f"truncate table dbo.st_{table_name}"
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    cursor.execute(sql_query)
    cnxt.commit()
    cursor.close()
    cnxt.close()

def fetch_records(table_name, last_job_run_date):
    if table_name == 'employees':
        sql_query = f"""
            select *
            from {table_name}
            where (
                created_on >= DateAdd(dd, -3, '{last_job_run_date}')
                or updated_on >= DateAdd(dd, -3, '{last_job_run_date}')
            )
        """
    elif table_name == 'departments':
        sql_query = f"""
            select * 
            from departments 
            where department_id in (
                select department_id
                from employees
                where (
                    created_on >= DateAdd(dd, -3, '{last_job_run_date}')
                    or updated_on >= DateAdd(dd, -3, '{last_job_run_date}')
                )
            )
        """
    else:
        sql_query = f"""
            select *
            from {table_name}
        """
    print(sql_query)
    cnxn = get_source_connection()
    cursor = cnxn.cursor()
    cursor.execute(sql_query)

    hr_list = []
    header = [single_name[0] for single_name in cursor.description]
    for row in cursor:
        hr_list.append([elem for elem in row])

    pd.DataFrame(hr_list, columns=header).to_csv(f"{table_name}.csv", index=False)

    cursor.close()
    cnxn.close()


def execute_procedures():
    cnxn = get_source_connection()
    cursor = cnxn.cursor()
    
    sql_query = "exec dw.dbo.load_ods"
    cursor.execute(sql_query)
    
    sql_query = "exec dw.dbo.load_dim_employees"
    cursor.execute(sql_query)
    
    sql_query ="exec dw.dbo.load_fact_hr"
    cursor.execute(sql_query)

    cursor.close()
    cnxn.close()


def insert_records(table_name, job_run_id):
    try:
        df = pd.read_csv(f"{table_name}.csv")
        
        if table_name == 'countries':
            con.insert_into_countries(df, table_name, job_run_id)
        elif table_name == 'departments':
            departments.insert_into_departments(df, table_name, job_run_id)
        elif table_name == 'employees':
            emp.insert_into_employees(df, table_name, job_run_id)
        elif table_name == 'job_history':
            job_history.insert_into_job_history(df, table_name, job_run_id)
        elif table_name == 'locations':
            locations.insert_into_locations(df, table_name, job_run_id)
        elif table_name == 'jobs':
            jobs.insert_into_jobs(df, table_name, job_run_id)
        elif table_name == 'regions':
            regions.insert_into_regions(df, table_name, job_run_id)
    except Exception as e:
        insert_into_job_run_summary(table_name, datetime.now(), end_time=datetime.now(), rows_processed=0, 
                            status="Fail", error_message=str(e), col_id="", job_run_id=job_run_id)


def main():
    job_run_id = get_job_run_id()

    for table_name in target_tables:
        try:
            last_job_run_date = get_last_job_run_date(table_name)
            fetch_records(table_name, last_job_run_date)
            truncate_table(table_name)
            insert_records(table_name, job_run_id)
            print(table_name)
        except Exception as e:
            print(e)

    execute_procedures()


if __name__ == "__main__":
    main()
