from data_importer.pginterface import PgInterface

def prob3f():
    pg = PgInterface()
    q = """SELECT
  ss.major,
  avg(grade) avgGrade
FROM (
       SELECT
         sid,
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
  INNER JOIN (
               SELECT
                 cid,
                 term,
                 sec
               FROM studentcoursedb.scheduled_courses
               WHERE subj = 'ABC'
             ) sc
    ON grades.term = sc.term AND grades.cid = sc.cid AND grades.sec = sc.sec
  INNER JOIN (
               SELECT
                 sid,
                 term,
                 major
               FROM studentcoursedb.student_status
             ) ss
    ON grades.sid = ss.sid AND grades.term = ss.term
GROUP BY major
order by avgGrade;"""

    cursor = pg.getcursor()
    cursor.execute(q)
    all = cursor.fetchall()
    min = -1
    max = 5
    print('Worse performing majors:')
    for row in all:
        if min == -1:
            min = row[1]
        elif min != row[1]:
            break
        print('%s: %0.4f' % row)
    print('Best performing majors:')
    for row in reversed(all):
        if max == 5:
            max = row[1]
        elif max != row[1]:
            break
        print('%s: %0.4f' % row)

