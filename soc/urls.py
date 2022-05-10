from curses.ascii import SO
from unicodedata import name
from django.urls import path
from .views import *

urlpatterns = [
    path("", soc_view, name="soc"),
    path("final/", finalize_view, name="finalize"),
    # gen bitstream
    path("fpga/select", selectFPGA, name="selectFPGA"),
    path("fpga/map", mapFPGA, name="mapFPGA"),
    path("fpga/bitsream", bitsream_page, name="bitstream"),
    path("download/bitstream", )
]
