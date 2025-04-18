from django.urls import path
from authentication import views

urlpatterns = [
    path('register/', views.register_view, name="register_doctor"),
    path('login/', views.login_view, name="login_docotor"),
]