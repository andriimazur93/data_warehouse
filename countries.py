import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_countries(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        cursor.execute("""INSERT INTO [dbo].[st_countries] (
            	            [country_id],
                            [country_name],
                            [region_id])
                        values(?,?,?)""", 
                row.country_id, row.country_name, row.region_id)
    cnxt.commit()
    cursor.close()
    cnxt.close()
