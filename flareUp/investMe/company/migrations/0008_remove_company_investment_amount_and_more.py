# Generated by Django 4.2.4 on 2023-08-19 06:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('company', '0007_alter_company_user'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='company',
            name='investment_amount',
        ),
        migrations.AddField(
            model_name='company',
            name='raising_amount',
            field=models.FloatField(blank=True, null=True),
        ),
    ]