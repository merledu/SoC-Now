from django.shortcuts import redirect, render
from .models import SoC
from django.core import serializers
import ast, json, os, re
from makeDiagram import makeDiagram
from thesocnow.settings import GENERATOR_DIR, DRIVERS, RTL_FILES,XDC_ENCODS
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
        outData["tl"]        = [1 if "tl" in actualData["bus"] else 0][0]

        with open("SoC-Now-Generator/src/main/scala/config.json", "w") as outfile:
            json.dump(outData,outfile )
        
        makeDiagram()
        return redirect("finalize")

    return render(request, "soc.html", {})

def finalize_view(request):

    return render(request, "finalize.html", {})

def selectFPGA(request):
    if request.method != "POST":
        os.chdir(GENERATOR_DIR)
        os.system("./peripheralScript.py")
        os.system(f"sbt 'runMain {DRIVERS['soc']}'")
        os.chdir("..")
    elif request.method == "POST":
        clk = request.POST.get("clk")
        fpga = "Arty"
        print(clk,fpga)
        file = open(f"{GENERATOR_DIR}/fpga/arty.xdc", "w")
        file.write(XDC_ENCODS["default"])
        file.close()
        clock_line = XDC_ENCODS["clk"]
        clock_line = clock_line.replace('x', str(float(clk)))
        file = open(f"{GENERATOR_DIR}/fpga/arty.xdc", "a")
        file.write(clock_line)
        file.close()
        return redirect("mapFPGA")

    return render(request, "selectFPGA.html", {})

def mapFPGA(request):
    file= open(f"{GENERATOR_DIR}/{RTL_FILES['soc']}", "r")
    content = file.readlines()
    file.close()
    n = 0
    IOs = []
    for i in content:
        if n == 1 :
            if ")" in i:
                n = 0
            else:
                newi = (i.split(" ")[-1])[:-2]
                IOs.append(newi)
                print("newi", newi)
        elif re.match("^module Generator..", i):
            print("MATHCED", i)
            n = 1

        
    return render(request, "mapFPGA.html", {"ios":IOs})

def bitsream_page(request):
    os.chdir(GENERATOR_DIR)
    os.system("make bitstream")
    os.chdir("..")
    return render(request, "bitstream.html", {})

def download_bitstream(request):
    # Define text file name
    filename = "Genera"
    # Define the full file path
    filepath = "tempFile.v"
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