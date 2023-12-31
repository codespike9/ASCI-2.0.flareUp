# Generated by Django 4.2.4 on 2023-08-28 19:21

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('company', '0013_delete_investor_bank_details'),
    ]

    operations = [
        migrations.CreateModel(
            name='Investor_To_Company_Bank_Details',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('IFSC_code', models.CharField(max_length=100)),
                ('ACC_no', models.CharField(max_length=100)),
                ('investor', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name_plural': 'Investor_To_Company_Bank_Details',
            },
        ),
    ]
