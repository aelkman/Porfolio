import sys
import os.path

sys.path.append(os.path.join(os.path.dirname(__file__), '../..'))
from data_importer.Problem3.problem3a import problem3a
from data_importer.Problem3.prob3b import prob3b
from data_importer.Problem3.prob3c import prob3c
from data_importer.Problem3.prob3d import prob3d
from data_importer.Problem3.prob3e import prob3e
from data_importer.Problem3.prob3f import prob3f
from data_importer.Problem3.prob3g import prob3g

# from Problem3.problem3c import problem3c

print('Problem a\n')
problem3a()
input("Press Enter to continue")
print('Problem b\n')
prob3b()
input("Press Enter to continue")
print('Problem c\n')
prob3c()
input("Press Enter to continue")
print('Problem d\n')
prob3d()
input("Press Enter to continue")
print('Problem e\n')
prob3e()
input("Press Enter to continue")
print('Problem f\n')
prob3f()
input("Press Enter to continue")
print('Problem g\n')
prob3g()
input("Press Enter to exit")
