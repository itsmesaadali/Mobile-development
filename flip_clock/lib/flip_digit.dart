import 'dart:ui';

import 'package:flutter/material.dart';

class FlipDigit extends StatefulWidget {
  final String value;
  const FlipDigit({super.key, required this.value});

  @override
  State<FlipDigit> createState() => _FlipDigitState();
}

class _FlipDigitState extends State<FlipDigit> {
  String _oldValue = '';
  String _newValue = '';
  bool _showOld = true;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
    _newValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant FlipDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _oldValue = oldWidget.value;
        _newValue = widget.value;
        _showOld = false;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) setState(() => _showOld = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: slide,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Container(
        key: ValueKey<String>(_showOld ? _newValue : _oldValue),
        width: 70,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _showOld ? _newValue : _oldValue,
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
