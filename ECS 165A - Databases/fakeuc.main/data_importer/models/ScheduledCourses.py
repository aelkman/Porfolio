from .model import Model


class ScheduledCourses(Model):
    TABLE_NAME = 'SCHEDULED_COURSES'
    fields = ('('
              ' CID int,'
              ' CRSE int,'
              ' SUBJ VARCHAR(15),'
              ' SEC int,'
              ' TERM NUMERIC(32,8),'
              ' PRIMARY KEY(CID, SEC, TERM)'
              # ' PRIMARY KEY(CID, SEC, TERM, CRSE)'
              ');'
              )
