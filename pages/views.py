import os
from unicodedata import name
from django.shortcuts import render, redirect
import os
from thesocnow.settings import DRIVERS, GENERATOR_DIR, RTL_FILES

# Create your views here.
def index_view(request):
    return render(request, "index.html", {})

def about_view(request):
    return render(request, "about1.html", {})

def contact_view(request):
    return render(request, "contact1.html", {})

def home_view(request):
    return render(request, "home.html", {})

def about_view2(request):
    return render(request, "about2.html", {})

def contact_view2(request):
    return render(request, "contact2.html", {})

def show_rtl(request, driverFile):
    file = open(os.path.join(GENERATOR_DIR, driverFile))
    rtl_content = file.read()
    file.close()

    context = {
        "rtl":rtl_content,
        "driverFile":driverFile
    }

    return render(request, "RTL.html", context)

def gen_rtl(request, component):
    os.chdir(GENERATOR_DIR)
    if component == "soc":
        os.system("./peripheralScript.py")
    os.system(f"sbt 'runMain {DRIVERS[component]}'")
    os.chdir("..")

    return redirect("rtl", RTL_FILES[component])

    
from django.http import HttpResponse
def download_driver(request, driverFile):
    file = open(os.path.join(GENERATOR_DIR, driverFile))
    rtl_content = file.read()
    file.close()

    response = HttpResponse(rtl_content, content_type='text/plain')
    response['Content-Disposition'] = f'attachment; filename="{driverFile}"'

    return response