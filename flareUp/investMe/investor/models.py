from django.db import models
from django.contrib.auth.models import User
from company.models import Company
# Create your models here.
from django.core.validators import MinValueValidator,MaxValueValidator

PERCENTAGE_VALIDATOR= [MinValueValidator(0),MaxValueValidator(100)]



class Investor_Bank_Details(models.Model):
    IFSC_code=models.CharField(max_length=100)
    ACC_no=models.CharField(max_length=100)
    investor=models.ForeignKey(User,on_delete=models.DO_NOTHING,null=True,blank=True)

    def __str__(self):
        return self.ACC_no
    class Meta:
        verbose_name_plural="Investors Bank Details"


class Investor_portfolio(models.Model):
    Investor= models.ForeignKey(User,on_delete=models.DO_NOTHING)
    company=models.ForeignKey(Company,on_delete=models.DO_NOTHING)
    equity_purchased=models.DecimalField(max_digits=4,decimal_places=2,validators=PERCENTAGE_VALIDATOR)
    price_paid=models.FloatField()
    payment_id=models.CharField(max_length=100)

    def __str__(self):
        return self.company.companyName
    class Meta:
        verbose_name_plural="Investors Portfolios"
