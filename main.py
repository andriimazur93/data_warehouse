from dao import get_source_connection, get_target_connection
import pandas as pd
import countries as con
import departments
import employees as emp
import job_history
import locations
import jobs
import regions


target_tables = [
    "countries",
    "departments",
    "employees",
    "job_history",
    "locations",
    "regions",
    "jobs",
]

def truncate_table(table_name):
    sql_query = f"truncate table dbo.st_{table_name}"
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    cursor.execute(sql_query)
    cnxt.commit()
    cursor.close()
    cnxt.close()

def fetch_records(table_name):
    sql_query = f"""
        select *
        from {table_name}
    """
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


def insert_records(table_name):
    if table_name == 'countries':
        con.insert_into_countries(table_name)
    elif table_name == 'departments':
        departments.insert_into_departments(table_name)
    elif table_name == 'employees':
        emp.insert_into_employees(table_name)
    elif table_name == 'job_history':
        job_history.insert_into_job_history(table_name)
    elif table_name == 'locations':
        locations.insert_into_locations(table_name)
    elif table_name == 'jobs':
        jobs.insert_into_jobs(table_name)
    elif table_name == 'regions':
        regions.insert_into_regions(table_name)


for table_name in target_tables:
    fetch_records(table_name)
    truncate_table(table_name)
    insert_records(table_name)
    print(table_name)
