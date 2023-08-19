from django.contrib.auth.models import User,AbstractUser
from django.db import models
from datetime import date
from django.db.models.signals import post_save
from django.dispatch import receiver

class CompanyManagerProfile(models.Model):
    username=models.CharField(max_length=100)
    email=models.EmailField(max_length=200)
    password=models.CharField(max_length=200)
    name = models.CharField(max_length=100)
    dob = models.DateField(("Date"), default=date.today)
    age=models.IntegerField(null=True,blank=True)
    gender=models.CharField(null=True,max_length=255)
    mobile_number=models.IntegerField()
    office_number=models.IntegerField()
    founder=models.BooleanField(default=True)
    designation=models.CharField(max_length=255)
    state=models.CharField(max_length=255)
    city=models.CharField(max_length=255)
    office_address=models.TextField()
    office_pincode=models.IntegerField()

    def __str__(self):
        return self.username
    class Meta:
        verbose_name_plural="Company Manager Profile"
    