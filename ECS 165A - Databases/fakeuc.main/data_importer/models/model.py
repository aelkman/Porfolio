from data_importer.pginterface import PgInterface
import time


class Model:
    pg = None
    TABLE_NAME = ''  # must define
    fields = ()  # must define
    sqlquery = ''
    schema = 'studentcoursedb'
    data = []

    def __init__(self):
        self.data = [];
        self.pg = PgInterface()

    def setcustomquery(self, q):
        self.sqlquery = q

    def load(self):
        cur = self.pg.getcursor()
        cur.execute(self.sqlquery)
        data = []
        for row in cur:
            data.append(row)
        self.pg.closeconnection()
        return data

    def loadone(self):
        cur = self.pg.getcursor()
        cur.execute(self.sqlquery)
        data = cur.fetchone()
        self.pg.closeconnection()
        return data

    def createtable(self, schema):
        cur = self.pg.getcursor()
        name = self.TABLE_NAME
        attr = self.fields
        self.schema = schema
        self.sqlquery = 'CREATE TABLE IF NOT EXISTS ' + schema + '.' + name + attr
        print("query: " + self.sqlquery)
        cur.execute(self.sqlquery)
        self.pg.commit()

    def enqueuedata(self, item):
        self.data.append(item)

    def enqueuedata_arr(self, items):
        self.data.extend(items)

    def insertdata(self):
        cur = self.pg.getcursor()
        # t = time.time()
        self.sqlquery = 'INSERT INTO ' + self.schema + '.' + self.TABLE_NAME + ' VALUES '
        for row in self.data:
            self.sqlquery += '(' + str(row).strip('[]').replace('"', "'").replace("'NULL'", 'NULL').replace("'',",'NULL,') + '),'

        if len(self.data) > 0:
            cur.execute(self.sqlquery[0:len(self.sqlquery) - 1])
            self.pg.commit()
        # print('commmit time: %.20f' % (time.time() - t))
        self.sqlquery = ''
        self.data = []
