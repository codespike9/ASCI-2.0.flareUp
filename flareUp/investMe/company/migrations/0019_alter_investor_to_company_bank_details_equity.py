# Generated by Django 4.2.4 on 2023-09-02 17:26

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('company', '0018_alter_company_last_year_revenue'),
    ]

    operations = [
        migrations.AlterField(
            model_name='investor_to_company_bank_details',
            name='equity',
            field=models.DecimalField(blank=True, decimal_places=2, max_digits=4, null=True, validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(100)]),
        ),
    ]
