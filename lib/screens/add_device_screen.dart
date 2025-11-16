import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/device_service.dart';
import '../utils/device_type_enum.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DeviceType _type = DeviceType.light;
  String _room = '';
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    final ds = Provider.of<DeviceService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Device')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Device Name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
                onSaved: (v) => _name = v!.trim(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<DeviceType>(
                value: _type,
                items: DeviceType.values.map((t) => DropdownMenuItem(value: t, child: Text(deviceTypeToString(t)))).toList(),
                onChanged: (v) => setState(() => _type = v!),
                decoration: const InputDecoration(labelText: 'Device Type'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Room Name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a room' : null,
                onSaved: (v) => _room = v!.trim(),
              ),
              const SizedBox(height: 12),
              SwitchListTile(title: const Text('Turn ON by default'), value: _isOn, onChanged: (v) => setState(() => _isOn = v)),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ds.addDevice(name: _name, type: _type, room: _room, isOn: _isOn);
                    Navigator.of(context).pop();
                  }
                },
                child: const SizedBox(width: double.infinity, child: Center(child: Text('Add Device'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
