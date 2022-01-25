import os
import subprocess
import re
import time


run_script = subprocess.call(["sh" , "./script.sh"])


# #print(run_script)
# file = open('/home/shahzaib/Documents/picofoxy/picofoxy/riscv-arch-test/Test_result.txt' , "r")
# readfile = file.read()
# file.close()

# output = re.compile(r'Compare.*')
# s=output.finditer(readfile)
# for i in s:
#     final = readfile[int(i.start()):-1]

# print(final)

# file1 = open('/home/shahzaib/Documents/picofoxy/picofoxy/riscv-arch-test/Test_result.txt', 'w')
# file1.write(final)
# file1.close()