from data_importer.models.model import Model


class Courses(Model):
    TABLE_NAME = 'COURSES'
    fields = ('('
              ' SUBJ varchar(15),'
              ' CRSE int,'
              ' UNITS_MIN int,'
              ' UNITS_MAX int,'
              ' PRIMARY KEY(SUBJ, CRSE)'
              ');'
              )
