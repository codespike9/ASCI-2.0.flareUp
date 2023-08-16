from rest_framework import viewsets,status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .models import CompanyManagerProfile
from .serializers import CompanyManagerProfileSerializer,RegisterSerializer,CompanyManagaerLoginSerializer

class register(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    allowed_methods = ['POST']

class companyManagaerProfileRegister(viewsets.ModelViewSet):
    queryset = CompanyManagerProfile.objects.all()
    serializer_class = CompanyManagerProfileSerializer
    allowed_methods = ['POST']

class CompanyManagaerLoginAPI(APIView):

    def post(self,request):
        data=request.data
        serializer=CompanyManagaerLoginSerializer(data=data)
        if serializer.is_valid():
            return Response({'status':True,'message':'user login'},status.HTTP_201_CREATED)
            return Response({
                'status':False,
                'message':serializer.errors
            },status.HTTP_400_BAD_REQUEST)
        
        # user=authenticate(username=serializer.data['username'],password=serializer.data['password'])
        # if not user:
        #     return Response({
        #         'status':False,
        #         'message':'Invalid Credentials'
        #     },status.HTTP_400_BAD_REQUEST)
        # print(serializer.data)
        else:
            return Response({
                    'status':False,
                    'message':serializer.errors
                },status.HTTP_400_BAD_REQUEST)