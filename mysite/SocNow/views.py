from django.shortcuts import render

# Create your views here.

def index(request):
    return render(request , "index.html")

def home(request):
    return render(request , "home.html")

def core(request):
    return render(request , "core.html")

def devices(request):
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
    return render(request , "bus.html")

def finalize(request):
    return render(request , "finalize.html")