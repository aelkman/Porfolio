import csv
from data_importer.models.Students import Students
from data_importer.models.StudentStatus import StudentStatus
from data_importer.models.ScheduledCourses import ScheduledCourses
from data_importer.models.Meeting import Meeting
from data_importer.models.Enrolled import Enrolled
from data_importer.models.Courses import Courses
from data_importer.models.Rooms import Rooms
import re
import time


class FakeUCParser:
    state = 0
    STATES = {
        'BLANK': 0,
        'COURSE': 1,
        'MEETING': 2,
        'ENROLLED': 3
    }
    create_table = ''

    end_of_course = False
    is_merged_q = False
    s_merged_meeting = False
    handle_row = {}

    known_students = {}
    known_courses = {}
    known_status = {}
    known_cid_term = {}
    current_term = ''
    current_cid = ''
    current_section = ''
    current_crse = ''
    current_subj = ''

    current_instr = ''
    current_meetings = {}

    all_rooms = {}
    current_roombuild = None

    courses = None
    enrolled = None
    meeting = None
    scheduled_courses = None
    students = None
    student_status = None

    cache = None

    def __init__(self):
        self.courses = Courses()
        self.enrolled = Enrolled()
        self.meeting = Meeting()
        self.scheduled_courses = ScheduledCourses()
        self.students = Students()
        self.student_status = StudentStatus()
        self.cache = CourseCache()

        self.state = self.STATES['BLANK']
        self.handle_row = {
            0: self.__handle_blank__,
            1: self.__handle_course__,
            2: self.__handle_meeting__,
            3: self.__handle_enrolled__,
        }

    def parsefile(self, filename):
        with open(filename, 'r') as csvf:
            # t = time.time()
            dialect = csv.Sniffer().sniff(csvf.read(1024))
            csvf.seek(0)
            reader = csv.reader(csvf, dialect)
            for row in reader:
                self.__readline__(row)
            self.commit_all()
            # print('parserow time: %.20f' % (time.time() - t))

    def get_state(self, row):
        if len(row) is 1 and row == ['']:
            if self.state == self.STATES['ENROLLED']:
                self.end_of_course = True
            self.state = self.STATES['BLANK']
        elif len(row) is 6 and row == ['CID', 'TERM', 'SUBJ', 'CRSE', 'SEC', 'UNITS']:
            self.state = self.STATES['COURSE']
        elif len(row) is 6 and row == ['INSTRUCTOR(S)', 'TYPE', 'DAYS', 'TIME', 'BUILD', 'ROOM']:
            self.state = self.STATES['MEETING']
        elif len(row) is 11 and row == ['SEAT', 'SID', 'SURNAME', 'PREFNAME', 'LEVEL', 'UNITS', 'CLASS', 'MAJOR',
                                        'GRADE', 'STATUS', 'EMAIL']:
            self.state = self.STATES['ENROLLED']

        return_state = self.state
        return return_state

    def __readline__(self, row):
        # print(row)
        state = self.get_state(row)
        # print(self.state)
        self.handle_row[state](row)

    def commit_all(self):
        self.courses.insertdata()
        self.enrolled.insertdata()
        self.meeting.insertdata()
        self.scheduled_courses.insertdata()
        self.students.insertdata()
        self.student_status.insertdata()

    def commit_rooms(self):
        rooms = Rooms()
        for br in self.all_rooms:
            if br is not ':':
                rooms.enqueuedata(
                    [self.all_rooms[br]['room'], self.all_rooms[br]['build'], self.all_rooms[br]['cap']])
        rooms.insertdata()

    def __handle_blank__(self, row):
        if self.end_of_course:
            if self.is_merged_q:
                for i in self.cache.student_status:
                    # print('test')
                    # self.known_status.pop(str(i[1]) + str(i[0]))
                    self.known_status[str(i[1] + 0.1) + str(i[0])] = i[2] + i[3] + i[4] + i[5]
                self.current_term += 0.1
                self.cache.update_term(self.current_term)

            if len(self.cache.enrolled) > 0:
                self.student_status.enqueuedata_arr(self.cache.student_status)
                self.scheduled_courses.enqueuedata_arr(self.cache.scheduled_courses)
                self.meeting.enqueuedata_arr(self.cache.meeting)
                self.enrolled.enqueuedata_arr(self.cache.enrolled)

            self.is_merged_q = False
            self.cache.clear()
        self.end_of_course=False
        return

    def __handle_course__(self, row):
        # print('course')
        if row == ['CID', 'TERM', 'SUBJ', 'CRSE', 'SEC', 'UNITS']:
            return
        self.current_cid = int(float(row[0]))
        self.current_term = int(float(row[1]))
        self.current_crse = int(float(row[3]))
        self.current_section = int(float(row[4]))
        self.current_subj = row[2]
        units = row[5].split(' - ')

        # if str(self.current_cid) + str(self.current_term) in self.known_cid_term:
        #     self.current_term += 0.1
        # self.known_cid_term[str(self.current_cid) + str(self.current_term)] = True

        self.cache.scheduled_courses.append([self.current_cid,
                                             self.current_crse,
                                             self.current_subj,
                                             self.current_section,
                                             self.current_term
                                             ])

        # self.scheduled_courses.enqueuedata([self.current_cid,
        #                                     self.current_crse,
        #                                     self.current_subj,
        #                                     self.current_section,
        #                                     self.current_term,
        #                                     ])
        if str(self.current_crse) + self.current_subj not in self.known_courses:
            self.courses.enqueuedata([row[2],
                                      self.current_crse,
                                      int(float(units[0])) if row[5] else 'NULL',
                                      int(float(units[1])) if len(units) > 1 else int(float(units[0]))
                                      ])
            self.known_courses[str(self.current_crse) + self.current_subj] = True

    def __handle_meeting__(self, row):
        # print('meeting')
        if row == ['INSTRUCTOR(S)', 'TYPE', 'DAYS', 'TIME', 'BUILD', 'ROOM']:
            self.current_instr = ''
            # self.current_meetings = {}
            self.current_roombuild = None
            return

        self.current_roombuild = row[4] + ':' + row[5]
        if self.current_roombuild not in self.all_rooms:
            self.all_rooms[self.current_roombuild] = {'cap': -1, 'room': row[5], 'build': row[4]}

        self.current_instr = self.current_instr if not row[0] else row[0]
        if re.match("..*'..*", self.current_instr):
            self.current_instr = re.sub("'", "''", self.current_instr)
        start_time = self.__gettime__(row[3], 0)
        end_time = self.__gettime__(row[3], 1)

        m = [
            self.current_cid,
            self.current_section,
            self.current_term,
            row[1] if row[1] else 'Unknown',  # if row[1] else 'Unknown',
            self.current_instr,
            row[2] if row[2] else 'TBA',
            row[3] if row[3] else 'TBA',
            start_time,
            end_time,
            row[4] if row[4] else 'TBA',
            int(float(row[5])) if row[5] else -1
        ]
        if m not in self.cache.meeting:
            self.cache.meeting.append(m)

        meeting_key = str(self.current_cid) + str(self.current_term) + row[2] + row[3] + row[4] + row[5]
        if meeting_key not in self.current_meetings:
            self.current_meetings[meeting_key] = str(self.current_subj) + str(self.current_crse)

        if self.current_meetings[meeting_key] != str(self.current_subj) + str(self.current_crse):
            if str(self.current_cid) + str(self.current_term + 0.1) + row[2] + row[3] + row[4] + row[5] not in \
                    self.current_meetings:
                self.is_merged_q = True
                self.current_meetings[
                    str(self.current_cid) + str(self.current_term + 0.1) + row[2] + row[3] + row[4] + row[5]] = str(
                    self.current_subj) + str(self.current_crse)
                # print('meeting collision')
        # elif self.time_collision(m):
        #     self.is_merged_q = True

                # meeting_key = str(self.current_cid) + str(self.current_section) + str(self.current_term) + row[1] + row[2]
                # if meeting_key not in self.current_meetings:
                # todo: test
                # self.current_meetings[meeting_key] = True
                # self.meeting.enqueuedata([
                #     self.current_cid,
                #     self.current_section,
                #     self.current_term,
                #     row[1] if row[1] else 'Unknown',
                #     self.current_instr,
                #     row[2] if row[2] else 'TBA',
                #     start_time,
                #     end_time,
                #     row[4],
                #     int(float(row[5])) if row[5] else 'NULL'
                # ])
                # else:
                #     print('meeting collision')

    def __handle_enrolled__(self, row):
        # print('enrolled')
        if row == ['SEAT', 'SID', 'SURNAME', 'PREFNAME', 'LEVEL', 'UNITS', 'CLASS', 'MAJOR', 'GRADE', 'STATUS',
                   'EMAIL']:
            return
        # print(row)
        self.all_rooms[self.current_roombuild]['cap'] = max(int(float(row[0])) if row[0] else -1,
                                                            self.all_rooms[self.current_roombuild]['cap'])

        self.cache.enrolled.append([
            self.current_cid,
            self.current_section,
            self.current_term,
            int(float(row[0])) if row[0] else 'NULL',
            int(float(row[1])) if row[1] else 'NULL',
            int(float(row[5])) if row[5] else 'NULL',
            row[8]
        ])
        # self.enrolled.enqueuedata([
        #     self.current_cid,
        #     self.current_section,
        #     self.current_term,
        #     int(float(row[0])) if row[0] else 'NULL',
        #     int(float(row[1])) if row[1] else 'NULL',
        #     int(float(row[5])) if row[5] else 'NULL',
        #     row[8]
        # ])
        if row[1] not in self.known_students:
            surname = row[2]
            if re.match("..*'..*", surname):
                surname = re.sub("'", "''", surname)
            prefname = row[3]
            if re.match("..*'..*", prefname):
                prefname = re.sub("'", "''", prefname)
            email = row[10]
            if re.match("..*'..*", email):
                email = re.sub("'", "''", email)
            self.students.enqueuedata([
                int(float(row[1])) if row[1] else 'NULL',
                surname,
                prefname,
                email
            ])
            self.known_students[row[1]] = True

        # if str(self.current_term) + row[1] == '200906580311542':
        #     print('test')
        if str(self.current_term) + row[1] not in self.known_status:
            self.known_status[str(self.current_term) + row[1]] = row[4] + row[6] + row[7] + row[9]
            self.cache.student_status.append([
                int(float(row[1])) if row[1] else 'NULL',
                self.current_term,
                row[4],
                row[6],
                row[7],
                row[9]
            ])
        elif self.known_status[str(self.current_term) + row[1]] != row[4] + row[6] + row[7] + row[9]:

            if str(self.current_term + 0.1) + row[1] not in self.known_status:
                # print('student collision')
                # print(self.current_term)
                # print(row)
                self.is_merged_q = True
                self.known_status[str(self.current_term + 0.1) + row[1]] = row[4] + row[6] + row[7] + row[9]
                self.cache.student_status.append([
                    int(float(row[1])) if row[1] else 'NULL',
                    self.current_term,
                    row[4],
                    row[6],
                    row[7],
                    row[9]
                ])


                # if row[1] + str(self.current_term) not in self.known_status:
                #     self.known_status[row[1] + str(self.current_term)] = True
                #     self.student_status.enqueuedata([
                #         int(float(row[1])) if row[1] else 'NULL',
                #         self.current_term,
                #         row[4],
                #         row[6],
                #         row[7],
                #         row[9]
                #     ])

    def __gettime__(self, time_str, startend):
        if not time_str:
            return 'NULL'
        time = time_str.split(' - ')
        return time[startend]

    # def time_collision(self,meet):
    #     collision = False
    #     if meet[7] != 'NULL' and meet[8] != 'NULL':
    #         for m in self.meeting.data:
    #             if (m[9] != 'TBA' and meet[9] != 'TBA' and
    #                         meet[9] == m[9] and meet[10] == m[10]) \
    #                     and (m[7] != 'NULL' and m[8] != 'NULL'):
    #                 for day in m[5]:
    #                     if day in meet[5]:
    #                         if (meet[7] >= m[7] <= meet[8]) or (meet[7] >= m[8] <= meet[8]):
    #                             collision = True
    #                         break
    #     return collision


class CourseCache:
    enrolled = []
    meeting = []
    scheduled_courses = []
    student_status = []

    def clear(self):
        self.enrolled = []
        self.meeting = []
        self.scheduled_courses = []
        self.student_status = []

    def update_term(self, term):
        for c in self.enrolled:
            c[2] = term
        for m in self.meeting:
            m[2] = term
        for sc in self.scheduled_courses:
            sc[4] = term
        for ss in self.student_status:
            ss[1] = term
