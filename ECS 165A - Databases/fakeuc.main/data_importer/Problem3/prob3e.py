from data_importer.pginterface import PgInterface

def prob3e():
    pg = PgInterface()
    cur = pg.getcursor()
    q = """select distinct a.crse, a.subj from
  (SELECT m.*, sc.subj, sc.crse
    FROM studentcoursedb.meeting m inner JOIN studentcoursedb.scheduled_courses sc
    on m.term = sc.term and m.cid = sc.cid
    ) a,
  (SELECT m.*, sc.subj, sc.crse
    FROM studentcoursedb.meeting m inner JOIN studentcoursedb.scheduled_courses sc
    on m.term = sc.term and m.cid = sc.cid
    ) b
where a.days similar to (CASE WHEN b.days = 'MW' THEN ('%(M|W)%')
            WHEN b.days = 'MWF' THEN ('%(M|W|F)%')
            WHEN b.days = 'MTWR' THEN ('%(M|T|W|R|)%')
            WHEN b.days = 'TR' THEN ('%(T|R)%') END)
            and a.crse = b.crse and a.subj = b.subj and
-- a.sec = b.sec and a.type = b.type and a.days = b.days and a.build = b.build and a.room = b.room
-- and
(
   a.time_begin > b.time_begin and a.time_begin < b.time_end and a.build = b.build and a.room = b.room
      )"""
    cur.execute(q)
    data = cur.fetchall()
    c=1
    for d in data:
        print(str(c)+": " + str(d[1]) + " " + str(d[0]))
        c=c+1
