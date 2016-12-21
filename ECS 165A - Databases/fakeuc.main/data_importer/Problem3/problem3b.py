from data_importer.pginterface import PgInterface

def problem3b():
    gpalist = []
    pg = PgInterface()
    cur = pg.getcursor()
    for i in range(1, 21):
        gpa = getUniqueStudentsUnit(cur, i)
        gpalist.append(gpa)
    print(str(gpalist))

def getUniqueStudentsUnit(cur, i):
    q1 = """select avg(grade) from(
  select sid, avg((CASE WHEN grade = 'A+'
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
                END)) as grade from(
      select term, sid, grade, sum(units) from studentcoursedb.enrolled
      where grade in ('A+','A','A-','B+','B','B-','C+','C','C-','D+','D','D-','F')
      group by term, sid, grade
      having sum(units)={numUnits}) as sidgrade
  group by sid
                                          ) as gpa""".format(numUnits = str(i))
    cur.execute(q1)
    gpa = cur.fetchall()
    print("GPA Average [Units {numUnits}]: ".format(numUnits = str(i)) + str(gpa[0]))
    return gpa[0]