# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-12 16:05
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tocayoapp', '0006_auto_20151210_0458'),
    ]

    operations = [
        migrations.AddField(
            model_name='gender',
            name='description',
            field=models.CharField(default='tbd', max_length=15, unique=False),
        ),
    ]