import 'dart:math' as math;
import 'package:flutter/material.dart';

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
  String _currentValue = '';

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentValue = widget.value;
        });
        _controller.reset();
      }
    });
  }

  @override
  void didUpdateWidget(covariant FlipDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value &&
        _currentValue == oldWidget.value &&
        _controller.isDismissed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 70,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * math.pi;
          return ClipRect(
            child: Stack(
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(angle),
                  alignment: Alignment.center,
                  child: _buildDigitCard(_currentValue, theme),
                ),
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(angle - math.pi),
                  alignment: Alignment.center,
                  child: _buildDigitCard(widget.value, theme, isBack: true),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDigitCard(String digit, ThemeData theme, {bool isBack = false}) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Transform(
          transform: isBack ? Matrix4.rotationX(math.pi) : Matrix4.identity(),
          alignment: Alignment.center,
          child: Text(
            digit,
            style: const TextStyle(
              fontSize: 70,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
