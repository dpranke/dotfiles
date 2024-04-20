import os
import subprocess
import sys
import time

# print sys.argv
start = time.time()
subprocess.call(sys.argv[1:], shell=True)
stop = time.time()
print "\nTook %.1f seconds" % (stop - start)
