from curses.ascii import SO
from unicodedata import name
from django.urls import path
from .views import *

urlpatterns = [
    path("", verif_select, name="verif_select"),
    path("core/", verify_core, name="verif_core"),
    path("add-asm-test/", add_ass_test, name="add_asm")
]