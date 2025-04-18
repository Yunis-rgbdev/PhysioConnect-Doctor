import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterController extends GetxController {
  // Defining the text controller id number and password and statememnts
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  var isLoading = false.obs; // Loading state
  var isError = false.obs; // Error state
  var errorMessage = ''.obs; // Error message
  var isRegistered = false.obs; // Registration state
  var isPasswordVisible = false.obs; // Password visibility state
  var isConfirmPasswordVisible = false.obs; // Confirm password visibility state

  @override
  void onInit() {
    super.onInit();

    idNumberController.addListener(() {
      if (idNumberController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    confirmPasswordController.addListener(() {
      if (confirmPasswordController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    firstnameController.addListener(() {
      if (firstnameController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    lastnameController.addListener(() {
      if (lastnameController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    emailController.addListener(() {
      if (emailController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    phoneNumberController.addListener(() {
      if (phoneNumberController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    ageController.addListener(() {
      if (ageController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    genderController.addListener(() {
      if (genderController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
  }

  @override
  void onClose() {
    idNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value; // Toggle password visibility
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value; // Toggle confirm password visibility
  }

  Future<void> sendAuth() async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/api/register/'); // Ensure trailing slash

    print(phoneNumberController.text);
    if (passwordController.text != confirmPasswordController.text) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Passwords do not match';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return print(errorMessage); // Stop the function execution
    }

    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'please enter password in both fields to confirm your password';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return print(errorMessage);
    }

    if (idNumberController.text.isEmpty || passwordController.text.isEmpty) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Please Enter both ID Number and password to continue signing up.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return print(errorMessage);
    }

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
          "name": firstnameController.text.trim(),
          "age": ageController.text.trim(),
          "phone_number": phoneNumberController.text.trim(),
          "gender": genderController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Success: $data");
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}