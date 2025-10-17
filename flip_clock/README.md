
                               ==============================

                            FLIP CLOCK + STOPWATCH APP (Flutter) 

                               ==============================

This project is a Flutter application that combines a FLIP CLOCK and a STOPWATCH in one app, with multiple switchable themes and animations.

---------------------------------------------------
📁 FILE STRUCTURE
---------------------------------------------------
```
main.dart
```
```
flip_clock_app.dart
```
```
flip_clock_page.dart
```
```
flip_digit.dart
```
```
stopwatch_page.dart
```
```
themes.dart
```
---------------------------------------------------
1️⃣ main.dart - APP ENTRY POINT
---------------------------------------------------
- Imports the main Flutter Material package.
- Imports the main app widget from flip_clock_app.dart.
- Defines the main() function, the entry point for the app.
- Runs the FlipClockApp widget inside runApp().

Widgets used:
- MaterialApp (indirectly through FlipClockApp)

---------------------------------------------------
2️⃣ flip_clock_app.dart - MAIN APP & NAVIGATION
---------------------------------------------------
Purpose:
- Manages the overall app structure.
- Handles navigation between "Clock" and "Stopwatch" pages using BottomNavigationBar.
- Handles dynamic theme switching.

Key Components:
- StatefulWidget (FlipClockApp) – allows theme and navigation updates.
- State variables:
  - _selectedIndex → controls which page is shown (Clock or Stopwatch)
  - _selectedThemeIndex → controls which color theme is active

- MaterialApp – wraps the entire UI and applies selected theme.
- BottomNavigationBar – provides navigation buttons for Clock and Stopwatch.

Widgets used:
- MaterialApp
- Scaffold
- BottomNavigationBar
- BottomNavigationBarItem
- Icon
- State / StatefulWidget

---------------------------------------------------
3️⃣ flip_clock_page.dart - FLIP CLOCK PAGE
---------------------------------------------------
Purpose:
- Displays a digital flip-style clock that updates every second.
- Lets user switch between 12-hour and 24-hour time formats.
- Provides theme change buttons using ChoiceChip.

Logic:
- Uses Timer.periodic to update the current time each second.
- Uses FlipDigit widget for each time digit with animation.
- Hides seconds digits on small screens using LayoutBuilder.
- Displays date and AM/PM indicator.

Widgets used:
- Scaffold
- SafeArea
- LayoutBuilder
- Center
- SingleChildScrollView
- Column
- Text
- Padding
- FittedBox
- Row
- FlipDigit (custom widget)
- ChoiceChip
- Switch

---------------------------------------------------
4️⃣ flip_digit.dart - ANIMATED FLIP DIGIT
---------------------------------------------------
Purpose:
- Represents a single flip-style animated number tile.
- Changes its displayed digit smoothly using AnimatedSwitcher.

Logic:
- Uses didUpdateWidget to detect when digit changes.
- Temporarily shows the old value during animation transition.
- Uses SlideTransition and FadeTransition to animate flip effect.

Widgets used:
- AnimatedSwitcher
- SlideTransition
- FadeTransition
- Container
- Text
- BoxDecoration
- BoxShadow
- Center

---------------------------------------------------
5️⃣ stopwatch_page.dart - STOPWATCH PAGE
---------------------------------------------------
Purpose:
- Displays a stopwatch with start/stop and reset buttons.
- Shows a circular progress ring indicating seconds.
- Lets user change theme using ChoiceChip (same as clock).

Logic:
- Uses Dart’s Stopwatch class to track elapsed time.
- Uses Timer.periodic to update displayed time every 100ms.
- Formats hours, minutes, and seconds for display.
- CircularProgressIndicator shows animated ring around time.

Widgets used:
- Scaffold
- Center
- Column
- Text
- Stack
- SizedBox
- TweenAnimationBuilder
- CircularProgressIndicator
- ElevatedButton
- Row
- ChoiceChip

---------------------------------------------------
6️⃣ themes.dart - COLOR THEMES
---------------------------------------------------
Purpose:
- Stores multiple predefined color themes for the app.
- Each theme uses Flutter’s ThemeData class.
- Themes control colors for background, cards, and text.

Themes included:
- Dark Blue
- Neon Green
- Orange Sunset
- Purple Galaxy
- Ice Blue

Widgets used:
- None directly (data only).
- ThemeData and ColorScheme from Flutter are used.

---------------------------------------------------
⚙️ WIDGET SUMMARY (ALL USED IN PROJECT)
---------------------------------------------------
Structural:
- MaterialApp
- Scaffold
- SafeArea
- Center
- Column
- Row
- Stack
- Padding
- SizedBox
- LayoutBuilder
- SingleChildScrollView
- FittedBox

Interactive:
- BottomNavigationBar
- BottomNavigationBarItem
- ChoiceChip
- Switch
- ElevatedButton

Text/Display:
- Text
- Container
- FlipDigit (custom)
- CircularProgressIndicator

Animation:
- AnimatedSwitcher
- SlideTransition
- FadeTransition
- TweenAnimationBuilder

Styling:
- BoxDecoration
- BoxShadow
- ThemeData
- ColorScheme

---------------------------------------------------
💡 SUMMARY
---------------------------------------------------
This project demonstrates advanced Flutter concepts such as:
✔ Custom animations (flip digits)
✔ Stateful widgets and lifecycle (Timer, didUpdateWidget)
✔ Theming and dynamic style updates
✔ Navigation with BottomNavigationBar
✔ Layout adaptation with LayoutBuilder
✔ Real-time UI updates via periodic timers

You can easily extend this project to include:
- Alarm functionality
- Countdown timers
- Custom theme creation via user input

---------------------------------------------------
© Explanation prepared by ChatGPT (GPT-5)
Detailed line-by-line and widget usage description.
---------------------------------------------------

