import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_regions(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        cursor.execute("""INSERT INTO [dbo].[st_regions] (
            	            [region_id],
                            [region_name])
                        values(?,?)""", 
                row.region_id, row.region_name)
    cnxt.commit()
    cursor.close()
    cnxt.close()
