from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,viewsets
from django.contrib.auth.models import User
from .serializers import RegisterSerializer,InvestorLoginSerializer
from django.contrib.auth import login
from company.models import Company
from rest_framework.authtoken.models import Token
from .serializers import CompanyListSerializer
from company.serializers import CompanySerializer
from django.contrib.auth import authenticate
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
        
        user=authenticate(username=serializer.data['username'],password=serializer.data['password'])
        if not user:
            return Response({
                'status':False,
                'message':'Invalid Credentials'
            },status.HTTP_400_BAD_REQUEST)
        token, _= Token.objects.get_or_create(user=user)
        login(request,user)

        return Response({'status':True,'message':'user login','token':str(token)},status.HTTP_201_CREATED)


class CompnayList(viewsets.ModelViewSet):
    queryset=Company.objects.all()
    serializer_class = CompanyListSerializer
    def list(self, request):
        if request.user.is_authenticated:
            queryset=Company.objects.filter(valid=True).order_by()
            serialized_data = self.serializer_class(queryset, many=True).data
        # Use param_value in your logic
            return Response(serialized_data)
        else:
            return Response({'Message':"You are not logged in!"})


class CompanyProfile(viewsets.ModelViewSet):
    serializer_class=CompanySerializer
    def list(self, request, *args, **kwargs):
        id = kwargs.get('id')
        if request.user.is_authenticated:
            queryset=Company.objects.filter(id=id)
            serialized_data = self.serializer_class(queryset, many=True).data
        # Use param_value in your logic
            return Response(serialized_data)
        else:
            return Response({'Message':"You are not logged in!"})
        
class filterCategory(viewsets.ViewSet):
    serializer_class=CompanyListSerializer
    def list(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            id = kwargs.get('id')
            queryset=Company.objects.filter(category=id)
            serialized_data = self.serializer_class(queryset, many=True).data
            return Response(serialized_data)
        else:
            return Response({'Message':'Login required'})
        

class filterValuation(viewsets.ViewSet):
    serializer_class=CompanyListSerializer
    def list(self,request,*args, **kwargs):
        if request.user.is_authenticated:
            price=kwargs.get('price')
            queryset=Company.objects.filter(valuation__gt = price)
            serialized_data = self.serializer_class(queryset, many=True).data
            return Response(serialized_data)
        else:
            return Response({'Message':'Login required'})


        

class Search(viewsets.ModelViewSet):
    serializer_class=CompanyListSerializer
    companies=Company.objects.all()
    def list(self,request):
        if request.user.is_authenticated:
            search= request.GET.get('search')
            if len(search) > 80 :
                return Response({'message':'Results not found'})
            else:
                companies=Company.objects.filter(companyName__icontains=search)
            serializer=self.serializer_class(companies,many=True)
            return Response({'data':serializer.data},status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({'message':'Login required'})


