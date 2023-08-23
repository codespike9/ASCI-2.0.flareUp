from rest_framework import serializers
from .models import Company,Category
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.conf import settings
from django.core.mail import send_mail
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
        subject = "New company listed"
        context={
                    "message":"New company created"
                }
        html_message = render_to_string('mail/mail_template1.html',context)
        plain_message = strip_tags(html_message)
        to = [settings.EMAIL_HOST_USER, ]
        from_email = self.context.get('email')
        # send_mail(subject=subject, message=body, from_email=from_email, recipient_list=to,fail_silently=False)
        send_mail(subject=subject, message=plain_message, from_email=from_email, recipient_list=to,fail_silently=False, html_message=html_message)

        validated_data['user'] = self.context.get('user')
        return super().create(validated_data)

