# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-15 05:17
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('tocayoapp', '0010_auto_20151213_0438'),
    ]

    operations = [
        migrations.AlterField(
            model_name='onto',
            name='child',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='onto_child_set', to='tocayoapp.Idea'),
        ),
        migrations.AlterField(
            model_name='onto',
            name='parent',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='onto_parent_set', to='tocayoapp.Idea'),
        ),
    ]
