from curses.ascii import SO
from distutils import extension
from http.client import HTTPResponse
from posixpath import isabs
from django.shortcuts import render, redirect
from .models import SoC
from django.http import JsonResponse
from django.core import serializers
# Create your views here.

def index(request):
    return render(request , "index.html")

def home(request):
    return render(request , "home.html")

def core(request):
    if request.method == "POST":
        SoC.objects.create(
            isa=32,
            extensions =["i"] ++ request.POST.getlist("ext")
        )
        return redirect("devices")
    return render(request , "core.html")

def devices(request):
    obj = list(SoC.objects.all())[-1]
    if request.method == "POST":
        obj.devices= ["gpio"] ++ request.POST.getlist("dev")
        obj.save()
        return redirect("bus")
    return render(request , "devices.html")

def login(request):
    return render(request , "login.html")

def about1(request):
    return render(request , "about1.html")

def about2(request):
    return render(request , "about2.html")

def contact1(request):
    return render(request , "contact1.html")

def contact2(request):
    return render(request , "contact2.html")

def signup(request):
    return render(request , "signup.html")

def UnderRiview(request):
    return render(request , "UnderRiview.html")

def bus(request):
    obj = list(SoC.objects.all())[-1]
    if request.method == "POST":
        obj.bus = request.POST.get("bus")
        obj.save()
        #json dump
        #turtle script
        return redirect("json_return")
    return render(request , "bus.html")

def finalize(request):
    return render(request , "finalize.html")




def json_return(request):
    InsertId= (SoC.objects.last()).id
    data = serializers.serialize("json" , SoC.objects.filter(pk=InsertId))
    with open("output.json", "w") as outfile:
        outfile.write(data)
    return redirect("finalize")