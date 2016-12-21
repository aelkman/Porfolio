from data_importer.models.model import Model


class Meeting(Model):
    TABLE_NAME = 'MEETING'
    fields = ('('
              '    CID int ,'
              '    SEC int ,'
              '    TERM NUMERIC(32,1) ,'
              '    TYPE varchar(32),'
              '    PROFESSOR varchar(32),'
              '    DAYS varchar(4),'
              '    TIME varchar(32),'
              '    TIME_BEGIN time,'
              '    TIME_END time,'
              '    BUILD varchar(5),'
              '    ROOM int'
              '    ,primary key(CID, SEC, TERM, TYPE, DAYS, TIME, BUILD, ROOM)'
              '  );'
              )
             # '('
             #  '    CID int references STUDENTCOURSEDB.SCHEDULED_COURSES(CID),'
             #  '    SEC int references STUDENTCOURSEDB.SCHEDULED_COURSES(SEC),'
             #  '    TERM int references STUDENTCOURSEDB.SCHEDULED_COURSES(TERM),'
             #  '    TYPE varchar(10),'
             #  '    PROFESSOR varchar(30),'
             #  '    DAYS varchar(4),'
             #  '    TIME_BEGIN time,'
             #  '    TIME_END time,'
             #  '    BUILD varchar(5),'
             #  '    ROOM int'
             #  '  );'
             #  )