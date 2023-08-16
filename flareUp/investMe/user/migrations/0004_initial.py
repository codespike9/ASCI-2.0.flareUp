# Generated by Django 4.2.4 on 2023-08-16 07:14

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('user', '0003_delete_companymanagerprofile'),
    ]

    operations = [
        migrations.CreateModel(
            name='CompanyManagerProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=100)),
                ('email', models.EmailField(max_length=200)),
                ('password', models.CharField(max_length=200)),
                ('name', models.CharField(max_length=100)),
                ('dob', models.DateField(default=datetime.date.today, verbose_name='Date')),
                ('age', models.IntegerField(blank=True, null=True)),
                ('gender', models.CharField(max_length=255, null=True)),
                ('mobile_number', models.IntegerField()),
                ('office_number', models.IntegerField()),
                ('founder', models.BooleanField(default=True)),
                ('designation', models.CharField(max_length=255)),
                ('state', models.CharField(max_length=255)),
                ('city', models.CharField(max_length=255)),
                ('office_address', models.TextField()),
                ('office_pincode', models.IntegerField()),
            ],
        ),
    ]
