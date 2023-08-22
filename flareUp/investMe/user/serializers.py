from rest_framework import serializers
from django.contrib.auth.models import User
from .models import CompanyManagerProfile
from company.models import Company

    
class CompanyManagerProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyManagerProfile
        fields = '__all__'  
        
    def validate(self, data):
        if data['username']:
            if CompanyManagerProfile.objects.filter(username=data['username']).exists():
                raise serializers.ValidationError('username is taken')
        if data['email']:
            if CompanyManagerProfile.objects.filter(email=data['email']).exists():
                raise serializers.ValidationError('email is taken')
        return data

class CompanyManagaerLoginSerializer(serializers.Serializer):
    username= serializers.CharField()
    password=serializers.CharField()

