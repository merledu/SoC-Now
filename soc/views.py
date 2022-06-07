from email import message
from glob import glob
import imp
from django.shortcuts import redirect, render
from django.contrib import messages
from .models import SoC
from django.core import serializers
import ast, json, os, re
from icecream import ic
import mimetypes
from django.http import HttpResponse, Http404, FileResponse
from makeDiagram import makeDiagram
from thesocnow.settings import GENERATOR_DIR, DRIVERS, RTL_FILES,XDC_ENCODS, ARTY_COMPS_i, ARTY_COMPS_o
from parseVenus import parse_riscv_assembly
# Create your views here.

def soc_view(request):
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
        
        makeDiagram()
        return redirect("finalize")

    return render(request, "soc.html", {})

def finalize_view(request):

    return render(request, "finalize.html", {})
mappedElemets = {}

def selectFPGA(request):
    if request.method != "POST":
        os.chdir(GENERATOR_DIR)
        os.system("./peripheralScript.py")
        os.system(f"sbt 'runMain {DRIVERS['fpga']}'")
        os.chdir("..")
        global mappedElemets
        mappedElemets = {}
        return redirect("mapFPGA")
    elif request.method == "POST":
        clk = request.POST.get("clk")
        fpga = "Arty"
        print(clk,fpga)
        # file = open(f"{GENERATOR_DIR}/fpga/arty.xdc", "w")
        # file.write(XDC_ENCODS["default"])
        # file.close()
        # clock_line = XDC_ENCODS["clk"]
        # clock_line = clock_line.replace('x', str(float(clk)))
        # file = open(f"{GENERATOR_DIR}/fpga/arty.xdc", "a")
        # file.write(clock_line)
        # file.close()
        return redirect("mapFPGA")

    return render(request, "selectFPGA.html", {})


def mapFPGA(request):
    file= open(f"{GENERATOR_DIR}/{RTL_FILES['fpga']}", "r")
    content = file.readlines()
    file.close()
    n = 0
    Inputs = []
    Outputs = []
    for i in content:
        if n == 1 :
            if ")" in i:
                n = 0
            else:
                if "input" in i:
                    newi = (i.split(" ")[-1])[:-2]
                    file = open(f"{GENERATOR_DIR}/src/main/scala/config.json", "r")
                    outData = json.load(file)
                    file.close()
                    ic(outData)
                    if "reset" in newi:
                        Inputs.append(newi)
                    elif outData["gpio"] == 1 and "gpio" in newi:
                        Inputs.append(newi)
                    elif outData["spi"] == 1 and "spi" in newi:
                        Inputs.append(newi)
                    elif outData["uart"] == 1 and "uart" in newi:
                        Inputs.append(newi)
                    elif outData["timer"] == 1 and "timer" in newi:
                        Inputs.append(newi)
                    elif outData["spi_flash"] == 1 and "spi_flash" in newi:
                        Inputs.append(newi)
                    elif outData["i2c"] == 1 and "i2c" in newi:
                        Inputs.append(newi)
                elif "output" in i or "inout" in i:
                    newi = (i.split(" ")[-1])[:-2]
                    file = open(f"{GENERATOR_DIR}/src/main/scala/config.json", "r")
                    outData = json.load(file)
                    file.close()
                    ic(outData)
                    if outData["gpio"] == 1 and "gpio" in newi:
                        Outputs.append(newi)
                    elif outData["spi"] == 1 and "spi" in newi:
                        Outputs.append(newi)
                    elif outData["uart"] == 1 and "uart" in newi:
                        Outputs.append(newi)
                    elif outData["timer"] == 1 and "timer" in newi:
                        Outputs.append(newi)
                    elif outData["spi_flash"] == 1 and "spi_flash" in newi:
                        Outputs.append(newi)
                    elif outData["i2c"] == 1 and "i2c" in newi:
                        Outputs.append(newi)
                
                print("newi", newi)
        elif "module SoCNow(" in i:
            print("MATHCED", i)
            n = 1

        
    return render(request, "mapFPGA.html", {"inputs":Inputs, "outputs":Outputs, "input_comps":ARTY_COMPS_i.keys(), "output_comps":ARTY_COMPS_o.keys(), "el":json.dumps(mappedElemets)})

def bitstream_gen(request):
    xdcContent = XDC_ENCODS["default"]
    ARTY_COMPS = {**ARTY_COMPS_i, **ARTY_COMPS_o}
    for i,j in mappedElemets.items():
        theString = ARTY_COMPS[i]
        theString = theString.replace("x", str(j))
        xdcContent += "\n" + theString
    file = open(f"{GENERATOR_DIR}/fpga/arty.xdc", "w")
    file.write(xdcContent)
    file.close()

    os.chdir(GENERATOR_DIR)
    os.system("make bitstream")
    os.chdir("..")

    return redirect("bitstream_view")

def bitsream_page(request):
    return render(request, "bitstream.html", {})

def download_bitstream(request):
    return FileResponse(open(f"{GENERATOR_DIR}/fpga/build/arty_35/SoCNow.bit", 'rb'), as_attachment=True)

def add_xdc(request, key, value):
    mappedElemets[key] = value
    ic(mappedElemets)
    return redirect("mapFPGA")

def add_program(request):
    file = open(f"{GENERATOR_DIR}/src/main/scala/config.json", "r")
    outData = json.load(file)
    file.close()
    BASE_ADDRESS = 40000000
    reg = 5
    program_str = f"#  BASE ADDRESSES: <br> # DCCM Base Address: 0x{BASE_ADDRESS} <br>"
    reg += 1
    BASE_ADDRESS += 1000
    if outData["gpio"] == 1:
        program_str += f"# GPIO Base Address: 0x{BASE_ADDRESS} <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["spi"] == 1:
        program_str += f"# SPI Base Address: 0x{BASE_ADDRESS}  <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["uart"] == 1:
        program_str += f"# UART Base Address 0x{BASE_ADDRESS}  <br>"
        reg += 1
        BASE_ADDRESS += 1000
    if outData["timer"] == 1:
        program_str += f"# Timer Base Address 0x{BASE_ADDRESS} <br>"
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
        file = open(f"{GENERATOR_DIR}/fpga/program.mem", "w")
        file.write(machCode)
        file.close()
        return redirect("bitstream")
        # except:
        #     messages.error(request, "Invalid Assembly Code")
        

        
    return render(request, "programMem.html", {"program":program_str})