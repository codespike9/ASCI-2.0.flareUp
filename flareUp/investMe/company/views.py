from django.shortcuts import render,redirect
from rest_framework import viewsets,status
from .serializers import CompanySerializer,TokenSerializer
from rest_framework import parsers
from .models import Company,Category
from .utils import MultipartJsonParser
from rest_framework.response import Response
from django.contrib.auth.decorators  import login_required
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.conf import settings
from django.core.mail import send_mail
from functools import wraps
from django.http import JsonResponse
from user.models import CompanyManagerProfile


class CompanyViewSet(viewsets.ModelViewSet):
    
    serializer_class=CompanySerializer
    parser_classes = (MultipartJsonParser, parsers.JSONParser)
    queryset=Company.objects.all().order_by()
    allowed_methods = ['POST','GET']

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context['user'] = self.request.session.get('user')
        context['email']=self.request.session.get('email')
        return context
    
    def create(self,request):

        token = request.headers['Token']
        user = CompanyManagerProfile.objects.get(token=token)
        if token:
            data=request.data
            serialzer=CompanySerializer(data=data)
            if serialzer.is_valid():
                serialzer.validated_data['user']=user.id
                serialzer.save()
                subject = "New company listed"
                context={
                            "message":"New company created"
                        }
                html_message = render_to_string('mail/mail_template1.html',context)
                plain_message = strip_tags(html_message)
                to = [settings.EMAIL_HOST_USER, ]
                from_email =user.email
                send_mail(subject=subject, message=plain_message, from_email=from_email, recipient_list=to,fail_silently=False, html_message=html_message)
                return Response({'data':serialzer.data},status.HTTP_201_CREATED)
            else:
                return Response({"message":"Not valid"})
        else:
            return Response({"Message":"Either you are not logged in or token is not available."})           


    
    def list(self, request):
        token = request.headers['Token']
        if token:
            profile = CompanyManagerProfile.objects.get(token=token)
            queryset=Company.objects.filter(user=profile.id).order_by()
            serialized_data = self.serializer_class(queryset, many=True).data
            return Response(serialized_data)
        else:
            return Response({"Message":"Either you are not logged in or token is not available."})
        
class CompanyProfileViewSet(viewsets.ModelViewSet):
    queryset=Company.objects.all()
    serializer_class=CompanySerializer

    def list(self, request, *args, **kwargs):
        logged_in=request.session.get('logged_in')
        id = kwargs.get('id')
        queryset=Company.objects.filter(id=id)
        serialized_data = self.serializer_class(queryset, many=True).data
        return Response(serialized_data)

        
    def update(self,request,**kwargs):
        logged_in=request.session.get('logged_in')
        id = kwargs.get('id')
        if logged_in:
            data=request.data
            data['valid']=False
            print(data)
            obj=Company.objects.get(id=id)
            serializer=CompanySerializer(obj,data=data,partial=True)
            if serializer.is_valid():
                serializer.save()
                subject = "Data updated"
                context={
                    "message":obj.companyName + " company updated"
                }
                html_message = render_to_string('mail/mail_template1.html',context)
                plain_message = strip_tags(html_message)
                to = [settings.EMAIL_HOST_USER, ]
                from_email = settings.EMAIL_HOST_USER
                # send_mail(subject=subject, message=body, from_email=from_email, recipient_list=to,fail_silently=False)
                send_mail(subject=subject, message=plain_message, from_email=from_email, recipient_list=to,fail_silently=False, html_message=html_message)
            else:
                return Response(serializer.errors)
            return Response(serializer.data)
        else:
            return Response({'Message':"You are not logged in!"})
        
    def destroy(self,request,**kwargs):
        logged_in=request.session.get('logged_in')
        id = kwargs.get('id')
        if logged_in:
            queryset=Company.objects.filter(id=id)
            queryset.delete()
            return Response({'message':'person deleted'})
        else:
            return Response({'Message':"You are not logged in!"})

@login_required(login_url="/api/signin")
def flareUpValidation(request):
    company=Company.objects.all()
    context={
        "company":company
    }
    return render(request,"FlareUp/validation.html",context)
def valid(request,id):
    if request.method == "POST":
        valid=request.POST.get('valid')
    company=Company.objects.get(id=id)
    if valid == "on":
        company.valid=True
    else:
        company.valid=False
    company.save()
    return redirect("validation")
