from rest_framework import viewsets,status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .models import CompanyManagerProfile
from .serializers import CompanyManagerProfileSerializer,CompanyManagaerLoginSerializer
from django.contrib.auth import logout
from rest_framework.decorators import api_view
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth import authenticate, login,logout
from django.views.decorators.cache import never_cache
from django.middleware.csrf import get_token
import secrets

def generate_token():
    return secrets.token_urlsafe(32)  # Generates a URL-safe token of length 32


@api_view(['GET'])
def logout_view(request):
    logout(request)
    data = {'message': 'Logged Out!'}
    return Response(data)



class companyManagaerProfileRegister(viewsets.ModelViewSet):
    queryset = CompanyManagerProfile.objects.all()
    serializer_class = CompanyManagerProfileSerializer
    http_method_names = ['post']

    
class CompanyManagaerLoginAPI(viewsets.ModelViewSet):
    queryset = CompanyManagerProfile.objects.all()
    serializer_class = CompanyManagaerLoginSerializer
    http_method_names = ['post']
    def create(self,request):
        data=request.data
        serializer=CompanyManagaerLoginSerializer(data=data)
        if not serializer.is_valid():
            return Response({
                'status':False,
                'message':serializer.errors
            },status.HTTP_400_BAD_REQUEST)
        
        print(serializer.data['username'])
        print(serializer.data['password'])
        users=CompanyManagerProfile.objects.all()
        for user in users:
            if user.username == serializer.data['username'] and user.password == serializer.data['password']:
                print(user.id)
                profile = CompanyManagerProfile.objects.get(id=user.id)
                profile.token = generate_token()
                profile.save()
                
                # login(request, user)

                request.session['user']=user.id
                request.session['email']=user.email

                return Response({'status':True,'message':'user login','token':profile.token},status.HTTP_201_CREATED)
        return Response({
            'status':False,
            'message':'Invalid Credentials'
        },status.HTTP_400_BAD_REQUEST)







@never_cache
def signin(request):
    if request.user.is_authenticated:
        return redirect('validation')
    if request.method=="POST":
        username = request.POST.get('user_name')
        password = request.POST.get('password')

        user_exists=False

        user = authenticate(request,username=username, password=password)
        if user is None:
            messages.error(request, "Invalid Username or Password")
            return render(request,"user/signin.html")
        else:
            login(request,user)
            return redirect('validation')

    return render(request,'user/signin.html')



@api_view(['GET'])
def get_csrf_token(request):
    csrf_token = get_token(request)
    return Response({'csrf_token': csrf_token})

