import json
from django.http import JsonResponse
from django.shortcuts import render
from pymongo import MongoClient
from .mongo_client import PatientCollection
from .mongo_client import DoctorCollection
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
# Create your views here.

client = MongoClient("mongodb://localhost:27017")
db = client["healthconnect"]
patients_collection = db["patients"]

def get_all_patients(request):
    patients_collection = PatientCollection()
    patients = patients_collection.get_all_patients()
    return JsonResponse({'patients': patients})

def get_patient_by_id(request, id):
    patients_collection = PatientCollection()
    patient = patients_collection.get_patient_by_id(id)
    if patient:
        return JsonResponse({'patient': patient})
    return JsonResponse({'error': 'Patient not found'})

@csrf_exempt
@require_http_methods(["POST"])
def activating_patient(request):
    client = MongoClient("mongodb://localhost:27017")
    db = client["healthconnect"]
    patients_collection = db["patients"]

    try:
        # Parse JSON data from request body
        data = json.loads(request.body.decode("utf-8"))
        id_number = data.get("id_number")
        isActive = data.get("isActive")

        if not id_number or isActive is None:
            return JsonResponse({'error': 'id_number and isActive are required fields'}, status=400)

        # Check if user exists with matching credentials
        user = patients_collection.find_one({"id_number": id_number})

        if user:
            # Validate isActive value
            if isActive not in [0, 1]:
                return JsonResponse({'error': 'isActive must be 0 or 1'}, status=400)

            # Update the user's isActive status
            patients_collection.update_one(
                {"id_number": id_number},
                {"$set": {"isActive": True if isActive == 1 else False}},
            )
            return JsonResponse({'message': 'User status updated successfully'}, status=200)
        else:
            return JsonResponse({'error': 'User not found'}, status=404)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

