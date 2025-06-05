from django.http import JsonResponse, HttpResponse
from django.shortcuts import render
from pymongo import MongoClient
import json
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods

# Create your views here.

# Initializing MongoDB client
# Assuming MongoDB is running on localhost:27017
client = MongoClient("mongodb://localhost:27017")
db = client["healthconnect"]
doctors_collection = db["doctors"]
patients_collection = db['patients']

#test for patients database
print(patients_collection)

# Register new docotor
@csrf_exempt
def register_view(request):

    # Check if the request method is POST
    if request.method != 'POST':
        return JsonResponse({'error': 'Invalid request method'}, status=405)
    
    try:
        # Decode the request body and parse the JSON data
        # Check if the request body is in JSON format
        data = json.loads(request.body.decode('utf-8'))
        # Check if the required fields are present in the request body
        # Extract the required fields from the request body
        id_number = data.get('id_number')
        password = data.get('password')
        name = data.get('name')
        age = data.get('age')
        email = data.get('email')
        phone_number = data.get('phone_number')
        gender = data.get('gender')
        
        # Check if the required fields are present in the request body
        # If any of the required fields are missing, return an error response
        if not id_number or not password or not phone_number:
            return JsonResponse({'error': 'Missing id_number, password or phone_number'}, status=400)
        
        # Check if the user already exists in the database
        # If the user already exists, return an error response
        if doctors_collection.find_one({"id_number": id_number}):
            return JsonResponse({'error': 'User already exists.'}, status=400)
        
        # If the user does not exist, create a new user in the database
        # Create a new user document with the provided data
        # Insert the new user document into the database
        # Return a success response
        doctor_data = {
            "id_number": id_number,
            "password": password,
            "name": name,
            "age": age,
            'email': email,
            "phone_number": phone_number,
            "gender": gender,
        }

        # Insert the new user document into the database
        # doctors_collection.insert_one(doctor_data)
        doctors_collection.insert_one(doctor_data)

        # Return a success response
        return JsonResponse({'message': 'User registered successfully.'})
    except json.JSONDecodeError:
        return JsonResponse({'error': 'Invalid JSON'}, status=400)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
    
# Login doctor
@csrf_exempt
def login_view(request):
    # Check if the request method is POST
    # If the request method is not POST, return an error response
    # If the request method is POST, proceed with the login process
    if request.method != 'POST':
        return JsonResponse({'error': 'Invalid request method'}, status=405)
    
    try:
        # Decode the request body and parse the JSON data
        # Check if the request body is in JSON format
        data = json.loads(request.body.decode('utf-8'))
        # Extract the required fields from the request body
        id_number = data.get('id_number')
        password = data.get('password')
        
        # Check if the required fields are present in the request body
        # If any of the required fields are missing, return an error response
        if not id_number or not password:
            return JsonResponse({'error': 'Missing id_number or password'}, status=400),
        
        # Check if the user exists in the database
        # If the user does not exist, return an error response
        if doctors_collection.find_one({"id_number": id_number, "password": password}):
            return JsonResponse({'status': 'success', 'message': 'Login successful.',})
        else:
            return JsonResponse({'error': 'User could not be found.'}, status=401)
        
    except json.JSONDecodeError:
        return JsonResponse({'error': 'Invalid JSON'}, status=400)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
    
# non-refer patient registration
@csrf_exempt
def non_refer_patient_registeration(request):
    #check if request method is POST or not.
    if request.method != 'POST':
        JsonResponse({'error': 'Invalid Request Method'}, status=405)
    try:
        #check if the request body is in JSON format and load them into the data variable
        data = json.loads(request.body.decode('utf-8'))
        # Extract the required fields from the request body
        id_number = data.get('id_number')
        therapist_id = data.get('therapist_id_number')
        password = data.get('password')
        name = data.get('name')
        age = data.get('age')
        phone_number = data.get('phone_number')
        gender = data.get('gender')

        #check if the required fields are present in the request body
        if not id_number or not therapist_id or not password:
            return JsonResponse({'error': 'required fields are empty'}, status=400)
        
        #check if the user exists in the database or not.
        #if it did exist then return a match error and terminate the process
        if patients_collection.find_one({"id_number": id_number, "password": password}):
            return JsonResponse({'status': 'unsuccessful', 'error': 'another patient with this inforamtion already exists!'}, status=401)
        else:
            #collecting the data and get it ready for database
            patient_data = {
                "id_number": id_number,
                "therapist_id_number": therapist_id,
                "password": password,
                "name": name,
                "age": age,
                "phone_number": phone_number,
                "gender": gender,
            }
            # save the patient's data in the database
            patients_collection.insert_one(patient_data)
            # Return a success response
            return JsonResponse({'message': 'User registered successfully.'})
        
    except json.JSONDecodeError:
        return JsonResponse({'error': 'Invalid JSON'}, status=400)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
    
    #