# Generated by Django 2.2.1 on 2019-10-27 22:56

import django_enumfield.db.fields
from django.db import migrations

import events.interfaces


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0011_auto_20190818_1321'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='status',
            field=django_enumfield.db.fields.EnumField(default=0, enum=events.interfaces.EventStatusType),
        ),
    ]
