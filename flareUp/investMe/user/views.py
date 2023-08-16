from rest_framework import viewsets,status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .models import CompanyManagerProfile
from .serializers import CompanyManagerProfileSerializer,RegisterSerializer,LoginSerializer

class register(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    allowed_methods = ['POST']

class companyManagaerProfileRegister(viewsets.ModelViewSet):
    
    queryset = CompanyManagerProfile.objects.all()
    serializer_class = CompanyManagerProfileSerializer

    allowed_methods = ['POST']

