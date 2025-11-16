import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/device_service.dart';
import '../utils/device_type_enum.dart';

class DeviceDetailScreen extends StatelessWidget {
  final String deviceId;
  const DeviceDetailScreen({Key? key, required this.deviceId})
      : super(key: key);

  IconData _iconFor(DeviceType t) {
    switch (t) {
      case DeviceType.light:
        return Icons.lightbulb_outline;
      case DeviceType.fan:
        return Icons.toys;
      case DeviceType.ac:
        return Icons.ac_unit;
      case DeviceType.camera:
        return Icons.videocam;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ds = Provider.of<DeviceService>(context);
    final device = ds.getById(deviceId);

    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12)
                      ],
                    ),
                    child: Center(child: Icon(_iconFor(device.type), size: 64)),
                  ),
                  const SizedBox(height: 12),
                  Text('${deviceTypeToString(device.type)} • ${device.room}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status', style: Theme.of(context).textTheme.titleLarge),
                Switch(
                    value: device.isOn,
                    onChanged: (_) => ds.toggleDevice(device.id)),
              ],
            ),
            const SizedBox(height: 12),
            if (device.type == DeviceType.light ||
                device.type == DeviceType.fan)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device.type == DeviceType.light ? 'Brightness' : 'Speed',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Slider(
                    min: 0,
                    max: 100,
                    value: device.value,
                    onChanged: device.isOn
                        ? (v) => ds.updateValue(device.id, v)
                        : null,
                  ),
                  Text('${device.value.toStringAsFixed(0)}%'),
                ],
              ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Dashboard'),
            )
          ],
        ),
      ),
    );
  }
}
