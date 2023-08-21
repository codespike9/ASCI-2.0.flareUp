from rest_framework import serializers
from .models import Company,Category

class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = Category
        fields= '__all__' 
class CompanySerializer(serializers.ModelSerializer):
    class Meta:
        model= Company
        fields='__all__'
    def create(self, validated_data):
        # Assign a value to a field before creating the object
        validated_data['user'] = self.context.get('session_data')
        return super().create(validated_data)

