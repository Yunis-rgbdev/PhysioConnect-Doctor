import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/authentication_page/login_controller.dart';
import 'package:frontend/dashboard_page/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final LoginController controllerL = Get.put(LoginController());

  DashboardView({super.key});

  final Color primaryColor = const Color(0xFF4F8FFF);
  final Color accentColor = const Color(0xFF00C6AE);
  final Color backgroundColor = const Color(0xFFF7F9FB);
  final Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              controllerL.logout();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 32,
            vertical: isMobile ? 12 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.only(left: isMobile ? 8 : 24, top: isMobile ? 8 : 24, bottom: 12),
                child: Text(
                  'درخواست ها',
                  style: PersianFonts.Yekan.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 22 : 32,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.patientNames.isEmpty) {
                    return Center(
                      child: Text(
                        'No requests found.',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: controller.patientNames.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final patientName = controller.patientNames[index].toString();
                        final patientID = controller.patientID[index].toString();
                        bool isActive = controller.patientStatus[index].toLowerCase() == 'true';

                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 500 + index * 100),
                          tween: Tween(begin: 0, end: 1),
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 30),
                              child: child,
                            ),
                          ),
                          child: Card(
                            color: cardColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 12 : 24,
                                vertical: isMobile ? 12 : 20,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: accentColor.withOpacity(0.15),
                                    child: Text(
                                      patientName.isNotEmpty ? patientName[0] : '?',
                                      style: TextStyle(
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 18 : 22,
                                      ),
                                    ),
                                    radius: isMobile ? 22 : 28,
                                  ),
                                  SizedBox(width: isMobile ? 10 : 24),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          patientName,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600,
                                            fontSize: isMobile ? 16 : 20,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '($patientID)',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: isMobile ? 11 : 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                                    child: isActive
                                        ? Chip(
                                            key: ValueKey('active$index'),
                                            label: Text('Active', style: TextStyle(color: Colors.white)),
                                            backgroundColor: accentColor,
                                            avatar: const Icon(Icons.check_circle, color: Colors.white, size: 18),
                                          )
                                        : ElevatedButton.icon(
                                            key: ValueKey('accept$index'),
                                            onPressed: () async {
                                              String patientID = controller.patientID[index].toString();
                                              await controller.acceptPatient("active", patientID);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(isMobile ? 120 : 150, isMobile ? 36 : 44),
                                              backgroundColor: primaryColor,
                                              foregroundColor: Colors.white,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: isMobile ? 12 : 24,
                                                vertical: isMobile ? 8 : 14,
                                              ),
                                            ),
                                            icon: const Icon(Icons.check_circle_outline, size: 20),
                                            label: Text(
                                              'Accept',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: isMobile ? 13 : 15,
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
