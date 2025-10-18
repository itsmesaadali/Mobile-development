// splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'flip_clock_app.dart'; // Import your main app widget

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;
  bool _showIcon = false;

  @override
  void initState() {
    super.initState();

    // Controller for progress ring animation (duration = 3 seconds)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Animate progress from 0.0 → 1.0 (for CircularProgressIndicator)
    _progress = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
    _controller.forward();

    // Show clock icon when ring finishes (after 3s)
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showIcon = true);

        // Wait 1 more second, then move to main app
        Timer(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const FlipClockApp()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Pure black background for style
      body: Center(
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Ring animation
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _progress.value,
                    strokeWidth: 10,
                    backgroundColor: Colors.white12,
                    color: Colors.white,
                  ),
                ),

                // Clock icon (appears after ring completes)
                AnimatedOpacity(
                  opacity: _showIcon ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: const Icon(
                    Icons.access_time,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
