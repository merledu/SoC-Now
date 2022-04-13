# Generated by Django 3.2 on 2022-04-10 11:12

from django.db import migrations, models
import django_mysql.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='SoC',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('isa', models.IntegerField()),
                ('extensions', django_mysql.models.ListCharField(models.CharField(max_length=50), max_length=100, size=None)),
                ('devices', django_mysql.models.ListCharField(models.CharField(max_length=50), blank=True, max_length=100, null=True, size=None)),
                ('bus', models.CharField(blank=True, max_length=50, null=True)),
            ],
        ),
    ]
