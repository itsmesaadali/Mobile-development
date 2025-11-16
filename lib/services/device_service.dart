import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/device.dart';
import '../utils/device_type_enum.dart';

class DeviceService extends ChangeNotifier {
  final List<Device> _devices = [
    Device(
      id: const Uuid().v4(),
      name: 'Living Room Light',
      type: DeviceType.light,
      room: 'Living Room',
      isOn: true,
      value: 80.0,
    ),
    Device(
      id: const Uuid().v4(),
      name: 'Bedroom Fan',
      type: DeviceType.fan,
      room: 'Bedroom',
      isOn: false,
      value: 40.0,
    ),
    Device(
      id: const Uuid().v4(),
      name: 'Hall Camera',
      type: DeviceType.camera,
      room: 'Hall',
      isOn: true,
      value: 0.0,
    ),
  ];

  List<Device> get devices => List.unmodifiable(_devices);

  void addDevice({
    required String name,
    required DeviceType type,
    required String room,
    bool isOn = false,
  }) {
    _devices.add(Device(
      id: const Uuid().v4(),
      name: name,
      type: type,
      room: room,
      isOn: isOn,
    ));
    notifyListeners();
  }

  void toggleDevice(String id) {
    final d = _devices.firstWhere((e) => e.id == id);
    d.isOn = !d.isOn;
    notifyListeners();
  }

  void updateValue(String id, double newValue) {
    final d = _devices.firstWhere((e) => e.id == id);
    d.value = newValue;
    notifyListeners();
  }

  Device getById(String id) => _devices.firstWhere((e) => e.id == id);
}
