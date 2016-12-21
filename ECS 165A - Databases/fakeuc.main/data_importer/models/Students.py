from data_importer.models.model import Model


class Students(Model):
    TABLE_NAME = 'STUDENTS'
    fields = ('  (SID int primary key,'
              '  SURNAME varchar(20),'
              '  PREFNAME varchar(30),'
              '  EMAIL varchar(39)'
              '  );'
              )
