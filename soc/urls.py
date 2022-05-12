from curses.ascii import SO
from unicodedata import name
from django.urls import path
from .views import *

APP_NAME = "soc"

urlpatterns = [
    path("", soc_view, name="soc"),
    path("final/", finalize_view, name="finalize"),
    # gen bitstream
    path("fpga/select/", selectFPGA, name="selectFPGA"),
    path("fpga/map/", mapFPGA, name="mapFPGA"),
    path("fpga/gen/bitstream/", bitstream_gen, name="bitstream"),
    path("fpga/bitstream/", bitsream_page, name="bitstream_view"),
    path("addxdc/<str:key>/<str:value>/", add_xdc, name="addXDC"),
    path("download/bitstream/",download_bitstream, name="downloadBitstream" ),
    path("fpga/program/", add_program, name="programFPGA"),
]
