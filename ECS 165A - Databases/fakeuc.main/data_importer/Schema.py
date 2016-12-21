from data_importer.models.Students import Students
from data_importer.models.StudentStatus import StudentStatus
from data_importer.models.Courses import Courses
from data_importer.models.ScheduledCourses import ScheduledCourses
from data_importer.models.Enrolled import Enrolled
from data_importer.models.Meeting import Meeting
from data_importer.models.Rooms import Rooms
from data_importer.pginterface import PgInterface


class Schema():
    pg = None
    schema = 'STUDENTCOURSEDB'
    sqlquery = ''
    s = Students()
    ss = StudentStatus()
    c = Courses()
    sc = ScheduledCourses()
    m = Meeting()
    e = Enrolled()
    rooms = Rooms()

    def __init__(self):
        self.pg = PgInterface()
        self.__createschema__()
        self.s.createtable(self.schema)
        self.ss.createtable(self.schema)
        self.c.createtable(self.schema)
        self.sc.createtable(self.schema)
        self.m.createtable(self.schema)
        self.e.createtable(self.schema)
        self.rooms.createtable(self.schema)

    def __createschema__(self):
        cur = self.pg.getcursor()
        self.sqlquery = ('CREATE SCHEMA IF NOT EXISTS ' + self.schema + ';')
        print(self.sqlquery)
        cur.execute(self.sqlquery)
        self.pg.commit()

