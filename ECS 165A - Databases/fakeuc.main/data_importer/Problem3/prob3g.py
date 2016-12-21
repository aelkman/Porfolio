from data_importer.pginterface import PgInterface

def prob3g():
    pg = PgInterface()
    q_top5 = """SELECT ss2.major, count(distinct ss1.sid) c
FROM studentcoursedb.student_status ss1, studentcoursedb.student_status ss2
WHERE
  ss1.sid = ss2.sid
  AND ss1.major LIKE 'ABC%'
  AND ss2.term < ss1.term
  AND ss1.major <> ss2.major
  AND ss2.major NOT LIKE 'ABC%'
group by ss2.major
order by c desc
limit 5;"""

    q_gradABC = """SELECT count(distinct ss.sid)
FROM
  (SELECT
     ss.sid  sid,
     ss.term term,
     ss.major
   FROM
     studentcoursedb.student_status ss INNER JOIN
     (SELECT
        sid,
        max(term) maxterm
      FROM studentcoursedb.student_status
      GROUP BY sid) mt
       ON mt.maxterm = ss.term AND mt.sid = ss.sid
   WHERE ss.major LIKE 'ABC%') grads, studentcoursedb.student_status ss
WHERE grads.sid = ss.sid AND ss.term <> grads.term AND ss.major NOT LIKE 'ABC%';"""

    print('Percent of total students to transfer to ABC and graduate as ABC:')
    cursor = pg.getcursor()
    cursor.execute(q_gradABC)
    transf = cursor.fetchone()[0]
    cursor.execute("select count(distinct sid) from studentcoursedb.student_status where major like 'ABC%';")
    all = cursor.fetchone()[0]
    print('%d/%d*100 = %0.2f%%\n' % (transf, all, transf/all*100))

    print('Top 5 majors to transfer into ABC and percent transferred from that major:')
    cursor = pg.getcursor()
    cursor.execute(q_top5)
    for row in cursor:
        print('%s: %0.2f%%' % (row[0],row[1]/transf*100))
    print('')
