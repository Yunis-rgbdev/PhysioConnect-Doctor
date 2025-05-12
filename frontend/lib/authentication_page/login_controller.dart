import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:frontend/authentication_page/login_view.dart';
import 'package:frontend/dashboard_page/dashbaord_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // Defining the text controller id number and password
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final obSecurePassword = true.obs; // Obscure password
  final isLoading = false.obs; // Loading state
  final isError = false.obs; // Error state
  final errorMessage = ''.obs; // Error message
  var isLoggedIn = false.obs; // Login state
  var doctorName = ''.obs; // Doctor name
  var doctorId = ''.obs; // Doctor ID

  void togglePasswordVisibility() {
    obSecurePassword.value = !obSecurePassword.value; // Toggle password visibility
  }

  void clearTextFields() {
    idNumberController.clear();
    passwordController.clear();
  }


  Future<void> login() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/login/');
    isLoading.value = true; // set Loading state to true
    isError.value = false; // set Error state to false
    errorMessage.value = ''; // set Error message to empty string

    if (idNumberController.text.isEmpty || passwordController.text.isEmpty) {
      isLoading.value = false; // set Loading state to false
      isError.value = true; // set Error state to true
      errorMessage.value = 'Please fill in all fields'; // set Error message
      return;
    }

    isLoading.value = true; // set Loading state to true

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "id_number": idNumberController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );
      isLoading.value = false;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        print("Login Success: $data, ${data['doctor_name']}/n . . .");
        if (data['status'] == 'success') {
          Get.offAll(DashboardView());
        }
        isLoggedIn.value = true;
        print('Filling the user variables');
        doctorName.value = data['doctor_name'];
        doctorId.value = data['doctor_id'];
        print('Doctor Name: ${doctorName.value} - Doctor ID: ${doctorId.value}, filled successfully');
        print('Navigating to dashboard page');
        Get.offAllNamed('/dashboard'); // Navigate to dashboard page
        print('Navigated to dashboard page successfully');
      } else {
        isError.value = true; // set Error state to true
        errorMessage.value = 'Login failed. Please try again.'; // set Error message
        print('Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false; // set Loading state to false
      isError.value = true; // set Error state to true
      errorMessage.value = 'An error occurred. Please try again.'; // set Error message
      print('Error: $e');
    } finally {
      isLoading.value = false; // set Loading state to false
    }
  }

  // if doctor login was successful this function will be called
  // and the userId witll be used to intilialize data from database to homepage
  // and the isLoggedIn will be set to true
  void setUserLoggedIn(String id) async {
    doctorId.value = id;
    isLoggedIn.value = true;
  }

  // Logout
  void logout() async {
    doctorId.value = '';
    idNumberController.clear();
    passwordController.clear();
    isLoggedIn.value = false;
    Get.to(LoginView());
  }
}