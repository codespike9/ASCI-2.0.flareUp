from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,viewsets
from django.contrib.auth.models import User
from .serializers import RegisterSerializer,InvestorLoginSerializer
from django.contrib.auth import login
from company.models import Company
from rest_framework.authtoken.models import Token
from .serializers import CompanyListSerializer,FilterCategorySerializer
# Create your views here.
class register(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    http_method_names = ['post']


class InvestorLogin(viewsets.ViewSet):

    http_method_names = ['post']
    def create(self,request):
        data=request.data
        serializer=InvestorLoginSerializer(data=data)
        if not serializer.is_valid():
            return Response({
                'status':False,
                'message':serializer.errors
            },status.HTTP_400_BAD_REQUEST)
        
        user=User.objects.all()
        for user in user:
            if user.email == serializer.data['email'] and user.password == serializer.data['password']:
                login(request,user)
                token, _= Token.objects.get_or_create(user=user)
                return Response({'status':True,'message':'user login','user':user.username,'token':str(token)},status.HTTP_201_CREATED)
        return Response({
            'status':False,
            'message':'Invalid Credentials'
        },status.HTTP_400_BAD_REQUEST)


class CompnayList(viewsets.ModelViewSet):
    queryset=Company.objects.all()
    serializer_class = CompanyListSerializer
    def list(self, request):
        if request.user.is_authenticated:
            queryset=Company.objects.all()
            serialized_data = self.serializer_class(queryset, many=True).data
        # Use param_value in your logic
            return Response(serialized_data)
        else:
            return Response({'Message':"You are not logged in!"})

class filterCategory(viewsets.ViewSet):
    serializer_class=FilterCategorySerializer
    def list(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            id = kwargs.get('id')
            queryset=Company.objects.filter(category=id)
            serialized_data = self.serializer_class(queryset, many=True).data
            return Response(serialized_data)
        else:
            return Response({'Message':'Login required'})



