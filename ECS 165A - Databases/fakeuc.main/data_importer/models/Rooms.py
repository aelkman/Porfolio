from data_importer.models.model import Model


class Rooms(Model):
    TABLE_NAME = 'ROOMS'
    fields = ('('
              ' ROOM INT,'
              ' BUILDING VARCHAR(5),'
              ' CAPACITY int,'
              ' PRIMARY KEY(ROOM, BUILDING)'
              ');'
              )
