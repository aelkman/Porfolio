import sys
import os.path

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

from data_importer.create_db_and_import import create_db_and_import


def main(args=None):
    create_db_and_import()


if __name__ == "__main__":
    main()