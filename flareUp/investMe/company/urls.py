from django.urls import path,include
from .views import valid
urlpatterns = [
     path('<int:id>',valid,name="valid"),
     
 ]