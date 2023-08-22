from company.views import CompanyViewSet,CompanyProfileViewSet
from django.urls import path,include
from user.views import companyManagaerProfileRegister, CompanyManagaerLoginAPI,logout_view
from investor.views import InvestorRegister, InvestorLogin
from rest_framework.routers import DefaultRouter

router= DefaultRouter()
router.register(r'company',CompanyViewSet,basename='company')
router.register(r'register_as_company_manager',companyManagaerProfileRegister,basename='register_as_company_manager')
router.register(r'register',InvestorRegister,basename='register')
router.register(r'invester_login',InvestorLogin,basename='register')
urlpatterns =router.urls




urlpatterns = [
     path('',include(router.urls)),
     path('loginAsCompanyManager/',CompanyManagaerLoginAPI.as_view()),
     path('logout/', logout_view, name='logout'),
     path('CompanyProfile/<int:id>/', CompanyProfileViewSet.as_view({'get': 'list','patch':'update','delete':'destroy'})),
     
 ]