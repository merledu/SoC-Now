from django.db import models

# Create your models here.
class ComplianceTests(models.Model):
    name = models.CharField(max_length=1000)
    name_convention = models.CharField(max_length=1000 , null=True , blank = True)
