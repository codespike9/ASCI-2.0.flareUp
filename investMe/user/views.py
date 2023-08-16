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

class LoginAPI(APIView):

    def post(self,request):
        data=request.data
        serializer=LoginSerializer(data=data)
        if not serializer.is_valid():
            return Response({
                'status':False,
                'message':serializer.errors
            },status.HTTP_400_BAD_REQUEST)
        
        user=authenticate(username=serializer.data['username'],password=serializer.data['password'])
        if not user:
            return Response({
                'status':False,
                'message':'Invalid Credentials'
            },status.HTTP_400_BAD_REQUEST)
        token, _= Token.objects.get_or_create(user=user)

        return Response({'status':True,'message':'user login','token':str(token)},status.HTTP_201_CREATED)