from unicodedata import name
from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path("", index_view, name="index"),
    path("about/", about_view, name="about1"),
    path("contact/", contact_view, name="contact1"),
    path("home/", home_view, name="home"),
    path("about-us/", about_view2, name="about2"),
    path("contact-us/", contact_view2, name="contact2"),
    path("rtl/<str:driverFile>/", show_rtl, name="rtl"),
    path("gen/<str:component>/", gen_rtl, name="gen"),
    path("download/driver/<str:driverFile>/", download_driver, name="downloadDriver"),

]
