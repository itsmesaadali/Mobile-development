import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/device_service.dart';
import '../widgets/device_card.dart';
import 'device_detail_screen.dart';
import 'add_device_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ds = Provider.of<DeviceService>(context);
    final devices = ds.devices;

    final crossAxis = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home Dashboard'),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(backgroundImage: AssetImage('assets/profile.jpg')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxis,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: devices.length,
          itemBuilder: (ctx, i) {
            final d = devices[i];
            return DeviceCard(
              device: d,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DeviceDetailScreen(deviceId: d.id))),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddDeviceScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
