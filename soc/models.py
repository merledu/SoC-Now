from django.db import models
from django_mysql.models import ListCharField

# Create your models here.
class SoC(models.Model):
    isa = models.IntegerField()
    extensions = ListCharField(
                base_field=models.CharField(max_length=50),
                max_length=100,
                
            )
    devices = ListCharField(
                base_field=models.CharField(max_length=50),
                max_length=100,
                null=True,
                blank=True
                            )
    bus = models.CharField(max_length=50, null=True, blank=True)
