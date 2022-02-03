from re import I
from django.contrib import admin
from .models import SoC, ComplianceTests
# Register your models here.
admin.site.register(SoC)
admin.site.register(ComplianceTests)