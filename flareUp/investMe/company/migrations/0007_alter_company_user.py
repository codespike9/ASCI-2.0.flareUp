# Generated by Django 4.2.4 on 2023-08-18 13:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('company', '0006_company_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='company',
            name='user',
            field=models.IntegerField(null=True),
        ),
    ]
