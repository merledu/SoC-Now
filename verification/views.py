from django.shortcuts import render
from .models import ComplianceTests
# Create your views here.
def verif_select(request):
    return render(request, "verif_select.html", {})

def verify_core(request):
    base = ComplianceTests.objects.all()[0]
    tests = ComplianceTests.objects.all()[1:]
    context = {"basecase":base, "testcases":tests}
    return render(request, "verify.html", context)

def add_ass_test(request):
    return render(request, "addTest2.html", {})