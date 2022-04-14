from curses.ascii import SO
from unicodedata import name
from django.urls import path
from .views import *

urlpatterns = [
    path("", soc_view, name="soc"),
    path("final/", finalize_view, name="finalize"),
    # gen bitstream
    path("select/fpga", selectFPGA, name="selectFPGA")
]
