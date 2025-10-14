import 'dart:async';
import 'package:flutter/material.dart';
import 'flip_digit.dart';
import 'themes.dart';

class FlipClockPage extends StatefulWidget {
  const FlipClockPage({super.key});

  @override
  State<FlipClockPage> createState() => _FlipClockPageState();
}

class _FlipClockPageState extends State<FlipClockPage> {
  Timer? _timer;
  DateTime _now = DateTime.now();
  bool _is24Hour = true;
  int _selectedThemeIndex = 0;

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
    _timer?.cancel();
    super.dispose();
  }

  String _getHours() {
    int h = _now.hour;
    if (!_is24Hour) {
      h = h % 12;
      if (h == 0) h = 12;
    }
    return h.toString().padLeft(2, '0');
  }

  String _getAmPm() => _now.hour < 12 ? 'AM' : 'PM';

  String _getDayName() {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];
    return days[_now.weekday - 1];
  }

  String _getFormattedDate() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${_now.day} ${months[_now.month - 1]} ${_now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemes.themes[_selectedThemeIndex]['theme'] as ThemeData;
    final hours = _getHours();
    final minutes = _now.minute.toString().padLeft(2, '0');
    final seconds = _now.second.toString().padLeft(2, '0');

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Flip Clock',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 20),

              // Day + Date
              Text(
                _getDayName(),
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getFormattedDate(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 40),

              // ⏰ Clock Display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlipDigit(value: hours[0]),
                  FlipDigit(value: hours[1]),
                  const SizedBox(width: 8),
                  const Text(
                    ':',
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FlipDigit(value: minutes[0]),
                  FlipDigit(value: minutes[1]),
                  const SizedBox(width: 8),
                  const Text(
                    ':',
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FlipDigit(value: seconds[0]),
                  FlipDigit(value: seconds[1]),

                  if (!_is24Hour) ...[
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            theme.cardTheme.color ?? theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getAmPm(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 40),

              // 🎨 Theme Selector
              const Text(
                'Select Theme:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(AppThemes.themes.length, (index) {
                  final themeData =
                      AppThemes.themes[index]['theme'] as ThemeData;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        AppThemes.themes[index]['name'] as String,
                        style: TextStyle(
                          color: _selectedThemeIndex == index
                              ? Colors.white
                              : themeData.primaryColor,
                        ),
                      ),
                      selected: _selectedThemeIndex == index,
                      selectedColor: themeData.primaryColor,
                      backgroundColor: Colors.grey[800],
                      onSelected: (selected) {
                        setState(() {
                          _selectedThemeIndex = index;
                        });
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // 🕓 Hour Format Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('12 Hour', style: TextStyle(color: Colors.white)),
                  Switch(
                    value: !_is24Hour,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        _is24Hour = !value;
                      });
                    },
                  ),
                  const Text('24 Hour', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
