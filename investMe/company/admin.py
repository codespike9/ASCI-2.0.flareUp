from django.contrib import admin
from .models import Company,Category
class CompanyAdmin():
    list_display=('business_stage','companyName','investment_amount','equity','valuation')

admin.site.register(Company)
admin.site.register(Category)
