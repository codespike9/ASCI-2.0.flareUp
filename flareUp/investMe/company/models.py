from django.db import models
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
    last_year_revenue=models.FloatField(null=True,blank=True)
    raising_amount=models.FloatField(null=True,blank=True)
    equity=models.DecimalField(max_digits=3,decimal_places=0,validators=PERCENTAGE_VALIDATOR)
    valuation=models.FloatField(null=True,blank=True)
    quantity_available=models.IntegerField(null=True,blank=True,default=100)


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
