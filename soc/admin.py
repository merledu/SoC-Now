import imp
from django.contrib import admin

# Register your models here.
from .models import SoC

admin.site.register(SoC)