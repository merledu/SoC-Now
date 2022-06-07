import re

file = open('SoC-Now-Generator/compliance/riscv-arch-test/Test_result.txt' , "r")
readfile = file.readlines()[-1]
file.close()

print(readfile)

output = re.compile(r'OK|FAIL')
final = output.search(readfile)

print("final value" , final)

print("save file")