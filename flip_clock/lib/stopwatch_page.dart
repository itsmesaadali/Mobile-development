import 'dart:async';
import 'package:flutter/material.dart';
import 'themes.dart';

class StopwatchPage extends StatefulWidget {
  final Function(int) onThemeChanged;
  final int themeIndex;

  const StopwatchPage({
    super.key,
    required this.onThemeChanged,
    required this.themeIndex,
  });

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage>
    with SingleTickerProviderStateMixin {
  late Stopwatch _stopwatch;
  Timer? _timer;
  String _formattedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
        setState(() {
          final ms = _stopwatch.elapsedMilliseconds;
          final hours = (ms ~/ 3600000).toString().padLeft(2, '0');
          final minutes = ((ms ~/ 60000) % 60).toString().padLeft(2, '0');
          final seconds = ((ms ~/ 1000) % 60).toString().padLeft(2, '0');
          _formattedTime = "$hours:$minutes:$seconds";
        });
      });
    }
    setState(() {});
  }

  void _reset() {
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      _formattedTime = "00:00:00";
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemes.themes[widget.themeIndex]['theme'] as ThemeData;
    final elapsed = _stopwatch.elapsedMilliseconds;
    final progress = ((elapsed % 60000) / 60000).clamp(0.0, 1.0);

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Stopwatch",
                style: TextStyle(color: Colors.white70, fontSize: 26),
              ),
              const SizedBox(height: 40),

              // RING STYLE PROGRESS INDICATOR
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) =>
                          CircularProgressIndicator(
                            value: value,
                            strokeWidth: 10,
                            color: Colors.white,
                            backgroundColor: Colors.white12,
                          ),
                    ),
                  ),
                  Text(
                    _formattedTime,
                    style: const TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // START / RESET BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _stopwatch.isRunning
                          ? Colors.redAccent
                          : Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: _startStop,
                    child: Text(
                      _stopwatch.isRunning ? "STOP" : "START",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: _reset,
                    child: const Text(
                      "RESET",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // THEME SELECTOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(AppThemes.themes.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text(AppThemes.themes[i]['name']),
                      selected: widget.themeIndex == i,
                      onSelected: (_) => widget.onThemeChanged(i),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
