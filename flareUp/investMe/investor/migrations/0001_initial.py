# Generated by Django 4.2.4 on 2023-08-28 19:09

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Investor_Bank_Details',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('IFSC_code', models.CharField(max_length=100)),
                ('ACC_no', models.CharField(max_length=100)),
            ],
            options={
                'verbose_name_plural': 'Investor_Bank_Details',
            },
        ),
    ]
