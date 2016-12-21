import psycopg2
import os

database = 'postgres'       #works on csif
#host = 'localhost'       #works on csif
port = "5432"
username = os.environ['USER']   #works on csif
#username = 'postgres'
#password = 'thevoid123'

class PgInterface:
    conn = None
    cursor = None

    def __init__(self):
        pass

    def __connect__(self):
        if self.conn is None or self.conn.closed:
            self.conn = psycopg2.connect(database=database, port=port, user=username)   #works on csif
            #self.conn = psycopg2.connect(host=host, port=port, user=username)   #works on csif
            #self.conn = psycopg2.connect(host=host, port=port, user=username, password=password)

    def getcursor(self):
        self.__connect__()
        if self.cursor is None:
            self.cursor = self.conn.cursor()
        return self.cursor

    def commit(self):
        self.conn.commit()

    def rollback(self):
        self.conn.rollback()

    def closeconnection(self):
        self.conn.close()

