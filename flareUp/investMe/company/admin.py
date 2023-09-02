from django.contrib import admin
from .models import Company,Category,Investor_To_Company_Bank_Details
class CompanyAdmin():
    list_display=('business_stage','companyName','investment_amount','equity','valuation')

admin.site.register(Company)
admin.site.register(Category)
admin.site.register(Investor_To_Company_Bank_Details)
