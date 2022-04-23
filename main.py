from dao import get_source_connection

cursor = get_source_connection()

cursor.execute('select job_title, min_salary, max_salary from jobs')

for row in cursor:
    print('row = %r' % (row,))