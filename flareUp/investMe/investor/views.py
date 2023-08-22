from django.shortcuts import render
from django.contrib.auth.models import User
from rest_framework import viewsets, status
from .serializers import InvestorSerializer, InvestorLoginSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate, login, logout
from rest_framework.authtoken.models import Token


class InvestorRegister(viewsets.ViewSet):
    queryset = User.objects.all()
    serializer_class = InvestorSerializer
    http_method_names = ['post']

class InvestorLogin(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = InvestorLoginSerializer

    def create(self, request):
        serializer = InvestorLoginSerializer(data = request.data)
        if not serializer.is_valid():
            return Response({'message' : serializer.errors}, status.HTTP_400_BAD_REQUEST)
        
        print(serializer.data)
        user = authenticate(request, username = serializer.data['username'], password = serializer.data['password'])
        
        if not user:
            return Response({'message':'Invalid Credentials'}, status.HTTP_400_BAD_REQUEST)
        
        login(request, user)
        token, _ = Token.objects.get_or_create(user = user)

        return Response({'message': 'User logged In','token':str(token)}, status.HTTP_201_CREATED)
        

    




# Create your views here.
