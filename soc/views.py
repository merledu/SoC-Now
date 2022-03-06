from django.shortcuts import render

# Create your views here.
def soc_view(request):
    return render(request, "soc.html", {})