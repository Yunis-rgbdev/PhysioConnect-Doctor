from django.urls import path
from authentication import views

urlpatterns = [
    path('register/', views.register_view, name="register_doctor"),
    path('login/', views.login_view, name="login_docotor"),
    path('non_refer_register/', views.non_refer_patient_registeration, name="register a non-refer patient"),
]