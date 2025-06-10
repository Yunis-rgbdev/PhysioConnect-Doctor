import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class NonReferRegisterController extends GetxController{
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final TextEditingController therapistidController = TextEditingController();
  final obsecurePassword = true.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isRegistered = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

    @override
  void onInit() {
    super.onInit();

    idController.addListener(() {
      if (idController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
        therapistidController.addListener(() {
      if (therapistidController.text.isNotEmpty) {
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
    confirmpasswordController.addListener(() {
      if (confirmpasswordController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    nameController.addListener(() {
      if (nameController.text.isNotEmpty) {
        isError.value = false; // set Error state to false
        errorMessage.value = ''; // set Error message to empty string
      }
    });
    phonenumberController.addListener(() {
      if (phonenumberController.text.isNotEmpty) {
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
    idController.dispose();
    therapistidController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    nameController.dispose();
    ageController.dispose();
    phonenumberController.dispose();
    genderController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obsecurePassword.value = !obsecurePassword.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value; // Toggle confirm password visibility
  }

  Future<void> non_refer_patients_register() async {
    final non_refer_register_url = Uri.parse('http://127.0.0.1:9000/api/non_refer_register/');

    print('registering user with ID: $idController and Therapist ID: $therapistidController');
    isLoading.value = true;
    // checking for password fields not being empty
    if (passwordController.text.isEmpty || confirmpasswordController.text.isEmpty) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Passwords fields are not filled';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return print(errorMessage); // Stop the function execution
    } else if (idController.text.isEmpty) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'ID field is neccessary';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return print(errorMessage); // Stop the function execution
    } else if (passwordController.text != confirmpasswordController.text) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'passwords doesnt match!';
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
        non_refer_register_url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "id_number": idController.text.trim(),
          "therapist_id_number": therapistidController.text.trim(),
          "password": passwordController.text.trim(),
          "name": nameController.text.trim(),
          "age": ageController.text.trim(),
          "phone_number": phonenumberController.text.trim(),
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

