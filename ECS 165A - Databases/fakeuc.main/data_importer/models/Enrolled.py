from data_importer.models.model import Model


class Enrolled(Model):
    TABLE_NAME = 'ENROLLED'
    fields = ('('
              '    CID int ,'
              '    SEC int ,'
              '    TERM NUMERIC(32,8) ,'
              '    SEAT int ,'
              '    SID int ,'
              '    UNITS int,'
              '    GRADE varchar(4),'
              '    primary key(CID, SEC, TERM, SID)'
              '  );'
              )
