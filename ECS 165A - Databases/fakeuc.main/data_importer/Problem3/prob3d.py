from data_importer.pginterface import PgInterface


def prob3d():
    pg = PgInterface()
    q = """SELECT
  subj,
  crse,
  professor,
  max(avgGrade) aGrade
FROM
  (SELECT
     subj,
     crse,
     professor,
     avg(grade) avgGrade
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
     INNER JOIN (

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
     LEFT JOIN studentcoursedb.scheduled_courses schedc
       ON grades.cid = schedc.cid AND grades.sec = schedc.sec AND grades.term = schedc.term
   WHERE subj = 'ABC' AND crse >= 100 AND crse < 200
   GROUP BY subj, crse, professor
   ORDER BY avg(grade) DESC
  ) a
GROUP BY subj, crse, professor"""

    minG = {}
    minProf = {}
    maxG = {}
    maxProf = {}
    cursor = pg.getcursor()
    cursor.execute(q)
    for rec in cursor:
        if rec[1] in minG:
            if minG[rec[1]] > rec[3]:
                minG[rec[1]] = rec[3]
                minProf[rec[1]] = rec[2]
        else:
            minG[rec[1]] = rec[3]
            minProf[rec[1]] = rec[2]

        if rec[1] in maxG:
            if maxG[rec[1]] < rec[3]:
                maxG[rec[1]] = rec[3]
                maxProf[rec[1]] = rec[2]
        else:
            maxG[rec[1]] = rec[3]
            maxProf[rec[1]] = rec[2]
    classes = minG.keys()
    classes = sorted(classes)
    for c in classes:
        print('ABC %s:' % c)
        print('Easiest instructor: %s ' % maxProf[c])
        print('grade: %s' % getGrade(maxG[c]))
        print('Hardest instructor: %s ' % minProf[c])
        print('grade: %s' % getGrade(minG[c]))


def getGrade(g):
    return str(g)

