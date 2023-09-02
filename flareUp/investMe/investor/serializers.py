from rest_framework import serializers
from django.contrib.auth.models import User
from company.models import Company

from django.core.validators import MinValueValidator,MaxValueValidator
from user.models import CompanyManagerProfile
PERCENTAGE_VALIDATOR= [MinValueValidator(0),MaxValueValidator(100)]

class InvestorLoginSerializer(serializers.Serializer):
        username= serializers.CharField()
        password=serializers.CharField()

class RegisterSerializer(serializers.ModelSerializer):

    class Meta:
        model=User
        fields=["first_name","last_name","username","email","password"]

    def validate(self, data):
        if data['username']:
            if User.objects.filter(username=data['username']).exists():
                raise serializers.ValidationError('username is taken')
        if data['email']:
            if User.objects.filter(email=data['email']).exists():
                raise serializers.ValidationError('email is taken')
        return data
    
    def create(self, validated_data):
        user=User.objects.create(username=validated_data['username'],email=validated_data['email'],first_name=validated_data['first_name'],last_name=validated_data['last_name'])
        user.set_password(validated_data['password'])
        user.save()
        return validated_data 


class CompanyListSerializer(serializers.ModelSerializer):
     

     class Meta:
          model =Company
          fields='__all__'

class InvestmentSummarySerializer(serializers.Serializer):
     
    equity=serializers.FloatField()
    id=serializers.IntegerField()


class PaymentSerializer(serializers.Serializer):
    equity_purchased=serializers.FloatField()
    payment_id=serializers.CharField()
    price_paid=serializers.FloatField()
    company=serializers.IntegerField()

