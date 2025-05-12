import 'package:flutter/material.dart';
import 'package:frontend/authentication_page/login_controller.dart';
import 'package:get/get.dart';

class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw wave pattern
    final path1 = Path();
    path1.moveTo(0, size.height * 0.65);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.65,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.65,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint);

    // Draw circles
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw various sized circles for the bubble effect
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.2),
      size.width * 0.08,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.3),
      size.width * 0.05,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.15),
      size.width * 0.1,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.4),
      size.width * 0.06,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.5),
      size.width * 0.04,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class LoginView extends StatelessWidget {
  
  
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 720) {
      return smallScreenLayout();
    } else {
      return LargeScreenLayout();
    }
  }
}



class smallScreenLayout extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  smallScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background wave pattern
          Positioned.fill(
            child: CustomPaint(
              painter: WavePatternPainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_back, color: Colors.white),
                      //   onPressed: () => Get.to(WelcomeScreen()),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome\nBack',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 48),
                    TextField(
                    controller: controller.idNumberController,
                    decoration: InputDecoration(
                      hintText: 'ID',
                      hintStyle: const TextStyle(color: Colors.black45),
                        prefixIcon: const Icon(Icons.perm_identity, color: Colors.blue),
                      suffixIcon: Obx(() => controller.doctorId.value.isNotEmpty
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const SizedBox()),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    ),
                  const SizedBox(height: 16),
                  Obx(() => TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obSecurePassword.value 
                              ? Icons.visibility_off 
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    obscureText: controller.obSecurePassword.value,
                  )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      child: const Text('Log in'),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LargeScreenLayout extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  LargeScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(flex: 2.toInt(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 36, horizontal: 36),
            decoration: BoxDecoration(
            color: Colors.blue[600],
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(5, 5), // Adjust this for shadow positioning
                blurRadius: 4.0,
                spreadRadius: 1.0,
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.topLeft,
               child: Text(
                'PhysioConnect',
                 style: TextStyle(
                  color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 18
                   ),
                ),
              ),
          ),
          ),
          Expanded(flex: 3.toInt(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 76, horizontal: 200),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Login', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40,),
                Align(
                  alignment: Alignment.center,
                  child:SizedBox(
                    width: 450,
                    child: TextField(
                    controller: controller.idNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      hintText: 'ID',
                      hintStyle: const TextStyle(color: Colors.black45),
                        prefixIcon: const Icon(Icons.perm_identity, color: Colors.blue),
                      suffixIcon: Obx(() => controller.doctorId.value.isNotEmpty
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const SizedBox()),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    ),
                 ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child:SizedBox(
                    width: 450,
                    child: TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.black45),
                        prefixIcon: const Icon(Icons.key, color: Colors.blue),
                      suffixIcon: Obx(() => controller.doctorId.value.isNotEmpty
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const SizedBox()),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    ),
                 ),
                ),
                SizedBox(height: 35),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(onPressed: (){}, child: Text('Submit'), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),),
                  ),
                )
              ],
            ),
          ),
          ),
          
        ],
      ),
    );
  }
}