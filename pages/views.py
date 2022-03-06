from unicodedata import name
from django.shortcuts import render

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
