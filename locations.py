import pandas as pd
import numpy as np

from dao import get_target_connection


def insert_into_locations(table_name):
    cnxt = get_target_connection()
    cursor = cnxt.cursor()
    df = pd.read_csv(f"{table_name}.csv")
    df = df.fillna(np.nan).replace([np.nan], [None]) 

    for index, row in df.iterrows():
        cursor.execute("""INSERT INTO [dbo].[st_locations] (
            	            [location_id],
                            [street_address],
                            [postal_code],
                            [city],
                            [state_province],
                            [country_id])
                        values(?,?,?,?,?,?)""", 
                row.location_id, row.street_address, row.postal_code,
                row.city, row.state_province, row.country_id)
    cnxt.commit()
    cursor.close()
    cnxt.close()
