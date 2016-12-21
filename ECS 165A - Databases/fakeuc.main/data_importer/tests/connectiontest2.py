from data_importer.pginterface import PgInterface

pg = PgInterface()
cur = pg.getcursor()
cur.execute('select count(*) from freight_data')
data = cur.fetchone()
print(data)
cur.execute('create table test_table (id int);')
pg.commit()