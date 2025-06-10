import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/authentication_page/register_controller.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  final RegisterController controllerA = Get.put(RegisterController());

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 900) {
          return const SmallScreenRegister();
        } else {
          return LargeScreenRegister();
        }
      },
    );
  }
}


// --- Large Screen Layout ---
class LargeScreenRegister extends StatelessWidget {
  LargeScreenRegister({super.key});

  static const Color primaryColor = Color(0xFF6750A4);
  final RegisterController _controllerR = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left animated gradient panel
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                const Positioned.fill(child: AnimatedGradientBackground()),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 48),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'PhysioConnect',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Right login form
          Expanded(
            flex: 3,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 420),
                  padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
                  child: Material(
                    elevation: 14,
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.98),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextField(
                            controller: _controllerR.idNumberController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.deepPurple[50],
                                hintText: 'ID',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.person, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                            ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.firstnameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.deepPurple[50],
                                hintText: 'name',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.medical_information, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.ageController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.deepPurple[50],
                                hintText: 'Age',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.medical_information, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.phoneNumberController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.deepPurple[50],
                                hintText: 'Phone',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.phone, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 22),
                          DropdownButtonFormField<String>(
                            style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.deepPurple[50],
                        hintText: 'Gender',
                        hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.people_alt_sharp, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                      
                      
                      ),
                      items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                          ))
                        .toList(),
                      onChanged: (value) {
                      _controllerR.genderController.text = value ?? '';
                      },
                    ),
                    const SizedBox(height: 22),
                                                Obx(() => TextField(
                      controller: _controllerR.passwordController,
                      
                      keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.deepPurple[50],
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.key, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controllerR.isPasswordVisible.value 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _controllerR.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _controllerR.isPasswordVisible.value,
                    )
                    ),
                    const SizedBox(height: 22),
                                                Obx(() => TextField(
                      controller: _controllerR.confirmPasswordController,
                      
                      keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.deepPurple[50],
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.key, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controllerR.isConfirmPasswordVisible.value 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _controllerR.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _controllerR.isConfirmPasswordVisible.value,
                    )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Small Screen View
class SmallScreenRegister extends StatelessWidget {
  const SmallScreenRegister({super.key});

  static const Color primaryColor = Color(0xFF6750A4);

  @override
  Widget build(BuildContext context) {
    final RegisterController _controllerR = Get.find<RegisterController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // animated background
            const Positioned(child: AnimatedGradientBackground()),

            // logo
            SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'PhysioConnect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 8,
                                )
                              ]
                            )
                          ),
                          const SizedBox(height: 48,),
                           TextField(
                             controller: _controllerR.idNumberController,
                             decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.93),
                                hintText: 'ID',
                                prefixIcon: const Icon(Icons.perm_identity, color: primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 18),
                                ),
                             keyboardType: TextInputType.number,
                             style: const TextStyle(color: Colors.black),
                           ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.firstnameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.93),
                              hintText: 'first name',
                              prefixIcon: const Icon(Icons.perm_identity, color: primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 18),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.lastnameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.93),
                              hintText: 'last name',
                              prefixIcon: const Icon(Icons.perm_identity, color: primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 18),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.ageController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.93),
                              hintText: 'age',
                              prefixIcon: const Icon(Icons.perm_identity, color: primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 18),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: _controllerR.phoneNumberController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.93),
                              hintText: 'phone number',
                              prefixIcon: const Icon(Icons.perm_identity, color: primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 18),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                          ),
                                        const SizedBox(height: 22),
                                        DropdownButtonFormField<String>(
                                          style: const TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.deepPurple[50],
                                            hintText: 'Gender',
                                            hintStyle: const TextStyle(color: Colors.black45),
                                            prefixIcon: const Icon(Icons.people_alt_sharp, color: primaryColor),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 18, horizontal: 18),
                                          ),
                                          items: ['Male', 'Female']
                                              .map((gender) => DropdownMenuItem<String>(
                                            value: gender,
                                            child: Text(gender),
                                          ))
                                              .toList(),
                                          onChanged: (value) {
                                            _controllerR.genderController.text = value ?? '';
                                          },
                                        ),
                                        const SizedBox(height: 22),
                                        Obx(() => TextField(
                                          controller: _controllerR.passwordController,

                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.deepPurple[50],
                                            hintText: 'Password',
                                            hintStyle: const TextStyle(color: Colors.black45),
                                            prefixIcon: const Icon(Icons.key, color: primaryColor),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 18, horizontal: 18),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _controllerR.isPasswordVisible.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.grey,
                                              ),
                                              onPressed: _controllerR.togglePasswordVisibility,
                                            ),
                                          ),
                                          obscureText: _controllerR.isPasswordVisible.value,
                                        )
                                        ),
                          const SizedBox(height: 22),
                          Obx(() => TextField(
                            controller: _controllerR.confirmPasswordController,

                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.deepPurple[50],
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              prefixIcon: const Icon(Icons.key, color: primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 18),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _controllerR.isConfirmPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: _controllerR.togglePasswordVisibility,
                              ),
                            ),
                            obscureText: _controllerR.isConfirmPasswordVisible.value,
                          )
                          ),

                        ],
                      ),
                    ),
                )
              ),
              // Stack(
              //   children: [
              //     const Positioned.fill(child: AnimatedGradientBackground()),
              //     Container(
              //       padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 48),
              //       alignment: Alignment.topCenter,
              //       child: Text(
              //         'PhysioConnect',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 28,
              //           letterSpacing: 1.2,
              //           shadows: [
              //             Shadow(
              //               color: Colors.black.withOpacity(0.18),
              //               blurRadius: 8,
              //               offset: const Offset(2, 2),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
        
            // space
            // Center Register Parameters
        
              // Center(
              //   child: SingleChildScrollView(
              //     child: Container(
              //       constraints: const BoxConstraints(maxWidth: 420),
              //       padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              //
              //       child: Material(
              //         elevation: 14,
              //         borderRadius: BorderRadius.circular(24),
              //         color: Colors.white.withOpacity(0.98),
              //         child: Padding(
              //           padding: const EdgeInsets.all(24.0),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               Text(
              //                 'Welcome Back',
              //                 style: TextStyle(
              //                   color: primaryColor,
              //                   fontSize: 32,
              //                   fontWeight: FontWeight.bold,
              //                   fontFamily: 'Roboto',
              //                 ),
              //               ),
              //               const SizedBox(height: 40),
              //               TextField(
              //                 controller: _controllerR.idNumberController,
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'ID',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.person, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //                 ),
              //                 keyboardType: TextInputType.number,
              //                 style: const TextStyle(color: Colors.black),
              //               ),
              //               const SizedBox(height: 22),
              //               TextField(
              //                 controller: _controllerR.firstnameController,
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'name',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.medical_information, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //                 ),
              //                 keyboardType: TextInputType.number,
              //                 style: const TextStyle(color: Colors.black),
              //               ),
              //               const SizedBox(height: 22),
              //               TextField(
              //                 controller: _controllerR.ageController,
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'Age',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.medical_information, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //                 ),
              //                 keyboardType: TextInputType.number,
              //                 style: const TextStyle(color: Colors.black),
              //               ),

              //               const SizedBox(height: 22),
              //               TextField(
              //                 controller: _controllerR.phoneNumberController,
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'Phone',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.phone, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //                 ),
              //                 keyboardType: TextInputType.number,
              //                 style: const TextStyle(color: Colors.black),
              //               ),
              //               const SizedBox(height: 22),
              //               DropdownButtonFormField<String>(
              //                 style: const TextStyle(color: Colors.black),
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'Gender',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.people_alt_sharp, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //
              //
              //                 ),
              //                 items: ['Male', 'Female']
              //                     .map((gender) => DropdownMenuItem<String>(
              //                   value: gender,
              //                   child: Text(gender),
              //                 ))
              //                     .toList(),
              //                 onChanged: (value) {
              //                   _controllerR.genderController.text = value ?? '';
              //                 },
              //               ),
              //               const SizedBox(height: 22),
              //               Obx(() => TextField(
              //                 controller: _controllerR.passwordController,
              //
              //                 keyboardType: TextInputType.number,
              //                 style: const TextStyle(color: Colors.black),
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'Password',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.key, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //                   suffixIcon: IconButton(
              //                     icon: Icon(
              //                       _controllerR.isPasswordVisible.value
              //                           ? Icons.visibility_off
              //                           : Icons.visibility,
              //                       color: Colors.grey,
              //                     ),
              //                     onPressed: _controllerR.togglePasswordVisibility,
              //                   ),
              //                 ),
              //                 obscureText: _controllerR.isPasswordVisible.value,
              //               )
              //               ),
              //               const SizedBox(height: 22),
              //               Obx(() => TextField(
              //                 controller: _controllerR.confirmPasswordController,
              //
              //                 keyboardType: TextInputType.number,
              //                 style: const TextStyle(color: Colors.black),
              //                 decoration: InputDecoration(
              //                   filled: true,
              //                   fillColor: Colors.deepPurple[50],
              //                   hintText: 'Confirm Password',
              //                   hintStyle: const TextStyle(color: Colors.black45),
              //                   prefixIcon: const Icon(Icons.key, color: primaryColor),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(14),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                   contentPadding: const EdgeInsets.symmetric(
              //                       vertical: 18, horizontal: 18),
              //                   suffixIcon: IconButton(
              //                     icon: Icon(
              //                       _controllerR.isConfirmPasswordVisible.value
              //                           ? Icons.visibility_off
              //                           : Icons.visibility,
              //                       color: Colors.grey,
              //                     ),
              //                     onPressed: _controllerR.togglePasswordVisibility,
              //                   ),
              //                 ),
              //                 obscureText: _controllerR.isConfirmPasswordVisible.value,
              //               )),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
        
          ],
        ),
      ),
    );
  }
}




// --- Animated Login Button ---
class AnimatedLoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const AnimatedLoginButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  State<AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 8,
                  shadowColor: widget.color.withOpacity(0.28),
                ),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- Animated Gradient Background ---
class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const List<Color> gradientColors1 = [
    Color(0xFF6750A4),
    Color(0xFFB69DF8),
    Color(0xFF9A82DB),
  ];
  static const List<Color> gradientColors2 = [
    Color(0xFFB69DF8),
    Color(0xFF6750A4),
    Color(0xFF9A82DB),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: List.generate(
                    3,
                        (i) => Color.lerp(
                      gradientColors1[i],
                      gradientColors2[i],
                      _animation.value,
                    )!,
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}