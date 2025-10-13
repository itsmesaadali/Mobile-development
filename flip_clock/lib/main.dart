import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const FlipClockApp());
}

class FlipClockApp extends StatelessWidget {
  const FlipClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlipClockPage(),
    );
  }
}

class FlipClockPage extends StatefulWidget {
  const FlipClockPage({super.key});

  @override
  State<FlipClockPage> createState() => _FlipClockPageState();
}

class _FlipClockPageState extends State<FlipClockPage> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _now.hour.toString().padLeft(2, '0');
    final minutes = _now.minute.toString().padLeft(2, '0');
    final seconds = _now.second.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipDigit(value: hours[0]),
            FlipDigit(value: hours[1]),
            const SizedBox(width: 8),
            FlipDigit(value: minutes[0]),
            FlipDigit(value: minutes[1]),
            const SizedBox(width: 8),
            FlipDigit(value: seconds[0]),
            FlipDigit(value: seconds[1]),
          ],
        ),
      ),
    );
  }
}

class FlipDigit extends StatefulWidget {
  final String value;
  const FlipDigit({super.key, required this.value});

  @override
  State<FlipDigit> createState() => _FlipDigitState();
}

class _FlipDigitState extends State<FlipDigit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _oldValue = '';
  String _newValue = '';

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
    _newValue = widget.value;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant FlipDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _newValue = widget.value;
      _controller.forward(from: 0);
    }
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
        final angle = _animation.value * math.pi;
        final isFirstHalf = _animation.value < 0.5;
        final value = isFirstHalf ? _oldValue : _newValue;

        return Container(
          width: 70,
          height: 90,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Top half
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      isFirstHalf ? _oldValue : _newValue,
                      style: const TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Animated flipping half
              Align(
                alignment: isFirstHalf
                    ? Alignment.topCenter
                    : Alignment.bottomCenter,
                child: Transform(
                  alignment: isFirstHalf
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(angle),
                  child: ClipRect(
                    child: Align(
                      alignment: isFirstHalf
                          ? Alignment.topCenter
                          : Alignment.bottomCenter,
                      heightFactor: 0.5,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 70,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
      },
    );
  }
}
