# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-06 15:20
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tocayoapp', '0003_auto_20151206_0613'),
    ]

    operations = [
        migrations.AddField(
            model_name='desig',
            name='uid',
            field=models.IntegerField(default=1),
        ),
    ]
