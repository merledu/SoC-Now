import imp
from operator import imod
from platform import machine
from django.shortcuts import render, redirect
from .models import ComplianceTests
from parseVenus import parse_riscv_assembly
from django.contrib import messages
import json, os
import mimetypes
from django.core import serializers
import ast
from icecream import ic
from soc.models import SoC
from django.http.response import HttpResponse
from thesocnow.settings import GENERATOR_DIR, DRIVERS, RTL_FILES,XDC_ENCODS, ARTY_COMPS_i, ARTY_COMPS_o

test_statuses = {}
# Create your views here.
def verif_select(request):
    base = ComplianceTests.objects.all()[0]
    tests = ComplianceTests.objects.all()[1:]
    if request.method == "POST":
        ic("c-test" in request.POST)
        if "compliance" in request.POST:
            selected_tests = request.POST.getlist("tst")
            selected_tests.append("I-ADD-01")
            global test_statuses
            test_statuses = {}
            for test in selected_tests:
                os.system("./compliance.sh " + test)
                compile_result(test)
                # return redirect("test_result", test)
            return redirect("test_result")
        
        elif "c-test" in request.POST:

            c_code = request.POST.get("main-c")
            file = open("/tmp/c_code.c", "w+")
            file.write(c_code)
            file.close()
            os.system("riscv32-unknown-elf-gcc -g /tmp/c_code.c -o /tmp/c_code.out")
            os.system("riscv32-unknown-elf-objdump -d /tmp/c_code.out > /tmp/c_code.elf")

            file = open("/tmp/c_code.elf", "r")
            contents = file.readlines()
            file.close()
            machineCode = []
            machineCodeFile = open("/tmp/machCode.txt", "w+")
            for line in contents[1:]:
                splittedList = line.split("\t")
                if len(splittedList)>1:
                    machineCode.append(splittedList[1])
            machineCodeFile.write("\n".join(machineCode))
            machineCodeFile.close()
            os.chdir(f"{GENERATOR_DIR}")
            os.system("sbt 'testOnly CoreTest -- -DwriteVcd=1 -DmemFile=/tmp/machCode.txt'")
            os.chdir("../")
            messages.success(request, "Successfully Generated VCD", extra_tags="success_vcd")

            context = {"basecase":base, "testcases":tests, "c_code":c_code, "machineCode":None, "soc_code":None}

        elif "s-test" in request.POST:
            assembly = request.POST.get("main-s")
            machCode = assembly #parse_riscv_assembly(assembly)
            file = open("/tmp/machCode.txt", "w+")
            file.write(machCode)
            file.close()
            os.chdir(f"{GENERATOR_DIR}")
            os.system("sbt 'testOnly CoreTest -- -DwriteVcd=1 -DmemFile=/tmp/machCode.txt'")
            os.chdir("../")
            messages.success(request, "Successfully Generated VCD", extra_tags="success_vcd")
            context = {"basecase":base, "testcases":tests, "c_code":None, "machineCode":machCode, "soc_code":None}
        
        elif "soc-test" in request.POST:
            assembly = request.POST.get("main-soc")
            machCode = assembly #parse_riscv_assembly(assembly)
            file = open("/tmp/machCode.txt", "w+")
            file.write(machCode)
            file.close()
            os.chdir(f"{GENERATOR_DIR}")
            os.system("sbt 'testOnly CoreTest -- -DwriteVcd=1 -DmemFile=/tmp/machCode.txt'")
            os.chdir("../")
            messages.success(request, "Successfully Generated VCD", extra_tags="success_vcd")
            context = {"basecase":base, "testcases":tests, "c_code":None, "machineCode":None, "soc_code":assembly}
            return render(request, "soc_test.html", context)
    else:
        context = {"basecase":base, "testcases":tests, "c_code":None, "machineCode":None, "soc_code":None}

            
    
    return render(request, "verif_select.html", context)

def verify_core(request):
    base = ComplianceTests.objects.all()[0]
    tests = ComplianceTests.objects.all()[1:]
    if request.method == "POST":
        selected_tests = request.POST.getlist("tst")
        selected_tests.append("I-ADD-01")
        global test_statuses
        test_statuses = {}
        for test in selected_tests:
            os.system("./compliance.sh " + test)
            compile_result(test)
            # return redirect("test_result", test)
        return redirect("test_result")
      
            
    context = {"basecase":base, "testcases":tests}
    return render(request, "verify.html", context)

def add_ass_test(request):
   
    program_str = f"\n"
    # program_str += f"\n#Please Generate the Machine Code from Venus and paste it here !!\n"

    if request.method == "POST":
        assembly = request.POST.get("editor")
        # try:
        machCode = assembly #parse_riscv_assembly(assembly)
        file = open("/tmp/machCode.txt", "w+")
        file.write(machCode)
        file.close()
        os.chdir(f"{GENERATOR_DIR}")
        os.system("sbt 'testOnly CoreTest -- -DwriteVcd=1 -DmemFile=/tmp/machCode.txt'")
        os.chdir("../")
        messages.success(request, "Successfully Generated VCD", extra_tags="success")


        # except:
        #     messages.error(request, "Invalid Assembly Code")
    return render(request, "addTest2.html", {"program":program_str})
def add_c_test(request):
    if request.method == "POST":
        c_code = request.POST.get("editor")
        file = open("/tmp/c_code.c", "w+")
        file.write(c_code)
        file.close()
        os.system("riscv32-unknown-elf-gcc -g /tmp/c_code.c -o /tmp/c_code.out")
        os.system("riscv32-unknown-elf-objdump -d /tmp/c_code.out > /tmp/c_code.txt")
        file = open("/tmp/c_code.txt", "r")
        outData = file.read()
        file.close()
        dataList = outData.split("\n")

        

    return render(request, "addTest.html", {})

def verify_soc(request):
    file = open(f"{GENERATOR_DIR}/src/main/scala/config.json", "r")
    outData = json.load(file)
    ic(outData["timer"] == 1)
    file.close()
    BASE_ADDRESS = 40000000
    reg = 5
    program_str = f"#  BASE ADDRESSES: <br> # DCCM Base Address: 0x{BASE_ADDRESS}  <br>"
    reg += 1
    BASE_ADDRESS += 1000
    if outData["gpio"] == 1:
        program_str += f"# GPIO Base Address: 0x{BASE_ADDRESS} <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["spi"] == 1:
        program_str += f"# SPI Base Address: 0x{BASE_ADDRESS} <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["uart"] == 1:
        program_str += f"# UART Base Address 0x{BASE_ADDRESS}  <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["timer"] == 1:
        program_str += f"# Timer Base Address 0x{BASE_ADDRESS}  <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["spi_flash"] == 1:
        program_str += f"# SPI Flash Base Address 0x{BASE_ADDRESS}  <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["i2c"] == 1:
        program_str += f"# I2C Base Address 0x{BASE_ADDRESS}  <br>"
        reg += 1
        BASE_ADDRESS += 1000
    # program_str += f"\n#Start your program here\n"
    # program_str += f"\n#Please Generate the Machine Code from Venus and paste it here !!\n"

    if request.method == "POST":
        assembly = request.POST.get("editor")
        
        machCode = assembly #parse_riscv_assembly(assembly)
        file = open("/tmp/machCode.txt", "w+")
        file.write(machCode)
        file.close()
        os.chdir(GENERATOR_DIR)
        os.system("./peripheralScript.py")
        os.system("sbt 'testOnly GeneratorTest -- -DwriteVcd=1 -DmemFile=/tmp/machCode.txt'")
        os.chdir("..")
        messages.success(request, "Successfully Generated VCD", extra_tags="success")


        # except:
        #     messages.error(request, "Invalid Assembly Code")
        
    return render(request, "soc_verif.html", {"program":program_str})

def download_soc_vcd(request):
    # Define Django project base directory
    BASE_DIR = GENERATOR_DIR
    # Define text file name
    filename = "Generator.vcd"
    #Top_Test Define the full file path
    filepath = f"{GENERATOR_DIR}/test_run_dir/Generator_Test/Generator.vcd"
    # Open the file for reading content
    path = open(filepath, 'r')
    # Set the mime type
    mime_type, _ = mimetypes.guess_type(filepath)
    # Set the return value of the HttpResponse
    response = HttpResponse(path, content_type=mime_type)
    # Set the HTTP header for sending to browser
    response['Content-Disposition'] = "attachment; filename=%s" % filename
    # Return the response value
    return response

def download_core_vcd(request):
    # Define Django project base directory
    BASE_DIR = GENERATOR_DIR
    # Define text file name
    filename = "Top.vcd"
    #Top_Test Define the full file path
    filepath = f"{GENERATOR_DIR}/test_run_dir/Core_Test/Top.vcd"
    # Open the file for reading content
    path = open(filepath, 'r')
    # Set the mime type
    mime_type, _ = mimetypes.guess_type(filepath)
    # Set the return value of the HttpResponse
    response = HttpResponse(path, content_type=mime_type)
    # Set the HTTP header for sending to browser
    response['Content-Disposition'] = "attachment; filename=%s" % filename
    # Return the response value
    return response

def select_soc(request):
    if request.method == "POST":
        obj = SoC.objects.create(
            isa        = 32,
            extensions = ["i"] + request.POST.getlist("ext"),
            devices    = ["gpio"] + request.POST.getlist("dev"),
            bus        = request.POST.get("bus")
        )

        data = serializers.serialize("json" , SoC.objects.filter(pk=obj.id))
        print(ast.literal_eval(data)[0]["fields"])

        actualData           = ast.literal_eval(data)[0]["fields"]
        outData              = {}
        outData["i"]         = [1 if "i" in actualData["extensions"] else 0][0]
        outData["m"]         = [1 if "m" in actualData["extensions"] else 0][0]
        outData["f"]         = [1 if "f" in actualData["extensions"] else 0][0]
        outData["c"]         = [1 if "c" in actualData["extensions"] else 0][0]
        outData["gpio"]      = [1 if "gpio" in actualData["devices"] else 0][0]
        outData["spi"]       = [1 if "spi" in actualData["devices"] else 0][0]
        outData["uart"]      = [1 if "uart" in actualData["devices"] else 0][0]
        outData["timer"]     = [1 if "timer" in actualData["devices"] else 0][0]
        outData["spi_flash"] = [1 if "spi_flash" in actualData["devices"] else 0][0]
        outData["i2c"]       = [1 if "i2c" in actualData["devices"] else 0][0]
        outData["wb"]        = [1 if "wb" in actualData["bus"] else 0][0]
        outData["tl"]        = [1 if "tl-ul" in actualData["bus"] else 0][0]
        outData["tlc"]       = [1 if "tl-c" in actualData["bus"] else 0][0]

        with open("SoC-Now-Generator/src/main/scala/config.json", "w") as outfile:
            json.dump(outData,outfile )
        
        return redirect("verif_soc")
    return render(request, "soc.html", {})

def compile_result(test):
    file = open(f"{GENERATOR_DIR}/compliance/riscv-arch-test/Test_result.txt", "r")
    content = file.readlines()[14:]
    file.close()
    ourLine = ""
    # print(content)
    for i in content:
        if test in i:
            # print("---",i)
            ourLine = i
            break
    contents = ourLine.split(" ")
    print(contents)
    status = contents[-1]
    if len(status) == 3:
        status = "PASSED"
    else:
        status = "FAILED"

    test_statuses[test] = status
    ic(test_statuses)
        

def test_result(request):
    return render(request, "test_result.html", {"tests":test_statuses })
    