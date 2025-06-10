import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/user_auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:9000/data';
  final TextEditingController idController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<List<dynamic>> getAllPatientsRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/patients/'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['patients'];
    } else {
      throw Exception('Failed to load patients');
    }
  }
}

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();
  final AuthController _controllerA = Get.find<AuthController>();

  var patientNames = <String>[].obs;
  var patientID = <String>[].obs;
  var patientToggleActivate = 1.obs;
  var patientToggleDiscard = 0.obs;
  var patientStatus = <String>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPatientNames();
    super.onInit();
  }

  Future<void> fetchPatientNames() async {
    isLoading.value = true;

    try {
      final List<dynamic> patientsJson =
          await _apiService.getAllPatientsRequests();

      // Safe extraction of names, handling null values
      patientNames.value = patientsJson
          .map((patient) => patient['name'] as String? ?? 'No Name')
          .toList();
      patientID.value = patientsJson
          .map(
              (patient) => patient['id_number'] as String? ?? 'No ID Available')
          .toList();
      patientStatus.value = patientsJson
          .map((patient) =>
              patient['status']?.toString() ?? 'isActive not true nor false')
          .toList();

      print('Successfully loaded ${patientNames.length} patient names');
    } catch (e) {
      print('Error fetching patients: $e');
    } finally {
      isLoading.value = false;
    }
    update();
  }

  Future<void> acceptPatient(String status, String patientId) async {

    final url = Uri.parse("http://127.0.0.1:9000/data/accept/");

    isLoading.value = true;

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "id_number": patientId,
          "status": status,
        }),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("${_controllerA.docId}, ${_controllerA.docName}");

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          print('Patient status updated to $status');
        } else {
          print("Failed: ${response.statusCode}");
        }
      } catch (e) {
        isLoading.value = false;
        print("Exception: $e");
      }
    }
  }

  // Future<void> postActivationtoggle(String id) async {

  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/active/'),
  //       body: json.encode({'id_number': id}), // Pass the id as JSON
  //       headers: {'Content-Type': 'application/json'}, // Specify JSON header
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Toggled isActive: ${data['isActive']}');
  //     } else {
  //       print('Error: ${response.statusCode} - ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   }
  // }











// GIT COMMIT APRIL 6 2025