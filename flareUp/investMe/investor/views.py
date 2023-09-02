from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,viewsets
from django.contrib.auth.models import User
from .serializers import RegisterSerializer,InvestorLoginSerializer,InvestmentSummarySerializer,PaymentSerializer
from django.contrib.auth import login
from company.models import Company,Investor_To_Company_Bank_Details
from .models import Investor_portfolio,Investor_Bank_Details
from rest_framework.authtoken.models import Token
from .serializers import CompanyListSerializer
from company.serializers import CompanySerializer
from django.contrib.auth import authenticate
from django.views.decorators.csrf import csrf_protect,csrf_exempt
from django.utils.decorators import method_decorator
import razorpay
from django.conf import settings
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.core.mail import send_mail
# Create your views here.

class register(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    http_method_names = ['post']


class InvestorLogin(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = InvestorLoginSerializer
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
    http_method_names = ['get']
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
    queryset=Company.objects.all()
    http_method_names = ['get']
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
            return Response(serialized_data,status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({'Message':'Login required'})
        


class filterValuation(viewsets.ViewSet):
    serializer_class=CompanyListSerializer
    def list(self,request,*args, **kwargs):
        if request.user.is_authenticated:
            price=kwargs.get('price')
            queryset=Company.objects.filter(valuation__gt = price)
            serialized_data = self.serializer_class(queryset, many=True).data
            return Response(serialized_data,status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({'Message':'Login required'})


        

class Search(viewsets.ModelViewSet):
    serializer_class=CompanyListSerializer
    companies=Company.objects.all()
    http_method_names = ['get']
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

def BusinessLogic(equity,valuation):
    equivalent_price=float(equity) * (valuation) / 100
    return equivalent_price


class InvestmentSummary(viewsets.ModelViewSet):
    serializer_class=InvestmentSummarySerializer
    companies=Company.objects.all()
    http_method_names = ['post']

    @csrf_exempt 
    def create(self,request,*args, **kwargs):
        data=request.data
        serializer=InvestmentSummarySerializer(data=data)
        if serializer.is_valid():
            choosen_equity=serializer.data['equity']
            id=serializer.data['id']
            company=Company.objects.get(id=id)
            equivalent_price= BusinessLogic(choosen_equity,company.valuation)
            client= razorpay.Client(auth = (settings.KEY , settings.SECRET) )
            print(client)
            payment= client.order.create({'amount':equivalent_price * 100,'currency':'INR','payment_capture':1})
            return Response({'choosen_equity':choosen_equity,'equivalent_price':equivalent_price,'company_id':id,'payment':payment},status.HTTP_201_CREATED)

class Pay(viewsets.ModelViewSet):
    serializer_class=PaymentSerializer
    companies=Company.objects.all()
    http_method_names = ['post']

    def create(self,request,*args,**kwargs):
        data=request.data
        serializer=PaymentSerializer(data=data)
        
        if serializer.is_valid():
            print(serializer.data['equity_purchased'])

            investor = Investor_portfolio(
                Investor= request.user,
                company=Company.objects.get(id=serializer.data['company']),
                equity_purchased=serializer.data['equity_purchased'],
                price_paid =serializer.data['price_paid'],
                payment_id=serializer.data['payment_id']
            )
            investor.save()


            equity=Company.objects.get(id=serializer.data['company']).equity
            company=Company.objects.get(id=serializer.data['company'])
            company.equity=float(equity) - float(serializer.data['equity_purchased'])
            company.save()


            companies=Investor_To_Company_Bank_Details.objects.all()
            investorList=[]
            for company in companies:
                investorList.append(company.investor)

            if request.user in investorList:
                company=Company.objects.get(id=serializer.data['company'])
                investor=Investor_To_Company_Bank_Details.objects.get(investor=request.user,company=company)
                investor.equity=float(investor.equity)+float(serializer.data['equity_purchased'])
                investor.save()
            else:
                investor=Investor_To_Company_Bank_Details(
                    investor=request.user,
                    IFSC_code=Investor_Bank_Details.objects.get(investor=request.user).IFSC_code,
                    ACC_no=Investor_Bank_Details.objects.get(investor=request.user).ACC_no,
                    equity=float(serializer.data['equity_purchased']),
                    company=company
                )
                investor.save()


            subject = "New company listed"
            context={
                        "message":"Thanks for investing!"
                    }
            html_message = render_to_string('mail/mail_template1.html',context)
            plain_message = strip_tags(html_message)
            to = [request.user.email, ]
            from_email =settings.EMAIL_HOST_USER
            send_mail(subject=subject, message=plain_message, from_email=from_email, recipient_list=to,fail_silently=False, html_message=html_message)

            return Response({"message":"Successful transaction"},status=status.HTTP_202_ACCEPTED)

# class InvestorLogin(viewsets.ViewSet):

#     http_method_names = ['post']
#     def create(self,request):
#         data=request.data
#         if not serializer.is_valid():
#             return Response({
#                 'status':False,
#                 'message':serializer.errors
#             },status.HTTP_400_BAD_REQUEST)
        
#         user=authenticate(username=serializer.data['username'],password=serializer.data['password'])
#         if not user:
#             return Response({
#                 'status':False,
#                 'message':'Invalid Credentials'
#             },status.HTTP_400_BAD_REQUEST)
#         token, _= Token.objects.get_or_create(user=user)
#         login(request,user)

#         return Response({'status':True,'message':'user login','token':str(token)},status.HTTP_201_CREATED)

            