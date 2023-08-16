from django.shortcuts import render
from rest_framework import viewsets,status
from .serializers import CompanySerializer
from rest_framework import parsers
from .models import Company
from .utils import MultipartJsonParser

class CompanyViewSet(viewsets.ModelViewSet):
    serializer_class=CompanySerializer
    parser_classes = (MultipartJsonParser, parsers.JSONParser)
    queryset=Company.objects.all().order_by()
