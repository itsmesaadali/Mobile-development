import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device.dart';
import '../services/device_service.dart';
import '../utils/device_type_enum.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final VoidCallback onTap;

  const DeviceCard({Key? key, required this.device, required this.onTap}) : super(key: key);

  IconData _iconFor(DeviceType t) {
    switch (t) {
      case DeviceType.light:
        return Icons.lightbulb;
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
    final media = MediaQuery.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 20,
                      child: Icon(_iconFor(device.type), size: 20),
                    ),
                    const SizedBox(width: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: media.size.width * 0.28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(device.name, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 2),
                          Text(device.room, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ]),
                  Consumer<DeviceService>(builder: (ctx, ds, _) {
                    return Switch(
                      value: device.isOn,
                      onChanged: (_) => ds.toggleDevice(device.id),
                    );
                  })
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(device.isOn ? '${deviceTypeToString(device.type)} is ON' : '${deviceTypeToString(device.type)} is OFF'),
                  if (device.type == DeviceType.light || device.type == DeviceType.fan)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: LinearProgressIndicator(value: device.value / 100),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
