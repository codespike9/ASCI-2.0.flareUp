# Generated by Django 4.2.4 on 2023-08-15 12:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='companymanagerprofile',
            name='age',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
