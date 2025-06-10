import 'package:flutter/material.dart';
import 'package:frontend/authentication_page/nonrefer_register_controller.dart';
import 'package:get/get.dart';

class NonReferRegisterView extends StatelessWidget {
  final NonReferRegisterController controllerA = Get.put(NonReferRegisterController());

  NonReferRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 900) {
          return SmallScreenNonReferRegister();
        } else {
          return LargeScreenRegister();
        }
      },
    );
  }
}

class LargeScreenRegister extends StatelessWidget {
  final NonReferRegisterController _controllerR = Get.find<NonReferRegisterController>();
  LargeScreenRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class SmallScreenNonReferRegister extends StatelessWidget {
  final NonReferRegisterController _controllerR = Get.find<NonReferRegisterController>();
  SmallScreenNonReferRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class NoneReferPatientSignup extends StatelessWidget {
  NoneReferPatientSignup({super.key});
  final NonReferRegisterController controllerN = Get.put(NonReferRegisterController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 720)
      {
        return Scaffold(
          body: Stack(
            children: [
              // Background wave pattern
              Positioned.fill(
                child: CustomPaint(
                  
                ),
              ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    const SizedBox(height: 32),
                    Text(
                      'Create\nAccount',
                      style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 48),
                    TextField(
                      controller: controllerN.nameController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.person_outline, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerN.idController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'ID Number',
                        prefixIcon: Icon(Icons.badge_outlined, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerN.therapistidController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Therapist ID',
                        prefixIcon: Icon(Icons.person_outline, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerN.ageController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        prefixIcon: Icon(Icons.cake_outlined, color: Colors.blue),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerN.phonenumberController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined, color: Colors.blue),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(

                      hintText: 'Gender',

                      prefixIcon: Icon(Icons.people_outline, color: Colors.blue),
                      ),
                      items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                          ))
                        .toList(),
                      onChanged: (value) {
                      controllerN.genderController.text = value ?? '';

                      },
                    ),
                    const SizedBox(height: 16),
                    Obx(() => TextField(
                      controller: controllerN.passwordController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controllerN.obsecurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: controllerN.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: controllerN.obsecurePassword.value,
                    )),
                    const SizedBox(height: 16),
                    Obx(() => TextField(
                      controller: controllerN.confirmpasswordController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controllerN.isConfirmPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: controllerN.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      obscureText: controllerN.isConfirmPasswordVisible.value,
                    )),
                    // const SizedBox(height: 16),
                    // TextField(
                    //   controller: controllerN.therapistidController,
                    //   cursorColor: Colors.black,
                    //   style: TextStyle(color: Colors.black),
                    //   decoration: const InputDecoration(
                    //     hintText: 'Therapist ID number',
                    //     prefixIcon: Icon(Icons.info_outline, color: Colors.blue),
                    //   ),
                    // ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controllerN.non_refer_patients_register,
                        child: const Text('Sign up'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: TextButton(
                        onPressed: () => Get.toNamed('/login'),
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
                  ],
                ),
        );
      } else {
        return Scaffold(
          body: Container(),
        );
      }
  
  }
}