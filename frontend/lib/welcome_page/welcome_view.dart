import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    const Color primaryColor = Color(0xFF6750A4); // Android 15-like purple

    Widget buildWelcomeHeader(double width, double height) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: width,
        height: height,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome To',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width < 600 ? 24 : 32,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'PhysioConnect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width < 600 ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildButtons(double width) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.08),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(horizontal: width < 600 ? 24 : width * 0.2, vertical: width < 600 ? 0 : 250),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _AnimatedModernButton(
                text: 'Login',
                icon: Icons.login_rounded,
                color: primaryColor,
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
              SizedBox(height: width < 600 ? 8.0 : 16),
              _AnimatedModernButton(
                text: 'Signup',
                icon: Icons.person_add_alt_1_rounded,
                color: primaryColor,
                onTap: () => Navigator.pushNamed(context, '/register'),
              ),
              SizedBox(height: width < 600 ? 8.0 : 16),
              _AnimatedModernButton(
                text: 'Signup Patient',
                icon: Icons.favorite_rounded,
                color: primaryColor,
                onTap: () => Navigator.pushNamed(context, '/nonreferregister'),
              ),
            ],
          ),
        ),
      );
    }

    var screenHeight = MediaQuery.of(context).size.height;

    Widget gradientBackground({required Widget child}) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor, primaryColor.withOpacity(0.7)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      );
    }

    if (screenWidth < 720) {
      // Mobile layout
      return gradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildWelcomeHeader(screenWidth, screenHeight * 0.35),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: buildButtons(screenWidth),
              ),
            ],
          ),
        ),
      );
    } else {
      // Tablet/Desktop layout
      return gradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            children: [
              Expanded(
                flex: 5,
                child: buildWelcomeHeader(screenWidth, screenHeight),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: buildButtons(screenWidth / 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

// Sleek modern animated button widget
class _AnimatedModernButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedModernButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  State<_AnimatedModernButton> createState() => _AnimatedModernButtonState();
}

class _AnimatedModernButtonState extends State<_AnimatedModernButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                widget.color,
                widget.color.withOpacity(0.85)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.18),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 26),
              const SizedBox(width: 12),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
