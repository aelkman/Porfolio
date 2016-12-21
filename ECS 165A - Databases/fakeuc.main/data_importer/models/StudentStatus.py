from .model import Model


class StudentStatus(Model):
    TABLE_NAME = 'STUDENT_STATUS'
    fields = ("""(
                  SID int,
                  TERM NUMERIC(32,8),
                  LEVEL varchar(2),
                  CLASS varchar(2),
                  MAJOR varchar(4),
                  STATUS varchar(3),
                  PRIMARY KEY(SID, TERM)
                );"""
              )
