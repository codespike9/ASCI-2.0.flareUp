from company.views import CompanyViewSet,CompanyProfileViewSet,flareUpValidation
from django.urls import path,include
from user.views import companyManagaerProfileRegister, CompanyManagaerLoginAPI,logout_view
from investor.views import register,InvestorLogin,CompnayList,filterCategory,Search,CompanyProfile,filterValuation,InvestmentSummary,Pay
from rest_framework.routers import DefaultRouter
from user.views import signin,get_csrf_token

router= DefaultRouter()
#company urls
router.register(r'company',CompanyViewSet,basename='company')
# router.register(r'CompanyProfile',CompanyProfileViewSet,basename='CompanyProfile')
router.register(r'loginAsCompanyManager',CompanyManagaerLoginAPI,basename='loginAsCompanyManager')
router.register(r'register_as_company_manager',companyManagaerProfileRegister,basename='register_as_company_manager')


#investor urls
router.register(r'companyList',CompnayList,basename='companyList')
router.register(r'register',register,basename='register')
router.register(r'loginInvestor',InvestorLogin,basename='loginInvestor')
router.register(r'searchCompany',Search,basename='searchCompany')
router.register(r'InvestmentSummary',InvestmentSummary,basename='InvestmentSummary')
router.register(r'pay',Pay,basename='pay')


urlpatterns =router.urls




urlpatterns = [
     path('',include(router.urls)),
     path("signin/",signin,name="signin"),
     path('filterCategory/<int:id>/',filterCategory.as_view({'get':'list'})),
     path('filterValuation/<int:price>/',filterValuation.as_view({'get':'list'})),
    #  path('InvestmentSummary/',InvestmentSummary.as_view({'post':'create'})),
     path('get_csrf_token/',get_csrf_token),
     path('companyProfileInvestor/<int:id>/',CompanyProfile.as_view({'get':'list'})),
     path('logout/', logout_view, name='logout'),
     path('CompanyProfile/<int:id>/', CompanyProfileViewSet.as_view({'get': 'list','patch':'update','delete':'destroy'})),
     
 ]