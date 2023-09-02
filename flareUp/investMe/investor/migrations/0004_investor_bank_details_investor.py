# Generated by Django 4.2.4 on 2023-09-01 20:26

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('investor', '0003_alter_investor_bank_details_options_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='investor_bank_details',
            name='investor',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL),
        ),
    ]
