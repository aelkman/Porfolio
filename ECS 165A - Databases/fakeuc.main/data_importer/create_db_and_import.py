from data_importer.fakeuccsvparser import FakeUCParser
from data_importer.Schema import Schema
import glob


def create_db_and_import():
    Schema()
    files = glob.glob('../data/*.csv')
    parser = FakeUCParser()
    for file in files:
        print(file)
        parser.parsefile(file)
    parser.commit_rooms()
    print('Data imported.')

