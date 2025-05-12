from pymongo import MongoClient
from django.conf import settings

class MongoDBConnection:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(MongoDBConnection, cls).__new__(cls)
            mongo_uri = ("mongodb://localhost:27017")
            cls._instance.client = MongoClient(mongo_uri)
            cls._instance.db = cls._instance.client["healthconnect"]
        return cls._instance
    
class PatientCollection:
    def __init__(self):
        connection = MongoDBConnection()
        self.collection = connection.db["patients"]

    def get_all_patients(self):
        patients = list(self.collection.find({}, {'_id': 0,}))
        return patients
    
    def get_patient_by_id(self, id):
        return self.collection.find_one({'id_number': id}, {'_id': 0})

class DoctorCollection:
    def __init__(self):
        connection = MongoDBConnection()
        self.collection = connection.db["doctors"]
    
    def get_all_doctors(self):
        doctors = list(self.collection.find({}, {'_id': 0}))
        return doctors
    
    def get_doctor_by_id(self, id):
        return self.collection.find_one({'id_number': id}, {'_id': 0})
    