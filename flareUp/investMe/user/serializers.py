from rest_framework import serializers
from django.contrib.auth.models import User
from .models import CompanyManagerProfile

class RegisterSerializer(serializers.Serializer):
    username=serializers.CharField()
    email=serializers.EmailField()
    password=serializers.CharField()

    def validate(self, data):
        if data['username']:
            if User.objects.filter(username=data['username']).exists():
                raise serializers.ValidationError('username is taken')
        if data['email']:
            if User.objects.filter(email=data['email']).exists():
                raise serializers.ValidationError('email is taken')
        return data
    
    def create(self, validated_data):
        user=User.objects.create(username=validated_data['username'],email=validated_data['email'])
        user.set_password(validated_data['password'])
        user.save()
        return validated_data
    
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