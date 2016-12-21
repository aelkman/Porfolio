from data_importer.pginterface import PgInterface

def problem3a():
    studentsunits = []
    unitratio = []
    pg = PgInterface()
    cur = pg.getcursor()
    tstudents = getUniqueStudents(cur)
    for i in range(1,21):
        numwithunits = getUniqueStudentsUnit(cur, i)
        studentsunits.append(numwithunits)
        unitratio = (str(round((numwithunits/tstudents)*100, 3)) + "%")
        print("Students with " + str(i) + " units: " + str(numwithunits) + ", " + str(unitratio))


def getUniqueStudents(cur):
    q1 = """select count(*) from (
              select distinct sid, term, sum(units) from studentcoursedb.enrolled
              group by sid, term
              having sum(units) > 0 and sum(units) <= 20
            )as sq1;"""
    cur.execute(q1)
    totalstudents = cur.fetchone()
    totalstudents = totalstudents[0]
    print("Total Students: " + str(totalstudents))
    return totalstudents


def getUniqueStudentsUnit(cur, i):
    q1 = """select count(*) from(
            select term, sid, sum(units) from studentcoursedb.enrolled
            group by term, sid
            having sum(units)={numUnits}) as solution;""".format(numUnits = str(i))
    cur.execute(q1)
    totalstudents = cur.fetchone()
    totalstudents = totalstudents[0]
    return totalstudents
