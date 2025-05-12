from django.urls import path
from dashboard import views

urlpatterns = [
    path('patients/', views.get_all_patients, name='get all patients'),
    path('active/', views.activating_patient, name='active or deactive patient'),
]