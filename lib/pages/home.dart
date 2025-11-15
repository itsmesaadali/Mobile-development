import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _methodChannel =
      MethodChannel('platformchannel.companyname.com/deviceinfo');

  String _deviceInfo = '';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      deviceInfo = await _methodChannel.invokeMethod('getDeviceInfo');
    } on PlatformException catch (e) {
      deviceInfo = "Failed to get device info: '${e.message}'.";
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel'),
      ),
      body: SafeArea(
        child: ListTile(
          title: const Text(
            'Device Info:',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            _deviceInfo,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
