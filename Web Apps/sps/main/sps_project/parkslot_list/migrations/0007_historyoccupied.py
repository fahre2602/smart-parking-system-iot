# Generated by Django 2.1.7 on 2019-07-27 09:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('parkslot_list', '0006_auto_20190509_1006'),
    ]

    operations = [
        migrations.CreateModel(
            name='HistoryOccupied',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('tanggal', models.DateTimeField(auto_now_add=True)),
                ('slot', models.CharField(max_length=4)),
                ('status', models.CharField(max_length=6)),
            ],
        ),
    ]
