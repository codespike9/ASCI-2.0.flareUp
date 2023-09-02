from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator,MaxValueValidator
from user.models import CompanyManagerProfile
PERCENTAGE_VALIDATOR= [MinValueValidator(0),MaxValueValidator(100)]

def get_session_data(request):
    return request.session.get('user')

class Category(models.Model):
    category = models.CharField(max_length=255)

    def __str__(self):
        return self.category
    class Meta:
        verbose_name_plural="Categories"

class Company(models.Model):
    # INVESTMENT_OPTIONS = [
    #     (500000,500000),
    #     (1000000,1000000),
    #     (1500000,1500000),
    #     (2000000,2000000),
    #     (2500000,2500000)
    # ]
    user= models.IntegerField(null=True)
    business_stage=models.CharField(max_length=150)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    industry_category=models.CharField(max_length=180)
    companyName=models.TextField()
    description=models.TextField()
    link=models.URLField(max_length=200)    
    abstract=models.FileField(null=True,blank=True,upload_to="pdf_files", max_length=150)
    last_month_revenue=models.FloatField()
    second_last_month_revenue=models.FloatField()
    third_last_month_revenue=models.FloatField()
    last_year_revenue=models.FloatField(null=True,blank=True,default=0)
    raising_amount=models.FloatField(null=True,blank=True)
    equity=models.DecimalField(max_digits=3,decimal_places=0,validators=PERCENTAGE_VALIDATOR)
    valuation=models.FloatField(null=True,blank=True)
    quantity_available=models.IntegerField(null=True,blank=True,default=100)
    valid=models.BooleanField(default=False,blank=True)
    image = models.ImageField(null=True,blank=True,upload_to="cover_images")

    def __str__(self):
        return self.companyName
    class Meta:
        verbose_name_plural="Company"
    def clean_my_field(self):
        data = self.cleaned_data['styles']
        # Perform validation or cleaning logic
        return data
    def save(self, *args, **kwargs):
        if self.last_year_revenue != 0:
            self.valuation = self.last_year_revenue * 3.0 #p/s ratio
        else:
            self.valuation = ( self.last_month_revenue + self.second_last_month_revenue + self.third_last_month_revenue ) * 4
        self.raising_amount = float(self.equity) * ( self.valuation / 100 )
        super(Company, self).save(*args, **kwargs)

    # def save_with_session_data(self, data, *args, **kwargs):
    #     # Use session_data and perform any calculations
    #     self.user=data
    #     print(self.user)
    #     super(Company, self).save(*args, **kwargs)


class Investor_To_Company_Bank_Details(models.Model):

    investor=models.ForeignKey(User,on_delete=models.DO_NOTHING)
    IFSC_code=models.CharField(max_length=100)
    ACC_no=models.CharField(max_length=100)
    equity=models.DecimalField(max_digits=4,decimal_places=2,validators=PERCENTAGE_VALIDATOR,blank=True,null=True)
    company=models.ForeignKey(Company,on_delete=models.DO_NOTHING,blank=True,null=True)
    def __str__(self):
        return self.investor.first_name
    class Meta:
        verbose_name_plural="Investor_To_Company_Bank_Details"