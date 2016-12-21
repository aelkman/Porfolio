from data_importer.pginterface import PgInterface


def prob3b():
    pg = PgInterface()
    q = """select un, avg(g)
from (
  SELECT
    sum(units) un,
    sum(units * (CASE WHEN grade = 'A+'
        THEN 4.0
                   WHEN grade = 'A'
                     THEN 4.0
                   WHEN grade = 'A-'
                     THEN 3.7
                   WHEN grade = 'B+'
                     THEN 3.3
                   WHEN grade = 'B'
                     THEN 3.0
                   WHEN grade = 'B-'
                     THEN 2.7
                   WHEN grade = 'C+'
                     THEN 2.3
                   WHEN grade = 'C'
                     THEN 2.0
                   WHEN grade = 'C-'
                     THEN 1.7
                   WHEN grade = 'D+'
                     THEN 1.3
                   WHEN grade = 'D'
                     THEN 1.0
                   WHEN grade = 'D-'
                     THEN 0.7
                   WHEN grade = 'F+'
                     THEN 0
                   WHEN grade = 'F'
                     THEN 0
                   WHEN grade = 'F-'
                     THEN 0
                   END)) / sum(units)   g
  FROM studentcoursedb.enrolled
  WHERE grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F+', 'F', 'F-')
  GROUP BY term, sid
  having sum(units)>0 and sum(units)<=20
) a GROUP BY un
ORDER BY un;"""
    print('GPA for students taking 1-20 units')

    cursor = pg.getcursor()
    cursor.execute(q)
    all = cursor.fetchall()
    for a in all:
        print('%d: %0.4f' % (a[0], a[1]))
