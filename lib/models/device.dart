import '../utils/device_type_enum.dart';

class Device {
  final String id;
  String name;
  DeviceType type;
  String room;
  bool isOn;
  double value; // brightness (0-100) or speed

  Device({
    required this.id,
    required this.name,
    required this.type,
    required this.room,
    this.isOn = false,
    this.value = 50.0,
  });
}
