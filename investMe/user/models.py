from django.contrib.auth.models import User
from django.db import models
from datetime import date
from django.db.models.signals import post_save
from django.dispatch import receiver

class CompanyManagerProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
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
        return self.user.username
    
    @receiver(post_save, sender=User)
    def create_company_manager_profile(sender, instance, created, **kwargs):
        if created:
            CompanyManagerProfile.objects.create(user=instance)

    # @receiver(post_save, sender=User)
    # def save_company_manager_profile(sender, instance, **kwargs):
    #     instance.companymanagerprofile.save()
    post_save.connect(create_company_manager_profile, sender=User)