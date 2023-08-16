from django.db import models
from django.core.validators import MinValueValidator,MaxValueValidator

PERCENTAGE_VALIDATOR= [MinValueValidator(0),MaxValueValidator(100)]

class Category(models.Model):
    category = models.CharField(max_length=255)

    def __str__(self):
        return self.category
    class Meta:
        verbose_name_plural="Categories"

class Company(models.Model):
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
    investment_amount=models.FloatField()
    equity=models.DecimalField(max_digits=3,decimal_places=0,validators=PERCENTAGE_VALIDATOR)
    valuation=models.FloatField()


    def __str__(self):
        return self.companyName
    class Meta:
        verbose_name_plural="Company"
    def clean_my_field(self):
        data = self.cleaned_data['styles']
        # Perform validation or cleaning logic
        return data
