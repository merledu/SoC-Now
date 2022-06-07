from curses.ascii import SO
from unicodedata import name
from django.urls import path
from .views import *

urlpatterns = [
    path("", verif_select, name="verif_select"),
    path("core/", verify_core, name="verif_core"),
    path("add-asm-test/", add_ass_test, name="add_asm"),
    path("add-c-test/", add_c_test, name="add_c"),
    path("soc/", verify_soc, name="verif_soc"),
    path("download-vcd/", download_soc_vcd, name="download_vcd"),
    path("download-core-vcd/", download_core_vcd, name="download_core_vcd"),
    path("select-soc/", select_soc, name="select_soc"),
    path("test-reults/", test_result, name="test_result"),
]