from data_importer.pginterface import PgInterface

def prob3c():
    pg = PgInterface()
    q = """SELECT
  professor,
  avg(grade)
FROM (
       SELECT
         cid,
         sec,
         term,
         (CASE WHEN grade = 'A+'
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
          END) grade
       FROM studentcoursedb.enrolled
       WHERE grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F+', 'F', 'F-')
     ) grades
  LEFT JOIN (

              SELECT
                term,
                cid,
                sec,
                professor
              FROM studentcoursedb.meeting
              WHERE professor IS NOT NULL
              GROUP BY term, cid, sec, professor
            ) m
    ON grades.cid = m.cid AND grades.sec = m.sec AND grades.term = m.term
GROUP BY professor
ORDER BY avg(grade) DESC;"""
    cursor = pg.getcursor()
    cursor.execute(q)
    all = cursor.fetchall()
    min = -1
    max = 5
    print('Easiest professors:')
    for row in all:
        if min == -1:
            min = row[1]
        elif min != row[1]:
            break
        print('%s: %0.4f' % row)
    print('\nHardest professors:')
    for row in reversed(all):
        if max == 5:
            max = row[1]
        elif max != row[1]:
            break
        print('%s: %0.4f' % row)

