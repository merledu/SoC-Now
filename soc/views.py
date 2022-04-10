from django.shortcuts import redirect, render
from .models import SoC
from django.core import serializers
import ast, json
from makeDiagram import makeDiagram
# Create your views here.
def soc_view(request):
    if request.method == "POST":
        obj = SoC.objects.create(
            isa=32,
            extensions =["i"] + request.POST.getlist("ext"),
            devices= ["gpio"] + request.POST.getlist("dev"),
            bus = request.POST.get("bus")
        )
        data = serializers.serialize("json" , SoC.objects.filter(pk=obj.id))
        print(ast.literal_eval(data)[0]["fields"])
        actualData = ast.literal_eval(data)[0]["fields"]
        outData = {}
        outData["i"] = [1 if "i" in actualData["extensions"] else 0][0]
        outData["m"] = [1 if "m" in actualData["extensions"] else 0][0]
        outData["f"] = [1 if "f" in actualData["extensions"] else 0][0]
        outData["c"] = [1 if "c" in actualData["extensions"] else 0][0]
        outData["gpio"] = [1 if "gpio" in actualData["devices"] else 0][0]
        outData["spi"] = [1 if "spi" in actualData["devices"] else 0][0]
        outData["uart"] = [1 if "uart" in actualData["devices"] else 0][0]
        outData["timer"] = [1 if "timer" in actualData["devices"] else 0][0]
        outData["spi_flash"] = [1 if "spi_flash" in actualData["devices"] else 0][0]
        outData["i2c"] = [1 if "i2c" in actualData["devices"] else 0][0]
        outData["wb"] = [1 if "wb" in actualData["bus"] else 0][0]
        outData["tl"] = [1 if "tl" in actualData["bus"] else 0][0]

        with open("../SoCNow/src/main/scala/config.json", "w") as outfile:
            # outfile.write(str(outData))
            json.dump(outData,outfile )
        
        makeDiagram()
        return redirect("finalize")
    return render(request, "soc.html", {})

