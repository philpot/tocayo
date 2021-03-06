# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-06 05:25
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Author',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('author', models.CharField(max_length=127)),
            ],
        ),
        migrations.CreateModel(
            name='Desig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.CreateModel(
            name='Freq',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('count', models.IntegerField(default=0)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
                ('desig', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Desig')),
            ],
        ),
        migrations.CreateModel(
            name='Gender',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=3)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.CreateModel(
            name='Idea',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('idea', models.CharField(max_length=47)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.CreateModel(
            name='Lang',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=47)),
                ('short', models.CharField(max_length=2)),
                ('long', models.CharField(max_length=3)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.CreateModel(
            name='Meaning',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
                ('desig', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Desig')),
                ('idea', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Idea')),
            ],
        ),
        migrations.CreateModel(
            name='Onto',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='onto_child_of', to='tocayoapp.Author')),
                ('child', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Idea')),
                ('parent', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='onto_parent_of', to='tocayoapp.Idea')),
            ],
        ),
        migrations.CreateModel(
            name='Pronounce',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
                ('desig', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Desig')),
            ],
        ),
        migrations.CreateModel(
            name='Scope',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
                ('desig', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Desig')),
                ('lang', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Lang')),
            ],
        ),
        migrations.CreateModel(
            name='ScopeType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=31)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.CreateModel(
            name='Survey',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=47)),
                ('year', models.IntegerField(default=0)),
                ('basis', models.IntegerField(default=0)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
                ('gender', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Gender')),
            ],
        ),
        migrations.CreateModel(
            name='Token',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('token', models.CharField(max_length=31)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.CreateModel(
            name='Utter',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('utter', models.CharField(max_length=47)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Author')),
            ],
        ),
        migrations.AddField(
            model_name='scope',
            name='scopeType',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.ScopeType'),
        ),
        migrations.AddField(
            model_name='pronounce',
            name='utter',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Utter'),
        ),
        migrations.AddField(
            model_name='freq',
            name='survey',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Survey'),
        ),
        migrations.AddField(
            model_name='desig',
            name='gender',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='tocayoapp.Gender'),
        ),
    ]
