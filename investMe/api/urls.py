from company.views import CompanyViewSet
from django.urls import path,include
from user.views import companyManagaerProfileRegister,LoginAPI,register
from rest_framework.routers import DefaultRouter

router= DefaultRouter()
router.register(r'company',CompanyViewSet,basename='company')
router.register(r'register',register,basename='register')
router.register(r'register_as_company_manager',companyManagaerProfileRegister,basename='register_as_company_manager')
urlpatterns =router.urls




urlpatterns = [
     path('',include(router.urls)),
     path('login/',LoginAPI.as_view()),
#     path('index/',index),
#     path('person/',person),
#     path('login/',login),
#     path('person-api-class/',personAPI.as_view()),
 ]