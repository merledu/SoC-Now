from django.shortcuts import render

# Create your views here.
def comp_view(request):
    return render(request, "components.html",{})