# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-10 04:52
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tocayoapp', '0004_desig_uid'),
    ]

    operations = [
        migrations.RenameField('Token', 'token', 'name'),
    ]