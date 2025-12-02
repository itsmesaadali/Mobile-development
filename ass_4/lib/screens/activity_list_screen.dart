import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ActivityListScreen extends StatefulWidget {
  @override
  _ActivityListScreenState createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  List activities = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    activities = await ApiService.getActivities();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Activity Logs")),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (_, i) {
          final data = activities[i];
          return ListTile(
            title: Text(data["location"]),
            subtitle: Text(data["timestamp"]),
            leading: Image.network(data["image"]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await ApiService.deleteActivity(data["id"]);
                loadData();
              },
            ),
          );
        },
      ),
    );
  }
}
