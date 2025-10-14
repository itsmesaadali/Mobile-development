import 'dart:async';
import 'package:flutter/material.dart';
import 'flip_digit.dart';
import 'themes.dart';

class FlipClockPage extends StatefulWidget {
  final Function(int) onThemeChanged;
  final int themeIndex;

  const FlipClockPage({
    super.key,
    required this.onThemeChanged,
    required this.themeIndex,
  });

  @override
  State<FlipClockPage> createState() => _FlipClockPageState();
}

class _FlipClockPageState extends State<FlipClockPage> {
  Timer? _timer;
  DateTime _now = DateTime.now();
  bool _is24Hour = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getHours() {
    int h = _now.hour;
    if (!_is24Hour) h = h % 12 == 0 ? 12 : h % 12;
    return h.toString().padLeft(2, '0');
  }

  String _getAmPm() => _now.hour < 12 ? 'AM' : 'PM';

  @override
  Widget build(BuildContext context) {
    final theme = AppThemes.themes[widget.themeIndex]['theme'] as ThemeData;
    final hours = _getHours();
    final minutes = _now.minute.toString().padLeft(2, '0');
    final seconds = _now.second.toString().padLeft(2, '0');

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 400;
              final hideSeconds = isSmallScreen;

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "${_now.day}/${_now.month}/${_now.year}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Clock Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlipDigit(value: hours[0]),
                              FlipDigit(value: hours[1]),
                              const SizedBox(width: 6),
                              const Text(
                                ":",
                                style: TextStyle(
                                  fontSize: 70,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              FlipDigit(value: minutes[0]),
                              FlipDigit(value: minutes[1]),

                              // hide seconds on small screens
                              if (!hideSeconds) ...[
                                const SizedBox(width: 6),
                                const Text(
                                  ":",
                                  style: TextStyle(
                                    fontSize: 70,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                FlipDigit(value: seconds[0]),
                                FlipDigit(value: seconds[1]),
                              ],

                              if (!_is24Hour)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    _getAmPm(),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Theme Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(AppThemes.themes.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(AppThemes.themes[i]['name']),
                              selected: widget.themeIndex == i,
                              onSelected: (_) => widget.onThemeChanged(i),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      // 24/12 hour switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '24 Hour',
                            style: TextStyle(color: Colors.white),
                          ),
                          Switch(
                            value: !_is24Hour,
                            activeColor: Colors.white,
                            onChanged: (v) => setState(() => _is24Hour = !v),
                          ),
                          const Text(
                            '12 Hour',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
