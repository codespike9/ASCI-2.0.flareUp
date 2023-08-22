from rest_framework import viewsets,status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .models import CompanyManagerProfile
from .serializers import CompanyManagerProfileSerializer,RegisterSerializer,CompanyManagaerLoginSerializer
from django.contrib.auth import logout
from rest_framework.decorators import api_view
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth import authenticate, login,logout
from django.views.decorators.cache import never_cache




@api_view(['GET'])
def logout_view(request):
    logout(request)
    data = {'message': 'Logged Out!'}
    return Response(data)

class register(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    http_method_names = ['post']

class companyManagaerProfileRegister(viewsets.ModelViewSet):
    queryset = CompanyManagerProfile.objects.all()
    serializer_class = CompanyManagerProfileSerializer
    http_method_names = ['post']

class CompanyManagaerLoginAPI(APIView):

    def post(self,request):
        data=request.data
        serializer=CompanyManagaerLoginSerializer(data=data)
        if not serializer.is_valid():
            return Response({
                'status':False,
                'message':serializer.errors
            },status.HTTP_400_BAD_REQUEST)
        
        user=CompanyManagerProfile.objects.all()
        for user in user:
            if user.username == serializer.data['username'] and user.password == serializer.data['password']:
                # token, _= Token.objects.get_or_create(user=user)
                request.session['logged_in'] = True
                request.session['user']=user.id
                request.session['email']=user.email
                return Response({'status':True,'message':'user login'},status.HTTP_201_CREATED)
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


