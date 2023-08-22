from django.shortcuts import render,redirect
from rest_framework import viewsets,status
from .serializers import CompanySerializer
from rest_framework import parsers
from .models import Company
from .utils import MultipartJsonParser
from rest_framework.response import Response
from django.contrib.auth.decorators  import login_required



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
    

    def list(self, request):
        
        logged_in=request.session.get('logged_in')
        
        if logged_in:
            queryset=Company.objects.filter(user=request.session.get('user'),valid=True).order_by()
            serialized_data = self.serializer_class(queryset, many=True).data
            return Response(serialized_data)
        else:
            return Response({'Message':"You are not logged in!"})
        
class CompanyProfileViewSet(viewsets.ModelViewSet):
    serializer_class=CompanySerializer
    def list(self, request, *args, **kwargs):
        logged_in=request.session.get('logged_in')
        id = kwargs.get('id')
        if logged_in:
            queryset=Company.objects.filter(id=id)
            serialized_data = self.serializer_class(queryset, many=True).data
        # Use param_value in your logic
            return Response(serialized_data)
        else:
            return Response({'Message':"You are not logged in!"})
    def update(self,request,**kwargs):
        logged_in=request.session.get('logged_in')
        id = kwargs.get('id')
        if logged_in:
            queryset=Company.objects.filter(id=id)
            serialized_data = self.serializer_class(queryset, many=True).data
            data=request.data
            obj=Company.objects.get(id=id)
            serializer=CompanySerializer(obj,data=data,partial=True)
            if serializer.is_valid():
                serializer.save()
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
